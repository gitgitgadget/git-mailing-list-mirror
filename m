From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Wed, 23 Sep 2015 10:50:58 +0200
Message-ID: <A29B974F-2B42-475F-92B6-8B25A54FCDEE@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com> <CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 10:51:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zeflg-0001IO-E4
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 10:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbbIWIvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 04:51:05 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37896 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbbIWIvB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 04:51:01 -0400
Received: by wiclk2 with SMTP id lk2so58656102wic.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aXDoPIuPy5ajxQqPr9+H5LvHcLSANciYlQ0WPukeCIE=;
        b=0YIpMQkF9zAn1gppzRBAyaTVIPnXikjE3PPvYB1AJp889nYeBb4xEABq31DTnjH2ho
         76EEpnwfcIMVxkMhbniV7FOsK/fZUOdPWdANjW3IChtzd7jYwV4Ndo/FV1Ffukip0kDQ
         s9Er4zE339E4jj6UuTuIxk2+KFl6udVOM11iNB2SnlKHpeAnxWTOUU0alwgyROovku7p
         rr36HZknMumT53FNSg6i5uP5w/hlqL9HxY0btF/+tH3+3J/Y8JNTq36aAfLBkSM20C0v
         JkX2QZzH9j+/Ud3So67GpfM+d+1uB3JEeWGUWIYCggTn8rZbVWZWa0F531P5JHHC8hvy
         Yc9A==
X-Received: by 10.180.198.178 with SMTP id jd18mr2782511wic.34.1442998260310;
        Wed, 23 Sep 2015 01:51:00 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm6083417wjb.32.2015.09.23.01.50.59
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 01:50:59 -0700 (PDT)
In-Reply-To: <CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278477>


On 23 Sep 2015, at 10:18, Lars Schneider <larsxschneider@gmail.com> wro=
te:

>=20
> On 23 Sep 2015, at 09:58, Luke Diamand <luke@diamand.org> wrote:
>=20
>> On 21 September 2015 at 23:41,  <larsxschneider@gmail.com> wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>> diff to v6:
>>> * fix spaces in .gitattributes for Git-LFS files (old "[:space:]", =
new "[[:space:]]")
>>> * generated patch on top of next (95c4325) to resolve merge conflic=
ts
>>=20
>> Trying this out by hand (rather than using the test cases) it crashe=
s
>> for me. Am I doing something wrong?
>>=20
>> - I've got the version of git-p4.py from
>> ef93b8df71f6d8a7936786c989714868c2d3540c in Junio's ls/p4-lfs branch=
=2E
>> - I have git-lfs v0.60 (just downloaded the binary distribution).
>>=20
>> Then I created a p4 repo, and added two files in Perforce, small.txt
>> and bigfile. bigfile is 400k.
>>=20
>> Doing a regular git clone works fine:
>>=20
>> $ mkdir depot
>> $ cd depot
>> $ git init .
>> $ git p4 sync //depot
>> $ git checkout p4/master
>>=20
>> (I'm using git init + git sync rather than git clone so that I can
>> setup the git config variables I need in the next step).
>>=20
>> Doing a clone with LFS support though doesn't work:
>>=20
>> $ mkdir depot2
>> $ cd depot2
>> $ git init
>> $ git config git-p4.largeFileSystem GitLFS
>> $ git config git-p4.largeFileThreshold 100k
>> $ git p4 sync //depot
>> Doing initial import of //depot/ from revision #head into refs/remot=
es/p4/master
>> Traceback (most recent call last):
>> File "/home/ldiamand/git/git/git-p4.py", line 3624, in <module>
>>   main()
>> File "/home/ldiamand/git/git/git-p4.py", line 3618, in main
>>   if not cmd.run(args):
>> File "/home/ldiamand/git/git/git-p4.py", line 3298, in run
>>   self.importHeadRevision(revision)
>> File "/home/ldiamand/git/git/git-p4.py", line 3085, in importHeadRev=
ision
>>   self.commit(details, self.extractFilesFromCommit(details), self.br=
anch)
>> File "/home/ldiamand/git/git/git-p4.py", line 2651, in commit
>>   self.streamP4Files(new_files)
>> File "/home/ldiamand/git/git/git-p4.py", line 2565, in streamP4Files
>>   cb=3DstreamP4FilesCbSelf)
>> File "/home/ldiamand/git/git/git-p4.py", line 501, in p4CmdList
>>   cb(entry)
>> File "/home/ldiamand/git/git/git-p4.py", line 2559, in streamP4Files=
CbSelf
>>   self.streamP4FilesCb(entry)
>> File "/home/ldiamand/git/git/git-p4.py", line 2501, in streamP4Files=
Cb
>>   self.streamOneP4File(self.stream_file, self.stream_contents)
>> File "/home/ldiamand/git/git/git-p4.py", line 2451, in streamOneP4Fi=
le
>>   (git_mode, contents) =3D
>> self.largeFileSystem.processContent(self.cloneDestination, git_mode,
>> relPath, contents)
>> File "/home/ldiamand/git/git/git-p4.py", line 1111, in processConten=
t
>>   return LargeFileSystem.processContent(self, cloneDestination,
>> git_mode, relPath, contents)
>> File "/home/ldiamand/git/git/git-p4.py", line 1004, in processConten=
t
>>   (git_mode, contents, localLargeFile) =3D
>> self.generatePointer(cloneDestination, contentTempFile)
>> File "/home/ldiamand/git/git/git-p4.py", line 1068, in generatePoint=
er
>>   oid,
>> File "/usr/lib/python2.7/posixpath.py", line 70, in join
>>   elif path =3D=3D '' or path.endswith('/'):
>> AttributeError: 'NoneType' object has no attribute 'endswith'
>>=20
> Confirmed. This is a bug!
>=20
> Can you try the following sequence of commands?
>=20
> $ mkdir depot2
> $ cd depot2
> $ git init
> $ git config git-p4.largeFileSystem GitLFS
> $ git config git-p4.largeFileThreshold 100k
> $ git p4 clone --destination=3D. //depot
>=20
> I=92ve always used =93clone=94 and all test cases uses =93clone=94. I=
 will fix it for =93sync=94.
