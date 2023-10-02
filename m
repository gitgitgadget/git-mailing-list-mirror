Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8024E784BC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbjJBPUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbjJBPUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:20:06 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F449A9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:20:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-775751c35d4so444996385a.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260002; x=1696864802; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN/vQ3ErYZFaCIF2KK/Knn4j4lZyf5wVZufzunB41Qw=;
        b=bhXnOiHo46O0HBnf17E8aLwhTNC70D6ObavmrT9zAR0UyAS5l0gx8UVZIZtzWj+nca
         dXDNt76JRMj4nFppJ5i/GRNAhCSk92KqMTJ+dPCew+QpAOuW9lfi5vweBnFvysn4JgWt
         cdUMUfWoFyNVDv9Y1HmRx2olaW9Q017Cm2hYVsk1hv0K4WdUc1S7Lky0yyL75Xbfc3Sz
         OZkikqYo2f+MbTvr9gY7unqqLvvx6KTpxEBeKpyOl7rG49wo9ZBs0ot8B3sOPPh6TRnH
         sDxn3hzz4d4GuzEqmJO4I+oleA6QpTZnysHEWGlBAPhlPZlNJ9r2pdl1+fzLzXNXXlNp
         Vm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260002; x=1696864802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BN/vQ3ErYZFaCIF2KK/Knn4j4lZyf5wVZufzunB41Qw=;
        b=oa9wnF+KN+V0CtzEqSc59mBd20ZMGTo2Npt6+yQIuG2FFco2rplluHsn2slnpPPQUF
         TcUp0n94kRiFVgEPo8WyDHFVCSO9cdrLVV0IWTwQrm27gdnTLaI/HtmBCliBRJ5U25sC
         9rUHFCXjz7xgxUmqS35b403rG5TXI0XA1SAwxolapVOOryWaj2K6AnmGNaquaoYU2Gtq
         AsfEp6go7+ostnVh4FuzbKdRjfYbzZzO/VjzeUVa4xSRQqGuMaveBJOUnT4RBs5FgTOh
         Kl/PWWMIczU9TgVrhfheWY85C23+/AhWt9bNX5PlFOg3wTtRD4BZdEiK5v0Of/l8bOym
         wDTg==
X-Gm-Message-State: AOJu0Yy4ZGuOWg4lvkg1sTIxcgY6IJcpjYqzjvlCvK+6RyPQjfOW5ZfZ
        ACbr8WU71s1rDPWDJ9x9pAPBSV7hmNz4h9of6msKmQ==
X-Google-Smtp-Source: AGHT+IGqXoJByNsGkqi3lE90NCRJ3Z5lNIxtFEHBjszqzMPpI5RmE8EQGMnhGf1bQNpHgxGYaF7Xxg==
X-Received: by 2002:a05:620a:9c7:b0:770:f332:f151 with SMTP id y7-20020a05620a09c700b00770f332f151mr10848671qky.64.1696260002010;
        Mon, 02 Oct 2023 08:20:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u25-20020ae9c019000000b0076f18be9a64sm6447836qkk.81.2023.10.02.08.20.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:20:01 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:20:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 6/12]  Clarifying backwards compatibility and when we break it
Message-ID: <ZRrfoJgiAr7NH53V@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Emily Shaffer, Notetaker: Taylor Blau)

* (Emily) In the last year, there were a handful of scenarios where we had
  issues with backwards compatibility.
   * E.g. config based hooks. As a result of this change, text coloration was
     broken from user-provided hooks. Missing tests, but still viewed it as
     backwards-compatibility-breaking.
   * E.g. deleted internal "git submodule--helper" that looked like a plumbing
     command, which other projects depended on. Was being used in the wild, even
     though we didn't expect it.
   * E.g. bare repository embedding. Interested in fixing that as a security
     concern
     (https://offensi.com/2019/12/16/4-google-cloud-shell-bugs-explained-bug-3/,
     https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bare_repos_and_fsmonitor_various_abuses.md).
     Weren't able to do so in a widespread fashion, since many projects are
     using it for testing setups (i.e. test fixtures).
* (Emily) When do we consider odd behavior as bugs, versus when do we consider
  them as something that's part of our backwards compatibility guarantee.
* (Emily) What do we want backwards compatibility to look like for libraries?
  How do we want to handle this in the future?
* (Minh) Is there documentation on how this should behave?
   * (Emily): Typically try to guarantee backwards compatibility via integration
     tests. Have changed documented behavior in the past when it seems "just
     wrong". Is the documentation the source of truth?
   * (Jonathan Nieder): In the case of browsers, using a specification for
     compatibility is a useful tool. What will work at the same time across
     different implementations? When there is a single implementation (e.g. git)
     it is easier to capture your intention with the implementation instead of a
     specification.
   * (Jonathan Nieder): Converting that documentation into a specification can
     hurt readability or inhibit its other uses.
   * (Junio): Tend to ensure that observable behavior is locked in via
     integration tests. Tests are the source of truth, along with
     implementation. Documentation is often lying. Unlike the browser example,
     we don't have an external specification to rely on. Intention from
     developers is captured in the log proposed message.
