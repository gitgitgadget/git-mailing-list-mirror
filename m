Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D4C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD24260F9D
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 07:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhG1Hoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhG1Hob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 03:44:31 -0400
Received: from mail.aixigo.de (mail.aixigo.de [IPv6:2001:67c:13b0:ffff::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE17BC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 00:44:29 -0700 (PDT)
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id 7141a045 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 28 Jul 2021 09:44:26 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de (vmdpcl078.ac.aixigo.de [172.19.97.224])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16S7iPKa038394
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 09:44:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1627458265;
        bh=rt78rysowXj8hDmV4A8DO9CC5toh4rR027r4Ud+03do=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=RtxjZXTPJhlyPMIzFk0veWN7wlHeYB+cdQhv48QkRHc9EfRTqJXuhV1LAqVp3I6Oe
         ctUEkWy/4p7ZINdU2TJy+AAbUEmUVIXpRS6aKPwdAVT64WquQcLkAmcjlAbMFK2jAd
         uQEpF62piyENQS1FjiJSiYvDd378flSNviOYzyKc=
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g>
 <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
 <xmqqwnpcdu1w.fsf@gitster.g>
 <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
 <610038c0e1056_8fd52084a@natae.notmuch>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
Message-ID: <9e8f1c87-cd08-e1a2-fd5d-713cb0590049@aixigo.com>
Date:   Wed, 28 Jul 2021 09:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <610038c0e1056_8fd52084a@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/21 6:48 PM, Felipe Contreras wrote:
> Alex Henrie wrote:
>> On Tue, Jul 27, 2021 at 2:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>>
>>>> Junio, would you be willing to accept adding -m without adding --merge also?
>>>
>>> My gut feeling is that "-m" without "--merge" in the context of
>>> "pull" is extremely unlikely to fly well.
>>>
>>> As "git pull" is a "git fetch" followed by a "git merge" (or "git
>>> rebase"), it takes the union of common command line options from
>>> both phases, and "git merge" takes "-m 'message'" which is an option
>>> fairly familiar to users (since it comes from "git commit").  Even
>>> if we are never going to pass "-m message" from "git pull" down to
>>> underlying "git merge", squatting on short and common "-m" would be
>>> a bad idea.
>>
>> Thanks for the explanation. I forgot that "-m" usually means
>> "message". That does seem like a good reason to not use "-m" for
>> "merge".
> 
> It means --merge plenty of times:
> 
>   * git restore -m
>   * git checkout -m
>   * git rebase -m
>   * git diff -m
>   * git read-tree -m
>   * git diff-tree -m

Add to Felipes list:

  * git switch -m

and maybe git cherry-pick -m where -m does not mean "merge" itself but 
is used to determine the parent of the merge (when picking merge 
commits) to base on.

Other examples of where -m has different meaning than merge:

  * git am -m (message-id)
  * git branch -m (move branch)

I would rephrase the question as to what would I expect `git pull -m` to 
do, if I had never heard of it before. In the case of fast-forwarding 
and rebasing trying to add a merge commit message with -m would not even 
make sense. Only in the case of trying to create a merge commit by 
issuing git pull this would make sense. So if we could agree on that 
being not the most used scenario, I think -m would be a great short 
option for --merge.

-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
