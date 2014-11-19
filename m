From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] error: save and restore errno
Date: Tue, 18 Nov 2014 17:43:44 -0800
Message-ID: <20141119014344.GP6527@google.com>
References: <20141119013532.GA861@peff.net>
 <20141119013710.GA2135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:43:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquJ9-0003Bh-1o
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbaKSBnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:43:43 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:57589 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbaKSBnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:43:42 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so2109063igb.13
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 17:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3KwKdXl5cAdX/W9yM5BXz8nD/HzQ/LsQbhXHQuIXSEk=;
        b=MqEzgjXc2WP90pHeuNjlEXblECrRAckHjzHjLSFf8Jp0GruJFoE86evq7cex6T9DXz
         2HcmfiUIymD8JAzOZXFIwgF0r2DuVVecvSM+OMVHG5oib/ZAz1MKtCIsvEH69mwOZBit
         pZ14DxItNwxiqYs0megT+PSWOeqIl9d5xvKHWhRSVFBuayq5HanrZ8116oBcbQc5qlY9
         fZwleOEF7tyulr6GkuPhW3PQxaGP3tvkhjE1UkVf1fbjchIkn0YvnaqNBpMnh2qq7Qn7
         N+rWu5XXdT13y+Yf2o+JwxjUudj9OUbfymsGp4SqdfXHSFS1k7yfASSvyanaRlwcEobA
         dQVg==
X-Received: by 10.107.17.79 with SMTP id z76mr24870372ioi.27.1416361421929;
        Tue, 18 Nov 2014 17:43:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id k140sm116715ioe.39.2014.11.18.17.43.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 17:43:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119013710.GA2135@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> It's common to use error() to return from a function, like:
>
> 	if (open(...) < 0)
> 		return error("open failed");
>
> Unfortunately this may clobber the errno from the open()
> call. So we often end up with code like this:
>
>         if (open(...) < 0) {
> 		int saved_errno = errno;
> 		error("open failed");
> 		errno = saved_errno;
> 		return -1;
> 	}
>
> which is less nice.

What the above doesn't explain is why the caller cares about errno.
Are they going to print another message with strerror(errno)?  Or are
they going to consider some errors non-errors (like ENOENT when trying
to unlink a file), in which case why is printing a message to stderr
okay?

All that said, given that there are real examples of code already
doing this, the patch seems sane.

[...]
>  usage.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