* (Minh) Should we be testing more, then?
   * (Emily) That's part of it, but some older behavior (e.g. from the original
     implementation) has less information in the commit message as a result of
     project culture at the time.
   * (Junio) Working-as-designed, but the design outlived its usefulness.
   * (Jonathan Nieder) E.g. ‘git-add' versus ‘git add'. Outcry after we changed
     behavior, so we rolled it back. Much later we got to a place where people
     weren't relying on this behavior as much.
* (Jonathan Nieder) There is another kind of documentation besides
  specification. E.g. the kernel has a documented guarantee about compatibility:
  "the kernel never breaks userspace". This doesn't mean that we can't have
  observable behavior changes. Only that they maintain "depended-upon" behavior
  that the kernel is reasonably responsible for providing. Can only determine
  this surface area by rolling out changes and seeing if folks complain.
* (Jonathan Nieder) It sometimes feels like we have adopted a similar
  philosophy, but the kernel has an easier job since POSIX, System V, etc have
  defined the overall shape of the syscall interface.
* (Elijah) Difficult to distinguish between bug fixes and breaking backwards
  compatibility. When we break existing test cases, document a rationale for
  doing so in the proposed patch message. Cases where documentation was just
  wrong. Often comes down to a judgment call.
* (Minh) Is the consensus to keep tests up-to-date, and add more tests when
  behavior is unclear?
* (Jonathan Nieder) Problem is that there can be differences of opinion on what
  are safe compatibility guarantees to break.
* (Emily) Also the case that there are tests that are in the integration suite
  that are enforcing things that weren't meant to be compatibility guarantees.
  E.g. enforcing error messages. How do we cope with legacy behavior and legacy
  tests when making a judgment call? There is some documentation in general
  about backwards compatibility, plumbing commands are frozen, porcelain
  commands are not. Should we expand that documentation to clarify how to
  decide?
* (brian) This would be helpful, but not sure what it would look like. Kernel's
  approach may be too rigid for Git. Sometimes useful to break backwards
  compatibility. E.g. "we have it, but it isn't a good choice." Users depend on
  those error messages. When we make a change that is overwhelmingly beneficial,
  can't please everybody all of the time.
* (Jonathan Nieder) Back to guarantees for library code. Kind of view the
  plumbing/porcelain decision as a failed experiment. Of course scripters are
  going to use the plumbing. Want a better backwards compatibility guarantee.
  People are going to want to add more functionality there and lock in
  additional behavior. When people write scripts, they write using the commands
  that they understand how to use. End-user commands gain for-scripting
  functionality.
* (Junio) Worse is when new features are added only to porcelain, and plumbing
  code is left behind.
* (Jonathan Nieder) In a way, we made it harder on ourselves. If porcelains are
  written as scripts, you need plumbing commands to expose the functionality
  they need. Now porcelains use function calls, so the well maintained interface
  is more on the (internal) library side
* Libification moves us in a good direction, since it provides an alternative to
  the CLI as a well-defined programmatic access method.
* (Jonathan Nieder) If we succeed at this, the command-line backwards
  compatibility guarantee for porcelain commands can break down a bit to the
  extent that users start to adopt the library code as their interface to Git.
* (Emily) If we have suitable replacements in the library, can we deprecate the
  plumbing variant of that functionality eventually? Freeze a particular
  plumbing command instead of adding to it
* (Taylor) Can't break existing behavior, shouldn't have to force users to
  upgrade to library code for existing behavior. Apologies if this is what you
  were saying.
* (Jakub) Auto-generated CLI shim, like cloud providers often provide for their
  APIs?
* (Jonathan Tan) Might be hard to create scriptable interfaces for library
  commands. Library allows us to pass pointers and function callbacks, neither
  of these we can accomplish via the shell.
* (Minh) Is there an understanding that the library has to implement 100% of the
  functionality of plumbing commands?
* (Emily) Not convinced that we need a one-to-one match between the library and
  command-line interface. Want to expose the same intent, not necessarily exact
  incantations.
* (Jonathan Nieder) Let me try and summarize. Question resonates with people, no
  one has a silver bullet. Maybe some agreement for using more tests, but the
  general approach to figuring out our compatibility guarantees remains an open
  discussion.
* (brian, via chat) One final thought: maybe we could look at what Semantic
  Versioning defines a breaking change as, since they've defined this in a very
  public way.
* (Phillip, via chat) Thinking back to yesterday there were people saying that
  they chose the cli over a library because of concerns about memory leaks and
  the library crashing/dying as well as licensing concerns. If we were to add
  new functionality only in libraries we'd need to make sure that they were
  robust.
