From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/8] remote-helpers: cleanup more global variables
Date: Wed, 28 Aug 2013 14:23:12 -0500
Message-ID: <1377717793-27170-8-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPy-0003pE-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab3H1T2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:33 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41850 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab3H1T2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:32 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so8226476oag.21
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nr4tsNStkbD7Y59+i4hNsnBLZIj3VsDQCzrls33kVpA=;
        b=AWffbivBBjvgoj9X9FF/KEWnRHiiSTUHqcebrGQeWXgit3gaaTpdmrP+1SX80QKMjn
         VlXOP8zukFBKjl9V67wsalNpCxPnz6rFQlBO2etIdoWKnVtXuRTJD9QRLWpYm0Z09F4q
         5NjY2MxYplnBqI3OeTQSuejP1THtZFU9R7FJn5Hgr9gkfEF8v2cyyBcm1edd2JSjpWL7
         eP+3U05eNvJx3EqKDeuQLT9zOWliTMh6wfBzp0oTzijjecu7wDng8LGp/QjiyiDFlPHL
         Jp+f3qIWGCI61lZP7UmV9UsmAOShXT1N8pF00ubTl35XbAuetga1JGPuEwtHmLUHfq3E
         gE+Q==
X-Received: by 10.182.61.19 with SMTP id l19mr7867096obr.55.1377718111411;
        Wed, 28 Aug 2013 12:28:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id a18sm27508683obf.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233201>

They don't need to be specified if they are not going to be set.

Suggested-by: Dusty Phillips <dusty@linux.ca>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 29 -----------------------------
 contrib/remote-helpers/git-remote-hg  | 30 ++----------------------------
 2 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index e4fdfb0..42cec58 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -178,11 +178,9 @@ class Parser:
         return (committer, int(date), tz)
 
 def rev_to_mark(rev):
-    global marks
     return marks.from_rev(rev)
 
 def mark_to_rev(mark):
-    global marks
     return marks.to_rev(mark)
 
 def fixup_user(user):
@@ -237,8 +235,6 @@ def get_filechanges(cur, prev):
     return modified, removed
 
 def export_files(tree, files):
-    global marks, filenodes
-
     final = []
     for path, fid in files.iteritems():
         kind = tree.kind(fid)
@@ -280,8 +276,6 @@ def export_files(tree, files):
     return final
 
 def export_branch(repo, name):
-    global prefix
-
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
 
@@ -382,16 +376,12 @@ def export_branch(repo, name):
     marks.set_tip(name, revid)
 
 def export_tag(repo, name):
-    global tags, prefix
-
     ref = '%s/tags/%s' % (prefix, name)
     print "reset %s" % ref
     print "from :%u" % rev_to_mark(tags[name])
     print
 
 def do_import(parser):
-    global dirname
-
     repo = parser.repo
     path = os.path.join(dirname, 'marks-git')
 
@@ -417,8 +407,6 @@ def do_import(parser):
     sys.stdout.flush()
 
 def parse_blob(parser):
-    global blob_marks
-
     parser.next()
     mark = parser.get_mark()
     parser.next()
@@ -429,8 +417,6 @@ def parse_blob(parser):
 class CustomTree():
 
     def __init__(self, branch, revid, parents, files):
-        global files_cache
-
         self.updates = {}
         self.branch = branch
 
@@ -587,9 +573,6 @@ def c_style_unescape(string):
     return string
 
 def parse_commit(parser):
-    global marks, blob_marks, parsed_refs
-    global mode
-
     parents = []
 
     ref = parser[1]
@@ -661,8 +644,6 @@ def parse_commit(parser):
     marks.new_mark(revid, commit_mark)
 
 def parse_reset(parser):
-    global parsed_refs
-
     ref = parser[1]
     parser.next()
 
@@ -678,8 +659,6 @@ def parse_reset(parser):
     parsed_refs[ref] = mark_to_rev(from_mark)
 
 def do_export(parser):
-    global parsed_refs, dirname
-
     parser.next()
 
     for line in parser.each_block('done'):
@@ -728,8 +707,6 @@ def do_export(parser):
     print
 
 def do_capabilities(parser):
-    global dirname
-
     print "import"
     print "export"
     print "refspec refs/heads/*:%s/heads/*" % prefix
@@ -747,8 +724,6 @@ def ref_is_valid(name):
     return not True in [c in name for c in '~^: \\']
 
 def do_list(parser):
