From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix git-init-db creating crap directories
Date: Tue, 20 Sep 2005 02:07:31 +0200
Message-ID: <20050920000731.GJ18320@pasky.or.cz>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz> <432F50BC.5000304@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:09:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVfs-0004VH-VU
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVITAHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbVITAHd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:07:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19946 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932480AbVITAHd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:07:33 -0400
Received: (qmail 11266 invoked by uid 2001); 20 Sep 2005 02:07:31 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <432F50BC.5000304@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8928>

Dear diary, on Tue, Sep 20, 2005 at 01:58:52AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Petr Baudis wrote:
> >Dear diary, on Tue, Sep 20, 2005 at 01:16:14AM CEST, I got a letter
> >
> >Another idea - try this patch:
> >
> >diff --git a/init-db.c b/init-db.c
> >--- a/init-db.c
> >+++ b/init-db.c
> >@@ -154,6 +154,7 @@ static void copy_templates(const char *g
> > 	}
> > 
> > 	memcpy(path, git_dir, len);
> >+	path[len] = 0;
> > 	copy_templates_1(path, len,
> > 			 template_path, template_len,
> > 			 dir);
> >
> 
> This seems to have worked.

Great. Resending a marginally better version with a cool log message and
everything.

--

The base target directory for the templates copying was initialized
to git_dir, but git_dir[len] is not zero but / at the time we do the
initialization. This is not what we want for our target directory string
since we pass it to mkdir(), so make it zero-terminated manually.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit dbe1fe2f0d6de58bc0c9f98e6cf9573874612890
tree 30398d409fa27e95e3e592c803f6cd5a93652234
parent 79d2a11ec497fe940ca9a1fd8e0b9f295d39c290
author Petr Baudis <pasky@suse.cz> Tue, 20 Sep 2005 01:55:53 +0200
committer Petr Baudis <xpasky@machine.(none)> Tue, 20 Sep 2005 01:55:53 +0200

 init-db.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -153,7 +153,8 @@ static void copy_templates(const char *g
 		return;
 	}
 
-	memcpy(path, git_dir, len);
+	memcpy(path, git_dir, len-1);
+	path[len] = 0;
 	copy_templates_1(path, len,
 			 template_path, template_len,
 			 dir);

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
