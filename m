From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: fatal: internal error in diff-resolve-rename-copy
Date: Tue, 06 Jul 2010 16:47:06 +0200
Message-ID: <4C3341EA.7070901@drmicha.warpmail.net>
References: <4C31CA75.9010709@drmicha.warpmail.net> <AANLkTimyZnvIs9XCwxKLxisum5KllXwrPygkCidC1CnH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 16:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9RX-0007PS-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0GFOsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 10:48:11 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44011 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751311Ab0GFOsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 10:48:09 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4593F131E6D;
	Tue,  6 Jul 2010 10:48:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 06 Jul 2010 10:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Dmym88xpgUr2SXBZuIdQ03xhahM=; b=N8Z0NoDPNB/Df8HdtLzxn/CuMpccwc7+2v5Cx3O5RlDOjoD67i5Skn1dq4BUfDDGD42Q+X66Dle8uf6tZoywmbP3Oj3cRFm2qeS9M4BCpnZvgGPWjjef/XxoWivRuoIAxFWIuteSw3D1OrJjey7W+X0spHdydxVmZXNb0NaF1t8=
X-Sasl-enc: gOLBPKF3dnIjTOGD2uvmKg92HCVciE8p8ROzCySAiKoJ 1278427677
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DAFAD4DA649;
	Tue,  6 Jul 2010 10:47:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTimyZnvIs9XCwxKLxisum5KllXwrPygkCidC1CnH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150358>

Alex Riesen venit, vidit, dixit 05.07.2010 20:20:
> On Mon, Jul 5, 2010 at 14:05, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> can someone help me with understanding or debugging the following? With
>> "log -p --stat" I get that strange fatal error. (With GIT_FLUSH=0 it
>> appears upfront.)
>>
>> Without "-p --stat" the log is displayed without a fatal error (same 3
>> commits), but with "-p" or "--stat" (or both) it's fatal.
> 
> Could you run the case under valgrind? (I suspect a corruption of diff
> data structures)

I have zero experience with valgrind. Running the reported command with
the same suppressions as the test suite does, but with full leak check,
I get the following report on stderr. Do you see anything suspicious in
there? Should I run valgrind with -v?

Michael

