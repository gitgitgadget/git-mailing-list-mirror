From: Petr Baudis <pasky@suse.cz>
Subject: Re: Garbage in .git directories???
Date: Tue, 20 Sep 2005 01:40:30 +0200
Message-ID: <20050919234030.GI18320@pasky.or.cz>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 01:41:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVFU-0007ew-Ac
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 01:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVISXkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 19:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVISXkd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 19:40:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64688 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932656AbVISXkc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 19:40:32 -0400
Received: (qmail 9296 invoked by uid 2001); 20 Sep 2005 01:40:30 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F46BE.5000406@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8926>

Dear diary, on Tue, Sep 20, 2005 at 01:16:14AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Petr Baudis wrote:
> >>
> >>FWIW, using cg-clone (using git-core 0.99.6 and cogito 0.14.1) I keep 
> >>finding a directory in .git which consists of a single DEL character 
> >>(\177).
> >
> >Does cg-init produce it too? It really seems that this has to be a bug
> >in git-init-db. If that is the case, could you try temporarily renaming
> >the templates directory?
> 
> cg-init does produce it, too.  I'm not sure what you mean with 
> temporarily renaming the templates directory?

Preventing git-init-db to copy its stuff into your .git/ - I think the
bug is likely somewhere there. Actually, this can be prevented by
passing an argument to git-init-db:

	git-init-db --template=somethingnonexisting

Another idea - try this patch:

diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -154,6 +154,7 @@ static void copy_templates(const char *g
 	}
 
 	memcpy(path, git_dir, len);
+	path[len] = 0;
 	copy_templates_1(path, len,
 			 template_path, template_len,
 			 dir);

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
