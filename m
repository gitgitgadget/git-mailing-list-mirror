From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 05/24] add documentation for the index api
Date: Wed, 27 Nov 2013 13:00:40 +0100
Message-ID: <1385553659-9928-6-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoP-0001kc-GY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab3K0MBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 07:01:42 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:34776 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab3K0MBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:40 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so5328611lab.28
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kyNQX81p5GRC9OY4NEtcWRuBYMou/K0jzPOQwPgIQKc=;
        b=VYo0oHQ0/crYDz1KCg6sUW1P8bivpBigOlzRuLf/Cbgxp2RIc+DotRcSQ4JgNYvy54
         HijvwawOGk8ogH7XsjwVKZxOMELq2XjRYywei8IiMlb5vvKRcfWb37g7bU+NVkFm0lIo
         o+niJGrt9AW1wuZ1qviaMo8VwPAthfXWnKpMQyj+cV1Rxrh0TNNxvPJ8U480L/VYRMrg
         veyA46zWKwYiKx2ay2OpL/eo3ndfZiDeXwfGLPKqEa3CwJ/keLBlbZUizI0k9Xkv+0Ai
         VI7PzinPq225BNGNv/DtehzW97wNJRkGdQw/Z2Ek1gfU3YMzDItnjLFfF+bEe+1ovIZk
         Z6PA==
X-Received: by 10.152.219.133 with SMTP id po5mr1387404lac.34.1385553699278;
        Wed, 27 Nov 2013 04:01:39 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id o1sm63646858lah.8.2013.11.27.04.01.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:37 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238417>

Add documentation for the index reading api.  This also includes
documentation for the new api functions introduced in the next patch.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/technical/api-in-core-index.txt | 56 +++++++++++++++++++=
++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-in-core-index.txt b/Documentat=
ion/technical/api-in-core-index.txt
index adbdbf5..2cf7a71 100644
--- a/Documentation/technical/api-in-core-index.txt
+++ b/Documentation/technical/api-in-core-index.txt
@@ -1,14 +1,62 @@
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
+	caller is still responsible for applying filters appropriately.  The
+	filtering is only done for performance reasons, as it's
+	possible to only read part of the index when the on-disk
+	format is index-v5.
++
+To iterate only over the entries that match the pathspec, use
+the for_each_index_entry function.
+
+`read_index`::
+
+	Read the whole index file from disk.
+
+`index_name_pos`::
+
+	Find a cache_entry with name in the index.  Returns pos if an
+	entry is matched exactly and -1-pos if an entry is matched
+	partially. e.g.
++
+....
+index:
+	file1
+	file2
+	path/file1
+	zzz
+....
++
+`index_name_pos("path/file1", 10)` returns 2, while
+`index_name_pos("path", 4)` returns -3
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
@@ -18,4 +66,4 @@ Talk about <read-cache.c> and <cache-tree.c>, things =
like:
 * cache_tree_invalidate_path()
 * cache_tree_update()
=20
-(JC, Linus)
+(JC, Linus, Thomas Gummerer)
--=20
1.8.4.2
