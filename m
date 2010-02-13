From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 3/5] Adapt the kwset code to Git
Date: Sat, 13 Feb 2010 15:20:50 +0100
Message-ID: <20100213142050.GD9543@fredrik-laptop>
References: <20100213141558.22851.13660.stgit@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgIrg-00064I-LS
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab0BMOUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 09:20:54 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:9918 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320Ab0BMOUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 09:20:53 -0500
Received: by ey-out-2122.google.com with SMTP id d26so841292eyd.19
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gfj4sK0Tdo9w0Qpizh7Vdad/l+r/dLaiEKwWdWsIr3M=;
        b=DzDvBmRUbgwbzkunzrNb/Svhw7iDWWP86BsBEUcITKe8IQHmlC5HcVVaQ5hBXl5CFZ
         zlLKdasg7RQx3u1OcmgiLCtGtVbxJkdVKuwq/xbBlifLh0ivLamBNB2NsVb0A2CTvqpC
         V3Eif6T/ba6Qm+nHenRKOTC23xHyLRIRsOJMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QO+WAJ2QAyUiFfLXyMkwSUHBPDGoxd1Oj6o2Kj7KocjShm/RNaeXgBUB9Mscv23d+a
         UrwrZSNX8X7I5fylwK+knTRNryXBPSmTGn/fx3oiaLBoWva5EE4H57ujTyzNtGSrZa4L
         I2fRZLUK0JVIIMPi6m6a0u1nPgtF/aGW5me6Y=
Received: by 10.213.104.74 with SMTP id n10mr2102610ebo.64.1266070852595;
        Sat, 13 Feb 2010 06:20:52 -0800 (PST)
Received: from fredrik-laptop (c83-250-157-96.bredband.comhem.se [83.250.157.96])
        by mx.google.com with ESMTPS id 10sm10705344eyd.21.2010.02.13.06.20.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 06:20:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100213141558.22851.13660.stgit@fredrik-laptop>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139800>

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

 kwset.c |   24 ++++++++++--------------
 kwset.h |   17 +++++++++++------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/kwset.c b/kwset.c
index 0957f66..2853859 100644
--- a/kwset.c
+++ b/kwset.c
@@ -1,3 +1,7 @@
+/* This file has been copied from GNU grep 2.5.4. A few small changes
+ * have been made to adapt the code to Git.
+ */
+
 /* kwset.c - search for any of a set of keywords.
    Copyright (C) 1989, 1998, 2000, 2005, 2007, 2009
    Free Software Foundation, Inc.
@@ -29,22 +33,14 @@
    String Matching:  An Aid to Bibliographic Search," CACM June 1975,
    Vol. 18, No. 6, which describes the failure function used below. */
 
-#ifdef HAVE_CONFIG_H
-# include <config.h>
-#endif
+#include "cache.h"
+
 #include <sys/types.h>
-#include "system.h"
 #include "kwset.h"
 #include "obstack.h"
 
-#ifdef GREP
-# include "xalloc.h"
-# undef malloc
-# define malloc xmalloc
-#endif
-
 #define NCHAR (UCHAR_MAX + 1)
-#define obstack_chunk_alloc malloc
+#define obstack_chunk_alloc xmalloc
 #define obstack_chunk_free free
 
 #define U(c) ((unsigned char) (c))
@@ -175,7 +171,7 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 	  link = (struct tree *) obstack_alloc(&kwset->obstack,
 					       sizeof (struct tree));
 	  if (!link)
-	    return _("memory exhausted");
+	    return "memory exhausted";
 	  link->llink = NULL;
 	  link->rlink = NULL;
 	  link->trie = (struct trie *) obstack_alloc(&kwset->obstack,
@@ -183,7 +179,7 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 	  if (!link->trie)
 	    {
 	      obstack_free(&kwset->obstack, link);
-	      return _("memory exhausted");
+	      return "memory exhausted";
 	    }
 	  link->trie->accepting = 0;
 	  link->trie->links = NULL;
@@ -406,7 +402,7 @@ kwsprep (kwset_t kws)
       /* Looking for just one string.  Extract it from the trie. */
       kwset->target = obstack_alloc(&kwset->obstack, kwset->mind);
       if (!kwset->target)
-	return _("memory exhausted");
+	return "memory exhausted";
       for (i = kwset->mind - 1, curr = kwset->trie; i >= 0; --i)
 	{
 	  kwset->target[i] = curr->links->label;
diff --git a/kwset.h b/kwset.h
index e8dec04..48c2ff1 100644
--- a/kwset.h
+++ b/kwset.h
@@ -1,3 +1,7 @@
+/* This file has been copied from GNU grep 2.5.4. A few small changes
+ * have been made to adapt the code to Git.
+ */
+
 /* kwset.h - header declaring the keyword set library.
    Copyright (C) 1989, 1998, 2005, 2007, 2009 Free Software Foundation, Inc.
 
@@ -27,22 +31,23 @@ struct kwsmatch
   size_t size[1];		/* Length of each submatch. */
 };
 
-typedef ptr_t kwset_t;
+struct kwset_t;
+typedef struct kwset_t* kwset_t;
 
 /* Return an opaque pointer to a newly allocated keyword set, or NULL
    if enough memory cannot be obtained.  The argument if non-NULL
    specifies a table of character translations to be applied to all
    pattern and search text. */
-extern kwset_t kwsalloc PARAMS((char const *));
+extern kwset_t kwsalloc(char const *);
 
 /* Incrementally extend the keyword set to include the given string.
    Return NULL for success, or an error message.  Remember an index
    number for each keyword included in the set. */
-extern const char *kwsincr PARAMS((kwset_t, char const *, size_t));
+extern const char *kwsincr(kwset_t, char const *, size_t);
 
 /* When the keyword set has been completely built, prepare it for
    use.  Return NULL for success, or an error message. */
-extern const char *kwsprep PARAMS((kwset_t));
+extern const char *kwsprep(kwset_t);
 
 /* Search through the given buffer for a member of the keyword set.
    Return a pointer to the leftmost longest match found, or NULL if
@@ -50,8 +55,8 @@ extern const char *kwsprep PARAMS((kwset_t));
    the matching substring in the integer it points to.  Similarly,
    if foundindex is non-NULL, store the index of the particular
    keyword found therein. */
-extern size_t kwsexec PARAMS((kwset_t, char const *, size_t, struct kwsmatch *));
+extern size_t kwsexec(kwset_t, char const *, size_t, struct kwsmatch *);
 
 /* Deallocate the given keyword set and all its associated storage. */
-extern void kwsfree PARAMS((kwset_t));
+extern void kwsfree(kwset_t);
 
