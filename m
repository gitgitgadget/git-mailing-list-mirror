Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA70C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0967C6112F
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhKJP7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhKJP7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 10:59:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ADDC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 07:56:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v11so12392571edc.9
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=C30YAN3bicWkFFGHHNqrz5Vd+eTxlp2d7T+xKhezoDQ=;
        b=aayRgnzUnWDnuJzRHw/CyU7DIegQn3J/6vMk4bBokyjS4hoJ/Ws/e3I2BPXrwQWqKJ
         abolGiDieUoUK/DmO/KnION88LRFc6pu0CpwE05vmtYlSCjVC6+PJAnDKmPgPz1QAmgf
         edUkm0pDhCiPXlsw8G6sTSVT90aBR9Jr5Fnd9elpPMXQA6mlP9auBeimeLammzSiCj4T
         zqcW6iFsOY9siTgGJCmF4Lq2SjbWS/sKzWc3t+4+aqTgkLGynI196IlESlCaOpvjb6WB
         HB7MpKi/AnzrC5TZuFhtW9PhnAwpmwgGxMEPY4FdEsTf2lWCc+MCJkZar9eb0fNrn8Mc
         dgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=C30YAN3bicWkFFGHHNqrz5Vd+eTxlp2d7T+xKhezoDQ=;
        b=zbshChkVwua9Ird5RWddXq54vov5YKja95s+B2EhwKuNPM9wwKpbFXheXMLtSI9Rwd
         mdGnzKwdTo9oPgreK+8cwDSLM6kuv3o9zI+X4H26OMrnjeLf3/UgIKv2ebcO8+PvVjoR
         XOBpKDp3atJwEoPPLvSbuzc1BYq0osCmRKBGNRF7MrSTrF9HYNyuW166XnxtFKtViJ6q
         fX+BtquYPMMpaxpyt9LPQqVJisZ264SzPdjjyX683e4U6q9ALhChRPpG0cAAeBnCX/2n
         3mcdggrpE+oSi0+G6hybE3PTWMe9olsmwYNYaVWWuaEMKH6Vz1mlnf9FZwzPp+zaYjLA
         QCNg==
X-Gm-Message-State: AOAM532eQ+6wsoDe3vUd0BTGjthdYUH7R2p0ZwK3OFOcIXIvzfGwUJ/V
        p+z9c3tcmCtJacLy6c9J8VaY3Pbiw5pYjw==
X-Google-Smtp-Source: ABdhPJxEDPBIND9RhjnamXHAnoOm0xd1EuxK7IQuherHuMiCM8t2PDJ58Hlexg0sMi/yncuSsNDRAw==
X-Received: by 2002:a17:907:a414:: with SMTP id sg20mr148591ejc.183.1636559794033;
        Wed, 10 Nov 2021 07:56:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hd15sm75155ejc.69.2021.11.10.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 07:56:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkpxg-0016HX-TO;
        Wed, 10 Nov 2021 16:56:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: RFC: A configuration design for future-proofing fsync() configuration
Date:   Wed, 10 Nov 2021 16:09:33 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211110.86r1bogg27.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to various fsync topics in-flight I've been encouraging
those involved to come up with some way to configure fsync() in a way
that'll make holistic sense in the end-state.

Continuing a discussion from [1] currently we have:

    ; Defaults to 'false'
    core.fsyncObjectFiles = [true|false]

In master..next this has been extended to this by Neeraj:

   core.fsyncObjectFiles = [true|false|batch]

Which, as an aside I hadn't considered before and I think we need to
change before it lands on "master", we really don't want config users
want to enable that makes older versions hard die. It's annoying to want
to configure a new thing and not being able to put it in .gitconfig
because older versions die on it:

    $ git -c core.fsyncObjectFiles=batch status; echo $?
    fatal: bad boolean config value 'batch' for 'core.fsyncobjectfiles'
    128

Then there's Eric Wong's proposed[2]:

    core.fsync = <bool>

