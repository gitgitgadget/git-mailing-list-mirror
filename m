From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 2/2] headers: include dependent headers
Date: Sun, 7 Sep 2014 13:01:33 -0700
Message-ID: <20140907200133.GA8201@google.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
 <1410049821-49861-2-git-send-email-davvid@gmail.com>
 <20140907194917.GB1611@google.com>
 <540CB7EA.1000303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:01:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQiek-0005j3-U4
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 22:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbaIGUBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 16:01:41 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:32799 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaIGUBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 16:01:40 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so19360881pdi.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2014 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7iuX5QfLIJTn+hbTlcOOuH2jmTX02cJETw0kTGZJk0k=;
        b=jB+yJGuR4bHU4Eepr+pYSlJhGSrg++SnDYEi15I+Q+2Mzu55ik36T5UK7m2urphPQV
         ACHSStEiQ67N7MIak5INz30paSA4e2S8AWLbCDD+3cNf9iwsx0I5HeWXLO6H3puKQOIq
         wMbDGnEq6gXfqNRaQjVDG0B1Mq1VzwuDJy5SWmw1+32t/voXZvx6hBgGC/u04HyWHfcl
         7oQH5fkDA+7MgCJOrv9W52Z8OVcL4gGdLJQZJk5a/p8OoEmmmTmviGvaug5/on8WtD6c
         eJj9Vjaeur3jNxulUli+uHAJSf6OpL950Nx7+bNyVjO+8ym6Umvdh6vFH+VC9GLfnLvV
         bKag==
X-Received: by 10.70.42.71 with SMTP id m7mr17741505pdl.72.1410120099519;
        Sun, 07 Sep 2014 13:01:39 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ps1sm7123082pdb.73.2014.09.07.13.01.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Sep 2014 13:01:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540CB7EA.1000303@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256626>

Johannes Sixt wrote:
> Am 07.09.2014 21:49, schrieb Jonathan Nieder:

>> +enum object_type;
>
> Enum forward declarations are a relatively new C feature. They certainly
> don't exist pre-C99.

Good catch.  That makes

diff --git i/archive.h w/archive.h
index 4a791e1..b2ca5bf 100644
--- i/archive.h
+++ w/archive.h
@@ -1,6 +1,7 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
+#include "cache.h"
 #include "pathspec.h"
 
 struct archiver_args {
diff --git i/attr.h w/attr.h
index 8b08d33..c971ef2 100644
--- i/attr.h
+++ w/attr.h
@@ -1,6 +1,8 @@
 #ifndef ATTR_H
 #define ATTR_H
 
+struct index_state;
+
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
diff --git i/branch.h w/branch.h
index 64173ab..5ce6e21 100644
--- i/branch.h
+++ w/branch.h
@@ -1,6 +1,8 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+#include "cache.h"
+
 /* Functions for acting on the information about branches. */
 
 /*
diff --git i/cache-tree.h w/cache-tree.h
index b47ccec..c22e2ec 100644
--- i/cache-tree.h
+++ w/cache-tree.h
@@ -1,8 +1,12 @@
 #ifndef CACHE_TREE_H
 #define CACHE_TREE_H
 
-#include "tree.h"
-#include "tree-walk.h"
+struct traverse_info;
+struct index_state;
+struct name_entry;
+struct tree;
+struct string_list;
+struct strbuf;
 
 struct cache_tree;
 struct cache_tree_sub {
diff --git i/column.h w/column.h
index 0a61917..8211386 100644
--- i/column.h
+++ w/column.h
@@ -1,6 +1,9 @@
 #ifndef COLUMN_H
 #define COLUMN_H
 
+struct option;
+struct string_list;
+
 #define COL_LAYOUT_MASK   0x000F
 #define COL_ENABLE_MASK   0x0030   /* always, never or auto */
 #define COL_PARSEOPT      0x0040   /* --column is given from cmdline */
@@ -26,7 +29,6 @@ struct column_options {
 	const char *nl;
 };
 
-struct option;
 extern int parseopt_column_callback(const struct option *, const char *, int);
 extern int git_column_config(const char *var, const char *value,
 			     const char *command, unsigned int *colopts);
diff --git i/commit.h w/commit.h
index aa8c3ca..097fc9e 100644
--- i/commit.h
+++ w/commit.h
@@ -1,13 +1,17 @@
 #ifndef COMMIT_H
 #define COMMIT_H
 
+#include "cache.h"
 #include "object.h"
-#include "tree.h"
-#include "strbuf.h"
-#include "decorate.h"
-#include "gpg-interface.h"
+#include "trace.h"
 #include "string-list.h"
 
+struct reflog_walk_info;
+struct rev_info;
+struct ref;
+struct signature_check;
+struct sha1_array;
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
@@ -151,7 +155,6 @@ struct userformat_want {
 };
 
 extern int has_non_ascii(const char *text);
-struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
@@ -231,8 +234,6 @@ extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
-struct sha1_array;
-struct ref;
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
diff --git i/convert.h w/convert.h
index 0c2143c..e623527 100644
--- i/convert.h
+++ w/convert.h
@@ -4,6 +4,8 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+struct strbuf;
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
diff --git i/csum-file.h w/csum-file.h
index bb543d5..9e29e35 100644
--- i/csum-file.h
+++ w/csum-file.h
@@ -1,6 +1,8 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
+#include "cache.h"
+
 struct progress;
 
 /* A SHA1-protected file */
diff --git i/diffcore.h w/diffcore.h
index c876dac..96fc827 100644
--- i/diffcore.h
+++ w/diffcore.h
@@ -4,6 +4,9 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
+struct userdiff_driver;
+struct diff_options;
+
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
@@ -22,8 +25,6 @@
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
-struct userdiff_driver;
-
 struct diff_filespec {
 	unsigned char sha1[20];
 	char *path;
diff --git i/object.h w/object.h
index 5e8d8ee..e61b290 100644
--- i/object.h
+++ w/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+#include "cache.h"
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git i/tree-walk.h w/tree-walk.h
index ae7fb3a..d7612cf 100644
--- i/tree-walk.h
+++ w/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+struct strbuf;
+
 struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
diff --git i/tree.h w/tree.h
index d84ac63..ef84153 100644
--- i/tree.h
+++ w/tree.h
@@ -3,6 +3,9 @@
 
 #include "object.h"
 
+struct pathspec;
+
+
 extern const char *tree_type;
 
 struct tree {
