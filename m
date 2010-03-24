From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 11:53:08 -0700
Message-ID: <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
	 <20100323024223.GA12257@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 19:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVhf-0003sM-Vo
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 19:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798Ab0CXSxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 14:53:11 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:30313 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645Ab0CXSxJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 14:53:09 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1980225qwh.37
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GFEqUg1C0QcOoolMwCkSRjuWnICc4gv1Rpd8wgLbTLA=;
        b=MZVBfJzfi5psAbZ5/4Xc1Mf8Rqw6Fv9BNOtTVMddk0Hx8dbjR2zDnlJJ6ciYEDLdBp
         9Vq9JMXbN8B3jB+W+8OJEzyBze3ZiAFg7EAPXYp5mGzJi4KBSNJWmDWU8T02npC2UUR5
         ZIvtoVmJpfsprovqfSaE0MYkbG8lMLXgx7mQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ICWp/WkUo7jke9AOUnXz920tBe3OeN9VZSKc1YsnVZmNd57pd7Cmtn6t4EH+QShN9t
         p24Q+1Rr2Hr9mYZFwuWu0GnUryPUqRiIbERf+EsVbUWUduSgTVA28DQ15ubBjFLn4TZt
         gwCiVkt/fR+ZWcmPHTzLBFTj8wdLTl0Cm3QKk=
Received: by 10.229.189.212 with SMTP id df20mr1402075qcb.21.1269456788449; 
	Wed, 24 Mar 2010 11:53:08 -0700 (PDT)
In-Reply-To: <20100323024223.GA12257@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143103>

On Mon, Mar 22, 2010 at 7:42 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Chris Packham wrote:
>
>> I would like to have base somehow find the objects it doesn't have i=
n
>> its object store and either download them or just copy them from the
>> object store of projecta.
> [...]
>> From reading [2] I think 'rm
>> .git/objects/info/alternates && git repack -a' might do the trick bu=
t
>> I'm not sure.
>
> Almost. =C2=A0Try =E2=80=98git repack -a && rm .git/objects/info/alte=
rnates=E2=80=99 instead. :)
>
> (Please back up the repository or try with something less important
> first, since I am not sure.)
>
> Hope that helps,
> Jonathan
>

git repack -a did the correct thing.

It occurs to me that the UI around alternates is a bit lacking i.e.
there isn't a git command to display the alternates in use or to add
them to an existing repository (or at least I couldn't find one
skimming the docs or googling). So here's my attempt to add a 'git
alternates' command which can display, add or remove an alternate. The
adding and removing could be done with standard shell commands but
I've found the recursive displaying quite useful and couldn't think of
a simple command line to achieve the same thing .

------8<------

=46rom a5c64de20937da132376d717f19a1d52b54701d2 Mon Sep 17 00:00:00 200=
1
=46rom: Chris Packham <judge.packham@gmail.com>
Date: Wed, 24 Mar 2010 11:34:11 -0700
Subject: [PATCH] Add git alternates command

Provides a friendlier UI for displaying and configuring alternates.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

This patch assumes multiple alterates are possible. If this is not corr=
ect then
it could be simplfied as there would be no need for walk_alternates.

 Makefile          |    1 +
 git-alternates.sh |  159 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100755 git-alternates.sh

diff --git a/Makefile b/Makefile
index 3a6c6ea..1a7b084 100644
--- a/Makefile
+++ b/Makefile
@@ -334,6 +334,7 @@ TEST_PROGRAMS_NEED_X =3D
 unexport CDPATH

 SCRIPT_SH +=3D git-am.sh
+SCRIPT_SH +=3D git-alternates.sh
 SCRIPT_SH +=3D git-bisect.sh
 SCRIPT_SH +=3D git-difftool--helper.sh
 SCRIPT_SH +=3D git-filter-branch.sh
