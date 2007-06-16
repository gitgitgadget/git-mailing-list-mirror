From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 5/9] Promote more common functions to Command methods.
Date: Sun, 17 Jun 2007 00:00:55 +0200
Message-ID: <20070616220055.14941.77446.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgKt-0000H7-LI
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbXFPWAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756189AbXFPWAz
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:00:55 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45550 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757897AbXFPWAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:00:47 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CE09C7491;
	Sun, 17 Jun 2007 00:00:45 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3E6171F08A;
	Sun, 17 Jun 2007 00:00:55 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50316>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/branch.py  |   10 +-
 stgit/commands/clean.py   |    4 -
 stgit/commands/commit.py  |    2 
 stgit/commands/common.py  |  270 +++++++++++++++++++++++----------------------
 stgit/commands/delete.py  |    4 -
 stgit/commands/diff.py    |    4 -
 stgit/commands/files.py   |    4 -
 stgit/commands/float.py   |    6 +
 stgit/commands/fold.py    |    4 -
 stgit/commands/goto.py    |    8 +
 stgit/commands/id.py      |    2 
 stgit/commands/imprt.py   |    6 +
 stgit/commands/mail.py    |    8 +
 stgit/commands/new.py     |    2 
 stgit/commands/pick.py    |   12 +-
 stgit/commands/pop.py     |    8 +
 stgit/commands/pull.py    |   12 +-
 stgit/commands/push.py    |    8 +
 stgit/commands/rebase.py  |   14 +-
 stgit/commands/refresh.py |    6 +
 stgit/commands/series.py  |    4 -
 stgit/commands/show.py    |    2 
 stgit/commands/sink.py    |    6 +
 stgit/commands/sync.py    |    8 +
 24 files changed, 207 insertions(+), 207 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 9777fad..e243830 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -98,7 +98,7 @@ class concreteCommand(Command):
         if self.__is_current_branch(doomed_name):
             check_local_changes()
             check_conflicts()
-            check_head_top_equal()
+            self.check_head_top_equal()
 
             if doomed_name != 'master':
                 git.switch_branch('master')
@@ -119,7 +119,7 @@ class concreteCommand(Command):
 
             check_local_changes()
             check_conflicts()
-            check_head_top_equal()
+            self.check_head_top_equal()
 
             tree_id = None
             if len(self.args) >= 2:
@@ -143,7 +143,7 @@ class concreteCommand(Command):
                              ' from "%s"' % self.args[1])
                     parentbranch = None
 
-                tree_id = git_id(self.args[1])
+                tree_id = self.git_id(self.args[1])
             else:
                 # branch stack off current branch
                 parentbranch = git.get_head_file()
@@ -178,7 +178,7 @@ class concreteCommand(Command):
 
             check_local_changes()
             check_conflicts()
-            check_head_top_equal()
+            self.check_head_top_equal()
 
             out.start('Cloning current branch to "%s"' % clone)
             crt_series.clone(clone)
@@ -293,7 +293,7 @@ class concreteCommand(Command):
 
             check_local_changes()
             check_conflicts()
-            check_head_top_equal()
+            self.check_head_top_equal()
 
             out.start('Switching to branch "%s"' % self.args[0])
             git.switch_branch(self.args[0])
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 10ee89e..3e9d829 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -60,7 +60,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         if not (self.flags.applied or self.flags.unapplied):
             self.flags.applied = self.flags.unapplied = True
@@ -73,4 +73,4 @@ class concreteCommand(Command):
             unapplied = crt_series.get_unapplied()
             self.__delete_empty(unapplied, False)
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 6e7bf13..56f3943 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -42,7 +42,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         applied = crt_series.get_applied()
         if not applied:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 60a6a7a..1ed5086 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -71,6 +71,141 @@ class Command:
         self.parser = OptionParser(usage = shortusage, option_list = self.options)
         self.flags, self.args = self.parser.parse_args()
 
