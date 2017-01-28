Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC27D1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 13:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdA1Nr4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 08:47:56 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:21658 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdA1Nry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 08:47:54 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id XTHZcmwLZxR4bXTHZclSEp; Sat, 28 Jan 2017 13:43:10 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=cwrikimMAAAA:8
 a=PKzvZo6CAAAA:8 a=anyJmfQTAAAA:8 a=uPZiAMpXAAAA:8 a=6dIGq6VdZj6MdIG8TrIA:9
 a=QEXdDO2ut3YA:10 a=E-ekhOY-9DyL1cemECQz:22 a=q92HNjYiIAC_jH7JDaYf:22
 a=YJ_ntbLOlx1v6PCnmBeL:22 a=svzibyHiZmA4t4YY0eFS:22
Message-ID: <C0FB9362D83842EB97B4C795C91F1775@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>,
        "Jeff King" <peff@peff.net>
Cc:     "Michael Spiegel" <michael.m.spiegel@gmail.com>,
        <git@vger.kernel.org>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com> <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net> <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
Subject: Re: show all merge conflicts
Date:   Sat, 28 Jan 2017 13:43:11 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKGsDmIAKPNMZnkZoJcezNi1b32IO+yzYTAJyDXA8FmUgQ+64OLwYED8C7ZeQ313XvGEYUf25DI2mebMKvPlP9pLeBOE6qRGAwpnS3RAOayD49B8v4OJ
 aHbP/XnIgda9UF59TZneSWBd07RgjN0H4yzbc/cFepBE3KwnesPWceyTdagufQRk/c7rU7MbwdZZpttBoHJPtdvJ5GW7Diz2dCx8rMVWGuvCME18CK+660bS
 ACLuMCSBt1JQRCGNQxn1TYhCqMabt8h4lVwJCyDrpHA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "G. Sylvie Davies" <sylvie@bit-booster.com>
> On Fri, Jan 27, 2017 at 9:51 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Jan 27, 2017 at 11:56:08AM -0500, Michael Spiegel wrote:
>>
>>> I'm trying to determine whether a merge required a conflict to resolve
>>> after the merge has occurred. The git book has some advice
>>> (https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging) to use
>>> `git show` on the merge commit or use `git log --cc -p -1`. These
>>> strategies work when the merge conflict was resolved with a change
>>> that is different from either parent. When the conflict is resolved
>>> with a change that is the same as one of the parents, then these
>>> commands are indistinguishable from a merge that did not conflict. Is
>>> it possible to distinguish between a conflict-free merge and a merge
>>> conflict that is resolved by with the changes from one the parents?
>>
>> No. You'd have to replay the merge to know if it would have had
>> conflicts.
>>
>
>
> Aside from the usual "git log -cc", I think this should work (replace
> HEAD with whichever commit you are analyzing):
>
> git diff --name-only HEAD^2...HEAD^1 > m1
> git diff --name-only HEAD^1...HEAD^2 > b1
> git diff --name-only HEAD^1..HEAD    > m2
> git diff --name-only HEAD^2..HEAD    > b2
>
> If files listed between m1 and b2 differ, then the merge is dirty.
> Similarly for m2 and b1.
>
> More information here:
>
> http://stackoverflow.com/questions/27683077/how-do-you-detect-an-evil-merge-in-git/41356308#41356308
>
>
> - Sylvie

This feels as though there ought to be some sort of --left-right option to 
get an indication of which side various changes came from

>
>> There was a patch series a few years ago that added a new diff-mode to
>> do exactly that, and show the diff against what was resolved. It had a
>> few issues (I don't remember exactly what) and never got merged.
>>
>> Certainly one complication is that you don't know exactly _how_ the
>> merge was done in the first place (e.g., which merge strategy, which
>> custom merge drivers were in effect, etc). But in general, replaying
>> with a standard merge-recursive would get you most of what you want to
>> know.
>>
>> I've done this manually sometimes when digging into erroneous merges
>> (e.g., somebody accidentally runs "git reset -- <paths>" in the middle
>> of a merge and throws away some changes.
>>
>> You should be able to do:
>>
>>   git checkout $merge^1
>>   git merge $merge^2
>>   git diff -R $merge
>>
>> to see what the original resolution did.
>>
>> -Peff
> 

