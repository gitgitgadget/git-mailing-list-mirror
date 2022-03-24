Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D3AC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 14:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348500AbiCXOvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbiCXOve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 10:51:34 -0400
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 07:50:02 PDT
Received: from ms11p00im-hyfv17281201.me.com (ms11p00im-hyfv17281201.me.com [17.58.38.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41703A775F
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1648133017;
        bh=Jd1A9BubGRNn58V5yB7iSmYsW/mXpUjCd91UiAdhuzg=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=uuhTWM9CAi++3Coe66PNuNN5xZrwS1n5HFJFHcx6CvlOZUszt9Z9g1MfmrMI37cc/
         xKN3pOUzM05aqd3Cd9gJ6fEpy2wL+FxlUoIegNMY4SHCNrcnyFD0Yhlr1SmqU4vvRn
         l+zZHyLp3WGBTnvQeTugFL3cNZzL6Z6NEcKrhXy7dw28mu6FGgZgupHN3I9ONRoB9n
         1R4jl8GAP1EeAyexnOwi61x5EJDvIrZqa12BYuBKP2MJN+mFhOER7gKxzZFl37e7F+
         d9A6IC28eKbjlCuiLUqLSWaqpjS7cbEGCWb1MYnK4+JEpF3V4U40lSc52mhvneaomb
         1zQOD6llKTIcA==
Received: from max-mbp-1449.fritz.box (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-hyfv17281201.me.com (Postfix) with ESMTPS id F16AAC8058C
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:43:36 +0000 (UTC)
From:   Maximilian Reichel <reichemn@icloud.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_6E1FDBB5-1FBA-4F6F-8D83-521F102B85AA"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: git reset --merge random behavior
Message-Id: <84FF8F9A-3A9A-4F2A-8D8E-5D50F2F06203@icloud.com>
Date:   Thu, 24 Mar 2022 15:43:33 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=985
 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2203240084
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_6E1FDBB5-1FBA-4F6F-8D83-521F102B85AA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following script (test.sh) multiple times:

 ```
 #!/bin/bash
GIT_TRACE=3Dtrue
export GIT_TRACE

mkdir gitDir0
cd gitDir0
env git -c init.defaultBranch=3Dmaster init=20
echo bar > bar.txt
env git add -v bar.txt=20
env git -c user.name=3D"P" -c user.email=3D"e@mail.com" commit -v -m =
first=20

mkdir ../gitDir2
cd ../gitDir2
env git -c init.defaultBranch=3Dmaster init=20
env git pull -v --set-upstream ../gitDir0=20
echo foo > foo.txt
env git add -v foo.txt=20
env git mv -v -f -- foo.txt bar.txt=20
env git reset --merge HEAD
```

What did you expect to happen? (Expected behavior)
I expect that the script shows the same behavior on every execution.

What happened instead? (Actual behavior)
I encountered two different behaviors (random):
1. Most of the time the git reset command succeeds and the file =
gitDir2/bar.txt contains the string "bar" after running the script.
2. Sometimes the git reset command fails and the file gitDir2/bar.txt =
contains the string "foo" after running the script.
In this case, the reset command produces the following output:
```
error: Entry 'bar.txt' not uptodate. Cannot merge.
fatal: Could not reset index file to revision 'HEAD'.
```
The full console output of both cases is attached to this mail, but they =
only really differ in this error message.

Anything else you want to add:
I could observe this behavior on git 2.35.1 and 2.34.1.
The behavior is not affected by whether GIT_TRACE is set.

I wrote a script that executes this test script repeatedly and keeps =
track of the possible outcomes of the gitDir2/bar.txt file.
It will print a line each time the content differs from the previous =
execution.
This script is attached to this mail (runner.sh).
Sample output of this script:
```
execution #0 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: =
Thu Mar 24 13:22:17 UTC 2022
execution #203 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: =
Thu Mar 24 13:22:29 UTC 2022
execution #204 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: =
Thu Mar 24 13:22:29 UTC 2022
execution #264 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: =
Thu Mar 24 13:22:32 UTC 2022
execution #265 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: =
Thu Mar 24 13:22:32 UTC 2022
execution #432 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: =
Thu Mar 24 13:22:40 UTC 2022
execution #433 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: =
Thu Mar 24 13:22:40 UTC 2022
execution #489 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: =
Thu Mar 24 13:22:43 UTC 2022
```


[System Info]
git version:
git version 2.35.1
cpu: x86_64
built from commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show

--Apple-Mail=_6E1FDBB5-1FBA-4F6F-8D83-521F102B85AA
Content-Disposition: attachment;
	filename=runner.sh
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="runner.sh"
Content-Transfer-Encoding: 7bit

#!/bin/bash
outputs_dir=outputs
script=test.sh
work_dir=workDir
observed_file=gitDir2/bar.txt

mkdir -p "$work_dir"
mkdir -p "$outputs_dir"
i=0
last_hash=
trap "exit 0" INT
while true; do
    (   # prepare work dir
        rm -rf $work_dir && 
        mkdir $work_dir && 
        cp $script $work_dir/$script &&
        cd $work_dir &&
        ./$script # execute script
    ) > consoleOut.txt 2>&1
    hash=$(md5sum <${work_dir}/$observed_file | tr -cd '[:alnum:]') # use md5 instead of md5sum on macOS
    if [ "$hash" != "$last_hash" ]; then
        # report when file content has changed
        printf  "execution #%d \t hash: %s \t date: %s\n" $i "$hash" "$(date)"
        if [ ! -d "${outputs_dir}/${hash}/" ]; then
            # copy working dir and console output to output dir
            cp -r ${work_dir} "${outputs_dir}/${hash}"
            cp ${work_dir}/$observed_file "${outputs_dir}/${hash}.txt"
            cp consoleOut.txt "${outputs_dir}/${hash}"
        fi
    fi
    last_hash=$hash
    ((i=i+1))
done
--Apple-Mail=_6E1FDBB5-1FBA-4F6F-8D83-521F102B85AA
Content-Disposition: attachment;
	filename=case2ConsoleOut.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="case2ConsoleOut.txt"
Content-Transfer-Encoding: quoted-printable

13:05:42.974156 git.c:458               trace: built-in: git init
warning: templates not found in /usr/local/share/git-core/templates
Initialized empty Git repository in /test2/workDir/gitDir0/.git/
13:05:42.976995 git.c:458               trace: built-in: git add -v =
bar.txt
add 'bar.txt'
13:05:42.979187 git.c:458               trace: built-in: git commit -v =
-m first
13:05:42.980431 run-command.c:654       trace: run_command: git =
maintenance run --auto --no-quiet
13:05:42.981375 git.c:458               trace: built-in: git maintenance =
run --auto --no-quiet
[master (root-commit) 4165aea] first
 1 file changed, 1 insertion(+)
 create mode 100644 bar.txt
13:05:42.984917 git.c:458               trace: built-in: git init
warning: templates not found in /usr/local/share/git-core/templates
Initialized empty Git repository in /test2/workDir/gitDir2/.git/
13:05:42.987933 git.c:458               trace: built-in: git pull -v =
--set-upstream ../gitDir0
13:05:42.988098 run-command.c:654       trace: run_command: git fetch =
--update-head-ok -v --set-upstream ../gitDir0
13:05:42.989104 git.c:458               trace: built-in: git fetch =
--update-head-ok -v --set-upstream ../gitDir0
13:05:42.989301 run-command.c:654       trace: run_command: unset =
GIT_PREFIX; GIT_PROTOCOL=3Dversion=3D2 'git-upload-pack =
'\''../gitDir0'\'''
13:05:42.990794 git.c:458               trace: built-in: git upload-pack =
../gitDir0
13:05:42.991782 run-command.c:654       trace: run_command: git =
pack-objects --revs --thin --stdout --delta-base-offset
remote: 13:05:42.992962 git.c:458               trace: built-in: git =
pack-objects --revs --thin --stdout --delta-base-offset       =20
13:05:42.993799 run-command.c:654       trace: run_command: git =
unpack-objects -q --pack_header=3D2,3
13:05:42.995006 git.c:458               trace: built-in: git =
unpack-objects -q --pack_header=3D2,3
13:05:42.995872 run-command.c:654       trace: run_command: git rev-list =
--objects --stdin --not --all --quiet --alternate-refs
13:05:42.996906 git.c:458               trace: built-in: git rev-list =
--objects --stdin --not --all --quiet --alternate-refs
=46rom ../gitDir0
 * branch            HEAD       -> FETCH_HEAD
13:05:42.998066 run-command.c:1582      run_processes_parallel: =
preparing to run up to 1 tasks
13:05:42.998076 run-command.c:1614      run_processes_parallel: done
13:05:42.998082 run-command.c:654       trace: run_command: git =
maintenance run --auto --no-quiet
13:05:42.999099 git.c:458               trace: built-in: git maintenance =
run --auto --no-quiet
13:05:43.002592 git.c:458               trace: built-in: git add -v =
foo.txt
add 'foo.txt'
13:05:43.004882 git.c:458               trace: built-in: git mv -v -f -- =
foo.txt bar.txt
warning: overwriting 'bar.txt'
Renaming foo.txt to bar.txt
13:05:43.007057 git.c:458               trace: built-in: git reset =
--merge HEAD
error: Entry 'bar.txt' not uptodate. Cannot merge.
fatal: Could not reset index file to revision 'HEAD'.

--Apple-Mail=_6E1FDBB5-1FBA-4F6F-8D83-521F102B85AA
Content-Disposition: attachment;
	filename=case1ConsoleOut.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="case1ConsoleOut.txt"
Content-Transfer-Encoding: quoted-printable

13:05:36.550286 git.c:458               trace: built-in: git init
warning: templates not found in /usr/local/share/git-core/templates
Initialized empty Git repository in /test2/workDir/gitDir0/.git/
13:05:36.553483 git.c:458               trace: built-in: git add -v =
bar.txt
add 'bar.txt'
13:05:36.555923 git.c:458               trace: built-in: git commit -v =
-m first
13:05:36.557265 run-command.c:654       trace: run_command: git =
maintenance run --auto --no-quiet
13:05:36.558315 git.c:458               trace: built-in: git maintenance =
run --auto --no-quiet
[master (root-commit) aea16b2] first
 1 file changed, 1 insertion(+)
 create mode 100644 bar.txt
13:05:36.561756 git.c:458               trace: built-in: git init
warning: templates not found in /usr/local/share/git-core/templates
Initialized empty Git repository in /test2/workDir/gitDir2/.git/
13:05:36.564497 git.c:458               trace: built-in: git pull -v =
--set-upstream ../gitDir0
13:05:36.564679 run-command.c:654       trace: run_command: git fetch =
--update-head-ok -v --set-upstream ../gitDir0
13:05:36.565640 git.c:458               trace: built-in: git fetch =
--update-head-ok -v --set-upstream ../gitDir0
13:05:36.565830 run-command.c:654       trace: run_command: unset =
GIT_PREFIX; GIT_PROTOCOL=3Dversion=3D2 'git-upload-pack =
'\''../gitDir0'\'''
13:05:36.567311 git.c:458               trace: built-in: git upload-pack =
../gitDir0
13:05:36.568164 run-command.c:654       trace: run_command: git =
pack-objects --revs --thin --stdout --delta-base-offset
remote: 13:05:36.569156 git.c:458               trace: built-in: git =
pack-objects --revs --thin --stdout --delta-base-offset       =20
13:05:36.570130 run-command.c:654       trace: run_command: git =
unpack-objects -q --pack_header=3D2,3
13:05:36.571443 git.c:458               trace: built-in: git =
unpack-objects -q --pack_header=3D2,3
13:05:36.572322 run-command.c:654       trace: run_command: git rev-list =
--objects --stdin --not --all --quiet --alternate-refs
13:05:36.573357 git.c:458               trace: built-in: git rev-list =
--objects --stdin --not --all --quiet --alternate-refs
=46rom ../gitDir0
 * branch            HEAD       -> FETCH_HEAD
13:05:36.574654 run-command.c:1582      run_processes_parallel: =
preparing to run up to 1 tasks
13:05:36.574663 run-command.c:1614      run_processes_parallel: done
13:05:36.574669 run-command.c:654       trace: run_command: git =
maintenance run --auto --no-quiet
13:05:36.575573 git.c:458               trace: built-in: git maintenance =
run --auto --no-quiet
13:05:36.578926 git.c:458               trace: built-in: git add -v =
foo.txt
add 'foo.txt'
13:05:36.581235 git.c:458               trace: built-in: git mv -v -f -- =
foo.txt bar.txt
warning: overwriting 'bar.txt'
Renaming foo.txt to bar.txt
13:05:36.583892 git.c:458               trace: built-in: git reset =
--merge HEAD

--Apple-Mail=_6E1FDBB5-1FBA-4F6F-8D83-521F102B85AA--
