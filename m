Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F801F463
	for <e@80x24.org>; Tue, 17 Sep 2019 13:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfIQNl1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 09:41:27 -0400
Received: from a7-10.smtp-out.eu-west-1.amazonses.com ([54.240.7.10]:44940
        "EHLO a7-10.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfIQNlZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Sep 2019 09:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1568727683;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Bq+bdBOUdMEeWOWM9cunao5JOiI7QdRmhu/xZVPf+7A=;
        b=RmiPn7fzIjzaLTH3zpMP2VCTyPo81iSvmdBN0M1B9xX5ov5nGfsabVZ7kcM8Sn8g
        GjABt9K1CsyHhr7fLqWYTNCUzkHmeFD5Bik28MABwz9gx981J5qwTw/p5pJ2pg6HNjj
        lxwGdVizGnnJDdahrz46uFsF89ahuvsksFrHQ7vc=
From:   =?UTF-8?Q?Herv=C3=A9_Beraud?= <herveberaud.pro@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016d3f74d202-d5b32dd4-0098-4ad0-8ac7-5fde254f7796-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
References: <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Rewrite feature to render hg-to-git compatible with
 python2.x and 3.x
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 17 Sep 2019 13:41:23 +0000
X-SES-Outgoing: 2019.09.17-54.240.7.10
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite features that are no longer supported (or recommended)
in Python 3 in the script so that it can be used with both
Python 2 and 3, namely:

- print is not a statement; use print() function instead.
- dict.has_key(key) is no more; use "key in dict" instead.
- map(lambda ..., collection) is not liked; use list comprehension.

These changes introduce a syntaxe compatible with the both versions of
python.

Python 2 is EOL at the end of 2019, the major part of distros
and systems now come with python 3  is the default version so
these address the situation to render this script compatible with
the latest versions of python.

Signed-off-by: Herv=C3=A9 Beraud <herveberaud.pro@gmail.com>
---
 contrib/hg-to-git/hg-to-git.py | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.p=
y
index de3f81667ed97..8fa7698df5c20 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -42,7 +42,7 @@
=20
 def usage():
=20
-        print """\
+        print("""\
 %s: [OPTIONS] <hgprj>
=20
 options:
@@ -54,7 +54,7 @@ def usage():
=20
 required:
     hgprj:  name of the HG project to import (directory)
-""" % sys.argv[0]
+""" % sys.argv[0])
=20
 #-------------------------------------------------------------------------=
-----
=20
@@ -104,29 +104,29 @@ def getgitenv(user, date):
 if state:
     if os.path.exists(state):
         if verbose:
-            print 'State does exist, reading'
+            print('State does exist, reading')
         f =3D open(state, 'r')
         hgvers =3D pickle.load(f)
     else:
-        print 'State does not exist, first run'
+        print('State does not exist, first run')
=20
 sock =3D os.popen('hg tip --template "{rev}"')
 tip =3D sock.read()
 if sock.close():
     sys.exit(1)
 if verbose:
-    print 'tip is', tip
+    print('tip is', tip)
=20
 # Calculate the branches
 if verbose:
-    print 'analysing the branches...'
+    print('analysing the branches...')
 hgchildren["0"] =3D ()
 hgparents["0"] =3D (None, None)
 hgbranch["0"] =3D "master"
 for cset in range(1, int(tip) + 1):
     hgchildren[str(cset)] =3D ()
     prnts =3D os.popen('hg log -r %d --template "{parents}"' % cset).read(=
).strip().split(' ')
-    prnts =3D map(lambda x: x[:x.find(':')], prnts)
+    prnts =3D [x[:x.find(':')] for x in prnts]
     if prnts[0] !=3D '':
         parent =3D prnts[0].strip()
     else:
@@ -154,15 +154,15 @@ def getgitenv(user, date):
         else:
             hgbranch[str(cset)] =3D "branch-" + str(cset)
=20
-if not hgvers.has_key("0"):
-    print 'creating repository'
+if "0" not in hgvers:
+    print('creating repository')
     os.system('git init')
=20
 # loop through every hg changeset
 for cset in range(int(tip) + 1):
=20
     # incremental, already seen
-    if hgvers.has_key(str(cset)):
+    if str(cset) in hgvers:
         continue
     hgnewcsets +=3D 1
=20
@@ -180,27 +180,27 @@ def getgitenv(user, date):
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
=20
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
-=09print 'parent:', parent
+=09print('parent:', parent)
     if mparent:
-        print 'mparent:', mparent
+        print('mparent:', mparent)
     if tag:
-        print 'tag:', tag
-    print '-----------------------------------------'
+        print('tag:', tag)
+    print('-----------------------------------------')
=20
     # checkout the parent if necessary
     if cset !=3D 0:
         if hgbranch[str(cset)] =3D=3D "branch-" + str(cset):
-            print 'creating new branch', hgbranch[str(cset)]
+            print('creating new branch', hgbranch[str(cset)])
             os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgve=
rs[parent]))
         else:
-            print 'checking out branch', hgbranch[str(cset)]
+            print('checking out branch', hgbranch[str(cset)])
             os.system('git checkout %s' % hgbranch[str(cset)])
=20
     # merge
@@ -209,7 +209,7 @@ def getgitenv(user, date):
             otherbranch =3D hgbranch[mparent]
         else:
             otherbranch =3D hgbranch[parent]
-        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
+        print('merging', otherbranch, 'into', hgbranch[str(cset)])
         os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "=
" %s %s' % (hgbranch[str(cset)], otherbranch))
=20
     # remove everything except .git and .hg directories
@@ -233,12 +233,12 @@ def getgitenv(user, date):
=20
     # delete branch if not used anymore...
     if mparent and len(hgchildren[str(cset)]):
-        print "Deleting unused branch:", otherbranch
+        print("Deleting unused branch:", otherbranch)
         os.system('git branch -d %s' % otherbranch)
=20
     # retrieve and record the version
     vvv =3D os.popen('git show --quiet --pretty=3Dformat:%H').read()
-    print 'record', cset, '->', vvv
+    print('record', cset, '->', vvv)
     hgvers[str(cset)] =3D vvv
=20
 if hgnewcsets >=3D opt_nrepack and opt_nrepack !=3D -1:
@@ -247,7 +247,7 @@ def getgitenv(user, date):
 # write the state for incrementals
 if state:
     if verbose:
-        print 'Writing state'
+        print('Writing state')
     f =3D open(state, 'w')
     pickle.dump(hgvers, f)
=20

--
https://github.com/git/git/pull/458
