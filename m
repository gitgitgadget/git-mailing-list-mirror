Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4756C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BE061054
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKKAuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhKKAuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 19:50:18 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C542C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:47:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x64so4124148pfd.6
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fciEs3ktPcL3q3RArczygrxQD/SsdDw6dvYN315hCjc=;
        b=fi710gVoT6hd/MFHLHOEpjxvt39MY+EkufhBDBs+VBYmLGbfWD6gJ/2yFjm2offD8u
         R2F2hAbYYt0Omz3UZ/98iSRYTEbF30/PDXfrpjZYKycGyyrjfSySrIabsX/H+iAoEANW
         fZE3xDWzZpqretGDu8JAl5FFqjpoEgAxKux0dViBZbIgU6ls/xlEtn8d8TDwo2XT99QO
         0IptKJCMTAGDXN4L4Y+i3FKKEooFH1Sy7aNESgx1ZTFh9dDpJts19t8ougq2Ir3EhuHm
         o1EgkzF4GXXomL/UrKcDxSWSETHBHd0tgqPx97/eGRilwoWO51UbAgoIjtY3bfQdlP/5
         rR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fciEs3ktPcL3q3RArczygrxQD/SsdDw6dvYN315hCjc=;
        b=LsiYL8We3qxVyJA/CPPgFIGTBAffWwAFC9AYIYp4XTHRkzmoPj9GZGZijYXwllun9R
         /eG6MjqdH3U+CZ6WLODLGnaCBhYZHFEd+Qr1sn6Wuvbajrr5banq8udpuwKy20thApyx
         ngLZ758w5BSPTUUMY5uu5P+wBD4vRoRboIURIK5iYy4lQ3aoOPq+ldkKX/T0sXwDwhUm
         w3TVab+Wmv/oeRkgK2VaDBuF1ttZ+B35ZhGBaMNOm8q0//ygSoWY3ARbKjDKTzQWXacO
         Zz2Wq42sJ0EYt5obieep5uxTduniAFjRvm77LaWf1EyyqwR/JrSHSIZaXqTFjbxAYTki
         MwAQ==
X-Gm-Message-State: AOAM531WGaMM5jzbt0i/xOSuj+jLkdFE+TkHR6JuWVYgrrlLWP5swa3e
        5qG5GQJ38TsrU41TKZKoPDg=
X-Google-Smtp-Source: ABdhPJxR5nlLdDL+E1c4smtWlmolp7jyF7N1GkW58uzVudni9X314p2Yt19vX1D0fp6neA09XKjoRw==
X-Received: by 2002:a63:6948:: with SMTP id e69mr1989494pgc.139.1636591649638;
        Wed, 10 Nov 2021 16:47:29 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id w13sm586112pgm.3.2021.11.10.16.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:47:29 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:47:24 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: RFC: A configuration design for future-proofing fsync()
 configuration