-    global tags
-
     master_branch = None
 
     for name in branches:
@@ -782,8 +757,6 @@ def clone(path, remote_branch):
     return remote_branch.sprout(bdir, repository=repo)
 
 def get_remote_branch(name):
-    global dirname, branches
-
     remote_branch = bzrlib.branch.Branch.open(branches[name])
     if isinstance(remote_branch.user_transport, bzrlib.transport.local.LocalTransport):
         return remote_branch
@@ -825,8 +798,6 @@ def find_branches(repo):
             yield name, branch.base
 
 def get_repo(url, alias):
-    global dirname, peer, branches
-
     normal_url = bzrlib.urlutils.normalize_url(url)
     origin = bzrlib.bzrdir.BzrDir.open(url)
     is_local = isinstance(origin.transport, bzrlib.transport.local.LocalTransport)
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 178a5a5..307d82c 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -227,8 +227,6 @@ class Parser:
         return sys.stdin.read(size)
 
     def get_author(self):
-        global bad_mail
-
         ex = None
         m = RAW_AUTHOR_RE.match(self.line)
         if not m:
@@ -261,8 +259,6 @@ def fix_file_path(path):
     return os.path.relpath(path, '/')
 
 def export_files(files):
-    global marks, filenodes
-
     final = []
     for f in files:
         fid = node.hex(f.filenode())
@@ -344,8 +340,6 @@ def fixup_user_hg(user):
     return (name, mail)
 
 def fixup_user(user):
-    global mode, bad_mail
-
     if mode == 'git':
         name, mail = fixup_user_git(user)
     else:
@@ -374,7 +368,7 @@ def updatebookmarks(repo, peer):
         bookmarks.write(repo)
 
 def get_repo(url, alias):
-    global dirname, peer
+    global peer
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
@@ -429,16 +423,12 @@ def get_repo(url, alias):
     return repo
 
 def rev_to_mark(rev):
-    global marks
     return marks.from_rev(rev.hex())
 
 def mark_to_rev(mark):
-    global marks
     return marks.to_rev(mark)
 
 def export_ref(repo, name, kind, head):
-    global prefix, marks, mode
-
     ename = '%s/%s' % (kind, name)
     try:
         tip = marks.get_tip(ename)
@@ -550,12 +540,9 @@ def export_branch(repo, branch):
     export_ref(repo, branch, 'branches', head)
 
 def export_head(repo):
-    global g_head
     export_ref(repo, g_head[0], 'bookmarks', g_head[1])
 
 def do_capabilities(parser):
-    global prefix, dirname
-
     print "import"
     print "export"
     print "refspec refs/heads/branches/*:%s/branches/*" % prefix
@@ -575,8 +562,6 @@ def branch_tip(branch):
     return branches[branch][-1]
 
 def get_branch_tip(repo, branch):
-    global branches
-
     heads = branches.get(hgref(branch), None)
     if not heads:
         return None
@@ -589,7 +574,7 @@ def get_branch_tip(repo, branch):
     return heads[0]
 
 def list_head(repo, cur):
-    global g_head, bmarks, fake_bmark
+    global g_head, fake_bmark
 
     if 'default' not in branches:
         # empty repo
@@ -605,8 +590,6 @@ def list_head(repo, cur):
     g_head = (head, node)
 
 def do_list(parser):
-    global branches, bmarks, track_branches
-
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
         bmarks[bmark] = repo[node]
@@ -674,8 +657,6 @@ def do_import(parser):
     print 'done'
 
 def parse_blob(parser):
-    global blob_marks
-
     parser.next()
     mark = parser.get_mark()
     parser.next()
@@ -692,9 +673,6 @@ def get_merge_files(repo, p1, p2, files):
             files[e] = f
 
 def parse_commit(parser):
-    global marks, blob_marks, parsed_refs
-    global mode
-
     from_mark = merge_mark = None
 
     ref = parser[1]
@@ -812,8 +790,6 @@ def parse_commit(parser):
     marks.new_mark(node, commit_mark)
 
 def parse_reset(parser):
-    global parsed_refs
-
     ref = parser[1]
     parser.next()
     # ugh
@@ -1006,8 +982,6 @@ def check_tip(ref, kind, name, heads):
         return tip in heads
 
 def do_export(parser):
-    global parsed_refs, bmarks, peer
-
     p_bmarks = []
     p_revs = {}
 
-- 
1.8.4-fc
