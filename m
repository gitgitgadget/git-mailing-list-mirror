From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v3] contrib/workdir: add a simple script to create a working
	directory
Date: Tue, 27 Mar 2007 00:15:32 +0100
Message-ID: <20070327115427.10016.93595.julian@quantumfyre.co.uk>
References: <7vabxzrzur.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:59:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWAL2-0004Ds-Mh
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbXC0L7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbXC0L7k
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:59:40 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:54127 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753825AbXC0L7i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 07:59:38 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 7E4DAC61A7
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 12:59:37 +0100 (BST)
Received: (qmail 8187 invoked by uid 103); 27 Mar 2007 12:59:34 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2937. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.026175 secs); 27 Mar 2007 11:59:34 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 27 Mar 2007 12:59:34 +0100
X-git-sha1: f133c83bbf07da54fcad2ea3fe450467e247a9c6 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <7vabxzrzur.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43270>

Add a simple script to create a working directory that uses symlinks
to point at an exisiting repository.  This allows having different
branches in different working directories but all from the same
repository.

Based on a description from Junio of how he creates multiple working
directories[1].  With the following caveat:

"This risks confusion for an uninitiated if you update a ref that
is checked out in another working tree, but modulo that caveat
it works reasonably well."

[1] http://article.gmane.org/gmane.comp.version-control.git/41513/

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Mon, 26 Mar 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
>> new file mode 100755
>> index 0000000..5bfd87e
>> --- /dev/null
>> +++ b/contrib/workdir/git-new-workdir
>> @@ -0,0 +1,55 @@
>> +#!/bin/bash
>
> I do not see anything bash specific you need to do in your
> script.

No.  Sorry, old habits die hard ...

>
>> +
>> +function usage () {
>> +	echo "usage:" $1;
>> +	exit 127;
>> +}
>> +
>> +function die () {
>> +	echo $1;
>> +	exit 128;
>> +}
>
> Do not add noiseword "function" in our shell scripts, please.
> This is the only thing POSIX says "produces unspecified results"
> I found in your script, so if you lose them you shouldn't have
> to say "#!/bin/bash".
>
>> +test $# -eq 3 || usage "$0 <original> <new_workdir> <branch>";
>> +
>> +orig_git=$1;
>> +new_workdir=$2;
>> +branch=$3;
>
> Perhaps default branch to whatever original's HEAD points at?

Yes, sounds good.

>
>> +
>> +# want to make sure that what is pointed to has a .git directory ...
>> +test -d ${orig_git}/.git || die "${original_git} is not a git
repository!";
>> +
>> +# don't link to a workdir, link to the original repo the workdir is
linked to
>> +if test -L ${orig_git}/.git/config
>> +then
>> +	orig_git=$(dirname $(dirname $(readlink -f gm/.git/config)));
>> +fi
>
> "gm"?  I think it is not worth doing this, as readlink is not
> all that portable.  Just see if it is a symlink and error out.

Er, quite.  Shouldn't write scripts at 02:00 ...
Didn't know readlink wasn't portable - so now I've learnt my one thing for today ... ;)

>
> Dq all pathname values you get from the user, like "$orig_git".
> They may have SP in them.

Oops.

>
> Do you need all those braces around shell variable names?

No, old habits again I'm afraid.

>
>> +# vim: tabstop=8
>> +# vim: noexpandtab
>
> Lose these two lines, please.
>

Gone.

 contrib/workdir/git-new-workdir |   57 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 contrib/workdir/git-new-workdir

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
new file mode 100755
index 0000000..9e70a59
--- /dev/null
+++ b/contrib/workdir/git-new-workdir
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+usage () {
+	echo "usage:" $@;
+	exit 127;
+}
+
+die () {
+	echo $@;
+	exit 128;
+}
+
+if test $# -lt 2 || test $# -gt 3
+then
+	usage "$0 <repository> <new_workdir> [<branch>]";
+fi
+
+orig_git=$1;
+new_workdir=$2;
+branch=$3;
+
+# want to make sure that what is pointed to has a .git directory ...
+test -d "$orig_git/.git" || die "\"$orig_git\" is not a git repository!";
+
+# don't link to a workdir
+if test -L "$orig_git/.git/config"
+then
+	die "\"$orig_git\" is a working directory only, please specify" \
+		"a complete repository.";
+fi
+
+# make sure the the links use full paths
+orig_git=$(cd "$orig_git"; pwd);
+
+# create the workdir
+mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!";
+
+# create the links to the original repo.  explictly exclude index, HEAD and
+# logs/HEAD from the list since they are purely related to the current working
+# directory, and should not be shared.
+for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache
+do
+	case $x in
+	*/*)
+		mkdir -p "$(dirname "$new_workdir/.git/$x")";
+		;;
+	esac
+	ln -s "$orig_git/.git/$x" "$new_workdir/.git/$x";
+done
+
+# now setup the workdir
+cd "$new_workdir";
+# copy the HEAD from the original repository as a default branch
+cp "$orig_git/.git/HEAD" .git/HEAD;
+# checkout the branch (either the same as HEAD from the original repository, or
+# the one that was asked for)
+git checkout -f $branch;
-- 
1.5.0.5
