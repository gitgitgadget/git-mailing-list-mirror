From: "Michael O'Cleirigh" <michael.ocleirigh@utoronto.ca>
Subject: [Announce] Availability of a Java based Subversion to Git
 conversion program with automatic (and pluggable) branch detection for whole
 repository conversions
Date: Thu, 23 Oct 2014 18:47:12 +0000
Message-ID: <602AE32062A87D439B75F178A061ED20C06AB4D6@arborexmbx3.UTORARBOR.UTORAD.Utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:47:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhNPv-0001eZ-D4
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 20:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbaJWSrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2014 14:47:18 -0400
Received: from bureau81.ns.utoronto.ca ([128.100.132.181]:55379 "EHLO
	bureau81.ns.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaJWSrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2014 14:47:15 -0400
Received: from exsmtp.utoronto.ca ([128.100.46.42])
	(authenticated bits=0)
	by bureau81.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id s9NIlDUW012060
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Thu, 23 Oct 2014 14:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=utoronto.ca; s=beta;
	t=1414090034; bh=/sv9/DGgFAtGSL2bNF4nJVRAmRTtP+TV7yl/u55TbaA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=WT1Zy/Z2z1U2BjGQeENmMhDta5gDPaVJrLbYGaB0S6VC6rrwokOC2GElEITLv0XlN
	 D7ISuULSfAPCDWHVvxo+wp+jXT/I1F6mL/so4UTHHLhnEiN6UgvdrbXGgeo2JM0LZU
	 QuMO9tCKibw0M/Gw4fUDIvV6QDW+aCmgYQGqnnO8=
Received: from ARBOREXMBX3.UTORARBOR.UTORAD.Utoronto.ca
 ([fe80::c555:d3aa:a859:70d5]) by arborexhubx2.UTORARBOR.UTORAD.Utoronto.ca
 ([fe80::347f:73b7:e489:ffd0%17]) with mapi id 14.03.0181.006; Thu, 23 Oct
 2014 14:47:13 -0400
Thread-Topic: [Announce] Availability of a Java based Subversion to Git
 conversion program with automatic (and pluggable) branch detection for whole
 repository conversions
Thread-Index: Ac/u3iSX4hTh3RQnTRigslQAzb6DYAAEy3fw
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.100.46.48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

=46or the past 8 months I've been working on the process and tooling to=
 convert the Kuali Student subversion repository into Git and to suppor=
t CI on pull requests with auto merge to trunk once the builds were gre=
en and the appropriate sign-off provided.

The Kuali Student project is being restructured so my work on CI was ha=
lted but I was able to get the repository converted and placed into Git=
hub: https://github.com/kuali-student/archived-from-svn (Contains Revis=
ions r1 through r77740 in 20,631 branches and 95,297 git commits)

This work is not being officially supported by the Kuali Foundation in =
the future but I'm personally interested in seeing other projects use i=
t to convert from Subversion into Git (and find any edge cases it might=
 not be handling correctly right now)

Since our conversion was successful I wanted to alert users on both the=
 Git and JGit mailing lists about the Java based conversion program tha=
t I wrote to perform the conversion.

The code and some cursory instructions on how to use it are located her=
e: https://github.com/kuali-student/git-repository-tools, the current v=
ersion can be downloaded from maven central: http://search.maven.org/#a=
rtifactdetails|org.kuali.student.repository|git-importer|0.0.4|jar

It is intended for larger repositories like kuali student with around 1=
00,000 or more revisions with many product streams and questionable at =
times branch naming strategies; instead of enumerating which branches y=
ou want this conversion program will extract everything.=A0=20

You can specify a per repository branch detection strategy to handle no=
n-standard cases so that looking back in the history things will make m=
ore sense, but it shouldn't be needed to get an accurate repository. =A0=
=A0

Key features:

=2E Full repository conversion by parsing Subversion version 2 dump str=
eams and writing into a bare Git repository.

=2E Automatic branch detection=20
o We figure out how to split the full path to a blob into a branch part=
 and file part.=A0 The branch part becomes the name of the branch and t=
