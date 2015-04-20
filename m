From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 10:53:07 +0100
Message-ID: <5534CC83.2000304@diamand.org>
References: <CALM2SnZmCJ2nVqPyLiepF1zJH=S0BzCTM=-L6hnn8Vnrb+prCw@mail.gmail.com> <1429312285-13552-1-git-send-email-lex@lexspoon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Lex Spoon <lex@lexspoon.org>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 11:53:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk8Oa-0003L4-9X
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 11:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbbDTJxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 05:53:36 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36764 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbbDTJxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 05:53:33 -0400
Received: by wgsk9 with SMTP id k9so172603164wgs.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=jwS/os9oGZooaQpzHjdZJgAo67knB7dhQAGFgXueQFc=;
        b=i+dgDLQLE2SgAHoRAUqWiAyMSXiuCf+AloKOCcQNe1UYAmQlkK17VfBqNNQdPx6Yzt
         CLwLFZQ0+8qo5o0NGvMCrrz5D7SYKTttgfGt+fOcNIR24Jcoi8WduwivdPgSnhW02tsS
         FlbeVgcDpssuIZIgY6O6jRxiI/bML7ZkLtM1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jwS/os9oGZooaQpzHjdZJgAo67knB7dhQAGFgXueQFc=;
        b=Lm5L6+WzGas6VfDVy/ElmcXtlO5HxUOSrSFXOc6ezehnYMpuWFGxqDqY7PFqoh4/LL
         X2GVeqnAfw7J89BNqqzHeg6T2RmVxoe7ZhxGI7NeHRzJlsa24W00x8Xek9t2yukHGn+A
         XF+Nj05nypqw1hxoZ5U5m4x3NfE/a6rf5hJYwD2gxOiBsIi+uZDXlY2ufIBCiKyALpVq
         8yR41HH+jCKmGtlCo4rQu/G8rjT58B9OI45tYllwkoF5jfya5f2ydpjFd4fGcJwx6baS
         OTTPzEj9IgcaPbs4vx7J3eMJe7iiyFAtxQPaeMinbfdCTG3V7Vzlifsl18Eapb/oUSJl
         DHug==
X-Gm-Message-State: ALoCoQkF6RGW3+/S57Pijq50Ai+s2BiYYim0aIqrNI0ISaQDISDkrPww8+kZcDCRp2KUgdylbeVt
X-Received: by 10.180.91.107 with SMTP id cd11mr22778849wib.51.1429523612674;
        Mon, 20 Apr 2015 02:53:32 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id f8sm14501258wiy.7.2015.04.20.02.53.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 02:53:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1429312285-13552-1-git-send-email-lex@lexspoon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267462>

On 18/04/15 00:11, Lex Spoon wrote:
> Simply running "p4 changes" on a large branch can
> result in a "too many rows scanned" error from the
> Perforce server. It is better to use a sequence
> of smaller calls to "p4 changes", using the "-m"
> option to limit the size of each call.
>
> Signed-off-by: Lex Spoon <lex@lexspoon.org>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Luke Diamand <luke@diamand.org>

I could be wrong about this, but it looks like importNewBranches() is 
taking an extra argument, but that isn't reflected in the place where it 
gets called. I think it just got missed.

As a result, t9801-git-p4-branch.sh fails with this error:

Importing revision 3 (37%)
     Importing new branch depot/branch1
Traceback (most recent call last):
   File "/home/lgd/git/git/git-p4", line 3327, in <module>
     main()
   File "/home/lgd/git/git/git-p4", line 3321, in main
     if not cmd.run(args):
   File "/home/lgd/git/git/git-p4", line 3195, in run
     if not P4Sync.run(self, depotPaths):
   File "/home/lgd/git/git/git-p4", line 3057, in run
     self.importChanges(changes)
   File "/home/lgd/git/git/git-p4", line 2692, in importChanges
     if self.importNewBranch(branch, change - 1):
