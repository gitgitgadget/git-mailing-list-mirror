From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/6] compat/regex/regcomp.c: reduce scope of variables
Date: Wed, 16 Apr 2014 02:33:26 -0700
Message-ID: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMEJ-0005aN-SF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbaDPJdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:33:45 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:59111 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaDPJdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:33:42 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so10479428pdj.40
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U5VKaOKxt5Z5OnZDjAXL7PAFZc8Nge3vm5tJujcgSBY=;
        b=w9B3YOTxrQ+Eg1TQeDlHv1cCC7hjSDdtPXji3KzJeDLHpRORIn+ZxmYxIlqS4EMxWw
         nyyRVSg7ZvuxeJRyFKjzsX5+vsiDuD+B/lGq9JbtpUIoEQvJp7zg4TVkDrObJmMD3IU0
         sfu85+sJF491Ul6g1PcaDCE8aXDGjH9/t8dUjW2za5du9M4834Foc8tBOz9HVaNVrjfJ
         0MF6aoSIUkZuKtmD9n7vSzGIgY6ifvNFUyG23UGC6F28W9s6nCJMlQOrfpltFfWZsWNp
         siYVQGyz54WTfeKQoT8zipm7zzLWpYPg8uO6zP+QWkeOLXDeFaeZ+ak5MhrSyY6VBGAp
         +KZQ==
X-Received: by 10.68.136.133 with SMTP id qa5mr7255721pbb.63.1397640822202;
        Wed, 16 Apr 2014 02:33:42 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id de5sm45687493pbc.66.2014.04.16.02.33.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 02:33:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246321>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 compat/regex/regcomp.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 06f3088..c7da378 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -368,7 +368,6 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
       else if (type == COMPLEX_BRACKET)
 	{
 	  re_charset_t *cset = dfa->nodes[node].opr.mbcset;
-	  int i;
 
 # ifdef _LIBC
 	  /* See if we have to try all bytes which start multiple collation
@@ -380,6 +379,7 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
 	      if (_NL_CURRENT_WORD (LC_COLLATE, _NL_COLLATE_NRULES) != 0
 		  && (cset->ncoll_syms || cset->nranges))
 		{
+		  int i;
 		  const int32_t *table = (const int32_t *)
 		    _NL_CURRENT (LC_COLLATE, _NL_COLLATE_TABLEMB);
 		  for (i = 0; i < SBC_MAX; ++i)
@@ -598,7 +598,7 @@ static bitset_t utf8_sb_map;
 static void
 free_dfa_content (re_dfa_t *dfa)
 {
-  int i, j;
+  int i;
 
   if (dfa->nodes)
     for (i = 0; i < dfa->nodes_len; ++i)
@@ -621,6 +621,7 @@ free_dfa_content (re_dfa_t *dfa)
   if (dfa->state_table)
     for (i = 0; i <= dfa->state_hash_mask; ++i)
       {
+	int j;
 	struct re_state_table_entry *entry = dfa->state_table + i;
 	for (j = 0; j < entry->num; ++j)
 	  {
@@ -994,7 +995,7 @@ free_workarea_compile (regex_t *preg)
 static reg_errcode_t
 create_initial_state (re_dfa_t *dfa)
 {
-  int first, i;
+  int first;
   reg_errcode_t err;
   re_node_set init_nodes;
 
@@ -1011,6 +1012,8 @@ create_initial_state (re_dfa_t *dfa)
      Then we add epsilon closures of the nodes which are the next nodes of
      the back-references.  */
   if (dfa->nbackref > 0)
+    {
+    int i;
     for (i = 0; i < init_nodes.nelem; ++i)
       {
 	int node_idx = init_nodes.elems[i];
@@ -1044,6 +1047,7 @@ create_initial_state (re_dfa_t *dfa)
 	      }
 	  }
       }
+    }
 
   /* It must be the first time to invoke acquire_state.  */
   dfa->init_state = re_acquire_state_context (&err, dfa, &init_nodes, 0);
@@ -1682,7 +1686,6 @@ static reg_errcode_t
 calc_eclosure_iter (re_node_set *new_set, re_dfa_t *dfa, int node, int root)
 {
   reg_errcode_t err;
-  int i;
   re_node_set eclosure;
   int ret;
   int incomplete = 0;
@@ -1708,6 +1711,8 @@ calc_eclosure_iter (re_node_set *new_set, re_dfa_t *dfa, int node, int root)
 
   /* Expand each epsilon destination nodes.  */
   if (IS_EPSILON_NODE(dfa->nodes[node].type))
+    {
+    int i;
     for (i = 0; i < dfa->edests[node].nelem; ++i)
       {
 	re_node_set eclosure_elem;
@@ -1741,6 +1746,7 @@ calc_eclosure_iter (re_node_set *new_set, re_dfa_t *dfa, int node, int root)
 	    re_node_set_free (&eclosure_elem);
 	  }
       }
+    }
 
   /* An epsilon closure includes itself.  */
   ret = re_node_set_insert (&eclosure, node);
@@ -2630,7 +2636,6 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
 		 bracket_elem_t *end_elem)
 # endif /* not RE_ENABLE_I18N */
 {
-  unsigned int start_ch, end_ch;
   /* Equivalence Classes and Character Classes can't be a range start/end.  */
   if (BE (start_elem->type == EQUIV_CLASS || start_elem->type == CHAR_CLASS
 	  || end_elem->type == EQUIV_CLASS || end_elem->type == CHAR_CLASS,
@@ -2647,6 +2652,7 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
 
 # ifdef RE_ENABLE_I18N
   {
+    unsigned int start_ch, end_ch;
     wchar_t wc;
     wint_t start_wc;
     wint_t end_wc;
@@ -2728,6 +2734,7 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
 # else /* not RE_ENABLE_I18N */
   {
     unsigned int ch;
+    unsigned int start_ch, end_ch;
     start_ch = ((start_elem->type == SB_CHAR ) ? start_elem->opr.ch
 		: ((start_elem->type == COLL_SYM) ? start_elem->opr.name[0]
 		   : 0));
-- 
1.7.10.4
