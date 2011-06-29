From: Christof =?iso-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: [PATCH] cygwin: set write permission before unlink
Date: Wed, 29 Jun 2011 16:31:20 +0200 (CEST)
Message-ID: <09c0b1900a67bd1f701c0b23954a34ab.squirrel@mail.localhost.li>
References: <1309331898-32247-1-git-send-email-rei.thiessen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Rei Thiessen" <rei.thiessen@gmail.com>
To: "Rei Thiessen" <rei.thiessen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 16:31:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbvnv-0006d5-JH
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 16:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab1F2ObZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 10:31:25 -0400
Received: from vserver.localhost.li ([85.214.46.152]:46238 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab1F2ObX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 10:31:23 -0400
Received: from localhost ([127.0.0.1]:60262 helo=mail.localhost.li)
	by mail.localhost.li with esmtp (Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QbvnU-0000Q2-SR; Wed, 29 Jun 2011 16:31:21 +0200
Received: from 194.39.218.10
        (SquirrelMail authenticated user mail@christof-krueger.de)
        by mail.localhost.li with HTTP;
        Wed, 29 Jun 2011 16:31:20 +0200 (CEST)
In-Reply-To: <1309331898-32247-1-git-send-email-rei.thiessen@gmail.com>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176444>

> +#undef unlink
> +int cygwin_unlink(const char *pathname)
> +{
> +	/* "read-only" files can't be unlinked */
> +	chmod(pathname, 0666);
> +	return unlink(pathname);
> +}

I've no idea on how cygwin maps file permissions to the underlying
filesystem, but the above raised my attention. Doesn't chmodding the file
to 0666 open a small windows where "group" and "other" users have read
access to the file? This might be unwanted by the user and could be
exploited by some attacker listening for changes on that file.
Or am I too paranoid?

Regards,
  Chris