==3379== Memcheck, a memory error detector
==3379== Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
==3379== Using Valgrind-3.5.0 and LibVEX; rerun with -h for copyright info
==3379== Command: git log --stat --follow LVVO/Formular\
Lehrverpflichtung\ SS\ 2009_FakIII.odt
==3379==
fatal: internal error in diff-resolve-rename-copy
==3379==
==3379== HEAP SUMMARY:
==3379==     in use at exit: 1,611,768 bytes in 148 blocks
==3379==   total heap usage: 12,842 allocs, 12,694 frees, 29,235,398
bytes allocated
==3379==
==3379== 4 bytes in 1 blocks are definitely lost in loss record 4 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x311087FE01: strdup (in /lib64/libc-2.12.so)
==3379==    by 0x4C3838: xstrdup (wrapper.c:22)
==3379==    by 0x46BBE0: git_config_string (config.c:406)
==3379==    by 0x46D082: git_config_from_file (config.c:185)
==3379==    by 0x46D4D5: git_config (config.c:802)
==3379==    by 0x491DAF: git_pager (pager.c:61)
==3379==    by 0x491DF4: setup_pager (pager.c:76)
==3379==    by 0x4041B8: handle_internal_command (git.c:262)
==3379==    by 0x4043C1: main (git.c:467)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:strdup
   fun:xstrdup
   fun:git_config_string
   fun:git_config_from_file
   fun:git_config
   fun:git_pager
   fun:setup_pager
   fun:handle_internal_command
   fun:main
}
==3379== 16 bytes in 1 blocks are possibly lost in loss record 13 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4C36E5: xmalloc (wrapper.c:34)
==3379==    by 0x46A6CD: commit_list_insert (commit.c:320)
==3379==    by 0x46B031: parse_commit_buffer (commit.c:272)
==3379==    by 0x46B22F: parse_commit (commit.c:309)
==3379==    by 0x4A9A2A: add_parents_to_list (revision.c:517)
==3379==    by 0x4A9E40: get_revision_1 (revision.c:2016)
==3379==    by 0x4A9EEA: get_revision_internal (revision.c:2121)
==3379==    by 0x4AA150: get_revision (revision.c:2202)
==3379==    by 0x4315DD: cmd_log_walk (log.c:264)
==3379==    by 0x43172B: cmd_log (log.c:515)
==3379==    by 0x4041E0: handle_internal_command (git.c:269)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:xmalloc
   fun:commit_list_insert
   fun:parse_commit_buffer
   fun:parse_commit
   fun:add_parents_to_list
   fun:get_revision_1
   fun:get_revision_internal
   fun:get_revision
   fun:cmd_log_walk
   fun:cmd_log
   fun:handle_internal_command
}
==3379== 27 bytes in 1 blocks are definitely lost in loss record 25 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4A051D7: realloc (vg_replace_malloc.c:476)
==3379==    by 0x4C364D: xrealloc (wrapper.c:80)
==3379==    by 0x4B53C7: strbuf_grow (strbuf.c:70)
==3379==    by 0x4B5733: strbuf_add (strbuf.c:183)
==3379==    by 0x49406F: expand_user_path (path.c:328)
==3379==    by 0x46C0C0: git_config_pathname (config.c:414)
==3379==    by 0x46D082: git_config_from_file (config.c:185)
==3379==    by 0x46D4D5: git_config (config.c:802)
==3379==    by 0x491DAF: git_pager (pager.c:61)
==3379==    by 0x491DF4: setup_pager (pager.c:76)
==3379==    by 0x4041B8: handle_internal_command (git.c:262)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:realloc
   fun:xrealloc
   fun:strbuf_grow
   fun:strbuf_add
   fun:expand_user_path
   fun:git_config_pathname
   fun:git_config_from_file
   fun:git_config
   fun:git_pager
   fun:setup_pager
   fun:handle_internal_command
}
==3379== 46 bytes in 1 blocks are definitely lost in loss record 33 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x311087FE01: strdup (in /lib64/libc-2.12.so)
==3379==    by 0x4C3838: xstrdup (wrapper.c:22)
==3379==    by 0x4BD99F: diff_tree_sha1 (tree-diff.c:377)
==3379==    by 0x4897EA: log_tree_commit (log-tree.c:542)
==3379==    by 0x4315BA: cmd_log_walk (log.c:265)
==3379==    by 0x43172B: cmd_log (log.c:515)
==3379==    by 0x4041E0: handle_internal_command (git.c:269)
==3379==    by 0x4043C1: main (git.c:467)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:strdup
   fun:xstrdup
   fun:diff_tree_sha1
   fun:log_tree_commit
   fun:cmd_log_walk
   fun:cmd_log
   fun:handle_internal_command
   fun:main
}
==3379== 51 bytes in 1 blocks are definitely lost in loss record 37 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4C36E5: xmalloc (wrapper.c:34)
==3379==    by 0x4AD45F: prefix_path (setup.c:10)
==3379==    by 0x4AD5EA: get_pathspec (setup.c:147)
==3379==    by 0x4A8BD0: setup_revisions (revision.c:1594)
==3379==    by 0x431113: cmd_log_init (log.c:78)
==3379==    by 0x431723: cmd_log (log.c:514)
==3379==    by 0x4041E0: handle_internal_command (git.c:269)
==3379==    by 0x4043C1: main (git.c:467)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:xmalloc
   fun:prefix_path
   fun:get_pathspec
   fun:setup_revisions
   fun:cmd_log_init
   fun:cmd_log
   fun:handle_internal_command
   fun:main
}
==3379== 65 bytes in 1 blocks are definitely lost in loss record 40 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4A051D7: realloc (vg_replace_malloc.c:476)
==3379==    by 0x4C364D: xrealloc (wrapper.c:80)
==3379==    by 0x4B53C7: strbuf_grow (strbuf.c:70)
==3379==    by 0x4B5B5A: strbuf_addf (strbuf.c:201)
==3379==    by 0x4816DF: system_path (exec_cmd.c:37)
==3379==    by 0x481801: setup_path (exec_cmd.c:104)
==3379==    by 0x4043B0: main (git.c:533)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:realloc
   fun:xrealloc
   fun:strbuf_grow
   fun:strbuf_addf
   fun:system_path
   fun:setup_path
   fun:main
}
==3379== 192 bytes in 1 blocks are definitely lost in loss record 56 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4A051D7: realloc (vg_replace_malloc.c:476)
==3379==    by 0x4C364D: xrealloc (wrapper.c:80)
==3379==    by 0x476812: diff_q (diff.c:3297)
==3379==    by 0x476869: diff_queue (diff.c:3311)
==3379==    by 0x477125: diff_addremove (diff.c:4150)
==3379==    by 0x4BD082: show_entry (tree-diff.c:255)
==3379==    by 0x4BD168: show_entry (tree-diff.c:217)
==3379==    by 0x4BD4A5: diff_tree (tree-diff.c:299)
==3379==    by 0x4BD79A: diff_tree_sha1 (tree-diff.c:414)
==3379==    by 0x4897EA: log_tree_commit (log-tree.c:542)
==3379==    by 0x4315BA: cmd_log_walk (log.c:265)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:realloc
   fun:xrealloc
   fun:diff_q
   fun:diff_queue
   fun:diff_addremove
   fun:show_entry
   fun:show_entry
   fun:diff_tree
   fun:diff_tree_sha1
   fun:log_tree_commit
   fun:cmd_log_walk
}
==3379== 384 bytes in 2 blocks are definitely lost in loss record 58 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4A051D7: realloc (vg_replace_malloc.c:476)
==3379==    by 0x4C364D: xrealloc (wrapper.c:80)
==3379==    by 0x476812: diff_q (diff.c:3297)
==3379==    by 0x476869: diff_queue (diff.c:3311)
==3379==    by 0x477125: diff_addremove (diff.c:4150)
==3379==    by 0x4BD082: show_entry (tree-diff.c:255)
==3379==    by 0x4BD4A5: diff_tree (tree-diff.c:299)
==3379==    by 0x4BD79A: diff_tree_sha1 (tree-diff.c:414)
==3379==    by 0x4897EA: log_tree_commit (log-tree.c:542)
==3379==    by 0x4315BA: cmd_log_walk (log.c:265)
==3379==    by 0x43172B: cmd_log (log.c:515)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:realloc
   fun:xrealloc
   fun:diff_q
   fun:diff_queue
   fun:diff_addremove
   fun:show_entry
   fun:diff_tree
   fun:diff_tree_sha1
   fun:log_tree_commit
   fun:cmd_log_walk
   fun:cmd_log
}
==3379== 545 bytes in 2 blocks are possibly lost in loss record 60 of 76
==3379==    at 0x4A0515D: malloc (vg_replace_malloc.c:195)
==3379==    by 0x4C36E5: xmalloc (wrapper.c:34)
==3379==    by 0x4C377E: xmallocz (wrapper.c:56)
==3379==    by 0x4AE627: unpack_sha1_file (sha1_file.c:1170)
==3379==    by 0x4B2200: read_object (sha1_file.c:2074)
==3379==    by 0x4B226E: read_sha1_file_repl (sha1_file.c:2088)
==3379==    by 0x46B1E7: parse_commit (cache.h:721)
==3379==    by 0x4A9A2A: add_parents_to_list (revision.c:517)
==3379==    by 0x4A9E40: get_revision_1 (revision.c:2016)
==3379==    by 0x4A9EEA: get_revision_internal (revision.c:2121)
==3379==    by 0x4AA150: get_revision (revision.c:2202)
==3379==    by 0x4315DD: cmd_log_walk (log.c:264)
==3379==
{
   <insert_a_suppression_name_here>
   Memcheck:Leak
   fun:malloc
   fun:xmalloc
   fun:xmallocz
   fun:unpack_sha1_file
   fun:read_object
   fun:read_sha1_file_repl
   fun:parse_commit
   fun:add_parents_to_list
   fun:get_revision_1
   fun:get_revision_internal
   fun:get_revision
   fun:cmd_log_walk
}
==3379== LEAK SUMMARY:
==3379==    definitely lost: 769 bytes in 8 blocks
==3379==    indirectly lost: 0 bytes in 0 blocks
==3379==      possibly lost: 561 bytes in 3 blocks
==3379==    still reachable: 1,610,438 bytes in 137 blocks
==3379==         suppressed: 0 bytes in 0 blocks
==3379== Reachable blocks (those to which a pointer was found) are not
shown.
==3379== To see them, rerun with: --leak-check=full --show-reachable=yes
==3379==
==3379== For counts of detected and suppressed errors, rerun with: -v
==3379== ERROR SUMMARY: 9 errors from 9 contexts (suppressed: 6 from 6)
