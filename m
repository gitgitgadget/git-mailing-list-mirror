From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/13] Add skeleton dump editor
Date: Thu, 8 Jul 2010 08:17:36 +0200
Message-ID: <20100708061736.GB3264@debian>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-5-git-send-email-artagnon@gmail.com>
 <20100707181619.GA2617@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 08:16:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWkOw-000373-5M
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 08:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab0GHGP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 02:15:56 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62567 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab0GHGPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 02:15:55 -0400
Received: by ewy23 with SMTP id 23so103369ewy.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uCXkaBMI6TPB9C0OVYl9UrVZ6fMcrFQ6vd58ueiNb+E=;
        b=J4Iyum9pNMn2ImdvmLyrK0ZN33LLIKRtfYwzn4j0USTLpznfBU3iM7KiSWI+1xFLOC
         Q+i2k+QAHOmTfz31oLUF331ZqOVe3sGMmla3Zd3t3hzkpD7+cH8f4CXf8h0Wrn7fD01P
         5zl2eXEPNnLQRCdoL5gAaYL95y7/az98YSz5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xz9KSc2jmDXjfcdjLXjHtOsLvtuVC8UNqN0YbzgacxTdQUD2pFeTnIFDDn4+pjNWoX
         biDij/5Ai2+q91AnG/AJzXCeKyndgM6e9Ge5+hycgioP+8S29g8eoqZtV+ozEX5HecF5
         kYaRCaCUQUpcOPtBxc24h1SGqAeYrbS1nv6VU=
Received: by 10.213.16.135 with SMTP id o7mr6549181eba.9.1278569753094;
        Wed, 07 Jul 2010 23:15:53 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm68273158eei.7.2010.07.07.23.15.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 23:15:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707181619.GA2617@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150539>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Add a dump editor and write out skeleton callback functions according
> > to the API documentation of svn_delta_editor_t. Also expose
> > get_dump_editor through a header.
> 
> This commit message tells me nothing... Maybe:
> 
> 	Add a no-op svn_editor.  The function to retrieve it is called
> 	get_dump_editor because it is planned to tweak it to write a
> 	dumpfile.  But for now it is more useful when used with the
> 	debug_editor, to get a list of editor operations printed to
> 	stderr.

Fixed.

> It could make sense to squash this with patch 5 as a demo.

Hm, I'm not too competent with handling lots of conflicts during an
interactive rebase: I'll try this out in a new branch and let you know
how it went.

> > --- /dev/null
> > +++ b/dump_editor.c
> > @@ -0,0 +1,143 @@
> > +/* Licensed under a two-clause BSD-style license.
> > + * See LICENSE for details.
> > + */
> > +
> > +#include "svn_pools.h"
> > +#include "svn_error.h"
> > +#include "svn_iter.h"
> > +#include "svn_repos.h"
> > +#include "svn_string.h"
> > +#include "svn_dirent_uri.h"
> > +#include "svn_path.h"
> > +#include "svn_time.h"
> > +#include "svn_checksum.h"
> > +#include "svn_props.h"
> 
> Are these all needed?

I figured that adding some implies adding some others. Fixed.

