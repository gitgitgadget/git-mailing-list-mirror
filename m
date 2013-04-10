From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] strbuf: create strbuf_humanize() to show byte sizes
Date: Wed, 10 Apr 2013 12:43:07 -0700
Message-ID: <20130410194307.GA27070@google.com>
References: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
 <1365620604-17851-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:43:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0vR-0005Si-QV
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935371Ab3DJTnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:43:17 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64901 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935310Ab3DJTnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:43:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so490696pad.39
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Lh7MzzyyTe5E1EKIN3SrK2zo6VgNmu8bTajUm/H0aR0=;
        b=pvEwuhR4ufEYKOJYaJ9e9KZkeKrbNt/YGTcdK3GTrX+7FjBbNugPWNDx1ZOOS/8146
         3Iq9YNeQSZ0q4pBwyCXcJKCye94DWa6lVvuboAfjrIqgPh55WF1hQNdwMXMsk86gmN7G
         jes50ljgiXBolqnG+y9OLH2D31Q6g9+ASDZhGp8K/ikc+bpqyR6mAnmIH8ygjjyNXPlc
         2Om8nragkw2J6msSDlzadEAE9poKJqDHPBMCOoSC+khK7bwBrni+973NKkxuBejHwgCO
         uFI4oGbTfUd5oqAgGVif6nda5O+ygu3V8e8wOCRnFXpOkoSeFtzVDHSVw6NBPmAV08sa
         3WBw==
X-Received: by 10.68.71.163 with SMTP id w3mr4665103pbu.139.1365622995598;
        Wed, 10 Apr 2013 12:43:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ak1sm1068500pbc.10.2013.04.10.12.43.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 12:43:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365620604-17851-1-git-send-email-apelisse@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220737>

Antoine Pelisse wrote:

> Separate text formatting from size simplification and make the function
> public in strbuf so that it can easily be used by other clients.
>
> We now can use strbuf_humanize() for both downloaded size and download
> speed calculation.

Sounds like a good thing to do.

>                    One of the drawbacks is that speed will now look like
> this when download is stalled: "0 bytes/s" instead of "0 KiB/s".

At first glance that is neither obviously a benefit nor obviously a
drawback.  Can you spell this out more?

> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -230,6 +230,11 @@ which can be used by the programmer of the callback as she sees fit.
>  	destination. This is useful for literal data to be fed to either
>  	strbuf_expand or to the *printf family of functions.
>  
> +`strbuf_humanize`::
> +
> +	Append the given byte size as a human-readable string (i.e. 12.23 KiB,
> +	3.50 MiB).

Based on the function name alone, it is not easy to guess what it will
do (e.g., maybe it will paraphrase 3 to "three" and 10000000 to
"enormous").  How about something like strbuf_filesize?

If I understand the code correctly, this jumps units each time it
exceeds 1.0 of the next unit (bytes, KiB, MiB, GiB), which sounds like
a fine behavior.

Hope that helps,
Jonathan
