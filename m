Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B65C43217
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbiBJTKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:10:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbiBJTKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:43 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B4810BA
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644520236;
        bh=l+IMxueLWgEV0DP5bqG5i1GIucZVyQPAi0OjcwhDWUg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GNXWfWHgEWRR14yaZBBD0ZUEaEY5I7eIIn61NLeN+46m4wunBxYWX+WbhPMhF3HGW
         l4wHJ454It65qnPuSQsMgWysK20wJn6DqBgoYb4Lv6llFnyY5532mZ6nOTtdvbFRUu
         Fh1QNojug9htZTykm2Exf1gUShCF3278mVnyRH3M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5UkC-1oP2hi2N6w-016zru; Thu, 10
 Feb 2022 20:10:36 +0100
Message-ID: <6f3d288a-8c2f-0d63-ea17-f6c038a9fa3e@web.de>
Date:   Thu, 10 Feb 2022 20:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
 <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de> <xmqqbkzigspr.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
 <xmqqbkzhdzib.fsf@gitster.g> <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
 <xmqqk0e364h7.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqk0e364h7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:spZFLLt016DJM8Y30hXw4zSlQcRMbk1NyZ3QjDWVzzeQiVxuNgk
 aOmUnpzD7GPI2uzai7P97SRaSEgSCC0+5ySBWzicP19mx1AbLjkgz5OY6Op5IiDk5Z0pR3U
 C/TEm2cJ3FyybT+mQezd0F2lM2NnIItOjNUYAeJ0KEUUYxChweOj7yQDLOhSvACyIUBL03L
 Cv57NP3UTgUn10eb7L2Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTP2BTWnTuA=:sVt/xGfTdUwz2cdLwEntA+
 I6R3VYU6hUdPsmLE0m0jPdOtTHR9TRLX+E1pyCfc8zixSXElULK0UDl7peL+hcRh735X4Xz4H
 Xlb13McYb2QqQJWDnCgVbvDijY7IFUQmEUgJNrtuueApsCkTZrwNWdEdrjzvaAY4YgZfr/zdI
 3TgxJFcQ+cxnoE4U+sFN1aaNbW4Gvk9lFnFV4W66C8k0KWK3P3xNaQkOhnYilNrdTydSRKbWP
 LHXD5QrKkcRq2Vj3d/lQvf7vLsdVBMCAI0sShbEJ3fe5vP/NkVNy0eHJnT96VZAa1NJrSWjfD
 kAAT0u9sSyWn4R0fyWY1N75amdo+K59Wf3aBUxOIyd0sgfpKInEcoLcnz1/DT3DXgOF7W6bty
 QaeNqjXG89hClZK0UJDhc7Ks/M5YLzMj2qNEfDbPDsycD7W5+RuazakQ8kfd0aZokyGpaA2Gb
 YXgzPMBQjWCW1vWhef+ZUXHU92bMo8E4pRVapVje1Z5EaqNw3IXHW3k6QU8j6MBNOtzAvadh2
 Rqt6VhAIRb0E21BKeFFFSCCuZUipqhp1l6goYs/x8dk6uwqNaRFf3Weeo5kKIxknujfTf8ynN
 BJ1wdE/vT8h1gmf3IHikFxKNL70kBHt/Nu1e6NM4Fr6KFnuqK99CRdROhtU6vSJYYGc9ELIAo
 eMIQ1uyv0HAGgLRsXQXq2GWD6UTEYWgOylU2SSHIKjvaREH/nyLPmWYnvQ6a/3OQjru7nIWZh
 buacqjAVUeYUN2HXtj21P8Z0e5LYf42OPf3v0KSD533LpKbRV3qQyEtCnyqi5nrO3rQNHFgS6
 Ql4aWCr5gEwdZjsu+f4EmdOq+qc7Bl0f5+DwBqMcy+g/HffIzLciBHJuHzy90rZK1uoq84y7i
 e7jZJMgNnCcSZXsFAwK5ZeMEwRrhQDM79e5VfvI155zznQMmAT4nNzHyXflIEXPTfdfOW6aXw
 J0SJG2XqaWqIMUaHl3GbY5T8bRmqer9/oADqPU+Yzk3aTclu3aSLVKEgM2yjHvFsvV0ap15U/
 9cwr4x2D1gr+c7Zh6BwIAE5ConUJJa6LQ3jjGHBcMuPd3cL/yTh8U6DqUztb5+N3aQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.22 um 23:48 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The number of files is relatively low and they aren't huge, right?
>
> As long as it is expected to fit on the command line, that's fine.
> But if the question is "it is OK to add a new option with known
> limitation", then it should be stated a bit differently.

I asked this question to find out if writing the files to $TMPDIR and
adding them with --add-file instead of with --add-file-with-content
would be feasible in patches 3 to 6.  git archive would not have to be
changed in that case.

>>> This will throw another monkey wrench to Konstantin's plan [*] to
>>> make "git archive" output verifiable with the signature on original
>>> Git objects, but it is not a new problem ;-)
>>>
>>>
>>> [Reference]
>>>
>>> * https://lore.kernel.org/git/20220207213449.ljqjhdx4f45a3lx5@meerkat.=
local/
>>
>> I don't see the conflict: If an untracked file is added to an archive
>> using --add-file, --add-file-with-content, or ZIP or tar then we'd
>> *want* the verification against a signed commit or tag to fail, no?  A
>> different signature would be required for the non-tracked parts.
>
> Yes, which is exactly how this (and existing --add-file) makes
> Konstantin's plan much less useful.
People added untracked files to archives before --add-file existed.

=2D-add-file-with-content could be used to add the .GIT_ARCHIVE_SIG file.

Additional untracked files would need a manifest to specify which files
are (not) covered by the signed commit/tag.  Or the .GIT_ARCHIVE_SIG
files could be added just after the signed files as a rule, before any
other untracked files, as some kind of a separator.

Just listing untracked files and verifying the others might still be
useful.  Warning about untracked files shadowing tracked ones would be
very useful.

Some equivalent to the .GIT_ARCHIVE_SIG file containing a signature of
the untracked files could optionally be added at the end to allow full
verification -- but would require signing at archive creation time.

Ren=C3=A9
