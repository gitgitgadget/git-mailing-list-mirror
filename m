From: David Ware <davidw@realtimegenomics.com>
Subject: Re: [PATCH v3] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Wed, 9 Dec 2015 13:16:52 +1300
Message-ID: <CAET=KiWRazHNTT5dJakUFGmRKMnFhv3Lxkm2WXa6bue=BrfU+A@mail.gmail.com>
References: <CAPig+cR36772YDc5RQRwXP3+ucVWumim9HYTXVMuGXN2cnQ7Ow@mail.gmail.com>
	<1449607160-20608-1-git-send-email-davidw@realtimegenomics.com>
	<xmqqk2ook52u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 01:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6SRG-00020N-HY
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 01:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbLIAQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 19:16:54 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36741 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbbLIAQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 19:16:53 -0500
Received: by vkay187 with SMTP id y187so33157643vka.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 16:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tsrb8mdqa76AXCGGiSNzN3CqKvq71kPg1kn6DsM8Nl4=;
        b=epz8/JStM7MbvwRLi2stuMpqiajaIP379QcCA75mjzBqauEtFR61m5LKBYAsFcF+bs
         VD0PG+PSEZ4lHqYYxep7HIE4XNME5811Klo9cNZyrtFaLhPA7mVrLD02aJGEhKIthT1f
         F1xKNNamZPOmih9BTS4+hGmqdAN1mK+AeGLCQnIGgLULN79v+jUJ+mzh7XSD6Fquif10
         r0xW8c3c4eaVTFEKjrYrXo0mQ/EkGGQQ7+b3iOcR17dJQgP/c0gNXs4Dq2JzvcwMiSLJ
         oNJR8DnitxTWoAAuoLSaDAOoow0ma+RxSvXt/RM/u6ywwSE/p7YzLTuDbhBAOSj5gIS5
         NKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Tsrb8mdqa76AXCGGiSNzN3CqKvq71kPg1kn6DsM8Nl4=;
        b=UZxZ+QUdxxZ2v7XfaoYk3zsgAhzm1Djz8iIOzpYTjVw2z9GLWDdSfSUIQYNC/blmJ7
         zeB2HcDKIr0488iBY5xQ1dq827ONR5gxxrqQpw7Lb/7ttzd7VrieQPZNbtbi3Bl5JKYO
         wwgGYwccfIX7myTNXH5QOJ+KyV8oXFJVjCCguAp/aHnBi4zmS7ck21VzZSzPMZK5ouAZ
         bm/VQ9jhAMcueWvZDMqdRQyec1mHT8s3GseZt2o/Kk32iDIK8qPO7mVUU7sRgleFZVlw
         wKldasCo5wRv7QQj0ilLlerHjDVctrhXfS/C3qagjHm1UEhYyQcdr2RjiqtCjEEhsMfZ
         XVhw==
X-Gm-Message-State: ALoCoQkloNKW8Ema05ROfbYUDR2CK/QgltLW2XljTjGwUTdU2bDzSMmCqzGbPF+uO1C3xKjqiemIZO+h7gfHmuLGnicYnopBPUqzzzyBlc3Ni7VMGMwf0II=
X-Received: by 10.31.5.132 with SMTP id 126mr2240053vkf.107.1449620212669;
 Tue, 08 Dec 2015 16:16:52 -0800 (PST)
Received: by 10.31.236.4 with HTTP; Tue, 8 Dec 2015 16:16:52 -0800 (PST)
In-Reply-To: <xmqqk2ook52u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282181>

On Wed, Dec 9, 2015 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Ware <davidw@realtimegenomics.com> writes:
>
>> A bug occurs in 'git-subtree split' where a merge is skipped even when
>> both parents act on the subtree, provided the merge results in a tree
>> identical to one of the parents. Fix by copying the merge if at least
>> one parent is non-identical, and the non-identical parent is not an
>> ancestor of the identical parent.
>>
>> Also, add a test case which checks that a descendant can be pushed to
>> its ancestor in this case.
>>
>> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
>> ---
>
> The first sentence may be made clearer if you rephrased the early
> part of the sentence this way:
>
>         'git subtree split' can incorrectly skip a merge even when
>         both parents ...
>

Noted.

>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 9f06571..b837531 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -479,8 +479,16 @@ copy_or_skip()
>>                       p="$p -p $parent"
>>               fi
>>       done
>> -
>> -     if [ -n "$identical" ]; then
>> +
>> +     copycommit=
>> +     if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
>> +             extras=$(git rev-list --boundary $identical..$nonidentical)
>> +             if [ -n "$extras" ]; then
>> +                     # we need to preserve history along the other branch
>> +                     copycommit=1
>> +             fi
>
> What is the significance of "--boundary" here?  I think for the
> purpose of "is the identical one part of the nonidentical one?" you
> do not need it, but there may be something subtle I missed.  I am
> asking this because use of "rev-list --boundary" in scripts is
> almost always a bug.
>

The other way around actually I'm trying to determine if nonidentical
contains any commits
 not in identical.  I'll confess I don't actually know specifically
what the --boundary option
does, this probably came from a stack overflow example while we were
looking up how to
best do the check. Further experimentation with the option suggests
that it does not do what
I want, so I will remove it. Thank you.

> Also, depending on how huge the output from the rev-list could be,
> you might want to use "rev-list --count $i..$n" and compare it with
> 0 instead--that way, you would not have to be worried about having
> to carry around a huge string that you would otherwise not use, only
> to see if that string is empty.

Thanks, I didn't know about that option.
