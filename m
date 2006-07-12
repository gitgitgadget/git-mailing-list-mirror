From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 08:43:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
 <44B37893.5090501@innova-card.com> <7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
 <44B4A6CA.3020206@innova-card.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 17:44:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0grs-00031D-BO
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 17:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWGLPnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWGLPnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 11:43:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751405AbWGLPnI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 11:43:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CFh3nW020386
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 08:43:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CFh261011832;
	Wed, 12 Jul 2006 08:43:02 -0700
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <44B4A6CA.3020206@innova-card.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23785>



On Wed, 12 Jul 2006, Franck Bui-Huu wrote:
> 
> [PATCH] Add a newline before appending "Signed-off-by:"
> 
> It looks nicer.

Yes. However, I think the sign-off detection is a bit broken (quite 
independently of your patch).

A number of people end up capitalizing the sign-off differently, so you 
have lines like "Signed-Off-By: Xy Zzy <xyzzy@example.org>".

Also, at least for the kernel, we often have alternative formats, like

	Acked-by: Elliot Xavier Ample <example@dummy.org>

and for that case, adding the extra newline is actually bad.

So I would suggest a totally different approach: instead of using 
"strstr(comments, signed_off_by)", it would probably be much better to 
just look for the last non-empty line, and see if it matches the format

	"^[nonspace]*: .*@.*$"

(yeah, that's not a valid regexp, but you get the idea).

On a slightly related note, I absolutely _hate_ how cherry-picking adds 
"(cherry-picked from commit <sha1>)" at the end. It's wrong for so many 
reasons, one of them being that it then breaks things like this, but the 
main one being that <sha1> will quite often actually end up not even 
_existing_ in the resulting archive (you cherry-picked from your private 
branch, and even if you keep your branch, you don't necessarily push it 
out).

Junio, can we make the default _not_ to do it, please?

			Linus
