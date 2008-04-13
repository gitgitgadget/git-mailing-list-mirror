From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] Calculate lines changed for cvs log command
Date: Sun, 13 Apr 2008 17:27:18 +0200
Message-ID: <3F0821AA-C11D-4C42-A415-D346A7CD89F8@nocrew.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-72-12488030
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 17:28:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl47w-0004KP-QE
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 17:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbYDMP1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 11:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbYDMP1W
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 11:27:22 -0400
Received: from mail.visit.se ([85.194.0.110]:48633 "EHLO mail.visit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017AbYDMP1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 11:27:22 -0400
Received: by mail.visit.se (Postfix, from userid 503)
	id C37B636E0319; Sun, 13 Apr 2008 17:27:38 +0200 (CEST)
Received: from [10.0.1.2] (cust.dsl-fiber-lan.snet.lk.85.194.37.51.visit.se [85.194.37.51])
	by mail.visit.se (Postfix) with ESMTP id 0200336E0319;
	Sun, 13 Apr 2008 17:27:36 +0200 (CEST)
X-Mailer: Apple Mail (2.919.2)
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on mail.visit.se
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79410>


--Apple-Mail-72-12488030
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

Attached patch attempts to report the correct lines changed when using  
the cvs log command with cvsserver. Is there any performance impact  
using "git-log -1 --shortstat <object>" instead of "git-cat-file  
commit <object>"?

(Also, it would be nice if git-log --pretty=format:XXX could display  
diff information such as shortstat, to make parsing more robust.)

Previously, cvs log reported "+2 -3" for all commits. This patch  
reports real values except when the commit is fetched from the SQLite  
DB, which remains "+2 -3" at all times.

(My mailer destroys inline patches, so I'm attaching it. Sorry about  
that.)

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
  git-cvsserver.perl |   32 ++++++++++++++++++++++----------
  1 files changed, 22 insertions(+), 10 deletions(-)


--Apple-Mail-72-12488030
Content-Disposition: attachment;
	filename=0001-Calculate-lines-changed-for-cvs-log-command.patch
Content-Type: application/octet-stream;
	x-unix-mode=0664;
	name="0001-Calculate-lines-changed-for-cvs-log-command.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=206ff024e5238e52f4b61226187ffa2d21b99fe081=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Fredrik=20Noring=20<noring@nocrew.org>=0ADate:=20=
Sun,=2013=20Apr=202008=2016:54:40=20+0200=0ASubject:=20[PATCH]=20=
Calculate=20lines=20changed=20for=20cvs=20log=20command=0A=0APreviously,=20=
"+2=20-3"=20was=20reported=20for=20all=20commits.=20This=20patch=20=
reports=0Alines=20changed=20except=20when=20the=20commit=20is=20fetched=20=
from=20the=20SQLite=20DB=0A(which=20remains=20"+2=20-3"=20at=20all=20=
times).=0A=0ASigned-off-by:=20Fredrik=20Noring=20<noring@nocrew.org>=0A=
---=0A=20git-cvsserver.perl=20|=20=20=2032=20=
++++++++++++++++++++++----------=0A=201=20files=20changed,=2022=20=
insertions(+),=2010=20deletions(-)=0A=0Adiff=20--git=20=
a/git-cvsserver.perl=20b/git-cvsserver.perl=0Aindex=2029dbfc9..5d31a95=20=
100755=0A---=20a/git-cvsserver.perl=0A+++=20b/git-cvsserver.perl=0A@@=20=
-1729,8=20+1729,9=20@@=20sub=20req_log=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20#=20reformat=20the=20date=20for=20log=20output=0A=20=20=20=20=20=20=
=20=20=20=20=20=20=20$revision->{modified}=20=3D=20=
sprintf('%04d/%02d/%02d=20%s',=20$3,=20$DATE_LIST->{$2},=20$1,=20$4=20)=20=
if=20(=20$revision->{modified}=20=3D~=20/(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/=20=
and=20defined($DATE_LIST->{$2})=20);=0A=20=20=20=20=20=20=20=20=20=20=20=20=
=20$revision->{author}=20=3D=20cvs_author($revision->{author});=0A-=20=20=
=20=20=20=20=20=20=20=20=20=20print=20"M=20date:=20=
$revision->{modified};=20=20author:=20$revision->{author};=20=20state:=20=
"=20.=20(=20$revision->{filehash}=20eq=20"deleted"=20?=20"dead"=20:=20=
"Exp"=20)=20.=20";=20=20lines:=20+2=20-3\n";=0A-=20=20=20=20=20=20=20=20=20=
=20=20=20my=20$commitmessage=20=3D=20=
$updater->commitmessage($revision->{commithash});=0A+=20=20=20=20=20=20=20=
=20=20=20=20=20(=20my=20$commitmessage,=20my=20$lines_changed=20)=20=3D=0A=
+=09=09$updater->commitinfo($revision->{commithash});=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20print=20"M=20date:=20$revision->{modified};=20=20=
author:=20$revision->{author};=20=20state:=20"=20.=20(=20=
$revision->{filehash}=20eq=20"deleted"=20?=20"dead"=20:=20"Exp"=20)=20.=20=
";=20=20lines:=20"=20.=20$lines_changed=20.=20"\n";=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20$commitmessage=20=3D~=20s/^/M=20/mg;=0A=20=20=20=20=20=20=
=20=20=20=20=20=20=20print=20$commitmessage=20.=20"\n";=0A=20=20=20=20=20=
=20=20=20=20}=0A@@=20-3023,12=20+3024,13=20@@=20sub=20getmeta=0A=20=20=20=
=20=20return=20$db_query->fetchrow_hashref;=0A=20}=0A=20=0A-=3Dhead2=20=
commitmessage=0A+=3Dhead2=20commitinfo=0A=20=0A-this=20function=20takes=20=
a=20commithash=20and=20returns=20the=20commit=20message=20for=20that=20=
commit=0A+this=20function=20takes=20a=20commithash=20and=20returns=20the=20=
commit=20message=20and=0A+lines=20changed=20for=20that=20commit=0A=20=0A=20=
=3Dcut=0A-sub=20commitmessage=0A+sub=20commitinfo=0A=20{=0A=20=20=20=20=20=
my=20$self=20=3D=20shift;=0A=20=20=20=20=20my=20$commithash=20=3D=20=
shift;=0A@@=20-3045,14=20+3047,24=20@@=20sub=20commitmessage=0A=20=20=20=20=
=20if=20(=20defined=20(=20$message=20)=20)=0A=20=20=20=20=20{=0A=20=20=20=
=20=20=20=20=20=20$message=20.=3D=20"=20"=20if=20(=20$message=20=3D~=20=
/\n$/=20);=0A-=20=20=20=20=20=20=20=20return=20$message;=0A+=20=20=20=20=20=
=20=20=20return=20(=20$message,=20"+2=20-3"=20);=20=20=20#=20FIXME:=20=
What's=20the=20real=20lines=20changed?=0A=20=20=20=20=20}=0A=20=0A-=20=20=
=20=20my=20@lines=20=3D=20safe_pipe_capture("git-cat-file",=20"commit",=20=
$commithash);=0A-=20=20=20=20shift=20@lines=20while=20(=20$lines[0]=20=3D~=
=20/\S/=20);=0A-=20=20=20=20$message=20=3D=20join("",@lines);=0A+=20=20=20=
=20my=20@lines=20=3D=20safe_pipe_capture("git-log",=20"-1",=20=
"--pretty=3Dformat:%s%n%b",=0A+=09=09=09=09=20=20"--shortstat",=20=
$commithash);=0A+=20=20=20=20my=20$files_changed=20=3D=200;=0A+=20=20=20=20=
my=20$insertions=20=3D=200;=0A+=20=20=20=20my=20$deletions=20=3D=200;=0A=
+=20=20=20=20(=20$files_changed,=20$insertions,=20$deletions=20)=20=3D=20=
(=20$lines[-1]=20=3D~=20/=20(\d+)=20files=20changed,=20(\d+)=20=
insertions.*,=20(\d+)=20deletions/=20);=0A+=20=20=20=20if=20(=20=
$files_changed=20)=0A+=20=20=20=20{=0A+=09pop(@lines);=20=20=20#=20=
Remove=20shortstat=0A+=09pop(@lines);=20=20=20#=20Remove=20extra=20=
newline=20prior=20to=20shortstat=0A+=20=20=20=20}=0A+=20=20=20=20=
map(s/\n$//s,=20@lines);=0A+=20=20=20=20$message=20=3D=20join("\n",=20=
@lines);=0A=20=20=20=20=20$message=20.=3D=20"=20"=20if=20(=20$message=20=
=3D~=20/\n$/=20);=0A-=20=20=20=20return=20$message;=0A+=20=20=20=20=
return=20(=20$message,=20sprintf("+%d=20-%d",=20$insertions,=20=
$deletions)=20);=0A=20}=0A=20=0A=20=3Dhead2=20gethistory=0A--=20=0A=
1.5.5.40.g4cdda.dirty=0A=0A=

--Apple-Mail-72-12488030
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-72-12488030--
