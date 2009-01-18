From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending
 objects to server
Date: Sun, 18 Jan 2009 14:32:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>  <7viqod5thi.fsf@gitster.siamese.dyndns.org> <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 14:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOXn5-0007lT-An
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 14:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991AbZARNc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 08:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbZARNc3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 08:32:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:54234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756114AbZARNc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 08:32:28 -0500
Received: (qmail invoked by alias); 18 Jan 2009 13:32:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 18 Jan 2009 14:32:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KRjQrHMmK0ppBjhNDYnCnmFrscaL40cGlIRl6/u
	Ndm6yQs3Vk9Mk7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106186>

Hi,

On Sun, 18 Jan 2009, Ray Chuan wrote:

> On Sun, Jan 18, 2009 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> > "Ray Chuan" <rctay89@gmail.com> writes:
> >
> >> A concern raised was repository corruption in the event of failure 
> >> during PUT. "put && move" won't afford any more protection than using 
> >> simply "put", since info/refs is not updated if a PUT fails, so there 
> >> is no cause for concern.
> >
> > That's a completely bogus reasoning.  Normal operation inside the 
> > repository that was pushed into won't look at info/refs at all.
> 
> i mentioned this "repository corruption" issue as it was raised
> previously by Johannes (towards the bottom):
> 
>   http://article.gmane.org/gmane.comp.version-control.git/106031

,.. and Junio just raised a new concern.  The repository as it is on the 
server could very well be served by other means, i.e. git:// and rsync://, 
and there could be cron jobs and interactive Git sessions trying to work 
with it.

The point is: the repository inside the document root of the web server is 
still a valid repository.

And the assumption is that whenever you have a file that looks like a 
valid object/pack inside a valid repository, that it does not need 
replacing.

So even when optimizing the uncommon (HTTP push is 2nd class citizen), we 
have to keep the common workflow intact (1st class citizens _are_ push by 
file system, ssh or git://).

Which unfortunately means that put && move must stay.

The same reasoning explains why http-push has to ignore the info/refs file 
when looking for common refs, BTW.

Ciao,
Dscho
