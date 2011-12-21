From: Sebastian Morr <sebastian@morr.cc>
Subject: [PATCH] Use Python's "print" as a function, not as a keyword
Date: Wed, 21 Dec 2011 03:19:31 +0100
Message-ID: <20111221021930.GA31364@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:19:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdAqP-0001oT-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab1LUBTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 20:19:41 -0500
Received: from static.148.34.47.78.clients.your-server.de ([78.47.34.148]:50060
	"EHLO morr.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab1LUBTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:19:39 -0500
Received: by morr.cc (Postfix, from userid 1001)
	id B1273476405A; Wed, 21 Dec 2011 02:19:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on morr.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.1
Received: from thinkpad (port-92-196-68-8.dynamic.qsc.de [92.196.68.8])
	by morr.cc (Postfix) with ESMTPSA id 61C9F4764058;
	Wed, 21 Dec 2011 02:19:32 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187545>

This has changed from Version 2.6 to Version 3.0. Replace all occurrences of

    print ...

with

    print(...)

and all occurrences of

    print >> output, ...

with

    output.write(... + "\n")
---

I noticed that "make" on master spawned an "invalid syntax" error (it
was caused by the "print ..." in git_remote_helpers/Makefile) and looked
into how to fix that. I have Python 3.2.2 installed.

I'm afraid this way it breaks for Python 2.6. It seems to be possible to do

    from __future__ import print_function

which we could install in all Python scripts.

But, as nobody seems to have cared before: Is Git designed to be
compatible only with versions prior 3.0?

 contrib/ciabot/ciabot.py           |    6 +-
 contrib/fast-import/git-p4         |  140 ++++++++++++++++++------------------
 contrib/fast-import/import-zips.py |    2 +-
 contrib/gitview/gitview            |    2 +-
 contrib/hg-to-git/hg-to-git.py     |   46 ++++++------
 contrib/p4import/git-p4import.py   |    6 +-
 git-remote-testgit.py              |   26 ++++----
 git_remote_helpers/Makefile        |    2 +-
 git_remote_helpers/git/exporter.py |    6 +-
 git_remote_helpers/git/git.py      |    2 +-
 git_remote_helpers/util.py         |   12 ++--
 11 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index 9775dff..10c5d22 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -173,7 +173,7 @@ if __name__ == "__main__":
     try:
         (options, arguments) = getopt.getopt(sys.argv[1:], "np:V")
     except getopt.GetoptError, msg:
-        print "ciabot.py: " + str(msg)
+        print("ciabot.py: " + str(msg))
         raise SystemExit, 1
 
     mailit = True
@@ -183,7 +183,7 @@ if __name__ == "__main__":
         elif switch == '-n':
             mailit = False
         elif switch == '-V':
-            print "ciabot.py: version 3.2"
+            print("ciabot.py: version 3.2")
             sys.exit(0)
 
     # Cough and die if user has not specified a project
@@ -214,7 +214,7 @@ if __name__ == "__main__":
         if mailit:
             server.sendmail(fromaddr, [toaddr], message)
         else:
-            print message
+            print(message)
 
     if mailit:
         server.quit()
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 5949803..bb72f71 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -495,7 +495,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         update = False
         if not gitBranchExists(remoteHead):
             if verbose:
-                print "creating %s" % remoteHead
+                print("creating %s" % remoteHead)
             update = True
         else:
             settings = extractSettingsGitLog(extractLogMessageFromGitCommit(remoteHead))
@@ -610,9 +610,9 @@ class P4Debug(Command):
     def run(self, args):
         j = 0
         for output in p4CmdList(args):
-            print 'Element: %d' % j
+            print('Element: %d' % j)
             j += 1
-            print output
+            print(output)
         return True
 
 class P4RollBack(Command):
@@ -655,14 +655,14 @@ class P4RollBack(Command):
 
                 if len(p4Cmd("changes -m 1 "  + ' '.join (['%s...@%s' % (p, maxChange)
                                                            for p in depotPaths]))) == 0:
-                    print "Branch %s did not exist at change %s, deleting." % (ref, maxChange)
+                    print("Branch %s did not exist at change %s, deleting." % (ref, maxChange))
                     system("git update-ref -d %s `git rev-parse %s`" % (ref, ref))
                     continue
 
                 while change and int(change) > maxChange:
                     changed = True
                     if self.verbose:
-                        print "%s is at %s ; rewinding towards %s" % (ref, change, maxChange)
+                        print("%s is at %s ; rewinding towards %s" % (ref, change, maxChange))
                     system("git update-ref %s \"%s^\"" % (ref, ref))
                     log = extractLogMessageFromGitCommit(ref)
                     settings =  extractSettingsGitLog(log)
@@ -672,7 +672,7 @@ class P4RollBack(Command):
                     change = settings['change']
 
                 if changed:
-                    print "%s rewound to %s" % (ref, change)
+                    print("%s rewound to %s" % (ref, change))
 
         return True
 
@@ -746,7 +746,7 @@ class P4Submit(Command, P4UserMap):
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
                 if gitConfig('git-p4.allowMissingP4Users').lower() == "true":
-                    print "%s" % msg
+                    print("%s" % msg)
                 else:
                     die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
 
@@ -884,7 +884,7 @@ class P4Submit(Command, P4UserMap):
                 return False
 
     def applyCommit(self, id):
-        print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
+        print("Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id)))
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
@@ -961,14 +961,14 @@ class P4Submit(Command, P4UserMap):
         applyPatchCmd = patchcmd + "--check --apply -"
 
         if os.system(tryPatchCmd) != 0:
-            print "Unfortunately applying the change failed!"
-            print "What do you want to do?"
+            print("Unfortunately applying the change failed!")
+            print("What do you want to do?")
             response = "x"
             while response != "s" and response != "a" and response != "w":
                 response = raw_input("[s]kip this patch / [a]pply the patch forcibly "
                                      "and with .rej files / [w]rite the patch to a file (patch.txt) ")
             if response == "s":
-                print "Skipping! Good luck with the next patches..."
+                print("Skipping! Good luck with the next patches...")
                 for f in editedFiles:
                     p4_revert(f)
                 for f in filesToAdd:
@@ -977,16 +977,16 @@ class P4Submit(Command, P4UserMap):
             elif response == "a":
                 os.system(applyPatchCmd)
                 if len(filesToAdd) > 0:
-                    print "You may also want to call p4 add on the following files:"
-                    print " ".join(filesToAdd)
+                    print("You may also want to call p4 add on the following files:")
+                    print(" ".join(filesToAdd))
                 if len(filesToDelete):
-                    print "The following files should be scheduled for deletion with p4 delete:"
-                    print " ".join(filesToDelete)
+                    print("The following files should be scheduled for deletion with p4 delete:")
+                    print(" ".join(filesToDelete))
                 die("Please resolve and submit the conflict manually and "
                     + "continue afterwards with git-p4 submit --continue")
             elif response == "w":
                 system(diffcmd + " > patch.txt")
-                print "Patch saved to patch.txt in %s !" % self.clientPath
+                print("Patch saved to patch.txt in %s !" % self.clientPath)
                 die("Please resolve and submit the conflict manually and "
                     "continue afterwards with git-p4 submit --continue")
 
@@ -1065,7 +1065,7 @@ class P4Submit(Command, P4UserMap):
                         self.modifyChangelistUser(changelist, p4User)
             else:
                 # skip this patch
-                print "Submission cancelled, undoing p4 changes."
+                print("Submission cancelled, undoing p4 changes.")
                 for f in editedFiles:
                     p4_revert(f)
                 for f in filesToAdd:
@@ -1106,19 +1106,19 @@ class P4Submit(Command, P4UserMap):
                 die("Cannot preserve user names without p4 super-user or admin permissions")
 
         if self.verbose:
-            print "Origin branch is " + self.origin
+            print("Origin branch is " + self.origin)
 
         if len(self.depotPath) == 0:
-            print "Internal error: cannot locate perforce depot path from existing branches"
+            print("Internal error: cannot locate perforce depot path from existing branches")
             sys.exit(128)
 
         self.clientPath = p4Where(self.depotPath)
 
         if len(self.clientPath) == 0:
-            print "Error: Cannot locate perforce checkout of %s in client view" % self.depotPath
+            print("Error: Cannot locate perforce checkout of %s in client view" % self.depotPath)
             sys.exit(128)
 
-        print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
+        print("Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath))
         self.oldWorkingDirectory = os.getcwd()
 
         # ensure the clientPath exists
@@ -1126,7 +1126,7 @@ class P4Submit(Command, P4UserMap):
             os.makedirs(self.clientPath)
 
         chdir(self.clientPath)
-        print "Synchronizing p4 checkout..."
+        print("Synchronizing p4 checkout...")
         p4_sync("...")
         self.check()
 
@@ -1151,7 +1151,7 @@ class P4Submit(Command, P4UserMap):
                 break
 
         if len(commits) == 0:
-            print "All changes applied!"
+            print("All changes applied!")
             chdir(self.oldWorkingDirectory)
 
             sync = P4Sync()
@@ -1354,7 +1354,7 @@ class P4Sync(Command, P4UserMap):
             # Ideally, someday, this script can learn how to generate
             # appledouble files directly and import those to git, but
             # non-mac machines can never find a use for apple filetype.
-            print "\nIgnoring apple filetype file %s" % file['depotFile']
+            print("\nIgnoring apple filetype file %s" % file['depotFile'])
             return
 
         # Perhaps windows wants unicode, utf16 newlines translated too;
@@ -1466,7 +1466,7 @@ class P4Sync(Command, P4UserMap):
         self.branchPrefixes = branchPrefixes
 
         if self.verbose:
-            print "commit into %s" % branch
+            print("commit into %s" % branch)
 
         # start with reading files; if that fails, we should not
         # create a commit.
@@ -1500,7 +1500,7 @@ class P4Sync(Command, P4UserMap):
 
         if len(parent) > 0:
             if self.verbose:
-                print "parent %s" % parent
+                print("parent %s" % parent)
             self.gitStream.write("from %s\n" % parent)
 
         self.streamP4Files(new_files)
@@ -1513,7 +1513,7 @@ class P4Sync(Command, P4UserMap):
             labelDetails = label[0]
             labelRevisions = label[1]
             if self.verbose:
-                print "Change %s is labelled %s" % (change, labelDetails)
+                print("Change %s is labelled %s" % (change, labelDetails))
 
             files = p4CmdList(["files"] + ["%s...@%s" % (p, change)
                                                     for p in branchPrefixes])
@@ -1556,14 +1556,14 @@ class P4Sync(Command, P4UserMap):
 
         l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
         if len(l) > 0 and not self.silent:
-            print "Finding files belonging to labels in %s" % `self.depotPaths`
+            print("Finding files belonging to labels in %s" % `self.depotPaths`)
 
         for output in l:
             label = output["label"]
             revisions = {}
             newestChange = 0
             if self.verbose:
-                print "Querying files for label %s" % label
+                print("Querying files for label %s" % label)
             for file in p4CmdList(["files"] +
                                       ["%s...@%s" % (p, label)
                                           for p in self.depotPaths]):
@@ -1575,7 +1575,7 @@ class P4Sync(Command, P4UserMap):
             self.labels[newestChange] = [output, revisions]
 
         if self.verbose:
-            print "Label changes: %s" % self.labels.keys()
+            print("Label changes: %s" % self.labels.keys())
 
     def guessProjectName(self):
         for p in self.depotPaths:
@@ -1613,8 +1613,8 @@ class P4Sync(Command, P4UserMap):
 
                     if destination in self.knownBranches:
                         if not self.silent:
-                            print "p4 branch %s defines a mapping from %s to %s" % (info["branch"], source, destination)
-                            print "but there exists another mapping from %s to %s already!" % (self.knownBranches[destination], destination)
+                            print("p4 branch %s defines a mapping from %s to %s" % (info["branch"], source, destination))
+                            print("but there exists another mapping from %s to %s already!" % (self.knownBranches[destination], destination))
                         continue
 
                     self.knownBranches[destination] = source
@@ -1685,28 +1685,28 @@ class P4Sync(Command, P4UserMap):
 
     def gitCommitByP4Change(self, ref, change):
         if self.verbose:
-            print "looking in ref " + ref + " for change %s using bisect..." % change
+            print("looking in ref " + ref + " for change %s using bisect..." % change)
 
         earliestCommit = ""
         latestCommit = parseRevision(ref)
 
         while True:
             if self.verbose:
-                print "trying: earliest %s latest %s" % (earliestCommit, latestCommit)
+                print("trying: earliest %s latest %s" % (earliestCommit, latestCommit))
             next = read_pipe("git rev-list --bisect %s %s" % (latestCommit, earliestCommit)).strip()
             if len(next) == 0:
                 if self.verbose:
-                    print "argh"
+                    print("argh")
                 return ""
             log = extractLogMessageFromGitCommit(next)
             settings = extractSettingsGitLog(log)
             currentChange = int(settings['change'])
             if self.verbose:
-                print "current change %s" % currentChange
+                print("current change %s" % currentChange)
 
             if currentChange == change:
                 if self.verbose:
-                    print "found %s" % next
+                    print("found %s" % next)
                 return next
 
             if currentChange < change:
@@ -1767,7 +1767,7 @@ class P4Sync(Command, P4UserMap):
                         filesForCommit = branches[branch]
 
                         if self.verbose:
-                            print "branch is %s" % branch
+                            print("branch is %s" % branch)
 
                         self.updatedBranches.add(branch)
 
@@ -1788,13 +1788,13 @@ class P4Sync(Command, P4UserMap):
                                         print("\n    Resuming with change %s" % change);
 
                                 if self.verbose:
-                                    print "parent determined through known branches: %s" % parent
+                                    print("parent determined through known branches: %s" % parent)
 
                         branch = self.gitRefForBranch(branch)
                         parent = self.gitRefForBranch(parent)
 
                         if self.verbose:
-                            print "looking for initial parent for %s; current parent is %s" % (branch, parent)
+                            print("looking for initial parent for %s; current parent is %s" % (branch, parent))
 
                         if len(parent) == 0 and branch in self.initialParents:
                             parent = self.initialParents[branch]
@@ -1807,11 +1807,11 @@ class P4Sync(Command, P4UserMap):
                                 self.initialParent)
                     self.initialParent = ""
             except IOError:
-                print self.gitError.read()
+                print(self.gitError.read())
                 sys.exit(1)
 
     def importHeadRevision(self, revision):
-        print "Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
+        print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
 
         details = {}
         details["user"] = "git perforce import user"
@@ -1869,8 +1869,8 @@ class P4Sync(Command, P4UserMap):
         try:
             self.commit(details, self.extractFilesFromCommit(details), self.branch, self.depotPaths)
         except IOError:
-            print "IO error with git fast-import. Is your git version recent enough?"
-            print self.gitError.read()
+            print("IO error with git fast-import. Is your git version recent enough?")
+            print(self.gitError.read())
 
 
     def getClientSpec(self):
@@ -1883,7 +1883,7 @@ class P4Sync(Command, P4UserMap):
                     # p4 has these %%1 to %%9 arguments in specs to
                     # reorder paths; which we can't handle (yet :)
                     if re.match('%%\d', v) != None:
-                        print "Sorry, can't handle %%n arguments in client specs"
+                        print("Sorry, can't handle %%n arguments in client specs")
                         sys.exit(1)
 
                     if v.startswith('"'):
@@ -1901,7 +1901,7 @@ class P4Sync(Command, P4UserMap):
                     # ... wildcard, then we're going to mess up the
                     # output directory, so fail gracefully.
                     if not cv.endswith('...'):
-                        print 'Sorry, client view in "%s" needs to end with wildcard' % (k)
+                        print('Sorry, client view in "%s" needs to end with wildcard' % (k))
                         sys.exit(1)
                     cv=cv[:-3]
 
@@ -1939,7 +1939,7 @@ class P4Sync(Command, P4UserMap):
 
         if self.syncWithOrigin and self.hasOrigin:
             if not self.silent:
-                print "Syncing with origin first by calling git fetch origin"
+                print("Syncing with origin first by calling git fetch origin")
             system("git fetch origin")
 
         if len(self.branch) == 0:
@@ -1963,11 +1963,11 @@ class P4Sync(Command, P4UserMap):
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
-                    print "Importing from/into multiple branches"
+                    print("Importing from/into multiple branches")
                 self.detectBranches = True
 
             if self.verbose:
-                print "branches: %s" % self.p4BranchesInGit
+                print("branches: %s" % self.p4BranchesInGit)
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
@@ -2004,14 +2004,14 @@ class P4Sync(Command, P4UserMap):
                 if not self.detectBranches:
                     self.initialParent = parseRevision(self.branch)
                 if not self.silent and not self.detectBranches:
-                    print "Performing incremental import into %s git branch" % self.branch
+                    print("Performing incremental import into %s git branch" % self.branch)
 
         if not self.branch.startswith("refs/"):
             self.branch = "refs/heads/" + self.branch
 
         if len(args) == 0 and self.depotPaths:
             if not self.silent:
-                print "Depot paths: %s" % ' '.join(self.depotPaths)
+                print("Depot paths: %s" % ' '.join(self.depotPaths))
         else:
             if self.depotPaths and self.depotPaths != args:
                 print ("previous import used depot path %s and now %s was specified. "
@@ -2065,8 +2065,8 @@ class P4Sync(Command, P4UserMap):
             else:
                 self.getBranchMapping()
             if self.verbose:
-                print "p4-git branches: %s" % self.p4BranchesInGit
-                print "initial parents: %s" % self.initialParents
+                print("p4-git branches: %s" % self.p4BranchesInGit)
+                print("initial parents: %s" % self.initialParents)
             for b in self.p4BranchesInGit:
                 if b != "master":
 
@@ -2104,8 +2104,8 @@ class P4Sync(Command, P4UserMap):
                 if len(args) == 0 and not self.p4BranchesInGit:
                     die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
                 if self.verbose:
-                    print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
-                                                              self.changeRange)
+                    print("Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
+                                                              self.changeRange))
                 changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
 
                 if len(self.maxChanges) > 0:
@@ -2113,18 +2113,18 @@ class P4Sync(Command, P4UserMap):
 
             if len(changes) == 0:
                 if not self.silent:
-                    print "No changes to import!"
+                    print("No changes to import!")
                 return True
 
             if not self.silent and not self.detectBranches:
-                print "Import destination: %s" % self.branch
+                print("Import destination: %s" % self.branch)
 
             self.updatedBranches = set()
 
             self.importChanges(changes)
 
             if not self.silent:
-                print ""
+                print("")
                 if len(self.updatedBranches) > 0:
                     sys.stdout.write("Updated branches: ")
                     for b in self.updatedBranches:
@@ -2166,7 +2166,7 @@ class P4Rebase(Command):
         # the branchpoint may be p4/foo~3, so strip off the parent
         upstream = re.sub("~[0-9]+$", "", upstream)
 
-        print "Rebasing the current branch onto %s" % upstream
+        print("Rebasing the current branch onto %s" % upstream)
         oldHead = read_pipe("git rev-parse HEAD").strip()
         system("git rebase %s" % upstream)
         system("git diff-tree --stat --summary -M %s HEAD" % oldHead)
@@ -2228,7 +2228,7 @@ class P4Clone(P4Sync):
         if not self.cloneDestination:
             self.cloneDestination = self.defaultDestination(args)
 
-        print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
+        print("Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination))
 
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
@@ -2251,7 +2251,7 @@ class P4Clone(P4Sync):
                 if not self.cloneBare:
                     system("git checkout -f")
             else:
-                print "Could not detect main branch. No checkout/master branch created."
+                print("Could not detect main branch. No checkout/master branch created.")
 
         return True
 
@@ -2280,7 +2280,7 @@ class P4Branches(Command):
             log = extractLogMessageFromGitCommit("refs/remotes/%s" % branch)
             settings = extractSettingsGitLog(log)
 
-            print "%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"])
+            print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
 class HelpFormatter(optparse.IndentedHelpFormatter):
