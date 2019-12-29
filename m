Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EBFC2D0D1
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675BC207E0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEmvPkAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfL2RZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:25:26 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41419 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfL2RZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 12:25:25 -0500
Received: by mail-wr1-f45.google.com with SMTP id c9so30813982wrw.8
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u89BHsKbKlJsXdgQOkU7bo1i4ljX+awRePsRxQ2fZr4=;
        b=mEmvPkAedUTMkMTsJN6Cd/yhLcNipSGB1ZC8LAd/wRuB08EqHO7QoIKhahjCgksLiU
         HPJdApaocA08KCoU1S6OgR4KHBj5dlXXprcaoZ0R0A1LKBL0qE+1jhKD09JQ3K+dcRw0
         Qbe4Zh0qZ+FRW/1ueymO6PXWJgbjfLX9xjAiyxkamEX2MxLs9fvhONFFX5W7hGUO8aXD
         k8+u3YLqZRg+/EKSgw6Sg3bRaP5eTz5TfRmGa2s9SqTCp4MHUAsbVfSZMOwco3r813RR
         Ms5O4xcDdxaSNcJLL2q2BvtJuKclf+JxDI5pYW0b76MxgIOZuOIvr56TjXNxbP990HC9
         lKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u89BHsKbKlJsXdgQOkU7bo1i4ljX+awRePsRxQ2fZr4=;
        b=uOLDhBupSMpf+DjExj4sEdT3SwtlKdb6L7bIJWT8U8yHUmIznqISR2pxbSatAHHmoG
         yVBm3DHTEHCdE4LdIqXjmlwae2dBxU9SP8TeHGpjLgvyk4+DLpCZ5MdFoaYjWy8W46uH
         QGzvX2z9VpujjrrnfsdFkBPL+QkOCpJOZyUnTvcfq0vtTNPeqk+L2HNW49mMqedyz01r
         8d4ZsxUVCPCJpwaxdUxSpiCaiLhqvZq5sFoMu5Hr7h2rA/shScCbYOUCpEKA+xR/+L07
         IB0QWPGKBKKfUJb8dMPgie2RmRZ8taB5rws6f90Uv5Jx0h45e0NV3Uu6HxK8RuvPuS8X
         MOCg==
X-Gm-Message-State: APjAAAXDQgmDbYRmanUyWBVDJvXYiJhy1xXVxFQshPozliKLE0w92G8M
        Uzv90PczDJYkm7hVZK1tRNu1zAaT
X-Google-Smtp-Source: APXvYqxxxZBLL8W79gOYSAG0cX2QUh5oqHUKFOI9u5N5xqf7GSr1/Foc5n6xuPRYQhmVfOPZ+geIow==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr49644131wru.154.1577640323990;
        Sun, 29 Dec 2019 09:25:23 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-10-13.w86-222.abo.wanadoo.fr. [86.222.153.13])
        by smtp.gmail.com with ESMTPSA id s1sm18655209wmc.23.2019.12.29.09.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 09:25:23 -0800 (PST)
Subject: Re: Comparing rebase --am with --interactive via p3400
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
 <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
 <CABPp-BGCQR+MLVTDoaXDmPrE4SCu+dQ794X6Kvx1PpiQ=6D7KQ@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <16add63e-a631-5ebf-bbbe-17823d942ee9@gmail.com>
