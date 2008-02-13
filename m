From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 13:45:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131344121.30505@racer.site>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <20080213105051.GA26522@coredump.intra.peff.net> <20080213112504.GA26627@coredump.intra.peff.net> <alpine.LSU.1.00.0802131213270.30505@racer.site>
 <m3fxvxc87u.fsf@localhost.localdomain> <alpine.LSU.1.00.0802131321140.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Rhodes, Kate" <masukomi@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:47:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHwU-0004eL-KP
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661AbYBMNpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757579AbYBMNpy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:45:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:50537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757241AbYBMNpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:45:53 -0500
Received: (qmail invoked by alias); 13 Feb 2008 13:45:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 13 Feb 2008 14:45:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3ef80+hT3rSdT1xvtafKkn43RIn0Q9esAOgimT+
	wKccS1JgMHyZEs
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802131321140.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73793>

Hi,

On Wed, 13 Feb 2008, Johannes Schindelin wrote:

> On Wed, 13 Feb 2008, Jakub Narebski wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Wed, 13 Feb 2008, Jeff King wrote:
> > > >  	}
> > > > +	if (!hashcmp(sha1, empty_tree.sha1))
> > > > +		return &empty_tree;
> > > >  	return NULL;
> > > >  }
> > > 
> > > Heh.  This is cute.  But it is also a bit hard to reference, no?  I 
> > > mean, you have to remember the SHA-1 of it...
> > > 
> > > Maybe {} ?

IOW something like this (on top of your two patches; feel free to merge):

-- snipsnap --
[PATCH] Make {} synonymous to the empty tree

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 cache.h     |    5 +++++
 sha1_file.c |    4 +---
 sha1_name.c |    5 +++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index f4c56fa..b71f772 100644
--- a/cache.h
+++ b/cache.h
@@ -266,6 +266,11 @@ static inline enum object_type object_type(unsigned int mode)
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 
+/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
+#define EMPTY_TREE_SHA1 (unsigned char *)\
+	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
+	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
diff --git a/sha1_file.c b/sha1_file.c
index 1a6c7c8..cba629a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1846,9 +1846,7 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
-	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60"
-	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04",
+	EMPTY_TREE_SHA1,
 	OBJ_TREE,
 	"",
 	0
diff --git a/sha1_name.c b/sha1_name.c
index 6cfd1f9..3a39a55 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -760,5 +760,10 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			return get_tree_entry(tree_sha1, cp+1, sha1, mode);
 		}
 	}
+	if (ret && !strcmp(name, "{}")) {
+		*mode = 0755;
+		hashcpy(sha1, EMPTY_TREE_SHA1);
+		ret = 0;
+	}
 	return ret;
 }
