From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Tue, 24 Aug 2010 22:57:18 -0500
Message-ID: <20100825035718.GG11619@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino>
 <AANLkTint_aF2ZZue5PeSnaAVFa7v+b1diqm3xyvCQsVJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 05:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo78u-0004lx-Ii
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab0HYD7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 23:59:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35412 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab0HYD7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 23:59:08 -0400
Received: by ywe9 with SMTP id 9so62061ywe.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Edj+He8c5lxV8QDWP0mlf1SfH9oQzZFzdvTjl7qrk8Q=;
        b=K74TS7DDb9vgCJwPFUSUO+nvwLFA8IJ+fyzGwV3EpVufuLKUS1WOOiBN/8V6NSbJNq
         N40XntsV7VH1/pe3wXfU7LW18EkK6NxjcmD95y/wmO60yJRkMpG4nB1ZbGYa1jlOowJ0
         C/kcAgux4XtZHrZayJmAny/5whRpSQTkI2uws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h5r9prm0hkITALu/MVttyajxbs2Kh77hN8JD6JZRBPMzq3poHciG5Sca9Jfx7OJq/4
         18QguBdSA3UmLze4vtSec6F1gReE6T/UPZh2HtItP2vOZZciVhF7xL8O8dVp0ToGc1u5
         7EXSI5k3Sq8CvSv5midQqf52juXIoMYcgFr+Y=
Received: by 10.151.100.12 with SMTP id c12mr7942182ybm.384.1282708746337;
        Tue, 24 Aug 2010 20:59:06 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m12sm942843ybn.7.2010.08.24.20.59.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 20:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTint_aF2ZZue5PeSnaAVFa7v+b1diqm3xyvCQsVJ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154409>

Hi,

Bert Wesarg wrote:

> thanks for doing this. But is there any prior art for using NULL as
> 'use the default flags' in the project? For what I know, I can't think
> of an example. But my inside knowledge into git drifts slowly away.

Not that I know of for option flags.  Probably worth mentioning in the
API docs, which I conveniently forgot to update.

-- 8< --
Subject: ll-merge: document options struct

In particular, try to make it clear that most callers will want to
pass `NULL` as the `opts` parameter.

Cc: Bert Wesarg <bert.wesarg@googlemail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index a7e050b..9dc1bed 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -17,6 +17,40 @@ responsible for a few things.
    path-specific merge drivers (specified in `.gitattributes`)
    into account.
 
+Data structures
+---------------
+
+* `mmbuffer_t`, `mmfile_t`
+
+These store data usable for use by the xdiff backend, for writing and
+for reading, respectively.  See `xdiff/xdiff.h` for the definitions
+and `diff.c` for examples.
+
+* `struct ll_merge_options`
+
+This describes the set of options the calling program wants to affect
+the operation of a low-level (single file) merge.  Some options:
+
+`virtual_ancestor`::
+	Behave as though this were part of a merge between common
+	ancestors in a recursive merge.
+	If a helper program is specified by the
+	`[merge "<driver>"] recursive` configuration, it will
+	be used (see linkgit:gitattributes[5]).
+
+`variant`::
+	Resolve local conflicts automatically in favor
+	of one side or the other (as in 'git merge-file'
+	`--ours`/`--theirs`/`--union`).  Can be `0`,
+	`XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
+	`XDL_MERGE_FAVOR_UNION`.
+
+`renormalize`::
+	Resmudge and clean the "base", "theirs" and "ours" files
+	before merging.  Use this when the merge is likely to have
+	overlapped with a change in smudge/clean or end-of-line
+	normalization rules.
+
 Low-level (single file) merge
 -----------------------------
 
@@ -28,15 +62,24 @@ Low-level (single file) merge
 	`.git/info/attributes` into account.  Returns 0 for a
 	clean merge.
 
-The caller:
+Calling sequence:
 
-1. allocates an mmbuffer_t variable for the result;
-2. allocates and fills variables with the file's original content
-   and two modified versions (using `read_mmfile`, for example);
-3. calls ll_merge();
-4. reads the output from result_buf.ptr and result_buf.size;
-5. releases buffers when finished (free(ancestor.ptr); free(ours.ptr);
-   free(theirs.ptr); free(result_buf.ptr);).
+* Prepare a `struct ll_merge_options` to record options.
+  If you have no special requests, skip this and pass `NULL`
+  as the `opts` parameter to use the default options.
+
+* Allocate an mmbuffer_t variable for the result.
+
+* Allocate and fill variables with the file's original content
+  and two modified versions (using `read_mmfile`, for example).
+
+* Call `ll_merge()`.
+
+* Read the merged content from `result_buf.ptr` and `result_buf.size`.
+
+* Release buffers when finished.  A simple
+  `free(ancestor.ptr); free(ours.ptr); free(theirs.ptr);
+  free(result_buf.ptr);` will do.
 
 If the modifications do not merge cleanly, `ll_merge` will return a
 nonzero value and `result_buf` will generally include a description of
@@ -47,18 +90,6 @@ The `ancestor_label`, `our_label`, and `their_label` parameters are
 used to label the different sides of a conflict if the merge driver
 supports this.
 
-The `flag` parameter is a bitfield:
-
- - The `LL_OPT_VIRTUAL_ANCESTOR` bit indicates whether this is an
-   internal merge to consolidate ancestors for a recursive merge.
-
- - The `LL_OPT_FAVOR_MASK` bits allow local conflicts to be automatically
-   resolved in favor of one side or the other (as in 'git merge-file'
-   `--ours`/`--theirs`/`--union`).
-   They can be populated by `create_ll_flag`, whose argument can be
-   `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
-   `XDL_MERGE_FAVOR_UNION`.
-
 Everything else
 ---------------
 
-- 
