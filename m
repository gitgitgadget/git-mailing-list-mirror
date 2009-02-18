From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH] check_updates(): effective removal of cache entries marked
 CE_REMOVE
Date: Wed, 18 Feb 2009 23:18:03 +0100
Message-ID: <1234995483-933-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 23:19:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZulY-0000fi-54
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 23:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZBRWSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZBRWSK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:18:10 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:39447 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbZBRWSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 17:18:09 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFA00MX88M5KZ80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 18 Feb 2009 23:18:05 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.205])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFA00JOR8M3DE70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 18 Feb 2009 23:18:05 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110586>

Below is oprofile output from GIT command 'git chekcout -q my-v2.6.25'
(move from tag v2.6.27 to tag v2.6.25 of the Linux kernel):

CPU: Core 2, speed 1999.95 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit
                         mask of 0x00 (Unhalted core cycles) count 20000
Counted INST_RETIRED_ANY_P events (number of instructions retired) with a
                           unit mask of 0x00 (No unit mask) count 20000
CPU_CLK_UNHALT...|INST_RETIRED:2...|
  samples|      %|  samples|      %|
------------------------------------
   409247 100.000    342878 100.000 git
        CPU_CLK_UNHALT...|INST_RETIRED:2...|
          samples|      %|  samples|      %|
        ------------------------------------
           260476 63.6476    257843 75.1996 libz.so.1.2.3
           100876 24.6492     64378 18.7758 kernel-2.6.28.4_2.vmlinux
            30850  7.5382      7874  2.2964 libc-2.9.so
            14775  3.6103      8390  2.4469 git
             2020  0.4936      4325  1.2614 libcrypto.so.0.9.8
              191  0.0467        32  0.0093 libpthread-2.9.so
               58  0.0142        36  0.0105 ld-2.9.so
                1 2.4e-04         0       0 libldap-2.3.so.0.2.31

Detail list of the top 20 function entries (libz counted in one blob):

CPU_CLK_UNHALTED  INST_RETIRED_ANY_P
samples  %        samples  %        image name               symbol name
260476   63.6862  257843   75.2725  libz.so.1.2.3            /lib/libz.so.1.2.3
16587     4.0555  3636      1.0615  libc-2.9.so              memcpy
7710      1.8851  277       0.0809  libc-2.9.so              memmove
3679      0.8995  1108      0.3235  kernel-2.6.28.4_2.vmlinux d_validate
3546      0.8670  2607      0.7611  kernel-2.6.28.4_2.vmlinux __getblk
3174      0.7760  1813      0.5293  libc-2.9.so              _int_malloc
2396      0.5858  3681      1.0746  kernel-2.6.28.4_2.vmlinux copy_to_user
2270      0.5550  2528      0.7380  kernel-2.6.28.4_2.vmlinux __link_path_walk
2205      0.5391  1797      0.5246  kernel-2.6.28.4_2.vmlinux ext4_mark_iloc_dirty
2103      0.5142  1203      0.3512  kernel-2.6.28.4_2.vmlinux find_first_zero_bit
2077      0.5078  997       0.2911  kernel-2.6.28.4_2.vmlinux do_get_write_access
2070      0.5061  514       0.1501  git                      cache_name_compare
2043      0.4995  1501      0.4382  kernel-2.6.28.4_2.vmlinux rcu_irq_exit
2022      0.4944  1732      0.5056  kernel-2.6.28.4_2.vmlinux __ext4_get_inode_loc
2020      0.4939  4325      1.2626  libcrypto.so.0.9.8       /usr/lib/libcrypto.so.0.9.8
1965      0.4804  1384      0.4040  git                      patch_delta
1708      0.4176  984       0.2873  kernel-2.6.28.4_2.vmlinux rcu_sched_grace_period
1682      0.4112  727       0.2122  kernel-2.6.28.4_2.vmlinux sysfs_slab_alias
1659      0.4056  290       0.0847  git                      find_pack_entry_one
1480      0.3619  1307      0.3816  kernel-2.6.28.4_2.vmlinux ext4_writepage_trans_blocks

Notice the memmove line, where the CPU did 7710 / 277 = 27.8 cycles
per instruction, and compared to the total cycles spent inside the
source code of GIT for this command, all the memmove() calls
translates to (7710 * 100) / 14775 = 52.2% of this.

Retesting with a GIT program compiled for gcov usage, I found out that
the memmove() calls came from remove_index_entry_at() in read-cache.c,
where we have:

        memmove(istate->cache + pos,
                istate->cache + pos + 1,
                (istate->cache_nr - pos) * sizeof(struct cache_entry *));

remove_index_entry_at() is called 4902 times from check_updates() in
unpack-trees.c, and each time called we move each cache_entry pointers
(from the removed one) one step to the left.

Since we have 28828 entries in the cache this time, and if we on
average move half of them each time, we in total move approximately
4902 * 0.5 * 28828 * 4 = 282 629 712 bytes, or twice this amount if
each pointer is 8 bytes (64 bit).

OK, is seems that the function check_updates() is called 28 times, so
the estimated guess above had been more correct if check_updates() had
been called only once, but the point is: we get lots of bytes moved.

To fix this, and use an O(N) algorithm instead, where N is the number
of cache_entries, we delete/remove all entries in one loop through all
entries.

>From a retest, the new remove_marked_cache_entries() from the patch
below, ended up with the following output line from oprofile:

46        0.0105  15        0.0041  git                      remove_marked_cache_entries

If we can trust the numbers from oprofile in this case, we saved
approximately ((7710 - 46) * 20000) / (2 * 1000 * 1000 * 1000) = 0.077
seconds CPU time with this fix for this particular test.  And notice
that now the CPU did only 46 / 15 = 3.1 cycles/instruction.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h        |    1 +
 read-cache.c   |   20 ++++++++++++++++++++
 unpack-trees.c |    4 +---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 6141269..0b11e3e 100644
--- a/cache.h
+++ b/cache.h
@@ -445,6 +445,7 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 extern int remove_index_entry_at(struct index_state *, int pos);
+extern void remove_marked_cache_entries(struct index_state *istate);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
diff --git a/read-cache.c b/read-cache.c
index ca4bec2..bb07371 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -465,6 +465,26 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	return 1;
 }
 
+/*
+ * Remove all cache ententries marked for removal, that is where
+ * CE_REMOVE is set in ce_flags.  This is much more effective than
+ * calling remove_index_entry_at() for each entry to be removed.
+ */
+void remove_marked_cache_entries(struct index_state *istate)
+{
+	struct cache_entry **ce_array = istate->cache;
+	unsigned int i, j;
+
+	for (i = j = 0; i < istate->cache_nr; i++) {
+		if (ce_array[i]->ce_flags & CE_REMOVE)
+			remove_name_hash(ce_array[i]);
+		else
+			ce_array[j++] = ce_array[i];
+	}
+	istate->cache_changed = 1;
+	istate->cache_nr = j;
+}
+
 int remove_file_from_index(struct index_state *istate, const char *path)
 {
 	int pos = index_name_pos(istate, path, strlen(path));
diff --git a/unpack-trees.c b/unpack-trees.c
index e3c3fa1..273b5da 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -93,11 +93,9 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			if (o->update)
 				unlink_entry(ce);
-			remove_index_entry_at(&o->result, i);
-			i--;
-			continue;
 		}
 	}
+	remove_marked_cache_entries(&o->result);
 	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
-- 
1.6.1.349.g99fa5
