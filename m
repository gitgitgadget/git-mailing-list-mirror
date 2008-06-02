From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix "next" link on bottom of commit log page
Date: Mon, 02 Jun 2008 01:52:31 -0700 (PDT)
Message-ID: <m3d4n01anr.fsf@localhost.localdomain>
References: <20080529181003.1249.qmail@b35f4f9e60eb05.315fe32.mid.smarden.org>
	<m3y75s1a9v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 10:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K35ng-00040W-2Y
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 10:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbYFBIwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 04:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYFBIwg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 04:52:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:3003 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYFBIwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 04:52:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so683736fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=IW4dqiNGuD+cmaOHxxs1bumWNR2rZsoBREuF65385Fk=;
        b=lVPbOyKsXEKKSY0rsUlROL5++x9CqR60S8A72hwuqsjTeloT90c+Is7zwz9pOciAmK5poslkxdKYQq18th3Qk6bf8MzYAY6R/XyFXlIiWGgmq6Ubhhh/sKDKT2QzM44gBO9fN1oyjk7me5m++zjeSGNwbNWwGypLOPNXJraf1bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=T6EmniqnhXDnjwlNI6gH34XzRURYtMe8k3ti9orm8QSSyoM4V24iLYygKsEKMnigiGzKsrNvFnWab7Auk5roFF0F4qouHYhp0OD609SBHb7xaldayD3kacf4d8HM2xYzqCM3X88BEwps46fZsjFsaNLeMFW7YMWlvEvtbirqaQk=
Received: by 10.86.28.2 with SMTP id b2mr2547848fgb.78.1212396753614;
        Mon, 02 Jun 2008 01:52:33 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.117])
        by mx.google.com with ESMTPS id e11sm3293192fga.4.2008.06.02.01.52.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 01:52:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m528qR01015583;
	Mon, 2 Jun 2008 10:52:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m528qPoL015580;
	Mon, 2 Jun 2008 10:52:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3y75s1a9v.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83503>

Jakub Narebski <jnareb@gmail.com> writes:

> Gerrit Pape <pape@smarden.org> writes:
> 
> > When viewing a gitweb repository commit log, the "next" link at the top
> > of the page works as expected, the "next" link on the bottom of the page
> > has a=search instead of a=log and thus fails to get you to the next
> > page.  This commit replaces the bottom "next" link with the same links
> > as shown at the top of the page.
> 
> > -		print $cgi->a({-href => href(-replay=>1, page=>$page+1),
> > -			       -accesskey => "n", -title => "Alt-n"}, "next");
> 
> Should not happen: href(-replay=>1, ...) should have the same value
> of 'a' parameter as the page it is in, so it should be 'log' not 'search'.
> 
> Will investigate.

Now I know what is happening.  git_header_html() modifies parameters
in $cgi, and href(-replay, ...) uses paramemeters values from $cgi,
not saved in variables (although it could).

So the correct solution would be to change the part which generates
search form in git_header_html() to _not_ modify $cgi->params().

Patch will follow...


P.S. I wonder if using Test::WWW::Mechanize (from CPAN) to test
gitweb's HTML output would be a good idea...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