> [...]
> > +svn_error_t *open_root(void *edit_baton,
> > +                       svn_revnum_t base_revision,
> > +                       apr_pool_t *pool,
> > +                       void **root_baton)
> > +{
> > +	return SVN_NO_ERROR;
> > +}
> 
> Might make sense to use
> 
> 	*root_baton = NULL;
> 
> for easier debugging.
> 
> [...]
> > +svn_error_t *add_directory(const char *path,
> [...]
> > +svn_error_t *open_directory(const char *path,
> [...]
> > +svn_error_t *add_file(const char *path,
> [...]
> > +svn_error_t *open_file(const char *path,
> [...]
> > +svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
> 
> Likewise.

Fixed. Excellent suggestion.

> [...]
> > +++ b/dumpr_util.h
> > @@ -0,0 +1,29 @@
> > +#ifndef DUMPR_UTIL_H_
> > +#define DUMPR_UTIL_H_
> > +
> > +struct edit_baton {
> 
> A more specific name might be nice (or might not, depending on the
> prevailing style in svn; I ought to check but I am too lazy).
> 
> > +	/* The stream to dump to: stdout */
> > +	svn_stream_t *stream;
> > +
> > +	/* pool is for per-edit-session allocations */
> > +	apr_pool_t *pool;
> 
> Unused; probably should delay adding these until there is a user to
> explain them.
> 
> > +
> > +	svn_revnum_t current_rev;
> 
> Used.
> 
> > +	
> > +	/* Store the properties that changed */
> > +	apr_hash_t *properties;
> > +	apr_hash_t *del_properties; /* Value is always 0x1 */
> > +	svn_stringbuf_t *propstring;
> > +
> > +	/* Path of changed file */
> > +	const char *changed_path;
> > +
> > +	/* Was a copy command issued? */
> > +	svn_boolean_t is_copy;
> > +
> > +	/* Temporary file to write delta to along with its checksum */
> > +	char *temp_filepath;
> > +	svn_checksum_t *checksum;
> 
> All unused.
> 
> > +};

Here's the diff after your review. It took me quite a long time to get
the interactive rebase right.

Add skeleton dump editor

Add a no-op svn_editor and expose the function get_dump_editor; this
dump editor will later be filled in to write the dumpfile. Currently,
it is more useful to wrap it in the debug_editor to get a list of
editor operations printed to stderr.


diff --git a/dump_editor.c b/dump_editor.c
index 2fdf93c..e1f3fca 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -3,14 +3,8 @@
  */
 
 #include "svn_pools.h"
-#include "svn_error.h"
-#include "svn_iter.h"
 #include "svn_repos.h"
-#include "svn_string.h"
-#include "svn_dirent_uri.h"
 #include "svn_path.h"
-#include "svn_time.h"
-#include "svn_checksum.h"
 #include "svn_props.h"
 
 #include "dumpr_util.h"
@@ -20,6 +14,7 @@ svn_error_t *open_root(void *edit_baton,
                        apr_pool_t *pool,
                        void **root_baton)
 {
+	*root_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
@@ -38,6 +33,7 @@ svn_error_t *add_directory(const char *path,
                            apr_pool_t *pool,
                            void **child_baton)
 {
+	*child_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
@@ -47,6 +43,7 @@ svn_error_t *open_directory(const char *path,
                             apr_pool_t *pool,
                             void **child_baton)
 {
+	*child_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
@@ -63,6 +60,7 @@ svn_error_t *add_file(const char *path,
                       apr_pool_t *pool,
                       void **file_baton)
 {
+	*file_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
@@ -72,6 +70,7 @@ svn_error_t *open_file(const char *path,
                        apr_pool_t *pool,
                        void **file_baton)
 {
+	*file_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
@@ -96,6 +95,8 @@ svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
                              svn_txdelta_window_handler_t *handler,
                              void **handler_baton)
 {
+	*handler = svn_delta_noop_window_handler;
+	*handler_baton = NULL;
 	return SVN_NO_ERROR;
 }

diff --git a/dumpr_util.h b/dumpr_util.h
index d206c19..2906543 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -2,28 +2,8 @@
 #define DUMPR_UTIL_H_
 
 struct edit_baton {
-	/* The stream to dump to: stdout */
 	svn_stream_t *stream;
-
-	/* pool is for per-edit-session allocations */
-	apr_pool_t *pool;
-
 	svn_revnum_t current_rev;
-	
-	/* Store the properties that changed */
-	apr_hash_t *properties;
-	apr_hash_t *del_properties; /* Value is always 0x1 */
-	svn_stringbuf_t *propstring;
-
-	/* Path of changed file */
-	const char *changed_path;
-
-	/* Was a copy command issued? */
-	svn_boolean_t is_copy;
-
-	/* Temporary file to write delta to along with its checksum */
-	char *temp_filepath;
-	svn_checksum_t *checksum;
 };
 
 #endif
