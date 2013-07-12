From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 05/19] Add documentation for the index api
Date: Fri, 12 Jul 2013 19:26:50 +0200
Message-ID: <1373650024-3001-6-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh8Z-00034u-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933292Ab3GLR2D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 13:28:03 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:61491 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR2B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:28:01 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so9297742pbc.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BLQGADwlDPZ/CZgIg1eZUd8SZ0RdxBnjyTW9bZdTx5E=;
        b=G034cra+tqlbkAGEYBQOmjGPjr5D6xOqnBdiR+leSlMiZ/UTg+qUGPegSKc5XjvSSU
         J7ijZXMQcfMUvu1y7zbxFEYXI8W+CBOmX4+C2M+Krk4WI7Nml0l2u3nfP9KP+xvT6qwB
         AM7kQtBr6Rhixbo6VmU27YUbApvO0YAArMy+k2IJWL+Np+pRCac1lRyzGamQ3qlSOBmK
         +PxbpiV+M16NKeKBIfUGsaHiT0trI/5pr7w2T7sp2P7sGpiBV4ykFR9oECIFVZrDjM35
         ADwMEpKPazTwEGbB84cYkwMXx00NB/3nTv92u59lTaZIhrZ45vXCJzCJm7VfLDArqa4U
         zMaw==
X-Received: by 10.66.186.14 with SMTP id fg14mr2218903pac.166.1373650081060;
        Fri, 12 Jul 2013 10:28:01 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id cx3sm46394293pbb.30.2013.07.12.10.27.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:28:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230215>

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
1.8.3.453.g1dfc63d
