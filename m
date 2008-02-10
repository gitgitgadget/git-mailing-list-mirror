From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Alternative approach to the git config NULL value checking
 patches..
Date: Sun, 10 Feb 2008 14:08:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKNV-0005U9-1v
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbYBJWJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbYBJWJv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:09:51 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52902 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbYBJWJu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 17:09:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AM8wSi013824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 14:09:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AM8wap016405;
	Sun, 10 Feb 2008 14:08:58 -0800
In-Reply-To: <7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73423>



On Sun, 10 Feb 2008, Junio C Hamano wrote:
> 
> I should have mentioned the reason why I did not suggest doing
> it this way in my [Janitor] message.
> 
> It is not "suttle difference between true and empty".  Empty
> means false, and with this approach, it switches the meaning of
> valueless form of config to quite the opposite.

No it does not.

> will now need to be changed to:
> 
> 	if (value == config_true)
>         	Ah we have true;
> 	else if (!*value)
>         	Ok this is false;

And that was done by my patch. 

> still need to be fixed to:
> 
> 	if (value == config_true)
>         	die("oops '%s' is not a bool", var);
> 	else if (!strcmp(value, "somevalue")
> 		Ok let's use somevalue;

And this is different from checking against NULL exactly how?

> > This also means that code (notably the value regexp parsing) that does 
> > something like
> >
> > 	value ? value : ""
> >
> > just automatically can go away, and just use 'value' directly.
> 
> Yes, but that's broken already, isn't it?

No, it was what the regex parsing logic was - empty matches empty. Whether 
we really want it or not, I dunno.

		Linus
