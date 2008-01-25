From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 16:12:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251535380.13593@iabervon.org>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org> <m3fxwlagbu.fsf@localhost.localdomain> <alpine.LNX.1.00.0801251355490.13593@iabervon.org> <200801252033.13142.jnareb@gmail.com> <7vir1h64k7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIVrW-00028K-VD
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 22:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbYAYVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 16:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbYAYVMi
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 16:12:38 -0500
Received: from iabervon.org ([66.92.72.58]:36829 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbYAYVMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 16:12:37 -0500
Received: (qmail 32422 invoked by uid 1000); 25 Jan 2008 21:12:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 21:12:35 -0000
In-Reply-To: <7vir1h64k7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71739>

On Fri, 25 Jan 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > So this config variable is actually about _rewriting_ URLs, rather than
> > having multiple _alternate_ URLs to fetch from. IMHO either the
> > documentation above should be (re)written better (there is time, as we
> > are in feature freeze), or the example mentioned above should be added
> > (but where?).
> 
> I think Documentation/urls.txt would be a good candidate.
> Currently it talks only about non-nicknamed remotes, and is
> included only in clone and remote.  This makes sense as their
> usage of urls.txt documentation is to talk about non-nicknamed
> forms only (obviously clone cannot talk about nicknames in a
> local repository that does not yet exist, and "remote add" needs
> a non-nicknamed form as well).
> 
> Documentation/urls.txt can be enhanced to say that once you have
> the remote.*.url and other configs, you can use its nickname to
> name a remote repository.  Then it would become a good enough
> shape to be included in push/fetch/pull pages as well.

Isn't that Documentation/urls-remotes.txt?

In any case, this is a different nicknaming mechanism, because remotes are 
nicknames for repositories, and this is nicknames for collections of 
similarly-named repositories. (E.g., all the different publicly-accessible 
repositories on kernel.org)

So, something like:

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 81ac17f..f47b9e0 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -36,6 +36,29 @@ To sync with a local directory, you can use:
 - file:///path/to/repo.git/
 ===============================================================
 
+If there are a large number of similarly-named remote repositories and
+you want to use a different format for them (such that the URLs you
+use will be rewritten into URLs that work), you can create a
+configuration section of the form:
+
+------------
+	[host "<host>"]
+		base = <actual url base>
+		alias = <other url base>
+------------
+
+In particular, if you need to use URLs like
+git://git.host.xz/repo.git, and you're getting a lot of URLs like
+host.xz:/path/to/repo.git/, or you'd like to use a URL like
+"work:repo.git" you can use a section:
+
+------------
+	[host "host.xz"]
+		base = git://git.host.xz/
+		alias = host.xz:/path/to/
+		alias = work:
+------------
+
 ifndef::git-clone[]
 They are mostly equivalent, except when cloning.  See
 linkgit:git-clone[1] for details.

	-Daniel
*This .sig left intentionally blank*
