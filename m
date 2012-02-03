From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Deal with HEAD pointing to unborn branch in "heads"  view
Date: Fri, 3 Feb 2012 22:33:05 +0100
Message-ID: <201202032233.05324.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201201302008.48421.jnareb@gmail.com> <CA+EqV8y3dhR8+PJbMxMNEsGjDOx6dxtPYjn8kDvAZxCAO7iS5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtQkt-0003S1-Hr
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab2BCVdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 16:33:10 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45898 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab2BCVdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:33:08 -0500
Received: by eekc14 with SMTP id c14so1296263eek.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TogvOICX6P8MJO+GlmO08tXosK0aGs74eZrWmWiG9Bw=;
        b=MnlDLJfdG7fscends5ji6IPFCtyJVOtsTRAwK7OjF331joNq+gdGyd6h0dxS208U96
         BxHEDNR/TFYyJIuizaFXkeTxXlIHSpoQe5uHGB6BD7F3tlmIvPgwHeFIHTSswUC1UGeL
         mWC6CGCkx45osL/KusZNjqWJnNDlytzvCee/Q=
Received: by 10.14.28.134 with SMTP id g6mr2818542eea.15.1328304787214;
        Fri, 03 Feb 2012 13:33:07 -0800 (PST)
Received: from [192.168.1.13] (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id n56sm26443429eeh.6.2012.02.03.13.33.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 13:33:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8y3dhR8+PJbMxMNEsGjDOx6dxtPYjn8kDvAZxCAO7iS5w@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189805>

On Mon, 30 Jan 2012, rajesh boyapati wrote:
>=20
> Thank you for your Suggestions in finding the error in my case.
> Do you have a blog, so that, I can know your updates about gitweb.

No, I don't have a blog, though I might use Git page on Google+ to
announce larger changes. =20

I am posting this to you to announce partial fix for your problem
in the form of patch to gitweb, which would hopefully made it to
next git version.

> 2012/1/30 Jakub Narebski <jnareb@gmail.com>
>> On Mon, 30 Jan 2012, rajesh boyapati wrote:
>>> 2012/1/28 Jakub Narebski <jnareb@gmail.com>
>>>> On Fri, 27 Jan 2012, rajesh boyapati wrote:

>>>>>     my $alternate =3D 1;
>>>>>     for (my $i =3D $from; $i <=3D $to; $i++) {
>>>>>         my $entry =3D $headlist->[$i];
>>>>>         my %ref =3D %$entry;
>>>>>         my $curr =3D $ref{'id'} eq $head;
>>>>>         if ($alternate) {
>>>>>             print "<tr class=3D\"dark\">\n";
>>>>>         } else {
>>>>>             print "<tr class=3D\"light\">\n";
>>>>>         }
>>>>>         $alternate ^=3D 1;
>>>>
>>>> Hmmmm... I see that we do not check if $head is defined here befor=
e using
>>>> it.  This can happen legitimately if we are on yet to be born orph=
an branch
>>>> (so $head, which should be named $head_at, is undefined) but there=
 exist
>>>> other branches (so $headlist is not empty).

This was simple to fix.

>>>>>>> [2012-01-25 18:50:35,658] ERROR
>>>>>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
>>>>>>> 18:50:35 2012] gitweb.cgi: Use of uninitialized value $commit_i=
d
>>>>>>> in open at /usr/lib/cgi-bin/gitweb.cgi line 2817.

>>>>> sub parse_commits {
>>>>> =A0 =A0 my ($commit_id, $maxcount, $skip, $filename, @args) =3D @=
_;
>>>>> =A0 =A0 my @cos;
>>>>>
>>>>> =A0 =A0 $maxcount ||=3D 1;
>>>>> =A0 =A0 $skip ||=3D 0;
>>>>>
>>>>> =A0 =A0 local $/ =3D "\0";
>>>>>
>>>>> =A0 =A0 open my $fd, "-|", git_cmd(), "rev-list",
>>>>> =A0 =A0 =A0 =A0 "--header",
>>>>> =A0 =A0 =A0 =A0 @args,
>>>>> =A0 =A0 =A0 =A0 ("--max-count=3D" . $maxcount),
>>>>> =A0 =A0 =A0 =A0 ("--skip=3D" . $skip),
>>>>> =A0 =A0 =A0 =A0 @extra_options,
>>>>> =A0 =A0 =A0 =A0 $commit_id,
>>>>> =A0 =A0 =A0 =A0 "--",
>>>>> =A0 =A0 =A0 =A0 ($filename ? ($filename) : ())
>>>>> =A0 =A0 =A0 =A0 or die_error(500, "Open git-rev-list failed");

But I was not able to fix this, at least not currently.  I wrote a fail=
ing
test case for "commit" and similar views on unborn HEAD... but they fai=
l
_without_ error message like the one quoted.

I'd have to go slower route of examining gitweb code in how it deals wi=
th
"invalid" HEAD (i.e. HEAD not pointing to commit, being on unborn branc=
h).

>>> For my git projects on gerrit, our main branch name is "base".
>>> We don't have any code on "master" branch.
>>> May be the $HEAD is looking for master branch(or checked out branch=
 in git
>>> project).--> In our case, "master" is an empty branch.
>>> Also, In the git projects, the HEAD file is pointing to "ref:
>>> refs/heads/master".
>>> So, I think that's the reason for errors.
>>>
>>> How can I make $HEAD to point to a branch other than "master"?.
>>>   a) I can do this by pointing HEAD file in git projects to other b=
ranch
>> [...]
>>>   b) Is there any way, other than doing above step (a) ?.
>>>      I mean I don't want to have a code on "master" branch and also=
 I