TypeError: importNewBranch() takes exactly 4 arguments (3 given)
rm: cannot remove `/home/lgd/git/git/t/trash 
directory.t9801-git-p4-branch/git/.git/objects/pack': Directory not empty
not ok 8 - import depot, branch detection, branchList branch definition


Thanks!
Luke


> ---
> Updated as suggested:
> - documentation added
> - avoided touch(1)
> - used test_seq
> - used || exit for test commands inside for loops
> - more tabs
> - fewer line breaks
> - expanded commit message
>
>   Documentation/git-p4.txt | 17 ++++++++++---
>   git-p4.py                | 54 +++++++++++++++++++++++++++++++---------
>   t/t9818-git-p4-block.sh  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 120 insertions(+), 15 deletions(-)
>   create mode 100755 t/t9818-git-p4-block.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index a1664b9..82aa5d6 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -225,9 +225,20 @@ Git repository:
>   	they can find the p4 branches in refs/heads.
>
>   --max-changes <n>::
> -	Limit the number of imported changes to 'n'.  Useful to
> -	limit the amount of history when using the '@all' p4 revision
> -	specifier.
> +	Import at most 'n' changes, rather than the entire range of
> +	changes included in the given revision specifier. A typical
> +	usage would be use '@all' as the revision specifier, but then
> +	to use '--max-changes 1000' to import only the last 1000
> +	revisions rather than the entire revision history.
> +
> +--changes-block-size <n>::
> +	The internal block size to use when converting a revision
> +	specifier such as '@all' into a list of specific change
> +	numbers. Instead of using a single call to 'p4 changes' to
> +	find the full list of changes for the conversion, there are a
> +	sequence of calls to 'p4 changes -m', each of which requests
> +	one block of changes of the given size. The default block size
> +	is 500, which should usually be suitable.
>
>   --keep-path::
>   	The mapping of file names from the p4 depot path to Git, by
> diff --git a/git-p4.py b/git-p4.py
> index 549022e..1fba3aa 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -740,17 +740,43 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
>   def originP4BranchesExist():
>           return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
>
> -def p4ChangesForPaths(depotPaths, changeRange):
> +def p4ChangesForPaths(depotPaths, changeRange, block_size):
>       assert depotPaths
> -    cmd = ['changes']
> -    for p in depotPaths:
> -        cmd += ["%s...%s" % (p, changeRange)]
> -    output = p4_read_pipe_lines(cmd)
> +    assert block_size
> +
> +    # Parse the change range into start and end
> +    if changeRange is None or changeRange == '':
> +        changeStart = '@1'
> +        changeEnd = '#head'
> +    else:
> +        parts = changeRange.split(',')
> +        assert len(parts) == 2
> +        changeStart = parts[0]
> +        changeEnd = parts[1]
>
> +    # Accumulate change numbers in a dictionary to avoid duplicates
>       changes = {}
> -    for line in output:
> -        changeNum = int(line.split(" ")[1])
> -        changes[changeNum] = True
> +
> +    for p in depotPaths:
> +        # Retrieve changes a block at a time, to prevent running
> +        # into a MaxScanRows error from the server.
> +        start = changeStart
> +        end = changeEnd
> +        get_another_block = True
> +        while get_another_block:
> +            new_changes = []
> +            cmd = ['changes']
> +            cmd += ['-m', str(block_size)]
> +            cmd += ["%s...%s,%s" % (p, start, end)]
> +            for line in p4_read_pipe_lines(cmd):
> +                changeNum = int(line.split(" ")[1])
> +                new_changes.append(changeNum)
> +                changes[changeNum] = True
> +            if len(new_changes) == block_size:
> +                get_another_block = True
> +                end = '@' + str(min(new_changes))
> +            else:
> +                get_another_block = False
>
>       changelist = changes.keys()
>       changelist.sort()
> @@ -1911,7 +1937,10 @@ class P4Sync(Command, P4UserMap):
>                   optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
>                   optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
>                                        help="Import into refs/heads/ , not refs/remotes"),
> -                optparse.make_option("--max-changes", dest="maxChanges"),
> +                optparse.make_option("--max-changes", dest="maxChanges",
> +                                     help="Maximum number of changes to import"),
> +                optparse.make_option("--changes-block-size", dest="changes_block_size", type="int",
> +                                     help="Internal block size to use when iteratively calling p4 changes"),
>                   optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
>                                        help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
>                   optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
> @@ -1940,6 +1969,7 @@ class P4Sync(Command, P4UserMap):
>           self.syncWithOrigin = True
>           self.importIntoRemotes = True
>           self.maxChanges = ""
> +        self.changes_block_size = 500
>           self.keepRepoPath = False
>           self.depotPaths = None
>           self.p4BranchesInGit = []
> @@ -2578,7 +2608,7 @@ class P4Sync(Command, P4UserMap):
>
>           return ""
>
> -    def importNewBranch(self, branch, maxChange):
> +    def importNewBranch(self, branch, maxChange, changes_block_size):
>           # make fast-import flush all changes to disk and update the refs using the checkpoint
>           # command so that we can try to find the branch parent in the git history
>           self.gitStream.write("checkpoint\n\n");
> @@ -2586,7 +2616,7 @@ class P4Sync(Command, P4UserMap):
>           branchPrefix = self.depotPaths[0] + branch + "/"
>           range = "@1,%s" % maxChange
>           #print "prefix" + branchPrefix
> -        changes = p4ChangesForPaths([branchPrefix], range)
> +        changes = p4ChangesForPaths([branchPrefix], range, changes_block_size)
>           if len(changes) <= 0:
>               return False
>           firstChange = changes[0]
> @@ -3002,7 +3032,7 @@ class P4Sync(Command, P4UserMap):
>                   if self.verbose:
>                       print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
>                                                                 self.changeRange)
> -                changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
> +                changes = p4ChangesForPaths(self.depotPaths, self.changeRange, self.changes_block_size)
>
>                   if len(self.maxChanges) > 0:
>                       changes = changes[:min(int(self.maxChanges), len(changes))]
> diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
> new file mode 100755
> index 0000000..153b20a
> --- /dev/null
> +++ b/t/t9818-git-p4-block.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description='git p4 fetching changes in multiple blocks'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo with ~100 changes' '
> +	(
> +		cd "$cli" &&
> +		>file.txt &&
> +		p4 add file.txt &&
> +		p4 submit -d "Add file.txt" &&
> +		for i in $(test_seq 0 9)
> +		do
> +			>outer$i.txt &&
> +			p4 add outer$i.txt &&
> +			p4 submit -d "Adding outer$i.txt" &&
> +			for j in $(test_seq 0 9)
> +			do
> +				p4 edit file.txt &&
> +				echo $i$j >file.txt &&
> +				p4 submit -d "Commit $i$j" || exit
> +			done || exit
> +		done
> +	)
> +'
> +
> +test_expect_success 'Clone the repo' '
> +	git p4 clone --dest="$git" --changes-block-size=10 --verbose //depot@all
> +'
> +
> +test_expect_success 'All files are present' '
> +	echo file.txt >expected &&
> +	test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt outer4.txt >>expected &&
> +	test_write_lines outer5.txt outer6.txt outer7.txt outer8.txt outer9.txt >>expected &&
> +	ls "$git" >current &&
> +	test_cmp expected current
> +'
> +
> +test_expect_success 'file.txt is correct' '
> +	echo 99 >expected &&
> +	test_cmp expected "$git/file.txt"
> +'
> +
> +test_expect_success 'Correct number of commits' '
> +	(cd "$git" && git log --oneline) >log &&
> +	test_line_count = 111 log
> +'
> +
> +test_expect_success 'Previous version of file.txt is correct' '
> +	(cd "$git" && git checkout HEAD^^) &&
> +	echo 97 >expected &&
> +	test_cmp expected "$git/file.txt"
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
>
