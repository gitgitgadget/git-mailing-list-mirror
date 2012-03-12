From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 11:57:03 -0500
Message-ID: <20120312165703.GB18791@burratino>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye>
 <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 17:57:33 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S78Yu-00066s-HG
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 17:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab2CLQ5V (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 12:57:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39056 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2CLQ5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 12:57:19 -0400
Received: by yenl12 with SMTP id l12so2771025yen.19
        for <multiple recipients>; Mon, 12 Mar 2012 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8cXrHqAuiUbFFU9ME4Ww97JRi556KQICA3p7CzRPsAA=;
        b=lSw2fvgf1g87qZlzD0J2igHnnQuuo+5pKaLfFGmh0fZ8890ESzP1/lgF9Qphrl353n
         S/UmkLKuZ7pHXRCqEMwcqlEX0zPBKNu03R24yTbmC5r/wSOCXEtsWvQutBMz0LC4sDjw
         YhNGnxDpunyVe52nZfYPn/EvDk9rD+9jB6o3kEJvN9dc7jakN+0UJQbB9HAq7iVkCdj1
         x0rRbMUpMDG/ETrFR3A7hvScAkHM/PEgV45F1sX17RZE6e25EGlKBNChogAMXRNpUylg
         1R3kA3ePewL89ZLtwgi2rTSDEIeaxgrQGYbj2+ExCpMldQJI1oXcooKBPxpxEq67wgKW
         YJnQ==
Received: by 10.60.5.193 with SMTP id u1mr8249113oeu.8.1331571438247;
        Mon, 12 Mar 2012 09:57:18 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x5sm21358009obn.5.2012.03.12.09.57.16
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 09:57:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192908>

Thomas Rast wrote:

> The problem with -b is that it's a backwards-compatibility shorthand for
> --binary, which used to pass --allow-binary-replacement (or --binary) to
> git-apply.  However, that option was obsoleted in 2b6eef9 (Make apply
> --binary a no-op., 2006-09-06) and has been a no-op for over 5 years.
> It has also not been documented since cb3a160 (git-am: ignore --binary
> option, 2008-08-09).
>
> So perhaps we can safely claim -b for --keep-non-patch, like so:

Thanks.

It we want to be extra friendly to people who have been using
"format-patch --binary" with "am -b" in their scripts, we could have a
transitional period during which -b is treated as a usage error.

Luckily, a quick Google code search does not reveal any users for "am
-b", so I am not too worried and would not mind your patch that just
switches over right away, though.  After all, the failure modes are:

 - if my current script using "am -b" gets run using ancient git, it
   will accept binary patches and will strip out too many brackets
   in the subject line

 - if my ancient script using "am -b" gets run using current git, it
   will helpefully keep [IA64] brackets in the subject line

Neither seems terribly painful.

The manual would need to mention that this once meant --binary to
avoid confusion when that happens.

Hope that helps,
Jonathan
