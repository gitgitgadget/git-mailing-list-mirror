Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08745C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76BE616E8
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKUd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:33:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFCC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:32:49 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s25so2109829ljo.11
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MnzQb3Jh0ScbQkuyZTj2kaX7pXGg8xHDYyPpDshbrD0=;
        b=fRAyAV3EHArq0/xtZ0vnER6GK2aM5PPzTo8utVP5bVt7AaFa5reSQZQIUxwlC+pd/v
         50yHbrCt2CKoITse8zkqRMhYhagq/7kGXYoEwwehcTzb5GSMIPJ5ceMBHOZHvPIsLG/C
         pkgMoOMnU9vFGsGGq0IbFnGh0umZYQU3Wi4U9q6t+2iRtWArXObgxU6nGYsUGVkUhxHA
         gxGGrjF9nYSMY9Q3U3nKLkas3Iky5AeDo7OxlydOatpq5DtqaBcVN0aPx/Xq8FiBNV0+
         h5i0ZBo9rGDl27XQoF+eIAo63FgxdfZBJTz1nOQiXk2q8HU4jaIANLfqKN0NxBwWVWhu
         YKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MnzQb3Jh0ScbQkuyZTj2kaX7pXGg8xHDYyPpDshbrD0=;
        b=jRdJnDeWwDYnMTvrp+VGopq3+st1AbAwxflueDnI+ZUJGtZpDzvn4qRz5bZod3+faC
         ffCNxnE0aZ3WwvjoUqwXHBYWwHoftD7NtR64OJ7bZ72zpez4MNOncqq5FQgAXJL3KthY
         LTGW2jcjRwZ9C7gAmnG8vdcUs8q37h2t8gD/dpeRQEnxAjhsggBnzwfnsPWNHUjTmfMF
         plXho4sJ9HkmOOFDGdPtTsZjwOGt/cmVH89AUfwOONMgl8Hh9jC8uaUFljed6aY5lrLn
         4O6hAm25JCOameEkokbqyY6ZfnpJXSL7RPY1ioGwgQSdgI+nW2AKtsNQ93l9S05duF/s
         gbdQ==
X-Gm-Message-State: AOAM531guXweWORAmQt6L5uyZuFnMLlrGl5EnVODcB278863N0KdT0RJ
        zq5vxew4j186Oxz2Ed88YEhnNVUu42E=
X-Google-Smtp-Source: ABdhPJwy22pg9MN9uVgakY57xFdm6N557g9w2ZsFCW/uyxVXy2/JBYqvPCY0x/9/unvFJDri57uT3w==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr4420612lji.472.1620765167925;
        Tue, 11 May 2021 13:32:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l23sm2954790ljb.26.2021.05.11.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:32:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
        <874kf9qeof.fsf@osv.gnss.ru>
        <CABPp-BHf45K3P8kKfTEWu-acWMdjTz74xvSPJwZVS_o=qagA6w@mail.gmail.com>
Date:   Tue, 11 May 2021 23:32:46 +0300
In-Reply-To: <CABPp-BHf45K3P8kKfTEWu-acWMdjTz74xvSPJwZVS_o=qagA6w@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 May 2021 12:56:32 -0700")
Message-ID: <87lf8lnh8x.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, May 11, 2021 at 12:00 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Tue, May 11, 2021 at 7:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Junio C Hamano <gitster@pobox.com> writes:
>> >>
>> >> > Junio C Hamano <gitster@pobox.com> writes:
>> >>
>> >> [...]
>> >>
>> >> > If we enable "some kind of diff" for "-m", I actually think that by
>> >> > default "git log -m" should be turned into "log --cc".  As you told
>> >> > Alex in your response, "log -m -p" is a quite unpleasant format to
>> >> > read---it is there only because it was the only thing we had before
>> >> > we invented "-c/--cc".
>> >>
>> >> Please, no! --cc has unfortunate feature of outputting exactly nothing
>> >> for a lot of merge commits, causing even more confusion than historical
>> >> "-m -p" format.
>> >>
>> >> The best default for -m output is --diff-merges=first-parent. Everybody
>> >> is familiar with it, and it's useful.
>> >>
>> >> > But that might be outside the scope of this series.  I dunno, but if
>> >> > there is no other constraints (like backward compatibility issues),
>> >> > I have a moderately strong preference to use "--cc" over "-m -p"
>> >> > from the get go for unconfigured people, rather than forcing
>> >> > everybody to configure
>> >>
>> >> I rather have strong preference for --diff-merges=first-parent. --cc is
>> >> only suitable for Git experts, and they know how to get what they want
>> >> anyway. Yep, by using --cc. Why spare yet another short option for that?
>> >
>> > Interesting.  I have a strong preference for --diff-merges=remerge
>> > (yeah, I know it's not upstream, but it's been ready to submit for
>> > months, but just backed up behind the other ort changes.  Sorry, I
>> > can't push those through any faster).  I've had others using it for
>> > about 9 months now.
>>
>> Once somebody uses it for 9 months and starts to understand what it is
>> and really loves it, she can still set log.diffMerges=remerge (new
>> feature) and have fun.
>>
>> >
>> > I think --cc is a lot better than -m for helping you find what users
>> > changed when they did the merge,
>>
>> Yes, but it doesn't mean it should be the default.
>
> I didn't say it should be.
>
>> In my workflows, the first thing that matters is what commit did what
>> changes on the current branch. I don't typically care what the user
>> changed during the merge operation, only about the result. If I do care,
>> then only after I find the merge commit is responsible, and I can then
>> use --cc if I want to.
>>
>> > but I agree the format is somewhat difficult for many users to
>> > understand. (--diff-merges=remerge, or --remerge-diff, fixes these
>> > problems, IMO.) I think --diff-merges=first-parent, while fine when
>> > explicitly requested on the command line, would be wildly misleading
>> > as a default because it would attribute changes to a merge commit that
>> > were made elsewhere.
>>
>> No, it's exactly this merge commit that made these changes to the
>> current branch. The changes you refer to have been made on another
>> branch, and not by this particular merge commit, and we fortunately have
>> the reference to those commits through the second parent of this one.
>
> If you only care about "what introduced these changes to the current
> branch", then it's not only the diff against second parent that is
> irrelevant: ALL commits that are part of the history only via the
> second or later parents are also irrelevant and thus you should be
> using --first-parent when asking this question.  That changes both
> history traversal and the diff output.

No, it's exactly why I don't always want --first-parent. I want to
traverse *all* the history, yet to see what's changed by every commit on
*this* branch in the process of traversal, be it a merge on not a merge
commit.

Thanks,

-- Sergey Organov