Date:   Sun, 29 Dec 2019 18:25:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGCQR+MLVTDoaXDmPrE4SCu+dQ794X6Kvx1PpiQ=6D7KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 27/12/2019 à 23:45, Elijah Newren a écrit :
> Hi Alban,
> 
> On Fri, Dec 27, 2019 at 1:11 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>>
>> Hi Johannes & Elijah,
>>
>> Le 01/02/2019 à 07:04, Johannes Schindelin a écrit :
>>> Hi Elijah,
>>>
>>> as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with the
>>> --am backend) and then with --keep-empty to force the interactive backend
>>> to be used. Here are the best of 10, on my relatively powerful Windows 10
>>> laptop, with current `master`.
>>>
>>> With regular rebase --am:
>>>
>>> 3400.2: rebase on top of a lot of unrelated changes             5.32(0.06+0.15)
>>> 3400.4: rebase a lot of unrelated changes without split-index   33.08(0.04+0.18)
>>> 3400.6: rebase a lot of unrelated changes with split-index      30.29(0.03+0.18)
>>>
>>> with --keep-empty to force the interactive backend:
>>>
>>> 3400.2: rebase on top of a lot of unrelated changes             3.92(0.03+0.18)
>>> 3400.4: rebase a lot of unrelated changes without split-index   33.92(0.03+0.22)
>>> 3400.6: rebase a lot of unrelated changes with split-index      38.82(0.03+0.16)
>>>
>>> I then changed it to -m to test the current scripted version, trying to
>>> let it run overnight, but my laptop eventually went to sleep and the tests
>>> were not even done. I'll let them continue and report back.
>>>
>>> My conclusion after seeing these numbers is: the interactive rebase is
>>> really close to the performance of the --am backend. So to me, it makes a
>>> total lot of sense to switch --merge over to it, and to make --merge the
>>> default. We still should investigate why the split-index performance is so
>>> significantly worse, though.
>>>
>>> Ciao,
>>> Dscho
>>>
>>
>> I investigated a bit on this.  From a quick glance at a callgrind trace,
>> I can see that ce_write_entry() is called 20 601[1] times with `git am',
>> but 739 802 times with the sequencer when the split-index is enabled.
> 
> Sweet, thanks for digging in and analyzing this.
> 
>> For reference, here are the timings, measured on my Linux machine, on a
>> tmpfs, with git.git as the repo:
>>
>> `rebase --am':
>>> 3400.2: rebase on top of a lot of unrelated changes             0.29(0.24+0.03)
>>> 3400.4: rebase a lot of unrelated changes without split-index   6.77(6.51+0.22)
>>> 3400.6: rebase a lot of unrelated changes with split-index      4.43(4.29+0.13)
>> `rebase --quiet':
> 
> --quiet?  Isn't that flag supposed to work with both backends and not
> imply either one?  We previously used --keep-empty, though there's a
> chance that flag means we're not doing a fair comparison (since 'am'
> will drop empty commits and thus have less work to do).  Is there any
> chance you actually ran a different command, but when you went to
> summarize just typed the wrong flag name?  Anyway, the best would
> probably be to use --merge here (at the time Johannes and I were
> testing, that wouldn't have triggered the sequencer, but it does now),
> after first applying the en/rebase-backend series just to make sure
> we're doing an apples to apples comparison.  However, I suspect that
> empty commits probably weren't much of a factor and you did find some
> interesting things...
> 

Yes, I did use `--keep-empty' but misremembered it when writing this email…

>>> 3400.2: rebase on top of a lot of unrelated changes             0.24(0.21+0.02)
>>> 3400.4: rebase a lot of unrelated changes without split-index   5.60(5.32+0.27)
>>> 3400.6: rebase a lot of unrelated changes with split-index      5.67(5.40+0.26)
>>
>> This comes from two things:
>>
>> 1. There is not enough shared entries in the index with the sequencer.
>>
>> do_write_index() is called only by do_write_locked_index() with `--am',
>> but is also called by write_shared_index() with the sequencer once for
>> every other commit.  As the latter is only called by
>> write_locked_index(), which means that too_many_not_shared_entries()
>> returns true for the sequencer, but never for `--am'.
>>
>> Removing the call to discard_index() in do_pick_commit() (as in the
>> first attached patch) solve this particular issue, but this would
>> require a more thorough analysis to see if it is actually safe to do.
> 
> I'm actually surprised the sequencer would call discard_index(); I
> would have thought it would have relied on merge_recursive() to do the
> necessary index changes and updates other than writing the new index
> out.  But I'm not quite as familar with the sequencer so perhaps
> there's some reason I'm unaware of.  (Any chance this is a left-over
> from when sequencer invoked external scripts to do the work, and thus
> the index was updated in another processes' memory and on disk, and it
> had to discard and re-read to get its own process updated?)
> 

The sequencer re-reads the index after invoking an external command
(either `git checkout', `git merge' or an `exec' command from the todo
list), which makes sense.  But this one seems to come from 6eb1b437933
("cherry-pick/revert: make direct internal call to merge_tree()",
2008-09-02).  So, yes, quite old, and perhaps no longer justified.

I know I had to add another discard_cache() in rebase--interactive.c
because it broke something with the submodules, but it does not seems
all that useful now that rebase.c no longer has to fork to use the
sequencer.

Cheers,
Alban

