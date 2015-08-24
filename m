From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 15:58:12 -0700
Message-ID: <xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
	<xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU0h0-00019g-HX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 00:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbbHXW6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 18:58:15 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34132 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbbHXW6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 18:58:14 -0400
Received: by pabzx8 with SMTP id zx8so16536108pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yglBAmk7a4nkELJW8ypr3U1q4+Z1FU9UNWoUPLNStzU=;
        b=lnBqF/ClmFEW/1MkKIxF123y/m8eNeUBfRhBSZpvmb00ba/9sOMLG1wPFiVoIdCpEL
         D0x/ziCqqIzg0MKjnkIIl0zYUCLgehQkcCwsFwTiRsUm+NgpAVNu6UMkPYFUF6urHwkK
         oEeeBW/iP40KX4fHle0lj7EScqQ3bbJAWXTUFkPzcuh8yVk9xzg4T5j1HHb6lx9FOQBq
         /dee2RHNoaJnM70Re1lUTifyPEHznxcs0HwaGUD+LmBdq66ESPSz//WUVvNpM+AJpESI
         Omqn9hD0mLmMfGGuaGeC3SplqnUhHfOB9GpdEj9CwsEnStQmlGiRfMB4yzy0O4cw/24N
         qypQ==
X-Received: by 10.66.222.161 with SMTP id qn1mr51102170pac.66.1440457093931;
        Mon, 24 Aug 2015 15:58:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id w11sm18563692pbs.55.2015.08.24.15.58.12
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 15:58:13 -0700 (PDT)
In-Reply-To: <xmqq7fok2u57.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 24 Aug 2015 15:34:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276496>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>> index 1997657..06d468e 100644
>>> --- a/Documentation/git-for-each-ref.txt
>>> +++ b/Documentation/git-for-each-ref.txt
>>> @@ -133,7 +133,8 @@ align::
>>>  	`<position>` is either left, right or middle and `<width>` is
>>>  	the total length of the content with alignment. If the
>>>  	contents length is more than the width then no alignment is
>>> -	performed.
>>> +	performed. If used with '--quote' everything in between %(align:..)
>>> +	and %(end) is quoted.
>>
>> There's no --quote, there are --shell, --python, ... (well, actually, I
>> would have prefered to have a single --quote=language option, but that's
>> not how it is now).
>>
>> I had already commented on a preliminary version of this series
>> off-list. I think all my previous comments have been taken into account.
>
> Thanks, both.  I think this is pretty close to being satisfactory
> ;-)  There may probably be a handful of minor nits like the above
> that need to be addressed, but I do not think I saw anything
> glaringly wrong that makes the series unsalvageable.  It was a very
> pleasant read.
>
> It's almost there, and I am very happy to see how this and other
> series evolved so far ;-)

Having said all that, it seems that there is some trivial typo or
thinko in the formatting code to break t7004.

Here is what I see...

ok 98 - verifying rfc1991 signature

expecting success:
        echo "rfc1991" >gpghome/gpg.conf &&
        echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
        git tag -l -n1 rfc1991-signed-tag >actual &&
        test_cmp expect actual &&
        git tag -l -n2 rfc1991-signed-tag >actual &&
        test_cmp expect actual &&
        git tag -l -n999 rfc1991-signed-tag >actual &&
        test_cmp expect actual

--- expect      2015-08-24 22:54:44.607272653 +0000
+++ actual      2015-08-24 22:54:44.611272643 +0000
@@ -1 +1 @@
-rfc1991-signed-tag RFC1991 signed tag
+rfc1991-signed-tagRFC1991 signed tag
not ok 99 - list tag with rfc1991 signature
