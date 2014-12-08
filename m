From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 08/23] Extract function should_expire_reflog_ent()
Date: Mon, 8 Dec 2014 14:33:30 -0800
Message-ID: <20141208223330.GA25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:33:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy6s6-00033R-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbaLHWde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:33:34 -0500
Received: from mail-ob0-f202.google.com ([209.85.214.202]:53678 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbaLHWdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:33:32 -0500
Received: by mail-ob0-f202.google.com with SMTP id va2so638947obc.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Hk9SyYMbPW0f8rPRol8co/agYxFDSO6/Nudtdtbyqdc=;
        b=gPQAAT3tEcsYSbOXyddca6rUvDfnkwWTiTQXE0pS9M6d51EnqvFJFl8LkSqBgQ6hGo
         Glu4RsJKAlVtN2hud727D/Xv1JsTL0y6ORykINLLIwBVFbg2QqhUM5TRUWhV/pDnu89r
         DMYTQ52wNKeQs4FwxPYc5GVwTuN7jao/Gu0+P5ddHITo/R5rXxMl3PbvD8Bx+HgZl9cL
         oINdmsURK15snKzMGdih5tMnLMcRdeW01tXj0wqbuS1XM2ucxdx27HbBu9Reczo2bmuG
         Ag2nJqiCHqqVRfUqCFck+5xLClmCDXJiYNt8INW7jC86PAaO5zJJpQ/xUiK5mR94m5Cz
         XyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Hk9SyYMbPW0f8rPRol8co/agYxFDSO6/Nudtdtbyqdc=;
        b=FMKm0RMjdSrLTlKYJBo2tw4QODEpxx1sUyr00AJmBo+ivihI5PY1RBuQ8mHJ27yF3H
         L4y5mY2Gnsuws4zFvyMVVe1hkUi4+MBNiliUS9XHHrp3W/PWviXfTYuZ/e4X8gIVfKuo
         yoJGURQTlPg7V6NGmXxMo5lcWrf8UZyqNcQIJXYZp2gq+zyxRkalyyGMpHgTu6BGyXNM
         P7AE/xkVHHkxAEdUsT6Ujsen5pRBXeUCLYQKFcquCmkppVkz847D89ciNy0079uVRyxQ
         IB9pzHjstNwzoiiZL8J9PbKkSgMmOyz1kX0vQB7ZALf4KRbuKKp4cgdwohbK483ebTTx
         bRCg==
X-Gm-Message-State: ALoCoQmoigrIqu6o6T4EFb7ZlMIO2GXdMEEUZVoWUX5exH406ku353oEpPJy1BjTCzQQGcBf7iK2
X-Received: by 10.42.247.14 with SMTP id ma14mr35909906icb.3.1418078011478;
        Mon, 08 Dec 2014 14:33:31 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si1693137yhe.3.2014.12.08.14.33.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:33:31 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id zERBcvI0.1; Mon, 08 Dec 2014 14:33:31 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 7F3BD140BBD; Mon,  8 Dec 2014 14:33:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-9-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261086>

On Fri, Dec 05, 2014 at 12:08:20AM +0100, Michael Haggerty wrote:
> Extracted from expire_reflog_ent() a function that is solely
> responsible for deciding whether a reflog entry should be expired. By
> separating this "business logic" from the mechanics of actually
> expiring entries, we are working towards the goal of encapsulating
> reflog expiry within the refs API, with policy decided by a callback
> function passed to it by its caller.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>

The comments below are just thoughts, which don't need to be
included into this commit.


> +	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
> +				     message, cb_data)) {
> +		if (!cb->newlog)
> +			printf("would prune %s", message);
> +		else if (cb->cmd->verbose)
> +			printf("prune %s", message);

While this commit is just shoveling code around, we don't want to introduce
changes here. So a question for a possible later follow up:
"git reflog" is listed as an ancillary manipulator, which still is porcelain.
So we maybe want to translate "[would] prune"?


> +			char sign = (tz < 0) ? '-' : '+';
> +			int zone = (tz < 0) ? (-tz) : tz;
> +			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
> +				sha1_to_hex(osha1), sha1_to_hex(nsha1),
> +				email, timestamp, sign, zone,
> +				message);

This is fine for just moving code around and reviewing.
I send a patch on top of this one to remove the manual calculation of the 
sign and zone and let the fprintf function figure it out.
