From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Sat, 9 Feb 2008 00:54:08 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802090053420.13593@iabervon.org>
References: <20080208174654.2e9e679c@pc09.procura.nl> <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com> <alpine.LNX.1.00.0802081526350.13593@iabervon.org> <7vk5leg0nj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNig0-0007DK-39
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbYBIFyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 00:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbYBIFyM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:54:12 -0500
Received: from iabervon.org ([66.92.72.58]:57665 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbYBIFyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 00:54:11 -0500
Received: (qmail 2272 invoked by uid 1000); 9 Feb 2008 05:54:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Feb 2008 05:54:08 -0000
In-Reply-To: <7vk5leg0nj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73196>

On Fri, 8 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > diff --git a/remote.c b/remote.c
> > index 0e00680..83a3d9d 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -348,7 +348,7 @@ struct remote *remote_get(const char *name)
> >         if (!name)
> >                 name = default_remote_name;
> >         ret = make_remote(name, 0);
> > -       if (name[0] != '/') {
> > +       if (name[0] != '/' && strcmp(name, "..")) {
> >                 if (!ret->url)
> >                         read_remotes_file(ret);
> >                 if (!ret->url)
> 
> Perhaps "static int valid_remote_nick(const char*)" is needed?
> I'd say we can limit it to something like:
> 
> static int valid_remote_nick(const char *name)
> {
> 	if (!name[0] || /* not empty */
>             (name[0] == '.' && /* not "." */
>              (!name[1] || /* not ".." */
>               (name[1] == '.' && !name[2]))))
> 		return 0;
> 	return !!strchr(name, '/'); /* no slash */
> }

Yeah, that looks right to me.

	-Daniel
*This .sig left intentionally blank*