Message-ID: <20211111004724.GA839@neerajsi-x1.localdomain>
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211110.86r1bogg27.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 04:09:33PM +0100, Ævar Arnfjörð Bjarmason wrote:
> As a follow-up to various fsync topics in-flight I've been encouraging
> those involved to come up with some way to configure fsync() in a way
> that'll make holistic sense in the end-state.
> 
> Continuing a discussion from [1] currently we have:
> 
>     ; Defaults to 'false'
>     core.fsyncObjectFiles = [true|false]
> 
> In master..next this has been extended to this by Neeraj:
> 
>    core.fsyncObjectFiles = [true|false|batch]
> 
> Which, as an aside I hadn't considered before and I think we need to
> change before it lands on "master", we really don't want config users
> want to enable that makes older versions hard die. It's annoying to want
> to configure a new thing and not being able to put it in .gitconfig
> because older versions die on it:
> 
>     $ git -c core.fsyncObjectFiles=batch status; echo $?
>     fatal: bad boolean config value 'batch' for 'core.fsyncobjectfiles'
>     128
> 
> Then there's Eric Wong's proposed[2]:
> 
>     core.fsync = <bool>
> 
> And now Patrick Steinhardt has a proposal to extend Neeraj's with[3]:
> 
>     ; Like core.fsyncObjectFiles, but apparently for .git/refs, not
>     ; .git/objects (but see my confusion on that topic in [1])
>     core.fsyncRefFiles = [<bool>|batch]
> 
> I think this sort of config schema would make everyone above happy
> 
> It would:
> 
>  A) Be easy to extend for any future fsync behavior we'd reasonably
>     implement
>  
>  B) Not make older git versions die. It's fine if they warn(), but not die.
> 
>  C) Has some pretty contrived key names, but I'm trying to maintain the
>     constraint that you can set both fsck.X=Y and
>     e.g. fetch.fsck.X=Y. I.e. we should be able to configure things
>     globally *and* per-command, like color.*, fsck.* etc.
> 
> Proposal:
> 
>   ; Turns on/off all fsync, whatever the method is. I.e. allows you to
>   ; never make any fsync() calls whatsoever (which we have another
>   ; in-flight topic for).
> 
>   ; The "false" was controversial, and we could just leave it
>   ; unimplemented
>   core.fsync = <bool>
> 
>   ; Optional, by default we'd use the most pedantic (I'd call our
>   ; current "loose", whether we want to forward-support it is another
>   ; matter.
>   ;
>   ; Whatever names we pick an option like this should ignore (or at most
>   ; warn about) values it doesn't know about, not hard die on it.
>   ;
>   ; Here "bach" is what Neeraj and Patrick are pursuing, a hypothetical
>   ; POSIX would be a pedantic way of exhaustively fsyncing everything.
>   ; 
>   ; We'd leave door open to e.g. setting it to "linux:ext4" or whatever,
>   ; to do only the work needed on some specific popular FS
>   core.fsyncMethod = loose | POSIX | batch | linux:ext4 | NTFS | ...
> 
>   ; Turn on or off entire categories of files we'd like to sync. This
>   ; way Neeraj's and Patrick's approach would be to set
>   ; core.fsyncMethod=batch, and then core.fsyncGroup=files &
>   ; core.fsyncGroup=refs.
> 
>   ; If we learn about a new core.fsyncGroup = xyz in the future a <bool>
>   ; in "core.fsyncGroupDefault" will prevail. I.e. if true it's
>   ; included, if false not.
>   ;
>   ; Whether "false" or "true" is the default depends on
>   ; core.fsyncMethod. For POSIX it would be true, for "loose" it's
>   ; false.
>   core.fsyncGroup = files
>   core.fsyncGroup = refs
>   core.fsyncGroup = objects
> 
> I'm not sure I like calling it "group". Maybe "class", "category"? Doing
> it with this structure is extensible to the two-level keys, as noted
> above.
> 
>   ; Our existing config knob. When "false" synonymous with:
>   ;
>   ;     core.fsync = true
>   ;     core.fsyncMethod = loose
>   ;     core.fsyncGroup = pack
>   ;
>   ; When "true" synonymous with the same as the above, plus:
>   ;     core.fsyncGroup = loose
>   ;
>   : Or something like that. I.e. we'll fsync *.pack, *.bitmap etc, and ;
>   ; probably some other stuff, but not loose objects etc.
>   ;
>   ; Whatever we fsync now exactly this schema should be generic enough
>   ; to support it.
>   core.fsyncObjectFiles = <bool>
> 
>   ; A namespace for core.fsyncMethod = <X>. Specific methods will
>   ; own this namespace and can configure whatever they want.
>   fsyncMethod.<x>.<a> = <b>
> 
> E.g. we might have:
> 
>   fsyncMethod.POSIX.content = true
>   fsyncMethod.POSIX.metadata = false
> 
> If we know we'd like to (depending on other config) to fsync things
> exhaustively or not, but do different things depending on file content
> or metadata. I.e. maybe your FS's fsync() on a file fd always implies a
> sync of the metadata, and maybe not.
> 
>   ; Change whatever fsync configuration you want per-command, similar to
>   ; fsck.* and fetch.fsck.*
>   transfer.fsyncGroup=*
>   fetch.fsyncGroup=*
>   ...
> 
> 1. https://lore.kernel.org/git/211110.86v910gi9a.gmgdl@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/
> 3. https://lore.kernel.org/git/cover.1636544377.git.ps@pks.im/
Hi Ævar,

Thanks for noticing the backwards compatibility issue with the 'batch' flag. I
agree that we need to fix that before committing my changes to master.

I'm hoping that we can agree to a version of what you're proposing, but my
preference would be to cut out the more granular controls. I'd prefer to see
just:
	core.fsync = [bool]   		- Turn fsyncing on or off.
	core.fsyncMethod = [string] 	- Controls how it's done (with a non-fatal warn on unrecognized values).
	core.fsyncObjectFiles = [bool]  - Sets core.fsync if that setting doesn't already have a value. For back-compat.

I don't think either we or the users should have to reason about what it means
for some parts of the repo to be fsynced and others not to be. If core.fsync is
'false' and someone gets a weird state after a system crash, no one should be
surprised. If core.fsync is 'true', and people are running on a reasonable
common filesystem, we should be trying to give decent performance and good
durability.

It would be nice to loop in some Linux fs developers to find out what can be
done on current implementations to get the durability without terrible
performance. From reading the docs and mailing threads it looks like the
sync_file_range + bulk fsync approach should actually work on the current XFS
implementation.

Thanks,
Neeraj
Windows Core Filesystem Dev
