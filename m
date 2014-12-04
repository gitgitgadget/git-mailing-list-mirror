From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/23] expire_reflog(): exit early if the reference has
 no reflog
Date: Thu, 4 Dec 2014 15:48:02 -0800
Message-ID: <20141204234801.GH16345@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:48:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwg88-0007ed-9x
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbaLDXsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:48:12 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55154 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbaLDXsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:48:12 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so19660961igb.7
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QUD5jj/mMtxJDjrsa8Uz2c7kAM+CPoEPlBVqiC4U8ec=;
        b=AYjEjzrpEO4t3P7d3T9X7z1pXTnHmqJp3vr6z4X51CHCujH/Eb1nKpFGVxEq0sGLfq
         a2No88UI4Co75qGDB7kwpc+0SkI+3EG275XecPM1qbJvbi18VDAbSf6E40Xef+v5Neqf
         4k8hahcpo3HW3/cwm29nCsQut7q9v8bDzaPLP7j8jhFWSYWHQLDvI1asxgIpb3kSL7JQ
         M+A96iyfjIx3wVPRK2xKx66xgdAMadGjkhBqVmoR+T9gHywudqmcNKwhvSg0Bl3eaYpB
         1HYgwli0S8FvFIHk0Z0GQwejj+QdaLjMMSrvecPKQUuIgrOIYvyBciGkXMBXIfGKJ0JO
         7clg==
X-Received: by 10.50.136.135 with SMTP id qa7mr16118711igb.32.1417736884746;
        Thu, 04 Dec 2014 15:48:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id m2sm15188524ioi.10.2014.12.04.15.48.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:48:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260843>

Michael Haggerty wrote:

> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -368,9 +368,11 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>  	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
>  	if (!lock)
>  		return error("cannot lock ref '%s'", refname);
> +	if (!reflog_exists(refname)) {
> +		unlock_ref(lock);
> +		return 0;
> +	}
>  	log_file = git_pathdup("logs/%s", refname);
> -	if (!reflog_exists(refname))
> -		goto finish;

Okay.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
