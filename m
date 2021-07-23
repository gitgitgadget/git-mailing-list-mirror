Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B34C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB8860ED4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGWJCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:02:44 -0400
Received: from mail.aixigo.de ([5.145.142.10]:24289 "EHLO mail.aixigo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhGWJCo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 05:02:44 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 05:02:43 EDT
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
        by mail.aixigo.de (OpenSMTPD) with ESMTPS id b8dfc65f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 23 Jul 2021 11:36:36 +0200 (CEST)
Received: from vmdpcl078.ac.aixigo.de ([172.19.100.218])
        by mailhost.ac.aixigo.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 16N9aZrC3462144
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 23 Jul 2021 11:36:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aixigo.com;
        s=default; t=1627032996;
        bh=JK0b2QXRM/mfZl7y6Mci3P86laAQVzX64CeIvyPUPkc=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=CxFMQi/5xN0yqTHJ0vrs2SQGLTbM8l3q1JJf3zphG1FdPi3XR+fqwvKWNZRP6SDyy
         GlTDDGgbomzx83B/K5PqHD+lfhzjn5qQFUmxdA3jc9tXRM5dN3C9BdqLLffBdxVyqh
         cMwGL6cuEOWV+t7KPl1AEnWND7ZiaCD5gjl9/jwY=
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
 <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
 <60f1b7853b8a2_ade9208c1@natae.notmuch>
 <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
 <60f1c9378d5a1_3302085c@natae.notmuch>
 <fa757764-db25-849d-d8d5-e28908059f6b@aixigo.com>
 <xmqq7dhi9nxv.fsf@gitster.g>
From:   Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Subject: Re: pull.rebase config vs. --ff-only on command line
Message-ID: <ed3f7289-0893-5199-a7ca-087604aee029@aixigo.com>
Date:   Fri, 23 Jul 2021 11:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dhi9nxv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/22/21 8:57 PM, Junio C Hamano wrote:
>>   * git -c pull.ff=only pull, do a fast-forward (or merge)
> 
> This should fast-forward if it can or otherwise fail if it cannot,
> right?

Yes, I should not have written "... (or merge)".

>>   * git -c pull.ff=only pull --merge, force a merge commit
> 
> This would fast-forward if it can or otherwise create a merge.
> Unlike "pull --no-ff", this should not "force" a merge commit.

Ack. I.e. it should work like "git merge" would by default.

>>   * git -c pull.ff=only pull --rebase, force rebase
> 
> This would rebase (we may not have our own commits on top of theirs,
> in which case it would end up fast-forwarding plus rebasing 0
> commits).

Yes. Again, this should and would behave like e.g. "git rebase" would if 
I were to rebase a branch which is a few commits _behind_ the branch I 
rebase on top of.

> I do not think the phrase "force rebase" makes much sense, though.
Agree.


-- 
aixigo AG
Karl-Friedrich-Str. 68, 52072 Aachen, Germany
phone: +49 (0)241 559709-390, fax: +49 (0)241 559709-99
email: matthias.baumgarten@aixigo.com
web: https://www.aixigo.com
District Court Aachen – HRB 8057
Board: Christian Friedrich, Tobias Haustein
Chairman of the Supervisory Board: Dr. Roland Schlager
