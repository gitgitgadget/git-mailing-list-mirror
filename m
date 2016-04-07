From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] sequencer.c: fix detection of duplicate s-o-b
Date: Thu, 7 Apr 2016 16:06:59 -0400
Message-ID: <CAP8UFD2OQfcogZj-hELxBB+-rWSW1YwPBCOXK1+oM2kKGaMwaA@mail.gmail.com>
References: <20160312130844.GA25639@1wt.eu>
	<xmqqr3eizsxu.fsf@gitster.mtv.corp.google.com>
	<20160406163726.GG28596@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Willy Tarreau <w@1wt.eu>
X-From: git-owner@vger.kernel.org Thu Apr 07 22:07:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGCw-0005zn-VH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbcDGUHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:07:08 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36291 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342AbcDGUHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 16:07:07 -0400
Received: by mail-wm0-f43.google.com with SMTP id v188so67974020wme.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zTLDb8aDD3Avg0xZ15h9VoX/ig3DBMYxG+QJv4qVF7Q=;
        b=Pq+xlmYhvlXpTgAgyeyfDesMmizaugsd1fo0YN90qSpX26evHYm64kgMp3/NHqD60u
         Tsr8zrxZe9z4N72KL4QNrweKU3c/gT7G9m6ZScb3dE6sIANvkTOIc6L/tv0K5S5HfiNL
         IqLnkwsfFxSJjpCMFauUVi+AquHkeedqzE+jd8voTqagFqsmm3m+jZIg8m1lSf8joSGQ
         2P+JnQ2no54mcsKnJSBNmFhjojFR7tZAnerKAB33xFzdvvlrAhJnVTq8CcpYYOtI3eaq
         iuJdKKsrDY5A0j/bJnFJWmqOJZk3hN78TdF+zgVuYsz9146agZMipBcT+qYmhZSUR019
         BMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zTLDb8aDD3Avg0xZ15h9VoX/ig3DBMYxG+QJv4qVF7Q=;
        b=kiGutco8Ledvq4C0A+INIIcmkaaUvZ5+DEFEAyv9cnaEsWFdUkhvTxb9n5kjVS0mk4
         A5qVS+mkTwX4DcKF8Mm6fe5a0VM10UaQj2cs0C0IZGy18z1nXFEfvONnGmL0r3B4VLMX
         3d6Ndi8PzFSc2EzHL0lrmNKBKtepKN8uyUVXyVvD8Q7x+dVYm20zXppf/RwXerhNcpbP
         BzUHsCQH9ndZmMDh71wGE0GIc13ndNawjYd30oneas2jcOk5KeolmLIR5k9+AAoLQNue
         cM5M2NCdYINvLPcoE4HPiPyNaCiu5QXkpxkdQxIrsbugh+ragjEk7l+R9MYOBPAfDFbZ
         W4zw==
X-Gm-Message-State: AD7BkJKDmtpovSqG2iqyiA6G3I5Hksy+tX31FhTJUaGVq6pQE5Cdp29z4vNt+j42WJiZOrkcKvE/t1elZhYgig==
X-Received: by 10.194.78.37 with SMTP id y5mr5459762wjw.78.1460059620011; Thu,
 07 Apr 2016 13:07:00 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Thu, 7 Apr 2016 13:06:59 -0700 (PDT)
In-Reply-To: <20160406163726.GG28596@1wt.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290980>

On Wed, Apr 6, 2016 at 12:37 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Wed, Apr 06, 2016 at 07:57:01AM -0700, Junio C Hamano wrote:
>> This seems to have been lost, perhaps because the top part that was
>> quite long didn't look like a patch submission message or something.
>
> Don't worry, we all know it's the submitter's responsibility to retransmit,
> I apply the same principle :-)
>
>> Git 1.7.12 is a quite ancient release and I wouldn't be surprised if
>> we made the behaviour change during the period leading to v2.6 on
>> purpose, but nothing immediately comes to mind. Christian (as the
>> advocate for the trailer machinery) and Brandon ("git shortlog
>> sequencer.c" suggests you), can you take a look?

Ok, I will try to have a look at that next week.

> FWIW it wad changed in 1.8.3 by commit bab4d10 ("sequencer.c: teach
> append_signoff how to detect duplicate s-o-b").

So the change is quite old and was made before I started working on
the trailer machinery.

> The change made a lot of sense but it didn't assume that this practice
> was common. And indeed I think this practice only happens in maintenance
> branches where people have to make a lot of adaptations to existing
> patches that they're cherry-picking. We do that a lot in stable kernels
> to keep track of what we may need to revisit if we break something.

Yeah, we know for some time, but after the above patch breakage
happened and after I worked on interpret-trailers, that some lines
inside [] are added by kernel people in the trailer part and that the
trailer machinery doesn't work properly with such lines.

Anyway if you want your patch to be applied, it will probably need tests.

Thanks,
Christian.