he file part turns into the Tree object of the commit.
o We track copy-from information similar I think to how git-svn does so=
 that for each subversion revision we have a list of all of the git bra=
nches and their heads at that point in time.
o We convert everything but if the branch naming is non-standard you ca=
n have branches created with subdirectories that really should have bee=
n separate branches themselves.

=2E Plugin Mechanism to define custom per repository branch detection (=
before falling back on the standard mechanisms)
o See how the student-plugin(https://github.com/kuali-student/git-repos=
itory-tools/tree/master/git-importer-student-plugin) was setup with its=
 own custom branch detection logic (lots of conversion iterations in th=
at scheme)=A0=20
o Also look at how unit testing can be done on the repository specific =
branch scenarios.

=2E Fusion instead of submodules for svn:externals
o The fusion-maven-plugin was created and its fuse mojo will do essenti=
ally a multi subtree merge to turn the aggregate branch (the one where =
the svn:externals property was set) into a commit whose tree contains a=
ctual materialized subdirectories with the tree of the module branch pl=
aced within it.
o The git-importer would leave fusion-maven-plugin.dat files in the roo=
t of the commit tree's where in svn there had been svn:externals set so=
 that this fusion process could be applied at a later point in time.

=2E Fairly fast
o Creating the subversion mirror and dump files can take some time
o The KS svn repository mirror was 8.8 GB but that turned into about 20=
 GB using bzip2 compressed subversion version 2 dump streams
o Running against the existing dump files it would take the importer ab=
out 12 hours to perform the full conversion on a low end core 2 duo (3G=
hz) writing on a raid-0 7200 RPM disk drive.=A0=20

=2E Accurate
o I compared our key release tags and development branches by doing an =
subversion export of the particular equivalent of the git branch (based=
 on the path and revision in the comment) and added into git and then d=
id a git diff to make sure there are no differences (and when I found d=
ifferences I tracked them down and added unit tests to reproduce and fi=
xed them).


Additional Cleanup Programs:

The git-repository-tools repository also includes the cleanup programs =
we used https://github.com/kuali-student/git-repository-tools/tree/mast=
er/git-repo-cleaner:

Our initial converted repo was 2.8 GB (final was 1.3 GB) so we looked a=
t splitting the graph based on date and then using git grafts to give d=
evelopers the full history.=A0 The splitting program would find the spl=
it point and write a grafts file for later use.

But we found out that a certain kind of database file was taking up a l=
ot of space (over 50% of the converted repository) so instead of splitt=
ing we did three cleanup operations:
1. Remove the content of all .mpx database files (sql files built a db =
which then dumped out csv files stored in files ending in .mpx which is=
 what we removed)
2. Remove two big files, one of them > 100 MB which was blocking the gi=
thub upload.
3. Rewrite all of the commits rewritten in steps 1 and 2 to update the =
fusion-maven-plugin.dat files generated by the exporter to use the late=
st commit ids (so that fusion would work)

Step 3 was interesting because the fusion-maven-plugin.dat files contai=
ned essentially extra parentage information so we needed to sort the li=
st of 95,297 commits in such a way that real and fusion parents were em=
itted first.=A0=A0 I was able to use the EWAH Compressed bitmap for thi=
s purpose (I used the EWAH bitmaps directly but was inspired by the jgi=
t packfile bitmap implementation).

The https://github.com/kuali-student/git-repository-tools/blob/master/g=
it-repo-cleaner/src/main/java/org/kuali/student/git/cleaner/AbstractRep=
ositoryCleaner.java class can be extended to support other use cases.

It loads all of the commits in the repository in a parents first orderi=
ng and then provides hooks to do different things.=A0 It takes care of =
updating the branch and tag references to point at the rewritten commit=
s.

All of this code is licensed under the Educational Community License, V=
ersion 2.0 (An add on to the Apache licence, Version 2.0).

Hopefully it will be useful to others,=20

Regards,=20

Michael

--
Michael O'Cleirigh
Java Developer=20
Enterprise Applications and Solutions Integration (EASI)
University of Toronto