@@ -2294,12 +2294,12 @@ class HelpFormatter(optparse.IndentedHelpFormatter):
             return ""
 
 def printUsage(commands):
-    print "usage: %s <command> [options]" % sys.argv[0]
-    print ""
-    print "valid commands: %s" % ", ".join(commands)
-    print ""
-    print "Try %s <command> --help for command specific help." % sys.argv[0]
-    print ""
+    print("usage: %s <command> [options]" % sys.argv[0])
+    print("")
+    print("valid commands: %s" % ", ".join(commands))
+    print("")
+    print("Try %s <command> --help for command specific help." % sys.argv[0])
+    print("")
 
 commands = {
     "debug" : P4Debug,
@@ -2324,8 +2324,8 @@ def main():
         klass = commands[cmdName]
         cmd = klass()
     except KeyError:
-        print "unknown command %s" % cmdName
-        print ""
+        print("unknown command %s" % cmdName)
+        print("")
         printUsage(commands.keys())
         sys.exit(2)
 
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index 82f5ed3..596963b 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -14,7 +14,7 @@ from time import mktime
 from zipfile import ZipFile
 
 if len(argv) < 2:
-	print 'Usage:', argv[0], '<zipfile>...'
+	print('Usage:', argv[0], '<zipfile>...')
 	exit(1)
 
 branch_ref = 'refs/heads/import-zips'
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 4c99dfb..c3e74f3 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -37,7 +37,7 @@ except ImportError:
         import gtksourceview
         have_gtksourceview = True
     except ImportError:
-        print "Running without gtksourceview2 or gtksourceview module"
+        print("Running without gtksourceview2 or gtksourceview module")
 
 re_ident = re.compile('(author|committer) (?P<ident>.*) (?P<epoch>\d+) (?P<tz>[+-]\d{4})')
 
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 046cb2b..3c55a6d 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -38,7 +38,7 @@ hgnewcsets = 0
 
 def usage():
 
-        print """\
+        print("""\
 %s: [OPTIONS] <hgprj>
 
 options:
@@ -50,7 +50,7 @@ options:
 
 required:
     hgprj:  name of the HG project to import (directory)
-""" % sys.argv[0]
+""" % sys.argv[0])
 
 #------------------------------------------------------------------------------
 
