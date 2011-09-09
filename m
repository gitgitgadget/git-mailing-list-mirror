From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/6] Improved infrastructure for refname normalization
Date: Fri, 09 Sep 2011 10:06:53 -0400
Message-ID: <4E6A1D7D.6050602@gmail.com>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21ja-00032H-Jh
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab1IIOHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 10:07:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53185 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1IIOHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 10:07:02 -0400
Received: by eyx24 with SMTP id 24so1303401eyx.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jJppkPdWtGYq8VXXss775MepoQs+J6ASRSl1wNrdvYM=;
        b=DSZvJqpjkNqzHzWG6eJQtqEuKYRF3G/hF/3mXkKYLA/9boKZ3g0GSFkfXqw4ky/bvV
         bfDNSbaKfJUghqq2T2hPsmKAR3UhZRQSxwPedk88y0XzMd/yjRVhVhavotkfUKAkGS61
         sCO/jNUWYVDKW9jeEoymi/U5tgzuzIqfOpSOY=
Received: by 10.52.65.42 with SMTP id u10mr467355vds.267.1315577219847;
        Fri, 09 Sep 2011 07:06:59 -0700 (PDT)
Received: from [10.0.1.131] (cpe-67-248-162-240.nycap.res.rr.com [67.248.162.240])
        by mx.google.com with ESMTPS id ch2sm4752724vdc.19.2011.09.09.07.06.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Sep 2011 07:06:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110818 Icedove/3.0.11
In-Reply-To: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181069>

On 09/09/2011 07:46 AM, Michael Haggerty wrote:
> As a prerequisite to storing references caches hierarchically (itself
> needed for performance reasons), here is a patch series to help us get
> refname normalization under control.
>
> The problem is that some UI accepts unnormalized reference names (like
> "/foo/bar" or "foo///bar" instead of "foo/bar") and passes them on to
> library routines without normalizing them.  The library, on the other
> hand, assumes that the refnames are normalized.  Sometimes (mostly in
> the case of loose references) unnormalized refnames happen to work,
> but in other cases (like packed references or when looking up refnames
> in the cache) they silently fail.  Given that refnames are sometimes
> treated as path names, there is a chance that some security-relevant
> bugs are lurking in this area, if not in git proper then in scripts
> that interact with git.

Why can't the library do the normalization instead of expecting every 
other component that deals with reference names having to do it for the 
library?

[...]

>
> * Forbid ".lock" at the end of any refname component, as directories
>    with such names can conflict with attempts to create lock files for
>    other refnames.

I find this overly restrictive. If you need to create a lock based on a 
reference name or component, use a name for the lock object that starts 
with one of the characters that reference names or components are 
already forbidden from starting with.


Gitzilla
