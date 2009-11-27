From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Fri, 27 Nov 2009 21:23:45 +0100
Message-ID: <200911272123.45163.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <40aa078e0911270623m1a06890cmd2d46b3d9e216769@mail.gmail.com> <40aa078e0911270746x55946f52qd76dc4f9443aebc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 27 21:24:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7MJ-0007SO-KC
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZK0UXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZK0UXv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:23:51 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63717 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752733AbZK0UXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:23:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 420CC19F610;
	Fri, 27 Nov 2009 21:23:45 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0911270746x55946f52qd76dc4f9443aebc6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133933>

On Freitag, 27. November 2009, Erik Faye-Lund wrote:
> On Fri, Nov 27, 2009 at 3:23 PM, Erik Faye-Lund
> <kusmabite@googlemail.com> wrote:
> > At the very least, I should remove the
> > "dup2(incoming, 1)"-call, but I'm open to other suggestions. Perhaps I
> > can change this patch to do the entire socket-passing (which is
> > currently in the next patch)?

No, an infrastructure change in a separate patch is good.

> Something along these lines?
>
> ---8<---
> -	cld.in = cld.out = fd;
> +	cld.in = dup(fd);
> +	cld.out = fd;
>...
> -	dup2(incoming, 0);
> -	dup2(incoming, 1);
> -	close(incoming);
> -
> -	exit(execute(0, addr));
> +	exit(execute(incoming, addr));
> ---8<---

Yes, this looks very good.

> When I think more about it, I might've broken the inetd-mode as it
> should communicate over stdin and stdout (not just stdin as it would
> try to do now)... I don't know the inetd internals, but this frightens
> me a bit.

Do we need inetd mode on Windows? At one time a looked for a inetd-like 
service, but couldn't find one.

-- Hannes
