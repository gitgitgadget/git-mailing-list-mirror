From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Tue, 25 Aug 2015 18:56:55 +0530
Message-ID: <CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <vpqzj1hkc5q.fsf@anie.imag.fr> <xmqq7fok2u57.fsf@gitster.dls.corp.google.com> <xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 15:27:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUEGA-0004nI-6r
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 15:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbHYN10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 09:27:26 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35087 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbbHYN1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 09:27:25 -0400
Received: by obbwr7 with SMTP id wr7so141755312obb.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O8/l1ap92/0MBv7dMyVL6o4MlYmWbwGfClUaQYNijZU=;
        b=eUfxjYQOirV01WGKaDpAUTZVGf4Yfb/qJwA97/PI8JcFbzRYR9GPsLe9VRxAk+RYvt
         NJ+nGPK3/TLE/Xm7PaIEehGZxYmFLhfXLTnM6/5enex/3c5DasQBpv6kK51bFf2/OXZ2
         7YAmgoQeffJ8bPlWFa6w6Ij++5Gn5eqd11LKeDmsjEs8nfXJXdsSIQbJm/ddQRx/Cn5i
         5oiAkJL7pNSnRw2xW1Ebp0NRUTP1ijhlbc5GNteiSXSExDpAVlRmd6b6zxNN/Jm3uldY
         2WNDT+YUXrMlT9V1vGvpznB8nIGVtXlmRHIjCHs6foEsa/MQL80n9fIOJKQ0iGzCU8t6
         +y4A==
X-Received: by 10.60.70.104 with SMTP id l8mr26182170oeu.37.1440509244729;
 Tue, 25 Aug 2015 06:27:24 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 06:26:55 -0700 (PDT)
In-Reply-To: <xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276526>

On Tue, Aug 25, 2015 at 4:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>>> index 1997657..06d468e 100644
>>>> --- a/Documentation/git-for-each-ref.txt
>>>> +++ b/Documentation/git-for-each-ref.txt
>>>> @@ -133,7 +133,8 @@ align::
>>>>     `<position>` is either left, right or middle and `<width>` is
>>>>     the total length of the content with alignment. If the
>>>>     contents length is more than the width then no alignment is
>>>> -   performed.
>>>> +   performed. If used with '--quote' everything in between %(align:..)
>>>> +   and %(end) is quoted.
>>>
>>> There's no --quote, there are --shell, --python, ... (well, actually, I
>>> would have prefered to have a single --quote=language option, but that's
>>> not how it is now).
>>>
>>> I had already commented on a preliminary version of this series
>>> off-list. I think all my previous comments have been taken into account.
>>
>> Thanks, both.  I think this is pretty close to being satisfactory
>> ;-)  There may probably be a handful of minor nits like the above
>> that need to be addressed, but I do not think I saw anything
>> glaringly wrong that makes the series unsalvageable.  It was a very
>> pleasant read.
>>
>> It's almost there, and I am very happy to see how this and other
>> series evolved so far ;-)
>
> Having said all that, it seems that there is some trivial typo or
> thinko in the formatting code to break t7004.
>
> Here is what I see...
>
> ok 98 - verifying rfc1991 signature
>
> expecting success:
>         echo "rfc1991" >gpghome/gpg.conf &&
>         echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
>         git tag -l -n1 rfc1991-signed-tag >actual &&
>         test_cmp expect actual &&
>         git tag -l -n2 rfc1991-signed-tag >actual &&
>         test_cmp expect actual &&
>         git tag -l -n999 rfc1991-signed-tag >actual &&
>         test_cmp expect actual
>
> --- expect      2015-08-24 22:54:44.607272653 +0000
> +++ actual      2015-08-24 22:54:44.611272643 +0000
> @@ -1 +1 @@
> -rfc1991-signed-tag RFC1991 signed tag
> +rfc1991-signed-tagRFC1991 signed tag
> not ok 99 - list tag with rfc1991 signature
>

Thats weird, I just ran all tests, and nothing failed.
Is this mid-way of the patch series? I tried it on the entire
series and seems fine to me

-- 
Regards,
Karthik Nayak