+    def git_id(self, rev):
+        """Return the GIT id
+        """
+        if not rev:
+            return None
+        try:
+            patch, branch, patch_id = parse_rev(rev)
+            if branch == None:
+                series = crt_series
+            else:
+                series = stack.Series(branch)
+            if patch == None:
+                patch = series.get_current()
+                if not patch:
+                    raise CmdException, 'No patches applied'
+            if patch in series.get_applied() or patch in series.get_unapplied():
+                if patch_id in ['top', '', None]:
+                    return series.get_patch(patch).get_top()
+                elif patch_id == 'bottom':
+                    return series.get_patch(patch).get_bottom()
+                elif patch_id == 'top.old':
+                    return series.get_patch(patch).get_old_top()
+                elif patch_id == 'bottom.old':
+                    return series.get_patch(patch).get_old_bottom()
+                elif patch_id == 'log':
+                    return series.get_patch(patch).get_log()
+            if patch == 'base' and patch_id == None:
+                return series.get_base()
+        except RevParseException:
+            pass
+        return git.rev_parse(rev + '^{commit}')
+
+    def check_head_top_equal(self):
+        if not crt_series.head_top_equal():
+            raise CmdException(
+                'HEAD and top are not the same. You probably committed\n'
+                '  changes to the tree outside of StGIT. To bring them\n'
+                '  into StGIT, use the "assimilate" command')
+
+    def print_crt_patch(self, branch = None):
+        if not branch:
+            patch = crt_series.get_current()
+        else:
+            patch = stack.Series(branch).get_current()
+
+        if patch:
+            out.info('Now at patch "%s"' % patch)
+        else:
+            out.info('No patches applied')
+
+    def push_patches(self, patches, check_merged = False):
+        """Push multiple patches onto the stack. This function is shared
+        between the push and pull commands
+        """
+        forwarded = crt_series.forward_patches(patches)
+        if forwarded > 1:
+            out.info('Fast-forwarded patches "%s" - "%s"'
+                     % (patches[0], patches[forwarded - 1]))
+        elif forwarded == 1:
+            out.info('Fast-forwarded patch "%s"' % patches[0])
+
+        names = patches[forwarded:]
+
+        # check for patches merged upstream
+        if names and check_merged:
+            out.start('Checking for patches merged upstream')
+
+            merged = crt_series.merged_patches(names)
+
+            out.done('%d found' % len(merged))
+        else:
+            merged = []
+
+        for p in names:
+            out.start('Pushing patch "%s"' % p)
+
+            if p in merged:
+                crt_series.push_patch(p, empty = True)
+                out.done('merged upstream')
+            else:
+                modified = crt_series.push_patch(p)
+
+                if crt_series.empty_patch(p):
+                    out.done('empty patch')
+                elif modified:
+                    out.done('modified')
+                else:
+                    out.done()
+
+    def pop_patches(self, patches, keep = False):
+        """Pop the patches in the list from the stack. It is assumed that
+        the patches are listed in the stack reverse order.
+        """
+        if len(patches) == 0:
+            out.info('Nothing to push/pop')
+        else:
+            p = patches[-1]
+            if len(patches) == 1:
+                out.start('Popping patch "%s"' % p)
+            else:
+                out.start('Popping patches "%s" - "%s"' % (patches[0], p))
+            crt_series.pop_patch(p, keep)
+            out.done()
+
+    def prepare_rebase(self, force=None):
+        if not force:
+            # Be sure we won't loose results of stg-(un)commit by error.
+            # Do not require an existing orig-base for compatibility with 0.12 and earlier.
+            origbase = crt_series._get_field('orig-base')
+            if origbase and crt_series.get_base() != origbase:
+                raise CmdException, 'Rebasing would possibly lose data'
+
+        # pop all patches
+        applied = crt_series.get_applied()
+        if len(applied) > 0:
+            out.start('Popping all applied patches')
+            crt_series.pop_patch(applied[0])
+            out.done()
+        return applied
+
+    def rebase(self, target):
+        if target == git.get_head():
+            out.info('Already at "%s", no need for rebasing.' % target)
+            return
+        out.start('Rebasing to "%s"' % target)
+        git.reset(tree_id = self.git_id(target))
+        out.done()
+
+    def post_rebase(self, applied, nopush, merged):
+        # memorize that we rebased to here
+        crt_series._set_field('orig-base', git.get_head())
+        # push the patches back
+        if not nopush:
+            self.push_patches(applied, merged)
+
 # Utility functions
 def parse_rev(rev):
     """Parse a revision specification into its
@@ -108,67 +243,17 @@ def parse_rev(rev):
     # No, we can't parse that.
     raise RevParseException
 
-def git_id(rev):
-    """Return the GIT id
-    """
-    if not rev:
-        return None
-    try:
-        patch, branch, patch_id = parse_rev(rev)
-        if branch == None:
-            series = crt_series
-        else:
-            series = stack.Series(branch)
-        if patch == None:
-            patch = series.get_current()
-            if not patch:
-                raise CmdException, 'No patches applied'
-        if patch in series.get_applied() or patch in series.get_unapplied():
-            if patch_id in ['top', '', None]:
-                return series.get_patch(patch).get_top()
-            elif patch_id == 'bottom':
-                return series.get_patch(patch).get_bottom()
-            elif patch_id == 'top.old':
-                return series.get_patch(patch).get_old_top()
-            elif patch_id == 'bottom.old':
-                return series.get_patch(patch).get_old_bottom()
-            elif patch_id == 'log':
-                return series.get_patch(patch).get_log()
-        if patch == 'base' and patch_id == None:
-            return series.get_base()
-    except RevParseException:
-        pass
-    return git.rev_parse(rev + '^{commit}')
-
 def check_local_changes():
     if git.local_changes():
         raise CmdException, \
               'local changes in the tree. Use "refresh" or "status --reset"'
 
-def check_head_top_equal():
-    if not crt_series.head_top_equal():
-        raise CmdException(
-            'HEAD and top are not the same. You probably committed\n'
-            '  changes to the tree outside of StGIT. To bring them\n'
-            '  into StGIT, use the "assimilate" command')
-
 def check_conflicts():
     if os.path.exists(os.path.join(basedir.get(), 'conflicts')):
         raise CmdException, \
               'Unsolved conflicts. Please resolve them first or\n' \
               '  revert the changes with "status --reset"'
 
-def print_crt_patch(branch = None):
-    if not branch:
-        patch = crt_series.get_current()
-    else:
-        patch = stack.Series(branch).get_current()
-
-    if patch:
-        out.info('Now at patch "%s"' % patch)
-    else:
-        out.info('No patches applied')
-
 def resolved(filename, reset = None):
     if reset:
         reset_file = filename + file_extensions()[reset]
@@ -191,60 +276,6 @@ def resolved_all(reset = None):
             resolved(filename, reset)
         os.remove(os.path.join(basedir.get(), 'conflicts'))
 
-def push_patches(patches, check_merged = False):
-    """Push multiple patches onto the stack. This function is shared
-    between the push and pull commands
-    """
-    forwarded = crt_series.forward_patches(patches)
-    if forwarded > 1:
-        out.info('Fast-forwarded patches "%s" - "%s"'
-                 % (patches[0], patches[forwarded - 1]))
-    elif forwarded == 1:
-        out.info('Fast-forwarded patch "%s"' % patches[0])
-
-    names = patches[forwarded:]
-
-    # check for patches merged upstream
-    if names and check_merged:
-        out.start('Checking for patches merged upstream')
-
-        merged = crt_series.merged_patches(names)
-
-        out.done('%d found' % len(merged))
-    else:
-        merged = []
-
-    for p in names:
-        out.start('Pushing patch "%s"' % p)
-
-        if p in merged:
-            crt_series.push_patch(p, empty = True)
-            out.done('merged upstream')
-        else:
-            modified = crt_series.push_patch(p)
-
-            if crt_series.empty_patch(p):
-                out.done('empty patch')
-            elif modified:
-                out.done('modified')
-            else:
-                out.done()
-
-def pop_patches(patches, keep = False):
-    """Pop the patches in the list from the stack. It is assumed that
-    the patches are listed in the stack reverse order.
-    """
-    if len(patches) == 0:
-        out.info('Nothing to push/pop')
-    else:
-        p = patches[-1]
-        if len(patches) == 1:
-            out.start('Popping patch "%s"' % p)
-        else:
-            out.start('Popping patches "%s" - "%s"' % (patches[0], p))
-        crt_series.pop_patch(p, keep)
-        out.done()
-
 def parse_patches(patch_args, patch_list, boundary = 0, ordered = False):
     """Parse patch_args list for patch names in patch_list and return
     a list. The names can be individual patches and/or in the