diff --git a/git-alternates.sh b/git-alternates.sh
new file mode 100755
index 0000000..74ec707
--- /dev/null
+++ b/git-alternates.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+#
+# This file is licensed under the GPL v2
+#
+
+USAGE=3D'[-r|--recursive] [-a|--add <dir>] [-f|--force -d|--delete <di=
r>]'
+
+. git-sh-setup
+
+#
+# Runs through the alternates file calling the callback function $1
+# with the name of the alternate as the first argument to the callback
+# any additional arguments are passed to the callback function.
+#
+walk_alternates()
+{
+    local alternates=3D$GIT_DIR/objects/info/alternates
+    local callback=3D$1
+    shift
+
+    if [ -e $alternates ]; then
+        while read line
+        do
+            $callback $line $*
+        done < $alternates
+    fi
+}
+
+#
+# Walk function to display one alternate object store and, if the user
+# has specified -r, recursively call show_alternates on the git
+# repository that the object store belongs to.
+#
+show_alternates_walk()
+{
+    say "Object store $1"
+    say "    referenced via $GIT_DIR"
+
+    local new_git_dir=3D${line%%/objects}
+    if [ "$recursive" =3D=3D "true" -a "$GIT_DIR" !=3D "$new_git_dir" =
]
+    then
+        GIT_DIR=3D$new_git_dir show_alternates
+    fi
+}
+
+show_alternates()
+{
+    walk_alternates show_alternates_walk
+}
+
+#
+# Walk function to check that the specified alternate does not
+# already exist.
+#
+check_current_alternate_walk()
+{
+    if test "$1" =3D "$2"; then
+        die "fatal: Object store $2 is already used by $GIT_DIR"
+    fi
+}
+
+add_alternate()
+{
+    if test ! -d $dir; then
+        die "fatal: $dir is not a directory"
+    fi
+
+    walk_alternates check_current_alternate_walk $dir
+
+    # At this point we know that $dir is a directory that exists
+    # and that its not already being used as an alternate. We could
+    # go further and verify that $dir has valid objects.
+
+    # if we're still going we can safely add the alternate
+    touch $GIT_DIR/objects/info/alternates
+    echo "$(readlink -f $dir)" >> $GIT_DIR/objects/info/alternates
+    say "$dir added as an alternate"
+    say "     use 'git repack -adl' to remove duplicate objects"
+}
+
+rewrite_alternates()
+{
+    if test "$1" !=3D "$2"; then
+        echo $2 >> $3
+    fi
+}
+
+del_alternate()
+{
+    if test ! $force =3D "true"; then
+        say "Not forced, use"
+        say "   'git repack -a' to fetch missing objects, then "
+        say "   '$dashless -f -d $dir' to remove the alternate"
+        die
+    fi
+
+    local alternates=3D$GIT_DIR/objects/info/alternates
+
+    new_alts_file=3D$(mktemp $alternates-XXXXXX)
+    touch $new_alts_file
+
+    walk_alternates rewrite_alternates $dir $new_alts_file
+    mv $new_alts_file $alternates
+
+    # save the git from repeatedly reading a 0 length file
+    if test $(stat -c "%s" $alternates) -eq 0; then
+        rm $alternates
+    fi
+}
+
+dir=3D""
+oper=3D""
+force=3D"false"
+
+# Option parsing
+while test $# !=3D 0
+do
+    case "$1" in
+        -r|--recursive)
+            recursive=3D"true"
+            ;;
+        -a|--add)
+            if test ! -z "$oper"; then
+                usage
+            fi
+            oper=3D"add"
+            case "$#,$1" in
+                1,*) usage ;;
+                *)   dir=3D$2; shift ;;
+            esac
+            ;;
+        -d|--delete)
+            if test ! -z "$oper"; then
+                usage
+            fi
+            oper=3D"del"
+            case "$#,$1" in
+                1,*) usage ;;
+                *)   dir=3D$2; shift ;;
+            esac
+            ;;
+        -f|--force)
+            force=3D"true"
+            ;;
+        -*)
+            usage
+            ;;
+        *)
+            ;;
+    esac
+    shift
+done
+
+# Now go and do it
+case $oper in
+    add) add_alternate ;;
+    del) del_alternate ;;
+    *)   show_alternates ;;
+esac
--=20
1.7.0.3
