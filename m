From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Fri, 22 Aug 2014 21:59:21 +0200
Message-ID: <53F7A119.7070704@gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 21:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKuzf-0007F8-RU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 21:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaHVT7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 15:59:24 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:52033 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaHVT7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 15:59:23 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so10993723wes.7
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=3bgxDUyAibOj66JKS1b8Udk/lUpBV/wIVLQ/4uiZfFM=;
        b=NJPKICKTBcKWVETVsWGmZbSWJ1HM5mrBg61eY662SIbHli9eRTZiSY+fHYJNM1HHNl
         vYDQ8Wl411b6ePSuY0PWFO9pDKL/ktjJ0oXbpWdcL9IVmCwCZRac2FfvjFRiWWhp1HIZ
         O25mQUvJCs0Iw/G0PZs0xaBLhrRcovNGiryAH3hhHYTGUqnTcIwXVrpMqg8SLPbCgdB8
         ueLhHVJHjU0eU4c23ZK5xzjv0/BFasDyc1rOY73Em6Sno4EliVaSW2IZ9JDzBFY/tGzj
         s7TLvcKIJWwuKgeg18CVHbT3daVTpIHITgCSQSrS5+kIYCGPgi+P+bV76Jez6Q6uYziu
         t7Lg==
X-Received: by 10.180.72.146 with SMTP id d18mr489116wiv.53.1408737562210;
        Fri, 22 Aug 2014 12:59:22 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id ch5sm77542389wjb.18.2014.08.22.12.59.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Aug 2014 12:59:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255698>

On 20.08.2014 00:06, Junio C Hamano wrote:
> While signed tags and commits assert that the objects thusly signed
> came from you, who signed these objects, there is not a good way to
> assert that you wanted to have a particular object at the tip of a
> particular branch.  My signing v2.0.1 tag only means I want to call
> the version v2.0.1, and it does not mean I want to push it out to my
> 'master' branch---it is likely that I only want it in 'maint', so
> the signature on the object alone is insufficient.
> 
> The only assurance to you that 'maint' points at what I wanted to
> place there comes from your trust on the hosting site and my
> authentication with it, which cannot easily audited later.
> 
> This series introduces a cryptographic assurance for ref updates
> done by "git push" by introducing a mechanism that allows you to
> sign a "push certificate" (for the lack of better name) every time
> you push.  Think of it as working on an axis orthogonal to the
> traditional "signed tags".

What kind of additional benefit do we gain? (i.e. why?)
The described problem, the lacking auditability of what's pushed
at which time, could be worked around like this:

Whenever you do a push, you just tag the latest commit in that branch.
So there would be tags like:
	master_2014_08_21
	master_2014_08_22
	...
	maint_2014_08_13
	maint_2014_08_21
and so on. Whenever there is no tag at the tip of the branch, we'd
know there is something wrong.
	
My guess would be usability as tagging so many branches is cumbersome
for a maintainer?

Looking at my made-up workaround again:
That would produce lots of tags. So I could imagine there would also be
lots of push certs. The number of push certs would
roughly scale linear to time passed. May this result in slowness over time?

Does this patch series mean, we'd get another object type (additional to
blobs, commits, tags, trees)?

I did not read the code yet, it's just first thoughts,
so this weigh this input lightly.

Stefan