@@ -351,34 +382,3 @@ def address_or_alias(addr_str):
     addr_list = [__address_or_alias(addr.strip())
                  for addr in addr_str.split(',')]
     return ', '.join([addr for addr in addr_list if addr])
-
-def prepare_rebase(force=None):
-    if not force:
-        # Be sure we won't loose results of stg-(un)commit by error.
-        # Do not require an existing orig-base for compatibility with 0.12 and earlier.
-        origbase = crt_series._get_field('orig-base')
-        if origbase and crt_series.get_base() != origbase:
-            raise CmdException, 'Rebasing would possibly lose data'
-
-    # pop all patches
-    applied = crt_series.get_applied()
-    if len(applied) > 0:
-        out.start('Popping all applied patches')
-        crt_series.pop_patch(applied[0])
-        out.done()
-    return applied
-
-def rebase(target):
-    if target == git.get_head():
-        out.info('Already at "%s", no need for rebasing.' % target)
-        return
-    out.start('Rebasing to "%s"' % target)
-    git.reset(tree_id = git_id(target))
-    out.done()
-
-def post_rebase(applied, nopush, merged):
-    # memorize that we rebased to here
-    crt_series._set_field('orig-base', git.get_head())
-    # push the patches back
-    if not nopush:
-        push_patches(applied, merged)
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 5a958ca..6d10895 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -70,7 +70,7 @@ class concreteCommand(Command):
         if applied and not self.flags.branch:
             check_local_changes()
             check_conflicts()