@@ -100,22 +100,22 @@ os.chdir(hgprj)
 if state:
     if os.path.exists(state):
         if verbose:
-            print 'State does exist, reading'
+            print('State does exist, reading')
         f = open(state, 'r')
         hgvers = pickle.load(f)
     else:
-        print 'State does not exist, first run'
+        print('State does not exist, first run')
 
 sock = os.popen('hg tip --template "{rev}"')
 tip = sock.read()
 if sock.close():
     sys.exit(1)
 if verbose:
-    print 'tip is', tip
+    print('tip is', tip)
 
 # Calculate the branches
 if verbose:
-    print 'analysing the branches...'
+    print('analysing the branches...')
 hgchildren["0"] = ()
 hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
@@ -151,7 +151,7 @@ for cset in range(1, int(tip) + 1):
             hgbranch[str(cset)] = "branch-" + str(cset)
 
 if not hgvers.has_key("0"):
-    print 'creating repository'
+    print('creating repository')
     os.system('git init')
 
 # loop through every hg changeset
@@ -176,27 +176,27 @@ for cset in range(int(tip) + 1):
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
-    print '-----------------------------------------'
-    print 'cset:', cset
-    print 'branch:', hgbranch[str(cset)]
-    print 'user:', user
-    print 'date:', date
-    print 'comment:', csetcomment
+    print('-----------------------------------------')
+    print('cset:', cset)
+    print('branch:', hgbranch[str(cset)])
+    print('user:', user)
+    print('date:', date)
+    print('comment:', csetcomment)
     if parent:
