From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] hex.c: reduce memory footprint of sha1_to_hex static buffers
Date: Fri, 13 Feb 2015 13:56:37 -0800
Message-ID: <CAGZ79kaEun-mEQPg7cmPV7RJR8A+BxSsSpeAQgcsuJn8L4TGEg@mail.gmail.com>
References: <1423862329-7899-1-git-send-email-sbeller@google.com>
	<xmqq7fvlmqu8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:56:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOE8-0001jM-5I
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbbBMV4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:56:41 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35058 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbbBMV4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:56:38 -0500
Received: by iecrl12 with SMTP id rl12so20423651iec.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n23zVMwuYZk0aMQToueELn8SsoU03cNbIo0heKuoDGE=;
        b=XqXrdHccDYj94kTuvpS7VxpNpM9RGtGdWaA/dAOol5+1g7D4eWrgxd4plU/JPLhMGh
         dnMNIVtaoFVmRrzTcNFcejXIuKIyNYwYTgO51EAiaYbk2zRjNXrrcqhdAAI4fzvYXbKI
         vRkSLBt2bvFkm43FSdRHCYospEOcjHrdJCCOrZrw4teJsG9Pg1m+ZcxQUki1nQYbZIql
         +MAFkOAczFQ515QsQdo8EvpvOXf9WMM6+pHSWI2PUrl2jhtXPB+hCNGjtd3+6g8NBjcf
         EPDGez30OivbHvzSFz4KY5V+1iycse8NO3+XxOWagaqmiA+VVzbktE9apr+CQKXUMxb3
         yVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n23zVMwuYZk0aMQToueELn8SsoU03cNbIo0heKuoDGE=;
        b=DVlW/YOZ1Mi/kRX4+8A0HNYP20M94vlCXk4Kl4lCiVg6Bv0nGtCGxZmMc7tEWIdUk2
         3IkBJziaq7Rm2UAtcO/UL/QqRLz+p+0OQYqVg/uQrBglEOCeUJGoMMTqRwRG0Zu7gGwC
         V8fpa0X9YLoiPFQXIySCWwXsSggXBLjcTUueABOULuQuKX3b6FIcxbefK6w8VA4iON6e
         l3lFrrG56d5VU1r0bfxabz/K4u4bXcl2gtPsGyK2GGnBXhF32T/ZUCQvzxl7lE1mC+Ms
         CTdB25Wr+tJrMml1Ju+Y8Y32zGG2PA7KFaCrRksvEtJveKPEWY58f6c5dTYybnksVtLm
         j33g==
X-Gm-Message-State: ALoCoQnkJzftBHD41OVQM8XT16MmtgTkwTZO0yFBc6Rgg6M+DBOUKtogv8Dt+216Q0QVJvKcCSqn
X-Received: by 10.107.137.17 with SMTP id l17mr14224204iod.33.1423864597933;
 Fri, 13 Feb 2015 13:56:37 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 13 Feb 2015 13:56:37 -0800 (PST)
In-Reply-To: <xmqq7fvlmqu8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263840>

On Fri, Feb 13, 2015 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> 41 bytes is the exact number of bytes needed for having the returned
>> hex string represented. 50 seems to be an arbitrary number, such
>> that there are no benefits from alignment to certain address boundaries.
>
> Yes, with s/seems to be/is/;
>
> This comes from e83c5163 (Initial revision of "git", the information
> manager from hell, 2005-04-07), and when dcb3450f (sha1_to_hex()
> usage cleanup, 2006-05-03) introduced the "4 recycled buffers" on
> top, the underlying array was left at 50 bytes long.
>
> You can now have "I fixed Linus's bug" badge ;-)

I don't think it's a bug, it's just wasting memory?

As I could not find any documentation on the
magical 50 in the early days, I cc'd Linus
in case there is something I did not think of yet.
