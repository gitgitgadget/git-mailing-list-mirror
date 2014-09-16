From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 05/35] rollback_lock_file(): set fd to -1
Date: Tue, 16 Sep 2014 13:38:52 -0700
Message-ID: <20140916203852.GE29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:39:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzWd-0006AT-VM
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbaIPUi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:38:56 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39602 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaIPUiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:38:55 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so524540pdb.11
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hPPspBOn1MH83obfRvvZCWdi5TDTlIzAvRbvePKoggk=;
        b=j6H+VVGNjtnozKcnAZv649Wnac5EAucZmPK7UqybybdKQoqxqv9Lybd3KRtJfTJuXB
         pF8sL8NZSZyR/usbWqaK3at0uhOj8sCLwlCa6LCM6fgZdSY4NKAfMSGcGLef8HMXS00g
         Twu/1EqkJXpdlWpTu3UNbz62vduxeWkxoCFnJsuRSWUnF//qzI9LP9+Udu+23+qwUXTH
         HZWnsRuyvqNzTzhFeLL8V+FRuwQXOC+OolfcE7eC5gIlq+kvLwqH1KCcabRs+dOPbn8v
         POIkZpKnfAeDfSyn8hhVLKKiYJZkeKT5RUYo2KXcYnrEC3YYv1p0Juw8wcK5oY3mgDXt
         hhGw==
X-Received: by 10.70.125.165 with SMTP id mr5mr63259906pdb.102.1410899935483;
        Tue, 16 Sep 2014 13:38:55 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id pw10sm14848773pbc.93.2014.09.16.13.38.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:38:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-6-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257188>

Michael Haggerty wrote:

> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -276,7 +276,7 @@ void rollback_lock_file(struct lock_file *lk)
>  		return;
>  
>  	if (lk->fd >= 0)
> -		close(lk->fd);
> +		close_lock_file(lk);

Doesn't need to be guarded by the 'if'.
