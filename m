From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 08/24] add documentation for the index api
Date: Sun, 18 Aug 2013 21:41:57 +0200
Message-ID: <1376854933-31241-9-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xq-0003q6-P8
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab3HRTsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Aug 2013 15:48:32 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42991 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:31 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so2407084wib.10
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PK3/d+oYWkREMm2Ow/80UcCuMa19nIh4eGFAU3aigrM=;
        b=Eedxsv8/YcAtOLxNoZUteF2cGezU3wBUgk43ynS0zAe5VEId6bOd5EdbSu1zTatzat
         o6ixd/2Om5VaQSsmcrjLdiqNS6NYAxtl/qnE5k+WfbJGYjx88MJf+pRRs++8tnSZRAAO
         tMDAjYvm4Qeb5kx9jv0TJ26HyaMwBNqgAjEuco0nspvIK6cRchX/We5GNgIODl9zCh1P
         gCnWHFTTuRSv5HX41CzEuAMI62MkWQn1ScusZ8DfQqLqy1WKvlnTeLGE1FlEJ8lNmigM
         FikZ+kUdJO25PPvwE4DAfQW1pwuNyk3zRDj5oDykQt2vpj1Y1E/eFKZtAszA/GUsGCNC
         UvYg==
X-Received: by 10.180.104.33 with SMTP id gb1mr807052wib.25.1376855309950;
        Sun, 18 Aug 2013 12:48:29 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id iz19sm11763967wic.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232497>

Add documentation for the index reading api.  This also includes
documentation for the new api functions introduced in the next patch.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/technical/api-in-core-index.txt | 54 +++++++++++++++++++=
++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-in-core-index.txt b/Documentat=
ion/technical/api-in-core-index.txt
index adbdbf5..9b8c37c 100644
--- a/Documentation/technical/api-in-core-index.txt
+++ b/Documentation/technical/api-in-core-index.txt
@@ -1,14 +1,60 @@
 in-core index API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+Reading API
+-----------
+
+`cache`::
+
+	An array of cache entries.  This is used to access the cache
+	entries directly.  Use `index_name_pos` to search for the
+	index of a specific cache entry.
+
+`read_index_filtered`::
+
+	Read a part of the index, filtered by the pathspec given in
+	the opts.  The function may load more than necessary, so the
+	caller still responsible to apply filters appropriately.  The
+	filtering is only done for performance reasons, as it's
+	possible to only read part of the index when the on-disk
+	format is index-v5.
+
+	To iterate only over the entries that match the pathspec, use
+	the for_each_index_entry function.
+
+`read_index`::
+
+	Read the whole index file from disk.
+
+`index_name_pos`::
+
+	Find a cache_entry with name in the index.  Returns pos if an
+	entry is matched exactly and -1-pos if an entry is matched
+	partially.
+	e.g.
+	index:
+	file1
+	file2
+	path/file1
+	zzz
+
+	index_name_pos("path/file1", 10) returns 2, while
+	index_name_pos("path", 4) returns -3
+
+`for_each_index_entry`::
+
+	Iterates over all cache_entries in the index filtered by
+	filter_opts in the index_state.  For each cache entry fn is
+	executed with cb_data as callback data.  From within the loop
+	do `return 0` to continue, or `return 1` to break the loop.
+
+TODO
+----
 Talk about <read-cache.c> and <cache-tree.c>, things like:
=20
-* cache -> the_index macros
-* read_index()
 * write_index()
 * ie_match_stat() and ie_modified(); how they are different and when t=
o
   use which.
-* index_name_pos()
 * remove_index_entry_at()
 * remove_file_from_index()
 * add_file_to_index()
@@ -18,4 +64,4 @@ Talk about <read-cache.c> and <cache-tree.c>, things =
like:
 * cache_tree_invalidate_path()
 * cache_tree_update()
=20
-(JC, Linus)
+(JC, Linus, Thomas Gummerer)
--=20
1.8.3.4.1231.g9fbf354.dirty
