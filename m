From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 22/23] lock_any_ref_for_update(): inline function
Date: Mon, 8 Dec 2014 15:34:22 -0800
Message-ID: <20141208233422.GM25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 09 00:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7oy-00068Q-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 00:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbaLHXeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 18:34:25 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:55161 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbaLHXeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 18:34:24 -0500
Received: by mail-ie0-f201.google.com with SMTP id rp18so664379iec.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+7hv97ubMv74/huwl2FI1wsaBx5fAAE8jBQZOkD/FTk=;
        b=SXhnBChlvlFQJ4Fk0MzTCtAHLdRi4H0vKCggcBits55swxOfBoBRGK9yPIEK82Kj08
         6/2kY3IJZTh813vPda/W3KL6B+46zdi0Q8owsGVSaeN/8cTAOKtIAxbg/JIOMnRag2jg
         M4M5uxg1f43prKkVz6E1KfxLt7WzvP+A1avbkygLVGU8aCF2ZXc2HiedrK8hiQb2w/4/
         b8VcZBF3d35mss4mSqo5QQwN640DMgIUBS0Pml9IVPSqKC9MLHIiAQBoFy380JKfphu6
         p5qkHGppG3LoqsebIyBLruckjEnqJ6yp24KdPX1RT/JfHxI9o1SpVyE9IapfBp6wnBpS
         5Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+7hv97ubMv74/huwl2FI1wsaBx5fAAE8jBQZOkD/FTk=;
        b=jb5WHDHH34jkmaJnSjO38lDkM6t5vQYtItY5TicrJUEBAN75Y7rO2thQGG0VWWI2XD
         1uqwgDQrmH+Wib22zKNO0lydIO3vhQFR+/qLYZ6ylQq5b2Gd9DZFJkUIAbL5z1BfPVEV
         Xt9SF9yL0vmv2dxArJ4XM6z+wrBHI53N77KfVktDJ7ZEzIVnF8u+I0Q8jlNrhzSPQ5o3
         EbRiYcZQnSDeAwbcqeMgVfbedZ5mNObXCN5s3gLteJeaasSCWXiKCVkIGHPfB0O2TFGI
         a2FhJYFdD797RU2DxZalZ46So4ox0OXsawo855k0Dqq92bJ+KCuqIaenAzKlojXGGPH9
         S5LA==
X-Gm-Message-State: ALoCoQlvrhOslHda9TABJcX9AOaJH2UBAZ1/a97MdLoN4WJ4nVzEO+iHGpdTBu/q8bKoK6IhvcnH
X-Received: by 10.43.9.72 with SMTP id ov8mr33111525icb.20.1418081663674;
        Mon, 08 Dec 2014 15:34:23 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id r6si1700947yhg.1.2014.12.08.15.34.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 15:34:23 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 07nBelvc.1; Mon, 08 Dec 2014 15:34:23 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id A355F140BBD; Mon,  8 Dec 2014 15:34:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-23-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261098>

On Fri, Dec 05, 2014 at 12:08:34AM +0100, Michael Haggerty wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Inline the function at its one remaining caller (which is within
> refs.c) and remove it.
> 


> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

It's originally from Ronnie, but his sign off is missing?

If that sign off is found again, 
Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  refs.c | 9 +--------
>  refs.h | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)
> 