-	print 'parent:', parent
+	print('parent:', parent)
     if mparent:
-        print 'mparent:', mparent
+        print('mparent:', mparent)
     if tag:
-        print 'tag:', tag
-    print '-----------------------------------------'
+        print('tag:', tag)
+    print('-----------------------------------------')
 
     # checkout the parent if necessary
     if cset != 0:
         if hgbranch[str(cset)] == "branch-" + str(cset):
-            print 'creating new branch', hgbranch[str(cset)]
+            print('creating new branch', hgbranch[str(cset)])
             os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
         else:
-            print 'checking out branch', hgbranch[str(cset)]
+            print('checking out branch', hgbranch[str(cset)])
             os.system('git checkout %s' % hgbranch[str(cset)])
 
     # merge
@@ -205,7 +205,7 @@ for cset in range(int(tip) + 1):
             otherbranch = hgbranch[mparent]
         else:
             otherbranch = hgbranch[parent]
-        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
+        print('merging', otherbranch, 'into', hgbranch[str(cset)])
         os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
 
     # remove everything except .git and .hg directories
@@ -229,12 +229,12 @@ for cset in range(int(tip) + 1):
 
     # delete branch if not used anymore...
     if mparent and len(hgchildren[str(cset)]):
-        print "Deleting unused branch:", otherbranch
+        print("Deleting unused branch:", otherbranch)
         os.system('git branch -d %s' % otherbranch)
 
     # retrieve and record the version
     vvv = os.popen('git show --quiet --pretty=format:%H').read()