And now Patrick Steinhardt has a proposal to extend Neeraj's with[3]:

    ; Like core.fsyncObjectFiles, but apparently for .git/refs, not
    ; .git/objects (but see my confusion on that topic in [1])
    core.fsyncRefFiles = [<bool>|batch]

I think this sort of config schema would make everyone above happy

It would:

 A) Be easy to extend for any future fsync behavior we'd reasonably
    implement
 
 B) Not make older git versions die. It's fine if they warn(), but not die.

 C) Has some pretty contrived key names, but I'm trying to maintain the
    constraint that you can set both fsck.X=Y and
    e.g. fetch.fsck.X=Y. I.e. we should be able to configure things
    globally *and* per-command, like color.*, fsck.* etc.

Proposal:

  ; Turns on/off all fsync, whatever the method is. I.e. allows you to
  ; never make any fsync() calls whatsoever (which we have another
  ; in-flight topic for).

  ; The "false" was controversial, and we could just leave it
  ; unimplemented
  core.fsync = <bool>

  ; Optional, by default we'd use the most pedantic (I'd call our
  ; current "loose", whether we want to forward-support it is another
  ; matter.
  ;
  ; Whatever names we pick an option like this should ignore (or at most
  ; warn about) values it doesn't know about, not hard die on it.
  ;
  ; Here "bach" is what Neeraj and Patrick are pursuing, a hypothetical
  ; POSIX would be a pedantic way of exhaustively fsyncing everything.
  ; 
  ; We'd leave door open to e.g. setting it to "linux:ext4" or whatever,
  ; to do only the work needed on some specific popular FS
  core.fsyncMethod = loose | POSIX | batch | linux:ext4 | NTFS | ...

  ; Turn on or off entire categories of files we'd like to sync. This
  ; way Neeraj's and Patrick's approach would be to set
  ; core.fsyncMethod=batch, and then core.fsyncGroup=files &
  ; core.fsyncGroup=refs.

  ; If we learn about a new core.fsyncGroup = xyz in the future a <bool>
  ; in "core.fsyncGroupDefault" will prevail. I.e. if true it's
  ; included, if false not.
  ;
  ; Whether "false" or "true" is the default depends on
  ; core.fsyncMethod. For POSIX it would be true, for "loose" it's
  ; false.
  core.fsyncGroup = files
  core.fsyncGroup = refs
  core.fsyncGroup = objects

I'm not sure I like calling it "group". Maybe "class", "category"? Doing
it with this structure is extensible to the two-level keys, as noted
above.

  ; Our existing config knob. When "false" synonymous with:
  ;
  ;     core.fsync = true
  ;     core.fsyncMethod = loose
  ;     core.fsyncGroup = pack
  ;
  ; When "true" synonymous with the same as the above, plus:
  ;     core.fsyncGroup = loose
  ;
  : Or something like that. I.e. we'll fsync *.pack, *.bitmap etc, and ;
  ; probably some other stuff, but not loose objects etc.
  ;
  ; Whatever we fsync now exactly this schema should be generic enough
  ; to support it.
  core.fsyncObjectFiles = <bool>

  ; A namespace for core.fsyncMethod = <X>. Specific methods will
  ; own this namespace and can configure whatever they want.
  fsyncMethod.<x>.<a> = <b>

E.g. we might have:

  fsyncMethod.POSIX.content = true
  fsyncMethod.POSIX.metadata = false

If we know we'd like to (depending on other config) to fsync things
exhaustively or not, but do different things depending on file content
or metadata. I.e. maybe your FS's fsync() on a file fd always implies a
sync of the metadata, and maybe not.

  ; Change whatever fsync configuration you want per-command, similar to
  ; fsck.* and fetch.fsck.*
  transfer.fsyncGroup=*
  fetch.fsyncGroup=*
  ...

1. https://lore.kernel.org/git/211110.86v910gi9a.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/
3. https://lore.kernel.org/git/cover.1636544377.git.ps@pks.im/
