Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C056C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BBE206CC
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJWWHHou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgDALdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:33:52 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35151 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgDALdw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:33:52 -0400
Received: by mail-wr1-f44.google.com with SMTP id d5so30197521wrn.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+URYNYgyPxMQpmbrG+QzoVJDKyA8VXkhak6iAVfID+8=;
        b=JJWWHHouWlfSngDm4higCL29PZPN4V9kACxf+KGstE1SJgwOacGFKwLo/TlKyidL4Z
         EsR6NOwg8EvGuCun6ZeGXC5rp6j0e3JzAAi2mr94qiTHSM/SkjDSrA8ifJ5aaupU2yvF
         Y2bp/ASeum0MrPRvi5NmSOnLwcc4kCN0qi6tcjhWDuiZbuXW9HUgNDGZo6YAapSVeKlW
         opKo6MfShFAOototBdW03NVVD7L91exnDoJvEE5oyjjkpOGKl1s/XClXCT3tcp0KAQw2
         BgZ1cBBiJeKq3GPF5/m3dfS2KnC7MRzCKzsNtmhHDtm2gSOmHYbbrui7dAqGF50EW2qa
         haEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+URYNYgyPxMQpmbrG+QzoVJDKyA8VXkhak6iAVfID+8=;
        b=muq6BIjuYdIxS1EQrBfPyGkDNRgl6PYAwGPXOX53I5MqnPKFZkeW+P8KTBqZGxhSnb
         C+r/72162ijgpW9x1r72VhJLKomsRzuzZ1LS7GbfE6X9xBBeJ6A6PANGaJKMsY677l5l
         8tOy9ijcSFO0S+Ssqr/uFdWvOy4VSLwCYMkEqIcrS0oaxK/p/3n3Te5Yw6urGMf2EcED
         XnaO/tlctJLWPbYl97UWRHOUfBLIV2ZtVz0riIv83exuKHVpdytH5DbXl/WzVagXRdHR
         RDfWa21YP5FvJPub1F08qGpkNrfb35T1mh7Ge6Wlj+AIS8cwFs4KH1vps0EVtHaq/faX
         P9Yw==
X-Gm-Message-State: ANhLgQ1Y0gYJISid0O8ftweGiRn0oeVHhsNAfzPN+72fNSxPjMTxJsR0
        2QVA6ibG7UinIXHzhpLt5qyyQLK5
X-Google-Smtp-Source: ADFU+vtpqPXSd7q4oIJL1ogMEG/Ev5LCUkyaIpE5THPU8kkm5hiccrI+jHUO1rsKx3+5xdWdnPslbA==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr27492505wrg.340.1585740829643;
        Wed, 01 Apr 2020 04:33:49 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.gmail.com with ESMTPSA id w4sm2321560wmc.18.2020.04.01.04.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 04:33:49 -0700 (PDT)
Subject: Re: Comparing rebase --am with --interactive via p3400
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
 <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
 <nycvar.QRO.7.76.6.2001312216410.46@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <b380123e-dbcd-7e92-67ab-e6cbf0cec061@gmail.com>
Date:   Wed, 1 Apr 2020 13:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001312216410.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Sorry for the late answer, I was really busy for the last months.

Le 31/01/2020 à 22:23, Johannes Schindelin a écrit :
> Hi Alban,
>  -%<-
> 
> Indeed. I offered these insights in #git-devel (slightly edited):
> 
> This `discard_index()` is in an awfully central location. I am rather
> certain that it would cause problems to just remove it.
> 
> Looking at `do_merge()`: it explicitly discards and re-reads the index if
> we had to spawn a `git merge` process (which we do if a strategy other
> than `recursive` was specified, or if it is an octopus merge). But I am
> wary of other code paths that might not be as careful.
> 
> I see that `do_exec()` is similarly careful.
> 

I have to admit that the index is not my area of expertise in git, so
sorry if my question is stupid: isn't there a less heavy way to find
unstaged or uncommitted changes than discarding and then reloading the
index?

> One thing I cannot fail to notice: we do not re-read a changed index
> after running the `prepare-commit-msg` hook, or for that matter, any other
> hook. That could even be an old regression from the conversion of the
> interactive rebase to using the sequencer rather than a shell script.
> 
> Further, `reset_merge()` seems to spawn `git reset --merge` without
> bothering to re-read the possibly modified index. Its callees are
> `rollback_single_pick()`, `skip_single_pick()` and `sequencer_rollback()`,
> none of which seem to be careful, either, about checking whether the index
> was modified in the meantime.
> 
> Technically, the in-memory index should also be discarded
> in `apply_autostash()`, but so far, we do not have any callers of that
> function, I don't think, that wants to do anything but release resources
> and exit.
> 
> The `run_git_checkout()` function discards, as intended. I
> am not quite sure whether it needs to, though, unless the `.git/index`
> file _was_ modified (it _is_ possible, after all, to run `git rebase -i
> HEAD`, and I do have a use case for that where one of my scripts generates
> a todo script, sort of a `git cherry-pick --rebase-merges`, because
> `cherry-pick` does not support that mode).
> 
> The `continue_single_pick()` function spawns a `git
> commit` which could potentially modify the index through a hook, but the
> first call site does not care and the second one guards against that
> (erroring out...).
> 
> My biggest concern is with the `run_git_commit()` function: it does not
> re-read a potentially-modified index (think of hooks).

Thank you for your analysis.

> 
> We will need to be very careful with this `discard_index()`, I think, and
> in my opinion there is a great opportunity here for cleaning up a little:
> rather than discarding and re-reading the in-memory index without seeing
> whether the on-disk index has changed at all appears a bit wasteful to me.
> 
> This could be refactored into a function that only discards and re-reads
> the index if the mtime of `.git/index` changed. That function could then
> also be taught to detect when the in-memory index has unwritten changes:
> that would constitute a bug.
> 

Hmm, checking if the mtime of the index to see if it changed isn't racy?
 Sub-second changes should happen, and to quote a comment in
is_racy_stat(), "nanosecond timestamped files can also be racy" -- even
if it should not really happen in the case of rebase…

> Ciao,
> Dscho
> 

Alban