-    print 'record', cset, '->', vvv
+    print('record', cset, '->', vvv)
     hgvers[str(cset)] = vvv
 
 if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
@@ -243,7 +243,7 @@ if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
 # write the state for incrementals
 if state:
     if verbose:
-        print 'Writing state'
+        print('Writing state')
     f = open(state, 'w')
     pickle.dump(hgvers, f)
 
diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-p4import.py
index b6e534b..144fafc 100644
--- a/contrib/p4import/git-p4import.py
+++ b/contrib/p4import/git-p4import.py
@@ -26,11 +26,11 @@ if s != default_int_handler:
 def die(msg, *args):
     for a in args:
         msg = "%s %s" % (msg, a)
-    print "git-p4import fatal error:", msg
+    print("git-p4import fatal error:", msg)
     sys.exit(1)
 
 def usage():
-    print "USAGE: git-p4import [-q|-v]  [--authors=<file>]  [-t <timezone>]  [//p4repo/path <branch>]"
+    print("USAGE: git-p4import [-q|-v]  [--authors=<file>]  [-t <timezone>]  [//p4repo/path <branch>]")
     sys.exit(1)
 
 verbosity = 1
@@ -48,7 +48,7 @@ def report(level, msg, *args):
     fd.writelines(msg)
     fd.close()
     if level <= verbosity:
