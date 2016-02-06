From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv8 4/9] submodule-config: slightly simplify
 lookup_or_create_by_name
Date: Fri, 5 Feb 2016 16:48:53 -0800
Message-ID: <20160206004852.GC28749@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
 <1454623776-3347-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRr3b-0000nG-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 01:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbcBFAs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 19:48:56 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34833 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcBFAsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 19:48:55 -0500
Received: by mail-pf0-f177.google.com with SMTP id c10so10798406pfc.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 16:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S273Rh55L/dfL9lQ2nv5SUc7Kmkpq5zAB/B4zWfrT7U=;
        b=tMGlsoIKTzZrZLw5Kzq3gi7nYUPgdUaHGz7c8c8NfftZMejd1Kw27W5WfQnsYuSqVq
         EFLXFMuUx4w20pnP5zDQy+mSnun5hjLRoYM6qxKlfasUc4LBC0eBTgu9NaDkgqgeXNmT
         64UjfNRD0Ldz49hBkPrHfG/ryqmXHQXXIy6HVaieOiWMsUSZffNZmYRVvW2BxTVLbs+G
         lfkhsbrhztmYelcfK9wP+PqL4N+iuzP4pZR3GRFpx72VsaK4+l6n/cCExjrmeys/8VSC
         AumAlHG7h7sn2fhkJqXTieW350ftNv+D6GPp8kkqOHh2FiYUj6WUnFmtp9Jeooeej6i5
         4feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S273Rh55L/dfL9lQ2nv5SUc7Kmkpq5zAB/B4zWfrT7U=;
        b=KTgpiIbhjRYOhhYWLiBzsEK/Lw119SdZmTe0DYP5hpvfDy6OWiX0aL4wHzQ18VNDjz
         cUSo/Dx5G8WUtZ6CS+2Z1cCtitN/V9kvAQHU5Ym9JPFo+pkAUHR9O7dPqwNjhrwi8Iic
         qgrPprMhDvdO5tKnl7AEH1IW+t1Y6Nb7dW8p8NEDSuPoP/JRPp9AhTQBQ1StcuRkVgHs
         KqFvryaDuTLb6MmIzs7MI8iJXaNmH+sLyYNXcz/ByPAFFzCq7foB9efZPxpaxBMSIF3l
         fdgPVcp0D+vmFORstTHiwALVAkl8o9KLkVLjIlvXCh+bmNPxKNvtTZvPyqVaM4ShIFMs
         WQLg==
X-Gm-Message-State: AG10YORv8TBzimC64esZjo2fjFSuox9v6TFRh2THhRNS+jujYbpo61zXf1t4BZVKBS3Cww==
X-Received: by 10.98.66.81 with SMTP id p78mr24176324pfa.43.1454719735309;
        Fri, 05 Feb 2016 16:48:55 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d5a0:f713:2934:4c2])
        by smtp.gmail.com with ESMTPSA id 89sm27097637pfi.2.2016.02.05.16.48.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 16:48:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454623776-3347-5-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285660>

Stefan Beller wrote:

> No need for a strbuf, when all we use it for, is duplicating a string.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