-            check_head_top_equal()
+            self.check_head_top_equal()
 
         # delete the patches
         for patch in applied + patches:
@@ -78,4 +78,4 @@ class concreteCommand(Command):
             out.info('Patch "%s" successfully deleted' % patch)
 
         if not self.flags.branch:
-            print_crt_patch()
+            self.print_crt_patch()
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index a015be7..1344953 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -85,9 +85,9 @@ class concreteCommand(Command):
             diff_flags = []
 
         if self.flags.stat:
-            out.stdout_raw(git.diffstat(self.args, git_id(rev1), git_id(rev2)) + '\n')
+            out.stdout_raw(git.diffstat(self.args, self.git_id(rev1), self.git_id(rev2)) + '\n')
         else:
-            diff_str = git.diff(self.args, git_id(rev1), git_id(rev2),
+            diff_str = git.diff(self.args, self.git_id(rev1), self.git_id(rev2),
                                 diff_flags = diff_flags )
             if diff_str:
                 pager(diff_str)
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index dbdbf11..ad3a5d1 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -56,8 +56,8 @@ class concreteCommand(Command):
         else:
             self.parser.error('incorrect number of arguments')
 
-        rev1 = git_id('%s//bottom' % patch)
-        rev2 = git_id('%s//top' % patch)
+        rev1 = self.git_id('%s//bottom' % patch)
+        rev2 = self.git_id('%s//top' % patch)
 
         if self.flags.stat:
             out.stdout_raw(git.diffstat(rev1 = rev1, rev2 = rev2) + '\n')
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 7acd70c..ea82ea5 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -46,7 +46,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         unapplied = crt_series.get_unapplied()
         applied = crt_series.get_applied()
@@ -85,7 +85,7 @@ class concreteCommand(Command):
         # check whether the operation is really needed
         if topop != topush:
             if topop:
-                pop_patches(topop)
+                self.pop_patches(topop)
             if topush:
                 topush.reverse()
-                push_patches(topush)
+                self.push_patches(topush)
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 73612fc..6d75df5 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -49,7 +49,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         if len(self.args) == 1:
             filename = self.args[0]
@@ -73,7 +73,7 @@ class concreteCommand(Command):
             bottom = crt_patch.get_bottom()
             git.apply_patch(filename = filename, base = bottom)
         elif self.flags.base:
-            git.apply_patch(filename = filename, base = git_id(self.flags.base))
+            git.apply_patch(filename = filename, base = self.git_id(self.flags.base))
         else:
             git.apply_patch(filename = filename)
 
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 0ca6bc3..ceec9ea 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -43,7 +43,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         applied = crt_series.get_applied()
         unapplied = crt_series.get_unapplied()
@@ -52,11 +52,11 @@ class concreteCommand(Command):
         if patch in applied:
             applied.reverse()
             patches = applied[:applied.index(patch)]
-            pop_patches(patches)
+            self.pop_patches(patches)
         elif patch in unapplied:
             patches = unapplied[:unapplied.index(patch)+1]
-            push_patches(patches)
+            self.push_patches(patches)
         else:
             raise CmdException, 'Patch "%s" does not exist' % patch
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 50ddc42..64f5132 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -47,4 +47,4 @@ class concreteCommand(Command):
         else:
             self.parser.error('incorrect number of arguments')
 
-        out.stdout(git_id(id_str))
+        out.stdout(self.git_id(id_str))
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 5c2a95f..2401c4a 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -292,7 +292,7 @@ class concreteCommand(Command):
 
         out.start('Importing patch "%s"' % patch)
         if self.flags.base:
-            git.apply_patch(diff = diff, base = git_id(self.flags.base))
+            git.apply_patch(diff = diff, base = self.git_id(self.flags.base))
         else:
             git.apply_patch(diff = diff)
         crt_series.refresh_patch(edit = self.flags.edit,
@@ -396,7 +396,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         if len(self.args) == 1:
             filename = self.args[0]
@@ -412,4 +412,4 @@ class concreteCommand(Command):
         else:
             self.__import_file(filename)
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b8bf1d2..cdc0e2a 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -405,11 +405,11 @@ class concreteCommand(Command):
                      'longdescr':    long_descr,
                      # for backward template compatibility
                      'endofheaders': '',
-                     'diff':         git.diff(rev1 = git_id('%s//bottom' % patch),
-                                              rev2 = git_id('%s//top' % patch),
+                     'diff':         git.diff(rev1 = self.git_id('%s//bottom' % patch),
+                                              rev2 = self.git_id('%s//top' % patch),
                                               diff_flags = diff_flags ),
-                     'diffstat':     git.diffstat(rev1 = git_id('%s//bottom'%patch),
-                                                  rev2 = git_id('%s//top' % patch)),
+                     'diffstat':     git.diffstat(rev1 = self.git_id('%s//bottom'%patch),
+                                                  rev2 = self.git_id('%s//top' % patch)),
                      # for backward template compatibility
                      'date':         '',
                      'version':      version_str,
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 2b7bd3d..87f3874 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -69,7 +69,7 @@ class concreteCommand(Command):
             self.parser.error('incorrect number of arguments')
 
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         if self.flags.author:
             self.flags.authname, self.flags.authemail = name_email(self.flags.author)
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 1ff9d05..6ec8be3 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -61,10 +61,10 @@ class concreteCommand(Command):
         if not self.flags.unapplied:
             check_local_changes()
             check_conflicts()
-            check_head_top_equal()
+            self.check_head_top_equal()
 
         commit_str = self.args[0]
-        commit_id = git_id(commit_str)
+        commit_id = self.git_id(commit_str)
         commit = git.Commit(commit_id)
 
         if self.flags.fold or self.flags.update:
@@ -80,7 +80,7 @@ class concreteCommand(Command):
                 patchname = None
 
         if self.flags.parent:
-            parent = git_id(self.flags.parent)
+            parent = self.git_id(self.flags.parent)
         else:
             parent = commit.get_parent()
 
@@ -100,8 +100,8 @@ class concreteCommand(Command):
 
             out.done()
         elif self.flags.update:
-            rev1 = git_id('//bottom')
-            rev2 = git_id('//top')
+            rev1 = self.git_id('//bottom')
+            rev2 = self.git_id('//top')
             files = git.barefiles(rev1, rev2).split('\n')
 
             out.start('Updating with commit %s' % commit_id)
@@ -157,4 +157,4 @@ class concreteCommand(Command):
             else:
                 out.done()
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index cd5c46d..3b8b536 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -51,7 +51,7 @@ class concreteCommand(Command):
         """Pop the topmost patch from the stack
         """
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         if not self.flags.keep:
             check_local_changes()
@@ -83,8 +83,8 @@ class concreteCommand(Command):
             raise CmdException, 'Cannot pop arbitrary patches with --keep'
 
         topop.reverse()
-        pop_patches(topop, self.flags.keep)
+        self.pop_patches(topop, self.flags.keep)
         if topush:
-            push_patches(topush)
+            self.push_patches(topush)
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 3fdbc74..06d9aa9 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -76,7 +76,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         if policy == 'pull':
             must_rebase = 0
@@ -87,7 +87,7 @@ class concreteCommand(Command):
         else:
             raise GitConfigException, 'Unsupported pull-policy "%s"' % policy
 
-        applied = prepare_rebase(force=self.flags.force)
+        applied = self.prepare_rebase(force=self.flags.force)
 
         # pull the remote changes
         if policy == 'pull':
@@ -96,14 +96,14 @@ class concreteCommand(Command):
         elif policy == 'fetch-rebase':
             out.info('Fetching from "%s"' % repository)
             git.fetch(repository)
-            rebase(git.fetch_head())
+            self.rebase(git.fetch_head())
         elif policy == 'rebase':
-            rebase(crt_series.get_parent_branch())
+            self.rebase(crt_series.get_parent_branch())
 
-        post_rebase(applied, self.flags.nopush, self.flags.merged)
+        self.post_rebase(applied, self.flags.nopush, self.flags.merged)
 
         # maybe tidy up
         if config.get('stgit.keepoptimized') == 'yes':
             git.repack()
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 14e8e41..0d41cad 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -71,13 +71,13 @@ class concreteCommand(Command):
                 out.done()
             else:
                 out.done('patch unchanged')
-            print_crt_patch()
+            self.print_crt_patch()
 
             return
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         unapplied = crt_series.get_unapplied()
         if not unapplied:
@@ -98,6 +98,6 @@ class concreteCommand(Command):
         if self.flags.reverse:
             patches.reverse()
 
-        push_patches(patches, self.flags.merged)
+        self.push_patches(patches, self.flags.merged)
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 111d78e..f953d6b 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -51,14 +51,14 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         # ensure an exception is raised before popping on non-existent target
-        if git_id(self.args[0]) == None:
-            raise GitException, 'Unknown revision: %s' % git_id(self.args[0])
+        if self.git_id(self.args[0]) == None:
+            raise GitException, 'Unknown revision: %s' % self.git_id(self.args[0])
 
-        applied = prepare_rebase(force=self.flags.force)
-        rebase(self.args[0])
-        post_rebase(applied, self.flags.nopush, self.flags.merged)
+        applied = self.prepare_rebase(force=self.flags.force)
+        self.rebase(self.args[0])
+        self.post_rebase(applied, self.flags.nopush, self.flags.merged)
 
-        print_crt_patch()
+        self.print_crt_patch()
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index e6a6953..90eb26b 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -96,7 +96,7 @@ class concreteCommand(Command):
                 raise CmdException, 'No patches applied'
 
         if not self.flags.force:
-            check_head_top_equal()
+            self.check_head_top_equal()
 
         if self.flags.undo:
             out.start('Undoing the refresh of "%s"' % patch)
@@ -126,7 +126,7 @@ class concreteCommand(Command):
             if self.flags.patch:
                 applied = crt_series.get_applied()
                 between = applied[:applied.index(patch):-1]
-                pop_patches(between, keep = True)
+                self.pop_patches(between, keep = True)
 
             out.start('Refreshing patch "%s"' % patch)
 
@@ -150,6 +150,6 @@ class concreteCommand(Command):
 
             if self.flags.patch:
                 between.reverse()
-                push_patches(between)
+                self.push_patches(between)
         else:
             out.info('Patch "%s" is already up to date' % patch)
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index ebb1ce4..2afa013 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -191,12 +191,12 @@ class concreteCommand(Command):
                 raise CmdException, '--graphical not supported with --missing'
 
             if applied:
-                gitk_args = ' %s^..%s' % (git_id(applied[0]), git_id(applied[-1]))
+                gitk_args = ' %s^..%s' % (self.git_id(applied[0]), self.git_id(applied[-1]))
             else:
                 gitk_args = ''
 
             for p in unapplied:
-                patch_id = git_id(p)
+                patch_id = self.git_id(p)
                 gitk_args += ' %s^..%s' % (patch_id, patch_id)
 
             if os.system('gitk%s' % gitk_args) != 0:
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index c207e45..5ff772f 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -66,7 +66,7 @@ class concreteCommand(Command):
         else:
             diff_flags = []
 
-        commit_ids = [git_id(patch) for patch in patches]
+        commit_ids = [self.git_id(patch) for patch in patches]
         commit_str = '\n'.join([git.pretty_commit(commit_id, diff_flags=diff_flags)
                                 for commit_id in commit_ids])
         if commit_str:
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 5ec0f1d..c3ef4d5 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -45,7 +45,7 @@ class concreteCommand(Command):
 
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
         oldapplied = crt_series.get_applied()
         unapplied = crt_series.get_unapplied()
@@ -57,10 +57,10 @@ class concreteCommand(Command):
             patches = [ crt_series.get_current() ]
 
         crt_series.pop_patch(self.flags.to or oldapplied[0])
-        push_patches(patches)
+        self.push_patches(patches)
 
         if not self.flags.nopush:
             newapplied = crt_series.get_applied()
             def not_reapplied_yet(p):
                 return not p in newapplied
-            push_patches(filter(not_reapplied_yet, oldapplied))
+            self.push_patches(filter(not_reapplied_yet, oldapplied))
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 513e7bb..9c95b99 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -62,7 +62,7 @@ class concreteCommand(Command):
     def __check_all(self):
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        self.check_head_top_equal()
 
     def func(self):
         """Synchronise a range of patches
@@ -135,13 +135,13 @@ class concreteCommand(Command):
         # pop to the one before the first patch to be synchronised
         popped = applied[applied.index(sync_patches[0]) + 1:]
         if popped:
-            pop_patches(popped[::-1])
+            self.pop_patches(popped[::-1])
 
         for p in sync_patches:
             if p in popped:
                 # push to this patch
                 idx = popped.index(p) + 1
-                push_patches(popped[:idx])
+                self.push_patches(popped[:idx])
                 del popped[:idx]
 
             # the actual sync
@@ -170,4 +170,4 @@ class concreteCommand(Command):
 
         # push the remaining patches
         if popped:
-            push_patches(popped)
+            self.push_patches(popped)
