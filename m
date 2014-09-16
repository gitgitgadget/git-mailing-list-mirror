From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 18/35] commit_lock_file(): if close fails, roll back
Date: Tue, 16 Sep 2014 15:19:56 -0700
Message-ID: <20140916221956.GR29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-19-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:20:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU16T-000822-R5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbaIPWUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:20:00 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48672 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbaIPWUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:20:00 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so674585pdj.8
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7H4ie2KykItcNECynKZ7+cUG5W5AV8Yx+xiodbztj9Q=;
        b=CJfU4N/0f0wRltdDEFyin9XGwoejO08e7hpxsdGs1s7v7H6jJe3XDJxBQmF3OpQ6iY
         WM91Nuo33U2AbR8fM3HO3v/0EG0vPI6FJXWc53eKQufQQ9Tm9QIWbQHHJhJ+KF4gNrht
         dzrtuVmcaOqKTt1cBgVqMwsdHHWflziDOng74iI0dk5e11kYj0bEJQTAXnuFTu+yE1zF
         AhSwzaKKyfnUnCIjHS6QE/TREra4n4TznPkuZ1XpCQHwKvJuaKKgMj0Zv+8QxXfqKxj4
         Ev7Rs7swEjL53JAWVrfamCRlrkOHZ4FQkLDO7dWlONDz193JAnf8wWZgk37BeM+0lJNF
         Zr6A==
X-Received: by 10.69.25.35 with SMTP id in3mr55027835pbd.63.1410905999868;
        Tue, 16 Sep 2014 15:19:59 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id iu10sm15010167pbd.57.2014.09.16.15.19.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:19:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-19-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257202>

Michael Haggerty wrote:

> If closing an open lockfile fails, then we cannot be sure of the
> contents of the lockfile

Is that true?  It seems more like a bug in close_lock_file: if it
fails, perhaps it should either set lk->fd back to fd or unlink the
lockfile itself.

What do other callers do on close_lock_file failure?

Jonathan