-        print msg
+        print(msg)
 
 class p4_command:
     def __init__(self, _repopath):
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 3dc4851..9803214 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -81,9 +81,9 @@ def do_capabilities(repo, args):
     """Prints the supported capabilities.
     """
 
-    print "import"
-    print "export"
-    print "refspec refs/heads/*:%s*" % repo.prefix
+    print("import")
+    print("export")
+    print("refspec refs/heads/*:%s*" % repo.prefix)
 
     dirname = repo.get_base_path(repo.gitdir)
 
@@ -92,11 +92,11 @@ def do_capabilities(repo, args):
 
     path = os.path.join(dirname, 'testgit.marks')
 
-    print "*export-marks %s" % path
+    print("*export-marks %s" % path)
     if os.path.exists(path):
-        print "*import-marks %s" % path
+        print("*import-marks %s" % path)
 
-    print # end capabilities
+    print() # end capabilities
 
 
 def do_list(repo, args):
@@ -109,16 +109,16 @@ def do_list(repo, args):
 
     for ref in repo.revs:
         debug("? refs/heads/%s", ref)
-        print "? refs/heads/%s" % ref
+        print("? refs/heads/%s" % ref)
 
     if repo.head:
         debug("@refs/heads/%s HEAD" % repo.head)
-        print "@refs/heads/%s HEAD" % repo.head
+        print("@refs/heads/%s HEAD" % repo.head)
     else:
         debug("@refs/heads/master HEAD")