>>>      don't want to point HEAD file in git projects to some other br=
anch.
>>>      Do I need to make any modifications to "gitweb.cgi" for this?
>>
>> Now that I know the source of this error, I can write test case
>> for it, and fix it.  I'll try to do it soon.
>>
>> So finally what you would need for (b) is just upgrade gitweb.

And here is the patch:
-- >8 ------------ >8 ---
=46rom: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Deal with HEAD pointing to unborn branch in "h=
eads"
 view

Gitweb has problems if HEAD points to an unborn branch, with no
commits on it yet, but there are other branches present (so it is not
newly initialized repository).

This can happen if non-bare repository (with default 'master' branch)
is updated not via committing but by other means like push to it, or
Gerrit.  It can happen also just after running "git checkout --orphan
<new branch>" but before creating any new commit on this branch.

This commit adds test and fixes the issue of being on unborn branch
(of HEAD not pointing to a commit) in "heads" view, and also in
"summary" view -- which includes "heads" excerpt as subview.

While at it rename local variable $head to $head_at, as it points to
current commit rather than current branch name (HEAD contents).

Reported-by: rajesh boyapati <boyapatisrajesh@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                     |    4 ++--
 t/t9500-gitweb-standalone-no-errors.sh |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..1f0ec12 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5570,7 +5570,7 @@ sub git_tags_body {
=20
 sub git_heads_body {
 	# uses global variable $project
-	my ($headlist, $head, $from, $to, $extra) =3D @_;
+	my ($headlist, $head_at, $from, $to, $extra) =3D @_;
 	$from =3D 0 unless defined $from;
 	$to =3D $#{$headlist} if (!defined $to || $#{$headlist} < $to);
=20
@@ -5579,7 +5579,7 @@ sub git_heads_body {
 	for (my $i =3D $from; $i <=3D $to; $i++) {
 		my $entry =3D $headlist->[$i];
 		my %ref =3D %$entry;
-		my $curr =3D $ref{'id'} eq $head;
+		my $curr =3D defined $head_at && $ref{'id'} eq $head_at;
 		if ($alternate) {
 			print "<tr class=3D\"dark\">\n";
 		} else {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-st=
andalone-no-errors.sh
index 0f771c6..81246a6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -739,4 +739,13 @@ test_expect_success \
 	'echo "\$projects_list_group_categories =3D 1;" >>gitweb_config.perl =
&&
 	 gitweb_run'
=20
+# --------------------------------------------------------------------=
--
+# unborn branches
+
+test_expect_success \
+	'unborn HEAD: "summary" page (with "heads" subview)' \
+	'git checkout orphan_branch || git checkout --orphan orphan_branch &&
+	 test_when_finished "git checkout master" &&
+	 gitweb_run "p=3D.git;a=3Dsummary"'
+
 test_done
--=20
1.7.9
