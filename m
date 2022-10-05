Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F96C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 21:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiJEVhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiJEVhU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 17:37:20 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14BF80483
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665005834; bh=brzZdeP7ydlUSGDXaJ8ZUt2J1TMHQPkMoIv1FrJXMS4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ktZz6iYCm1BtmQ+UjPn96DoHvA9p2MeKF9YXdlyMpEqMMMmElrXHhGde7WrUYVWHJ
         g7AYfKTYxXg74LPTcK0c+4jcNcj9klqYcBfwNt/dSpiX3okzLuIgmP93pPwKnRWIuB
         z5IoPAHOKaf+5e0ElJpJRUCbhLfOSOi9VRHtwltoGgwe/d1W/+S8VTet0dsrYXVtEE
         xH0KUCys7MvNEoXrWFuICJSVlWTd/8Q0ST8k1v4nni5525nA8Zoh1K1rkOXu/fO/Hr
         w50SopXSoM5nOUcZZKTfHDnRL4NtKq+3F4BNPHBBqU+ITMd13cdvMwudbnlC8lTZZz
         /MfeQfwCnueXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([46.223.163.81]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MsaRt-1pUqv30Mxf-00tl7R; Wed, 05 Oct 2022 23:37:14 +0200
From:   Markus Heidelberg <markus.heidelberg@web.de>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Markus Heidelberg <markus.heidelberg@web.de>
Subject: [filter-repo PATCH] contrib: new tool to convert svn:externals to Git submodules
Date:   Wed,  5 Oct 2022 23:36:33 +0200
Message-Id: <20221005213633.7070-1-markus.heidelberg@web.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjOFAbzor2lLfKcjWYmIXaFI6JZaH4cNH1Y6v53Lz1WwUkvJF5J
 +HAuicyOGHPQzVgJs5/P4VI65yKAyqND2d3b7foE8+UGWqviW5rMgO784yvTHvoK6Y6ZQ0L
 JlZ6WT944sO2yDy4MK9Wl163P6SJthyQvQao63jzItv+Wmgb5gdIw5bW9J4E5loiIRvnuka
 E6MU0NgFPXkebAFfj3yLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XVzcXSd6488=:ul/iF/JIn/P1EUKVDtxvbp
 kIYxTbuShlLp7fadc4XSwMgYZpmaH1Q+68hShWHbrI/HY3NEogWeH8F/8P8wJUbGFA5SbyppR
 t1qterLd9j+nIP2jNbGghN/3W6879Uk477CbbvqCFAJPxN3A4Rr6eMDFXUn6F32PfB99mXzyv
 7AkfeMc7kCU8ctg9Yh6kNgkZYOZutk8lJksHckWHFZ1fVuqFdl7VGASTTbGddiMQeCBZdT0wt
 KlWx0K0u5OdmPNzn4vB4N4awEWcbWjT8C4ASr9noYpgXL7cVhNLlD3ADzggUV0jprnx92MViq
 Mm+ZH4l5lqITYAe+kkUa0yQSfHft5pnrQhOnQMau5KPoQ+Mapuf7TSNEvqtswXgP6uRpqBJK8
 af6S5aUM+fphkwy3gB2/NhMJ9Sl9DAY5KLOspqeqYUlDzKn1bFMVQDEfwAbCTdOP8kFD842MU
 2JDs0gBTgRx/+pf3Kn//6wSKR1F+2FwSPvQUSG8XjSH1Hv2cPVmpedTVNEhnpNJTNos1O7GCa
 QKsI0Ae1TiG8F7Qq/UeEB/9Htx6KgFvbAManhFCHTG6OM2xtKL9k2KD33cuibLNh5zehmbPYY
 NzDGdQFlcdwZ2e+ZKE3AePYibzt8QfYZfcLOy4UzEZvI/E9G7xbThbaG0xS3ZYZpyV8SJUHf5
 +9GHY9qF7fqqmWXFiI4zfg7bXxn+736n00t8VpRsIq0InRtdtZmBarLJYDWyd2BXworGr44tD
 s2Ibut8NGfZiV8DzwbriAUhDqlEjJSYp8ytbfk0+/XO1+rNNOQ4oV5Geqri4Fl03NH7oG7TSI
 H6zPU7eBbxHGCwCYP9/l+No/EjksZHA8CjpMEXAua5ufNeFqm+WPpdVHlkSlEQuVRTrQRsJNU
 pfRLcTl0Rp25/DkrQvyQpGudtM18XEljna3PSohXPdk/hs9IWqz3jgNPfy30xhsrZKtPpQd2p
 N+lmJzecSW1iW12KNSXTWHuXiPLPpz2f6GSIk1qwRLhPLyawgeDf1L+xupeSO5T1Iq4e+Fg/C
 qSx+wPCOdUJ3fyEhTVxasSTrpWGftW87XpTC93UlzxYqgoNCJJl4c7Own9m8sfw/haP52U3ax
 IMUMZl0HxJEILEFtCIkmy8xTpYAOkkH1cZ73+iRYEymtuZkLv73mYbKAGDEzX2CLOmF0XEB2r
 8mZKjpZy8ubKztachJHUilAzpy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is meant to be a post-processing step after SVN-to-Git conversion
by SubGit (https://subgit.com/), which creates a ".gitsvnextmodules"
file that we will use for svn:externals conversion.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
=2D--

The SVN-to-Git mapping file format might have to be changed in the
future when implementing other features, don't know yet. At least I
wanted to publish this script now that the basics work. Maybe there are
even some other late-adopters for whose this script might still be
useful.

I'm eager for hints where descriptions/comments are confusing or
incomplete.

This script was already used for migration of an SVN repository in our
company.

Relates to https://github.com/newren/git-filter-repo/issues/14

 contrib/filter-repo-demos/README.md           |   1 +
 .../filter-repo-demos/convert-svnexternals    | 587 ++++++++++++++++++
 2 files changed, 588 insertions(+)
 create mode 100644 contrib/filter-repo-demos/convert-svnexternals

diff --git a/contrib/filter-repo-demos/README.md b/contrib/filter-repo-dem=
os/README.md
index ef021b1..9612428 100644
=2D-- a/contrib/filter-repo-demos/README.md
+++ b/contrib/filter-repo-demos/README.md
@@ -16,6 +16,7 @@ lint-history         |Run some lint command on all non-b=
inary files in history.
 clean-ignore         |Delete files from history which match current gitig=
nore rules.
 filter-lamely (or filter&#8209;branch&#8209;ish) |A nearly bug compatible=
 re-implementation of filter-branch (the git testsuite passes using it ins=
tead of filter-branch), with some performance tricks to make it several ti=
mes faster (though it's still glacially slow compared to filter-repo).
 bfg-ish              |A re-implementation of most of BFG Repo Cleaner, wi=
th new features and bug fixes.
+convert-svnexternals |Insert Git submodules according to SVN externals.

 ## Purpose

diff --git a/contrib/filter-repo-demos/convert-svnexternals b/contrib/filt=
er-repo-demos/convert-svnexternals
new file mode 100644
index 0000000..0c81507
=2D-- /dev/null
+++ b/contrib/filter-repo-demos/convert-svnexternals
@@ -0,0 +1,587 @@
+#!/usr/bin/env python3
+
+"""
+This is a program that will insert Git submodules according to SVN extern=
als
+definitions (svn:externals properties) from the original Subversion repos=
itory
+throughout the history.
+
+Information about the externals is obtained from the ".gitsvnextmodules" =
file
+created during SVN-to-Git conversion by SubGit (https://subgit.com/). Its
+config option "translate.externals=3Dtrue" had to be used therefore.
+
+Actual modifications:
+- Insert gitlinks (mode 160000) into the tree.
+- Add .gitmodules file with relevant sections.
+- Remove sections converted to submodules from .gitsvnextmodules file
+  and delete it if empty.
+
+.gitsvnextmodules example:
+[submodule "somedir/extdir"]
+	path =3D somedir/extdir
+	owner =3D somedir
+	url =3D https://svn.example.com/somesvnrepo/trunk
+	revision =3D 1234
+	branch =3D /
+	fetch =3D :refs/remotes/git-svn
+	remote =3D svn
+	type =3D dir
+
+Resulting addition in "somedir" tree (cat-file pretty-print format):
+160000 commit 1234123412341234123412341234123412341234	extdir
+
+Resulting .gitmodules entry:
+[submodule "somedir/extdir"]
+	path =3D somedir/extdir
+	url =3D https://git.example.com/somegitrepo.git
+
+SVN-to-Git mapping file:
+Can be created from SubGit's "refs/svn/map".
+One line per mapping in following format:
+<svn url> TAB <svn rev> TAB <git url> TAB <git commit> TAB <state>
+- Leading '#' can be used for comments.
+- <svn url> must not contain a trailing slash.
+- <state> has to be "commit" to be usable, but can be "missing" if <git c=
ommit>
+  does not exist in the repository anymore. Adopted from git-cat-file out=
put.
+Example:
+https://svn.example.com/somesvnrepo/trunk	1234	https://git.example.com/so=
megitrepo.git	1234123412341234123412341234123412341234	commit
+
+Features:
+- Repeatedly added/removed externals will be handled properly.
+- Externals replaced by directly added files and vice versa will be handl=
ed
+  properly.
+
+Caveats:
+- This script must NOT be run repeatedly. A second invocation would lead =
to a
+  different result in case the externals could only be converted partiall=
y.
+- Inconsistent SVN repositories (with failing checkout) not handled, i.e.
+  - normal directory and external with the same path
+  - external path not existing for the given revision
+- No attention was paid to non-ASCII and special characters in gitlink pa=
ths,
+  might cause problems.
+- There is no error handling for mandatory options missing in .gitsvnextm=
odules
+  file. The script would crash in case of such buggy files, but that shou=
ldn't
+  happen in practice.
+
+TODO:
+- Add external files directly.
+- Alternatively add external directories directly instead of using a subm=
odule.
+"""
+
+"""
+Please see the
+  ***** API BACKWARD COMPATIBILITY CAVEAT *****
+near the top of git-filter-repo.
+"""
+
+import argparse
+import os
+import sys
+import shutil
+import subprocess
+import configparser
+from urllib.parse import urlsplit
+
+try:
+  import git_filter_repo as fr
+except ImportError:
+  raise SystemExit("Error: Couldn't find git_filter_repo.py.  Did you for=
get to make a symlink to git-filter-repo named git_filter_repo.py or did y=
ou forget to put the latter in your PYTHONPATH?")
+
+svn_root_url =3D ""
+svn_git_mappings =3D []
+
+def parse_args():
+  """
+  Parse and return arguments for this script.
+
+  Also do some argument sanity checks and adaptions.
+  """
+  parser =3D argparse.ArgumentParser(
+      description=3D"Add Git submodules according to svn:externals from .=
gitsvnextmodules. "
+                  "As preparation for this conversion process, an analysi=
s can be performed.")
+
+  parser.add_argument('--force', '-f', action=3D'store_true',
+      help=3D"Rewrite repository history even if the current repo does no=
t "
+           "look like a fresh clone.")
+  parser.add_argument('--refs', nargs=3D'+',
+      help=3D"Limit history rewriting to the specified refs. Option is di=
rectly "
+           "forwarded to git-filter-repo, see there for details and cavea=
ts. "
+           "Use for debugging purposes only!")
+  parser.add_argument('--svn-root-url',
+      help=3D"Root URL of the corresponding SVN repository, "
+           "needed for conversion of relative to absolute external URLs."=
)
+
+  analysis =3D parser.add_argument_group(title=3D"Analysis")
+  analysis.add_argument('--analyze', action=3D'store_true',
+      help=3D"Analyze repository history and create auxiliary files for c=
onversion process.")
+  analysis.add_argument('--report-dir', type=3Dos.fsencode,
+      help=3D"Directory to write report, defaults to GIT_DIR/filter-repo/=
svnexternals, "
+           "refuses to run if exists, --force delete existing dir first."=
)
+
+  conversion =3D parser.add_argument_group(title=3D"Conversion")
+  conversion.add_argument('--svn-git-mapfiles', type=3Dos.fsencode, nargs=
=3D'+', metavar=3D'MAPFILE',
+      help=3D"Files with SVN-to-Git revision mappings for SVN externals c=
onversion.")
+
+  args =3D parser.parse_args()
+
+  if args.analyze and args.svn_git_mapfiles:
+    raise SystemExit("Error: --svn-git-mapfiles makes no sense with --ana=
lyze.")
+
+  if not args.analyze and not args.svn_git_mapfiles:
+    raise SystemExit("Error: --svn-git-mapfiles is required for the conve=
rsion process.")
+
+  return args
+
+def read_mappings(mapfiles):
+  """
+  Read files with SVN-to-Git mappings and return a list of mappings from =
it.
+  """
+  mappings =3D []
+  for mapfile in mapfiles:
+    with open(mapfile, "rb") as f:
+      for line in f:
+        line =3D line.rstrip(b'\r\n')
+
+        # Skip blank and comment lines
+        if not line or line.startswith(b'#'):
+          continue
+
+        # Convert to string for use with configparser later
+        line =3D line.decode()
+
+        # Parse the line
+        fields =3D line.split('\t', 4)
+        mapping =3D {'svn_url': fields[0],
+                   'svn_rev': int(fields[1]),
+                   'git_url': fields[2],
+                   'git_commit': fields[3],
+                   'state': fields[4]}
+
+        mappings.append(mapping)
+  return mappings
+
+cat_file_process =3D None
+def parse_config(blob_id):
+  """
+  Create a configparser object for a .gitsvnextmodules/.gitmodules file f=
rom
+  its blob ID.
+  """
+  parsed_config =3D configparser.ConfigParser()
+
+  if blob_id is not None:
+    # Get the blob contents
+    cat_file_process.stdin.write(blob_id + b'\n')
+    cat_file_process.stdin.flush()
+    objhash, objtype, objsize =3D cat_file_process.stdout.readline().spli=
t()
+    contents_plus_newline =3D cat_file_process.stdout.read(int(objsize)+1=
)
+
+    # Parse it
+    parsed_config.read_string(contents_plus_newline.decode())
+
+  return parsed_config
+
+def create_blob(parsed_config):
+  """
+  Create a filter-repo blob object from a .gitsvnextmodules/.gitmodules
+  configparser object according to Git config style.
+  """
+  lines =3D []
+  for sec in parsed_config.sections():
+    lines.append("[" + sec + "]\n")
+    for opt in parsed_config.options(sec):
+      lines.append("\t" + opt + " =3D " + parsed_config[sec][opt] + "\n")
+
+  return fr.Blob(''.join(lines).encode())
+
+def get_git_url(svn_url):
+  """
+  Get the Git URL for a corresponding SVN URL.
+  """
+  for entry in svn_git_mappings:
+    if entry['svn_url'] =3D=3D svn_url:
+      return entry['git_url']
+  else:
+    return None
+
+def get_git_commit_hash(svn_url, svn_rev):
+  """
+  Get the Git commit hash for its corresponding SVN URL+revision.
+
+  The mapping is not restricted to the exact revision, but also uses the =
next
+  lower revision found. Needed when the revision was set to that of the r=
oot
+  URL instead of to that of the specific subdirectory (e.g. trunk). Torto=
iseSVN
+  behaves so when setting the external to HEAD.
+  """
+  ent =3D None
+  rev =3D 0
+
+  for entry in svn_git_mappings:
+    if (entry['svn_url'] =3D=3D svn_url
+          and entry['svn_rev'] <=3D svn_rev
+          and entry['svn_rev'] > rev):
+      ent =3D entry
+      rev =3D entry['svn_rev']
+
+  if ent is not None and ent['state'] =3D=3D "commit":
+    return ent['git_commit']
+  else:
+    return None
+
+def get_absolute_svn_url(svnext_url, svn_root_url):
+  """
+  Convert a relative svn:externals URL to an absolute one.
+
+  If the format is unsupported, return the URL unchanged with success=3DF=
alse.
+  If no root URL is given or the URL is absolute already, return it uncha=
nged.
+
+  In all cases, even if returned "unchanged", trailing slashes are remove=
d.
+  """
+  # Remove trailing slash(es)
+  svnext_url =3D svnext_url.rstrip("/")
+  svn_root_url =3D svn_root_url.rstrip("/")
+
+  # Normalize URLs in relative format
+  svn_root_parsed =3D urlsplit(svn_root_url)
+  if svnext_url.startswith(("../", "^/../")): # unsupported
+    return (False, svnext_url)
+  elif not svn_root_url:
+    pass # unchanged
+  elif svnext_url.startswith("^/"):
+    svnext_url =3D svn_root_url + svnext_url[1:]
+  elif svnext_url.startswith("//"):
+    svnext_url =3D svn_root_parsed.scheme + ":" + svnext_url
+  elif svnext_url.startswith("/"):
+    svnext_url =3D svn_root_parsed.scheme + "://" + svn_root_parsed.netlo=
c + svnext_url
+
+  return True, svnext_url
+
+def add_submodule_tree_entry(commit, parsed_config, section):
+  """
+  Add a submodule entry to the tree of a Git commit.
+
+  SVN externals information obtained from parsed .gitsvnextmodules file.
+  """
+  # Skip type=3Dfile (SVN file external), not possible as submodule
+  if parsed_config[section]['type'] !=3D 'dir':
+    return False
+
+  success, svn_url =3D get_absolute_svn_url(parsed_config[section]['url']=
, svn_root_url)
+  # Skip unsupported URL format
+  if not success:
+    return False
+
+  # Get SVN revision
+  if parsed_config.has_option(section, 'revision'):
+    svn_rev =3D int(parsed_config[section]['revision'])
+  else:
+    # TODO: revision has to be guessed according to commit timestamp, ski=
p for now
+    return False
+
+  # SVN url+revision mapping to Git commit
+  git_hash =3D get_git_commit_hash(svn_url, svn_rev)
+  # Skip missing or unusable mapping
+  if git_hash is None:
+    return False
+  git_hash =3D git_hash.encode()
+
+  dirname =3D parsed_config[section]['path'].encode()
+
+  # Add gitlink to tree
+  commit.file_changes.append(fr.FileChange(b'M', dirname, git_hash, b'160=
000'))
+
+  return True
+
+def get_commit_map_path():
+  """
+  Return path to commit-map file.
+  """
+  git_dir =3D fr.GitUtils.determine_git_dir(b'.')
+  return os.path.join(git_dir, b'filter-repo', b'commit-map')
+
+def parse_commit_map(commit_map_file):
+  """
+  Parse commit-map file and return a dictionary.
+  """
+  parsed_map =3D {}
+  with open(commit_map_file, "rb") as f:
+    for line in f:
+      line =3D line.rstrip(b'\r\n')
+
+      # Skip blank lines
+      if not line:
+        continue
+
+      # Store old/new commits, also the "old"/"new" header in the first l=
ine
+      old, new =3D line.split()
+      parsed_map[old] =3D new
+  return parsed_map
+
+def merge_commit_maps(old_commit_map, new_commit_map):
+  """
+  Merge old and new commit-map by omitting intermediate commits.
+
+  Return the merged dictionary.
+  """
+  merged_map =3D {}
+  for (key, old_val) in old_commit_map.items():
+    new_val =3D new_commit_map[old_val] if old_val in new_commit_map else=
 old_val
+    merged_map[key] =3D new_val
+  return merged_map
+
+def write_commit_map(commit_map, commit_map_file):
+  """
+  Write commit-map dictionary to file.
+  """
+  with open(commit_map_file, 'wb') as f:
+    for (old, new) in commit_map.items():
+      f.write(b'%-40s %s\n' % (old, new))
+
+def create_report_dir(args):
+  """
+  Create the directory for analysis report.
+  """
+  if args.report_dir:
+    reportdir =3D args.report_dir
+  else:
+    git_dir =3D fr.GitUtils.determine_git_dir(b'.')
+
+  # Create the report directory as necessary
+    results_tmp_dir =3D os.path.join(git_dir, b'filter-repo')
+    if not os.path.isdir(results_tmp_dir):
+      os.mkdir(results_tmp_dir)
+    reportdir =3D os.path.join(results_tmp_dir, b'svnexternals')
+
+  if os.path.isdir(reportdir):
+    if args.force:
+      sys.stdout.write("Warning: Removing recursively: \"%s\"" % fr.decod=
e(reportdir))
+      shutil.rmtree(reportdir)
+    else:
+      sys.stdout.write("Error: dir already exists (use --force to delete)=
: \"%s\"\n" % fr.decode(reportdir))
+      sys.exit(1)
+
+  os.mkdir(reportdir)
+
+  return reportdir
+
+analysis =3D {'dir_ext_orig': [],
+            'dir_ext_abs': [],
+            'file_ext_orig': [],
+            'file_ext_abs': []}
+def write_analysis(reportdir):
+  """
+  Prepare analysis and write it to files in report directory.
+  """
+  analysis['dir_ext_orig'].sort()
+  analysis['dir_ext_abs'].sort()
+  analysis['file_ext_orig'].sort()
+  analysis['file_ext_abs'].sort()
+
+  sys.stdout.write("Writing reports to %s..." % fr.decode(reportdir))
+  sys.stdout.flush()
+
+  with open(os.path.join(reportdir, b"dir-externals-original.txt"), 'wb')=
 as f:
+    for url in analysis['dir_ext_orig']:
+      f.write(("%s\n" % url).encode())
+
+  with open(os.path.join(reportdir, b"dir-externals-absolute.txt"), 'wb')=
 as f:
+    for url in analysis['dir_ext_abs']:
+      f.write(("%s\n" % url).encode())
+
+  with open(os.path.join(reportdir, b"file-externals-original.txt"), 'wb'=
) as f:
+    for url in analysis['file_ext_orig']:
+      f.write(("%s\n" % url).encode())
+
+  with open(os.path.join(reportdir, b"file-externals-absolute.txt"), 'wb'=
) as f:
+    for url in analysis['file_ext_abs']:
+      f.write(("%s\n" % url).encode())
+
+  sys.stdout.write("done.\n")
+
+def analyze_externals(commit, metadata):
+  """
+  Generate/extend analysis of SVN externals for a Git commit.
+
+  Used as filter-repo commit callback.
+  """
+  for change in commit.file_changes:
+    if change.filename =3D=3D b'.gitsvnextmodules' and change.type =3D=3D=
 b'M':
+      gitsvnextmodules =3D parse_config(change.blob_id)
+
+      for sec in gitsvnextmodules.sections():
+        url =3D gitsvnextmodules[sec]['url']
+        success, abs_url =3D get_absolute_svn_url(url, svn_root_url)
+
+        # List of svn:externals URLs, also add the URL to the absolute li=
st if
+        # conversion was not successful
+        if gitsvnextmodules[sec]['type'] =3D=3D 'dir':
+          if url not in analysis['dir_ext_orig']:
+            analysis['dir_ext_orig'].append(url)
+          if abs_url not in analysis['dir_ext_abs']:
+            analysis['dir_ext_abs'].append(abs_url)
+        else:
+          if url not in analysis['file_ext_orig']:
+            analysis['file_ext_orig'].append(url)
+          if abs_url not in analysis['file_ext_abs']:
+            analysis['file_ext_abs'].append(abs_url)
+
+def insert_submodules(commit, metadata):
+  """
+  Insert submodules for a Git commit.
+
+  Used as filter-repo commit callback.
+
+  Since .gitsvnextmodules just contains the svn:externals state for the g=
iven
+  commit, we cannot derive specific changes from that file.
+  So we can only add/modify the gitlinks according to .gitsvnextmodules
+  (without knowing whether adding a new or modifying an existing or even
+  "modifying" an unchanged submodule, but none of that really matters).
+  We do not have information about deleted externals, those will be handl=
ed in
+  a separate filter run afterwards.
+
+  The .gitmodules file however will already be correct in this function b=
ecause
+  we don't need to know about specific changes to add, modify or delete i=
t.
+  """
+  for change in commit.file_changes:
+    if change.filename =3D=3D b'.gitsvnextmodules' and change.type in (b'=
M', b'D'):
+      gitsvnextmodules =3D parse_config(change.blob_id)
+      gitmodules =3D configparser.ConfigParser()
+
+      # Add gitlinks to the tree and prepare .gitmodules file content
+      for sec in gitsvnextmodules.sections():
+        if add_submodule_tree_entry(commit, gitsvnextmodules, sec):
+          # Gitlink added
+          # -> Add this entry to .gitmodules as well
+
+          # Create the section name string manually, do not rely on
+          # .gitsvnextmodules to always use the proper section name.
+          sec_name =3D 'submodule "' + gitsvnextmodules[sec]['path'] + '"=
'
+          gitmodules[sec_name] =3D {}
+
+          # submodule.<name>.path
+          gitmodules[sec_name]['path'] =3D gitsvnextmodules[sec]['path']
+
+          # submodule.<name>.url
+          success, svn_url =3D get_absolute_svn_url(gitsvnextmodules[sec]=
['url'], svn_root_url)
+          git_url =3D get_git_url(svn_url)
+          if git_url is not None:
+            gitmodules[sec_name]['url'] =3D git_url
+          else:
+            # Abort, but this will not happen in practice, catched in
+            # add_submodule_tree_entry() via get_git_commit_hash() alread=
y.
+            raise SystemExit("Error: No Git URL found in mapping although=
 a commit hash could be found.")
+
+      # Write blob and adapt tree for .gitmodules
+      if gitmodules.sections():
+        # Create a blob object from the content and add it to the tree.
+        blob =3D create_blob(gitmodules)
+        filter.insert(blob)
+        commit.file_changes.append(fr.FileChange(b'M', b'.gitmodules', bl=
ob.id, b'100644'))
+      else:
+        # Delete the file, even if a "git rm" of all submodules keeps it =
empty.
+        commit.file_changes.append(fr.FileChange(b'D', b'.gitmodules'))
+
+def delete_submodules(commit, metadata):
+  """
+  Delete submodules from a Git commit.
+
+  Used as filter-repo commit callback.
+
+  Delete all submodules (inserted in the previous filter run) without an =
entry
+  in .gitsvnextmodules, these were real deletions of externals, which cou=
ldn't
+  be detected before.
+  Only the tree entries have to be removed because the .gitmodules file i=
s
+  already in correct state from previous filter run.
+  """
+  for change in commit.file_changes:
+    if change.filename =3D=3D b'.gitsvnextmodules' and change.type in (b'=
M', b'D'):
+      gitsvnextmodules =3D parse_config(change.blob_id)
+
+      # Search for all submodules in the tree
+      output =3D subprocess.check_output('git ls-tree -d -r -z'.split() +=
 [commit.original_id])
+      for line in output.split(b'\x00'):
+        if not line:
+          continue
+        mode_objtype_objid, dirname =3D line.split(b'\t', 1)
+        mode, objtype, objid =3D mode_objtype_objid.split(b' ')
+        if mode =3D=3D b'160000' and objtype =3D=3D b'commit':
+          # Submodule found
+          # -> Delete it if there is no corresponding entry in
+          #    .gitsvnextmodules, keep/reinsert it otherwise
+          for sec in gitsvnextmodules.sections():
+            if gitsvnextmodules[sec]['path'].encode() =3D=3D dirname:
+              # Reinsert it, might have been deleted in previous commits
+              if add_submodule_tree_entry(commit, gitsvnextmodules, sec):
+                # And remove the config section because this external has=
 been
+                # converted
+                gitsvnextmodules.remove_section(sec)
+                break
+          else:
+            # Delete it
+            commit.file_changes.append(fr.FileChange(b'D', dirname))
+
+      # Rewrite .gitsvnextmodules to contain the unhandled externals only=
,
+      # delete it if empty (all externals converted).
+      if gitsvnextmodules.sections():
+        # Create a blob object from the content and replace the original =
one.
+        blob =3D create_blob(gitsvnextmodules)
+        filter.insert(blob)
+        change.blob_id =3D blob.id
+      else:
+        if change.type =3D=3D b'M':
+          # File became empty, delete it
+          commit.file_changes.append(fr.FileChange(b'D', b'.gitsvnextmodu=
les'))
+          break # avoid endless for loop
+        #else:
+          # File was empty already, delete command already present in str=
eam
+
+my_args =3D parse_args()
+
+# Use passed URL without trailing slash(es)
+if my_args.svn_root_url:
+  svn_root_url =3D my_args.svn_root_url.rstrip("/")
+
+# Arguments forwarded to filter-repo
+extra_args =3D []
+if my_args.force:
+  extra_args =3D ['--force']
+if my_args.refs:
+  extra_args +=3D ['--refs'] + my_args.refs
+
+cat_file_process =3D subprocess.Popen(['git', 'cat-file', '--batch'],
+                                    stdin =3D subprocess.PIPE,
+                                    stdout =3D subprocess.PIPE)
+if my_args.analyze:
+  # Analysis
+  reportdir =3D create_report_dir(my_args)
+
+  fr_args =3D fr.FilteringOptions.parse_args(['--dry-run']
+                                           + extra_args)
+  filter =3D fr.RepoFilter(fr_args, commit_callback=3Danalyze_externals)
+  filter.run()
+
+  write_analysis(reportdir)
+else:
+  # Conversion
+  svn_git_mappings =3D read_mappings(my_args.svn_git_mapfiles)
+
+  # There are no references to commit hashes in commit messages because t=
his
+  # script runs on a Git repository converted from a Subversion repositor=
y.
+  fr_args =3D fr.FilteringOptions.parse_args(['--preserve-commit-hashes',
+                                            '--preserve-commit-encoding',
+                                            '--replace-refs', 'update-no-=
add']
+                                           + extra_args)
+  filter =3D fr.RepoFilter(fr_args, commit_callback=3Dinsert_submodules)
+  filter.run()
+
+  # Store commit-map after first run
+  first_commit_map =3D parse_commit_map(get_commit_map_path())
+
+  filter =3D fr.RepoFilter(fr_args, commit_callback=3Ddelete_submodules)
+  filter.run()
+
+  # Update commit-map after second run, based on original IDs
+  second_commit_map =3D parse_commit_map(get_commit_map_path())
+  merged_commit_map =3D merge_commit_maps(first_commit_map, second_commit=
_map)
+  write_commit_map(merged_commit_map, get_commit_map_path())
+
+cat_file_process.stdin.close()
+cat_file_process.wait()
=2D-
2.37.3

