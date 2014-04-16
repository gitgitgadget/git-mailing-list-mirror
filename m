From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 3/6] compat/regex/regexec.c: reduce scope of variables
Date: Wed, 16 Apr 2014 02:33:28 -0700
Message-ID: <1397640811-17719-3-git-send-email-gitter.spiros@gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMEc-0006Ar-5c
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbaDPJeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:34:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47081 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbaDPJdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:33:44 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so10785249pad.29
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZS2wJ/JojsxxuhEAhPCb7E9pP8brUxMmDJTpJn/+7A=;
        b=pjq8fMS+gdse36d6EG2RqhcrZRzBvkVrFjM2BuVhOryytULapqYfCGt+7OCXIwwqyo
         uKqo7BOAZMKjPh3HSv0GnTCi5yueGbcbe57StYWMGKQx2oKpYeMEojNrK6PWKwKOIClb
         13C0Z1uzxFy2/UKe5OkBKtWNqm/4gaAtyZmLTqx6ZDuJqEOoxvErpEGMbi7om0Hb+n9r
         bgribjFxcSqNvsH8r1QN5+DeGYs+qLgzuNNh3EDLZVtQG0+pZeah6OVlgdhidp4hM+gB
         7i8xdUOjYoXAYXqzCMa5aFO/tP70h6LFUrhE+a5BCuRHbZudg6VQk630Oo8vXfYi/ZHv
         mTVw==
X-Received: by 10.68.228.1 with SMTP id se1mr7305202pbc.43.1397640824388;
        Wed, 16 Apr 2014 02:33:44 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id de5sm45687493pbc.66.2014.04.16.02.33.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 02:33:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246324>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 compat/regex/regexec.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index eb5e1d4..f86dbeb 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -1254,12 +1254,12 @@ proceed_next_node (const re_match_context_t *mctx, int nregs, regmatch_t *regs,
 		   struct re_fail_stack_t *fs)
 {
   const re_dfa_t *const dfa = mctx->dfa;
-  int i, err;
+  int err;
   if (IS_EPSILON_NODE (dfa->nodes[node].type))
     {
       re_node_set *cur_nodes = &mctx->state_log[*pidx]->nodes;
       re_node_set *edests = &dfa->edests[node];
-      int dest_node;
+      int dest_node, i;
       err = re_node_set_insert (eps_via_nodes, node);
       if (BE (err < 0, 0))
 	return -2;
@@ -1446,9 +1446,9 @@ set_regs (const regex_t *preg, const re_match_context_t *mctx, size_t nmatch,
 
       if (idx == pmatch[0].rm_eo && cur_node == mctx->last_node)
 	{
-	  int reg_idx;
 	  if (fs)
 	    {
+	      int reg_idx;
 	      for (reg_idx = 0; reg_idx < nmatch; ++reg_idx)
 		if (pmatch[reg_idx].rm_so > -1 && pmatch[reg_idx].rm_eo == -1)
 		  break;
@@ -1818,7 +1818,6 @@ add_epsilon_src_nodes (const re_dfa_t *dfa, re_node_set *dest_nodes,
 		       const re_node_set *candidates)
 {
   reg_errcode_t err = REG_NOERROR;
-  int i;
 
   re_dfastate_t *state = re_acquire_state (&err, dfa, dest_nodes);
   if (BE (err != REG_NOERROR, 0))
@@ -1826,6 +1825,7 @@ add_epsilon_src_nodes (const re_dfa_t *dfa, re_node_set *dest_nodes,
 
   if (!state->inveclosure.alloc)
     {
+      int i;
       err = re_node_set_alloc (&state->inveclosure, dest_nodes->nelem);
       if (BE (err != REG_NOERROR, 0))
 	return REG_ESPACE;
@@ -3824,7 +3824,6 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
 # ifdef _LIBC
       const unsigned char *pin
 	= ((const unsigned char *) re_string_get_buffer (input) + str_idx);
-      int j;
       uint32_t nrules;
 # endif /* _LIBC */
       int match_len = 0;
@@ -3867,6 +3866,7 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
 	  for (i = 0; i < cset->ncoll_syms; ++i)
 	    {
 	      const unsigned char *coll_sym = extra + cset->coll_syms[i];
+              int j;
 	      /* Compare the length of input collating element and
 		 the length of current collating element.  */
 	      if (*coll_sym != elem_len)
@@ -4004,13 +4004,14 @@ find_collation_sequence_value (const unsigned char *mbs, size_t mbs_len)
 
       for (idx = 0; idx < extrasize;)
 	{
-	  int mbs_cnt, found = 0;
+	  int found = 0;
 	  int32_t elem_mbs_len;
 	  /* Skip the name of collating element name.  */
 	  idx = idx + extra[idx] + 1;
 	  elem_mbs_len = extra[idx++];
 	  if (mbs_len == elem_mbs_len)
-	    {
+	    { 
+              init mbs_cnt;
 	      for (mbs_cnt = 0; mbs_cnt < elem_mbs_len; ++mbs_cnt)
 		if (extra[idx + mbs_cnt] != mbs[mbs_cnt])
 		  break;
-- 
1.7.10.4