>=20
> Thanks for reporting,
> Lars

I think I found an easy fix. Can you try it?

(in case my mail app messes something up: I changed line 2240 in git-p4=
=2Epy to 'self.cloneDestination =3D os.getcwd()=92)

Thanks,
Lars


diff --git a/git-p4.py b/git-p4.py
index 8c7496d..1d1bb87 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2237,7 +2237,7 @@ class P4Sync(Command, P4UserMap):
         self.tempBranches =3D []
         self.tempBranchLocation =3D "git-p4-tmp"
         self.largeFileSystem =3D None
-        self.cloneDestination =3D None
+        self.cloneDestination =3D os.getcwd()

         if gitConfig('git-p4.largeFileSystem'):
             largeFileSystemConstructor =3D globals()[gitConfig('git-p4=
=2ElargeFileSystem')]
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 7385a2b..6d374c0 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -86,6 +86,35 @@ test_expect_success 'Store files in LFS based on siz=
e (>24 bytes)' '
        )
 '

+test_expect_success 'Store files in LFS based on size (>24 bytes) and =
use git p4 sync and no client spec' '
+       test_when_finished cleanup_git &&
+       (
+               cd "$git" &&
+               git init . &&
+               git config git-p4.largeFileSystem GitLFS &&
+               git config git-p4.largeFileThreshold 24 &&
+               git p4 sync //depot &&
+               git checkout p4/master
+               test_file_in_lfs file2.dat 25 "content 2-3 bin 25 bytes=
" &&
+               test_file_in_lfs "path with spaces/file3.bin" 25 "conte=
nt 2-3 bin 25 bytes" &&
+               test_file_in_lfs file4.bin 26 "content 4 bin 26 bytes X=
X" &&
+
+               test_file_count_in_dir ".git/lfs/objects" 2 &&
+
+               cat >expect <<-\EOF &&
+
+               #
+               # Git LFS (see https://git-lfs.github.com/)
+               #
+               /file2.dat filter=3Dlfs -text
+               /file4.bin filter=3Dlfs -text
+               /path[[:space:]]with[[:space:]]spaces/file3.bin filter=3D=
lfs -text
+               EOF
+               test_path_is_file .gitattributes &&
+               test_cmp expect .gitattributes
+       )
+'
+
 test_expect_success 'Store files in LFS based on size (>25 bytes)' '
        client_view "//depot/... //client/..." &&
        test_when_finished cleanup_git &&
