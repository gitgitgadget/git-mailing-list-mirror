From: Michael Blume <blume.mike@gmail.com>
Subject: mac test failure -- 2gb clone
Date: Wed, 12 Nov 2014 13:57:49 -0800
Message-ID: <CAO2U3QjFCBqJ+_E-nyxGnm3GdwB1zJgK6d8SJ4QULQHY1D6bUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:58:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xofvc-0003aY-Su
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 22:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbaKLV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 16:58:13 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:60471 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbaKLV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 16:58:12 -0500
Received: by mail-la0-f46.google.com with SMTP id gm9so12291419lab.33
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=zV0T4MrEl5QqZ3WDegyW0q8XU3jB105D+kcQTnCxBsc=;
        b=n9qBgb6VwIHk3/OmerpY8jqClKQB+N4j9hBhfje12NKi8R3rTs08xR4ShSDvkoxd0q
         57hVIKR/7VcIftb1xyl/7M4rXkleIJM9rphUQQFy264RhhFiDRcmPD50jMNEPz7cs8Bh
         k2qjzbPi66106Npl2JBzMYpTDST2pI3MIA14eQXe7tDz7PeMm+I715+DGLQEqvF2grqZ
         AzzktacB+SG8zVBw7qmqMKQ97HdeK2trjt5XYJ968dyHFWPR8nuyL0ljLpkdhDZwAD21
         crNNOSfG1n6lCppD95DduvcB8BEDjG6oflsFEgGs1SBdtRz4/JZgtpGtEh1i1oc4Qvoq
         vipw==
X-Received: by 10.152.120.73 with SMTP id la9mr44758564lab.23.1415829490727;
 Wed, 12 Nov 2014 13:58:10 -0800 (PST)
Received: by 10.25.160.20 with HTTP; Wed, 12 Nov 2014 13:57:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is in pu, haven't checked if it's also in master, this is the
first time I've run this test

$ GIT_TEST_CLONE_2GB=t ./t5705-clone-2gb.sh -v
Initialized empty Git repository in
/Users/michael.blume/workspace/git/t/trash
directory.t5705-clone-2gb/.git/
expecting success:

git config pack.compression 0 &&
git config pack.depth 0 &&
blobsize=$((100*1024*1024)) &&
blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
i=1 &&
(while test $i -le $blobcount
do
printf "Generating blob $i/$blobcount\r" >&2 &&
printf "blob\nmark :$i\ndata $blobsize\n" &&
#test-genrandom $i $blobsize &&
printf "%-${blobsize}s" $i &&
echo "M 100644 :$i $i" >> commit
i=$(($i+1)) ||
echo $? > exit-status
done &&
echo "commit refs/heads/master" &&
echo "author A U Thor <author@email.com> 123456789 +0000" &&
echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
echo "data 5" &&
echo ">2gb" &&
cat commit) |
git fast-import --big-file-threshold=2 &&
test ! -f exit-status


git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:       5000
Total objects:           23 (         0 duplicates                  )
      blobs  :           21 (         0 duplicates          0 deltas
of          0 attempts)
      trees  :            1 (         0 duplicates          0 deltas
of          0 attempts)
      commits:            1 (         0 duplicates          0 deltas
of          0 attempts)
      tags   :            0 (         0 duplicates          0 deltas
of          0 attempts)
Total branches:           1 (         1 loads     )
      marks:           1024 (        21 unique    )
      atoms:             21
Memory total:          2344 KiB
       pools:          2110 KiB
     objects:           234 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =          2
pack_report: pack_mmap_calls          =          1
pack_report: pack_open_windows        =          1 /          1
pack_report: pack_mapped              =   54863024 /   54863024
---------------------------------------------------------------------

ok 1 - setup

expecting success:

git clone --bare --no-hardlinks . clone-bare


Cloning into bare repository 'clone-bare'...
done.
ok 2 - clone - bare

expecting success:

git clone file://. clone-wt


Cloning into 'clone-wt'...
fatal: No path specified. See 'man git-pull' for valid url syntax
not ok 3 - clone - with worktree, file:// protocol
#
#
# git clone file://. clone-wt
#
#

# failed 1 among 3 test(s)
1..3
