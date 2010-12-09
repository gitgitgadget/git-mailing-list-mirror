From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 01/18] gitweb: Prepare for splitting gitweb
Date: Thu, 09 Dec 2010 15:30:10 -0800 (PST)
Message-ID: <m37hfi34q2.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 00:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQpwL-0002lZ-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 00:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab0LIXaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:30:15 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:55663 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab0LIXaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:30:14 -0500
Received: by bwz16 with SMTP id 16so3346637bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=v9vkRUudLKGuuBsfGEd4TP22v+Zie4W6M+hRnKXQ+KM=;
        b=g6BNbVfZqg6GAy2LDvhrxYJVa7Jkqh5VkbYHT7NW2h9ZYLRLXQJp+LOU46bJ22Banx
         83Mk/2R6U6vBxnddHc5SDke4dsR48KP3XPlAyedOb0WktVVatoW/75lgnI7jZ0ZqoE7c
         0L/xF0DMjbuJ3VeSxbz5GABbr9MK1PB4+uuKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jdMjtdg+h4IQs56J4alP6+8Bg6og3j0HNqmeVJ023OxfI26Dfdw0dJg7mxnf27kxw2
         hpa1SEAYpGBzuW1aZd5wiOWxlWwK8wNExHkcSt2XxfeiZh/3evxQQsA47DlPxTRIXekJ
         s0Xl1vvRPdbOrPt4TfHHYAsTVD4ApmWvs+W+I=
Received: by 10.204.68.69 with SMTP id u5mr62504bki.99.1291937412743;
        Thu, 09 Dec 2010 15:30:12 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id l3sm46349fan.2.2010.12.09.15.30.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 15:30:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB9NTfSc019690;
	Fri, 10 Dec 2010 00:29:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB9NTP4R019686;
	Fri, 10 Dec 2010 00:29:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-2-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163357>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> From: Jakub Narebski <jnareb@gmail.com>
> +install-modules:
> +	install_dirs="$(sort $(dir $(GITWEB_MODULES)))" && \
> +	for dir in $$install_dirs; do \
> +		test -d '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$dir' || \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/$$dir'; \

This should be

  +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/$$dir; \

or even

  +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)'/"$$dir"; \

Shell variables should be not inside single quotes (as oposed to make
variables, where it does not matter).

Please rebase on top of v7.4, where it was fixed.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
