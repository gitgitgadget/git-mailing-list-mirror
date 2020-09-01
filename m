Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF47C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBAD2064B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evbDv4if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIAUfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 16:35:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396DCC061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 13:35:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so1513902pfh.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zzyy4O6LEoPE9U/BjdPDtjx0iZpDTUPtdYI7xzdFYQQ=;
        b=evbDv4ifGWOpwZSjxCmhp6UERyjMj7VWkh3jKQ3vjUvRA54TFVTVFdZHj9Em7mR8VS
         BTRHTKpSAN4EQUUjfPZlzBkSDq/TgdzKLn8R1bnqeuwTS+AtCEQTQe/4hiYX4RDEu9kj
         xtlPXyr/IreaBl4bWCNrcRSxKW4Uo53IbB09lueNnFKisjRuVG7FO0FZcx2L6tHAm30M
         bEOYAp+WWP9I5oKxQ9DUGviftwVuU+8ha6+eBMqE67sIdF6wU0BxJmV43NlvVY4AfjXT
         +jOY75QRPsRCbeU1Awr/OEUt4iKLBAXql/bSdRATyOqX38h+4czUTNo6iqgZT9yLz4Tu
         cuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zzyy4O6LEoPE9U/BjdPDtjx0iZpDTUPtdYI7xzdFYQQ=;
        b=sN6LqmSGvy4xMXxrMxSiZhQAMoe2ecMZK1xgZtj73kWd0NaTu81LuGZnSO5ASGsA3a
         oBZjcGn14W2+4s+wukcqLU78Wa1Dqc+KQ3v+ML71iDypvEr4Yn7ZgLGI0hHUjhK/dZT2
         gtxt61toQUNSoJ6tq8lky04v5IHoX9p7Rlq3mW/K+1QlTETFjp8OVXfTdlvbVzqbDuTY
         BH0T1/K4suBqHMPNxf2nLFPlWTeGGIBUbcxTU5kEnIat8TvPzaLQbTyqbmoIBBS3Jm/s
         j/oAjm9p5S/OHrxi06SmtF8qUg4d+pKkgmmcpy1V8MeOLIByzJuNjoBCStcUufKjuOmp
         MZRw==
X-Gm-Message-State: AOAM532KKTLtS67NQaC/sT4TnD+gQ+c5Y/8Cw9sLGXmX84t2W+s212sH
        9xTBLU2I21tcWMTwcgJfpiw=
X-Google-Smtp-Source: ABdhPJwiYZQi07VtqlupsMRtU7xu9TrAQkbhZ5IpR1cKek9ohEagVW8r+06wXz53LF5YJYX9Nvc04A==
X-Received: by 2002:aa7:9ddc:: with SMTP id g28mr3595179pfq.21.1598992526449;
        Tue, 01 Sep 2020 13:35:26 -0700 (PDT)
Received: from lwitch-pc ([49.206.127.231])
        by smtp.gmail.com with ESMTPSA id r123sm3104249pfc.187.2020.09.01.13.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:35:25 -0700 (PDT)
Message-ID: <31e40c63bbac03d261ac6f46a0d2f6ae90a21038.camel@gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com
Date:   Wed, 02 Sep 2020 02:05:22 +0530
In-Reply-To: <20200831130448.GA119147@konoha>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
         <xmqq8se36gev.fsf@gitster.c.googlers.com> <20200826091502.GA29471@konoha>
         <ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com>
         <20200831130448.GA119147@konoha>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-31 at 18:34 +0530, Shourya Shukla wrote:
> On 31/08 01:28, Kaartic Sivaraam wrote:
> 
> This is what I have done finally:
> ---
> 	if (read_cache() < 0)
> 		die(_("index file corrupt"));
> 
> 	if (!force) {
> 		if (cache_file_exists(path, strlen(path), ignore_case) ||
> 		    cache_dir_exists(path, strlen(path)))
> 			die(_("'%s' already exists in the index"), path);
> 	} else {
> 		int cache_pos = cache_name_pos(path, strlen(path));
> 		struct cache_entry *ce = the_index.cache[cache_pos];
> 		if (cache_pos >= 0 && !S_ISGITLINK(ce->ce_mode))
> 			die(_("'%s' already exists in the index and is not a "
> 			      "submodule"), path);
> 	}
> ---
> 
> I did not put the 'cache_pos >= 0' at the start since I thought that it
> will unnecessarily increase an indentation level. Since we are using
> 'cache_{file,dir}_exists' in the first check and 'cache_name_pos()' in
> the second, the placement of check at another indentation level would be
> unnecessary. What do you think about this?
> 

Interestingly. 'cache_dir_exists' seems to work as expected only when
the global ignore_case whose value seems to depend on core.ignorecase.
So, we can't just rely on 'cache_dir_exists to identify a directory
that has tracked contents. Apparently, the 'directory_exists_in_index'
in 'dir.c' seems to have the code that we want here (which is also the
only user of 'index_dir_exists'; the function for which
'cache_dir_exists' is a convenience wrapper.

The best idea I could think of is to expose that method and re-use it
here. Given that my kowledge about index and caching is primitive, I'm
not sure if there's a better approach. If others have a better idea for
handling this directory case, do enlighten us.

> > This is more close to what the shell version did but misses one case
> > which might or might not be covered by the test suite[1]. The case when
> > path is a directory that has tracked contents. In the shell version we
> > would get:
> > 
> >    $ git submodule add ../git-crypt/ builtin
> >    'builtin' already exists in the index
> >    $ git submodule add --force ../git-crypt/ builtin
> >    'builtin' already exists in the index and is not a submodule
> > 
> >    In the C version with the above snippet we get:
> > 
> >    $ git submodule add --force ../git-crypt/ builtin
> >    fatal: 'builtin' does not have a commit checked out
> >    $ git submodule add ../git-crypt/ builtin
> >    fatal: 'builtin' does not have a commit checked out
> > 
> >    That's not appropriate and should be fixed. I believe we could do
> >    something with `cache_dir_exists` to fix this.
> > 
> > 
> >    Footnote
> >    ===
> > 
> >    [1]: If it's not covered already, it might be a good idea to add a test
> >    for the above case.
> 
> Like Junio said, we do not care if it is a file or a directory of any
> sorts, we will give the error if it already exists. Therefore, even if
> it is an untracked or a tracked one, it should not matter to us. Hence
> testing for it may not be necessary is what I feel. Why should we test
> it?

I'm guessing you misunderstood. A few things:

- We only care about tracked contents for the case in hand.

- Identifying whether a given path corresponds to a directory
  which has tracked contents is tricky. Neither 'cache_name_pos'
  nor 'cache_file_exists' handle this. 'cache_dir_exists' is also
  not very useful as mentioned above.

So, we do have to take care when handling that case as Junio pointed
out.

-- 
Sivaraam