-        print "@refs/heads/master HEAD"
+        print("@refs/heads/master HEAD")
 
-    print # end list
+    print() # end list
 
 
 def update_local_repo(repo):
@@ -161,7 +161,7 @@ def do_import(repo, args):
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, refs)
 
-    print "done"
+    print("done")
 
 
 def do_export(repo, args):
@@ -178,8 +178,8 @@ def do_export(repo, args):
         repo.non_local.push(repo.gitdir)
 
     for ref in changed:
-        print "ok %s" % ref
-    print
+        print("ok %s" % ref)
+    print()
 
 
 COMMANDS = {
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index 74b05dc..f65f064 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -23,7 +23,7 @@ endif
 
 PYLIBDIR=$(shell $(PYTHON_PATH) -c \
 	 "import sys; \
-	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
+	 print('lib/python%i.%i/site-packages' % sys.version_info[:2])")
 
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
index 9ee5f96..e6ad51e 100644
--- a/git_remote_helpers/git/exporter.py
+++ b/git_remote_helpers/git/exporter.py
@@ -38,10 +38,10 @@ class GitExporter(object):
         if not os.path.exists(dirname):
             os.makedirs(dirname)
 
-        print "feature relative-marks"
+        print("feature relative-marks")
         if os.path.exists(os.path.join(dirname, 'git.marks')):
-            print "feature import-marks=%s/git.marks" % self.repo.hash
-        print "feature export-marks=%s/git.marks" % self.repo.hash
+            print("feature import-marks=%s/git.marks" % self.repo.hash)
+        print("feature export-marks=%s/git.marks" % self.repo.hash)
         sys.stdout.flush()
 
         args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
diff --git a/git_remote_helpers/git/git.py b/git_remote_helpers/git/git.py
index 007a1bf..43f6c53 100644
--- a/git_remote_helpers/git/git.py
+++ b/git_remote_helpers/git/git.py
@@ -111,7 +111,7 @@ class GitObjectFetcher(object):
         """
         if self.queue and self.in_transit is None:
             self.in_transit = self.queue.pop(0)
-            print >> self.proc.stdin, self.in_transit[0]
+            self.proc.stdin.write(self.in_transit[0] + "\n")
 
     def push (self, obj, callback):
         """Push the given object name onto the queue.
diff --git a/git_remote_helpers/util.py b/git_remote_helpers/util.py
index fbbb01b..f6bd42e 100644
--- a/git_remote_helpers/util.py
+++ b/git_remote_helpers/util.py
@@ -32,20 +32,20 @@ DEBUG = False
 
 def notify(msg, *args):
     """Print a message to stderr."""
-    print >> sys.stderr, msg % args
+    sys.stderr.write(msg % args + "\n")
 
 def debug (msg, *args):
     """Print a debug message to stderr when DEBUG is enabled."""
     if DEBUG:
-        print >> sys.stderr, msg % args
+        sys.stderr.write(msg % args + "\n")
 
 def error (msg, *args):
     """Print an error message to stderr."""
-    print >> sys.stderr, "ERROR:", msg % args
+    sys.stderr.write("ERROR: " + msg % args + "\n")
 
 def warn(msg, *args):
     """Print a warning message to stderr."""
-    print >> sys.stderr, "warning:", msg % args
+    sys.stderr.write("warning: " + msg % args + "\n")
 
 def die (msg, *args):
     """Print as error message to stderr and exit the program."""
@@ -87,10 +87,10 @@ class ProgressIndicator(object):
         if msg is None:
             msg = self.States[self.n % len(self.States)]
         msg = self.prefix + msg
-        print >> self.f, "\r%-*s" % (self.prev_len, msg),
+        self.f.write("\r%-*s" % (self.prev_len, msg) + "\n")
         self.prev_len = len(msg.expandtabs())
         if lf:
-            print >> self.f
+            self.f.write("\n")
             self.prev_len = 0
         self.n += 1
 
-- 
1.7.8.382.g9f1d9.dirty
