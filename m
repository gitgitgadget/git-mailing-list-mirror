Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FD120195
	for <e@80x24.org>; Fri, 15 Jul 2016 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbcGOS6e (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 14:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbcGOS6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 14:58:33 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8ACA98553D;
	Fri, 15 Jul 2016 18:58:32 +0000 (UTC)
Received: from [192.168.3.156] (vpn-55-41.rdu2.redhat.com [10.10.55.41])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6FIwVss026028;
	Fri, 15 Jul 2016 14:58:32 -0400
Subject: [StGit PATCH] contrib/vim: Fix filetype detection in VIM >=7.4
From:	Zane Bitter <zbitter@redhat.com>
To:	git@vger.kernel.org
Cc:	catalin.marinas@gmail.com
Date:	Fri, 15 Jul 2016 14:58:31 -0400
Message-ID: <146860882262.30566.9308142555262174975.stgit@zbitter>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Jul 2016 18:58:32 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The command "setfiletype" will not override an existing filetype. This was
never a problem for me previously, but since upgrading from VIM 7.3 to 7.4
the filetype for StGit's files is explicitly set to "text", preventing the
stgit ftdetect plugin overriding it. Use "setlocal filetype=" instead to
ensure that we override any previously detected filetype.

Signed-off-by: Zane Bitter <zbitter@redhat.com>
---
 contrib/vim/ftdetect/stg.vim |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/contrib/vim/ftdetect/stg.vim b/contrib/vim/ftdetect/stg.vim
index abd4d9f..adf46dd 100644
--- a/contrib/vim/ftdetect/stg.vim
+++ b/contrib/vim/ftdetect/stg.vim
@@ -6,23 +6,22 @@
 if has("autocmd")
 
   " Detect 'stg new' files
-  autocmd BufNewFile,BufRead .stgit-new.txt       setf     stgnew
-  autocmd BufNewFile,BufRead .stgitmsg.txt        setf     stgnew
+  autocmd BufNewFile,BufRead .stgit-new.txt       setlocal filetype=stgnew
+  autocmd BufNewFile,BufRead .stgitmsg.txt        setlocal filetype=stgnew
   " Ignore the modeline so we get type 'stgnew' instead of 'diff'
   autocmd BufNewFile,BufRead .stgitmsg.txt        setlocal nomodeline
 
   " Detect 'stg edit' files
-  autocmd BufNewFile,BufRead .stgit-edit.txt      setf     stgedit
-  " Use set filetype instead of setfiletype to override detection as patch
+  autocmd BufNewFile,BufRead .stgit-edit.txt      setlocal filetype=stgedit
   autocmd BufNewFile,BufRead .stgit-edit.patch    setlocal filetype=stgedit
   autocmd BufNewFile,BufRead .stgit-edit.diff     setlocal filetype=stgedit
   autocmd BufNewFile,BufRead .stgit-failed.patch  setlocal filetype=stgedit
 
   " Detect 'stg squash' files
-  autocmd BufNewFile,BufRead .stgit-squash.txt    setf     stgsquash
+  autocmd BufNewFile,BufRead .stgit-squash.txt    setlocal filetype=stgsquash
 
   " Detect 'stg mail' files
-  autocmd BufNewFile,BufRead .stgitmail.txt       setf     stgmail
+  autocmd BufNewFile,BufRead .stgitmail.txt       setlocal filetype=stgmail
 
 
   " A modeline in a diff belongs to the diffed file, so ignore it

