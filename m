From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 20:56:41 +0200
Message-ID: <4FD24AE9.8020101@web.de>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 20:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd4Mb-000814-MS
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 20:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab2FHS4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 14:56:45 -0400
Received: from mout.web.de ([212.227.17.12]:55714 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab2FHS4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 14:56:45 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MA5dJ-1SoN1P1KzR-00BTjx; Fri, 08 Jun 2012 20:56:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Provags-ID: V02:K0:RCsABOtbF3Z6aasRmNNL/xAts7AOpvdr0/rg5pL3NkQ
 7xXKAdKo57vnlYUFoaxbntcc6lAazizTasJGRIItIVxBZkXG22
 0DM0cOUbDDe1nKeUK+Byj4nLydDARmjCMsWTy9m5SCjQ2JMQPe
 w4pZbKgjMtjINv1ZT/btr1OjV1tgcWDc9HBaMnAkNA9UD8Gav2
 iD1Pevv9q+qkHxgboRYqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199517>

On 08.06.12 16:53, Lucien Kong wrote:
> This patch provides a way to automatically add these "exec" lines
> between each commit applications. For instance, running 'git rebase -i
> --exec "make test"' lets you check that intermediate commits are
> compilable. It is also compatible with the option --autosquash. At
> this point, you can't use --exec without the interactive mode (-i).
> 
> Tests about this new command are also added in
> t3404-rebase-interactive.sh.

> Should now work on MacOS.

Hej,
I'm not sure on which commit to apply the patch. 
(may be we shoud improve git format-patch to tell us the original commit ID),
but if I remove the non applying part, it looks like this:

=================
ok 54 - rebase-i history with funny messages

expecting success: 
	git checkout master &&
	git checkout -b execute &&
	test_commit one_exec main.txt one_exec &&
	test_commit two_exec main.txt two_exec &&
	test_commit three_exec main.txt three_exec

Switched to branch 'master'
Switched to a new branch 'execute'
[execute 925b01e] one_exec
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 main.txt
[execute 7f87cbe] two_exec
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[execute f0f177e] three_exec
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
ok 55 - prepare for rebase -i --exec

expecting success: 
	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
	(
		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
		export FAKE_LINES &&
		git rebase -i HEAD~2 >expected
	) &&
	sed 1,9d expected >expect &&
	mv expect expected &&
	test_cmp expected actual

error: unknown option `exec'
usage: git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
   or: git rebase [-i] [options] --onto <newbase> --root [<branch>]
   or: git-rebase [-i] --continue | --abort | --skip

Available options are
    -v, --verbose         display a diffstat of what changed upstream
    -q, --quiet           be quiet. implies --no-stat
    --onto ...            rebase onto given branch instead of upstream
    -p, --preserve-merges
                          try to recreate merges instead of ignoring them
    -s, --strategy ...    use the given merge strategy
    --no-ff               cherry-pick all commits, even if unchanged
    -m, --merge           use merging strategies to rebase
    -i, --interactive     let the user edit the list of commits to rebase
    -k, --keep-empty	     preserve empty commits during rebase
    -f, --force-rebase    force rebase even if branch is up to date
    -X, --strategy-option ...
                          pass the argument through to the merge strategy
    --stat                display a diffstat of what changed upstream
    -n, --no-stat         do not show diffstat of what changed upstream
    --verify              allow pre-rebase hook to run
    --rerere-autoupdate   allow rerere to update index with resolved conflicts
    --root                rebase all reachable commits up to the root(s)
    --autosquash          move commits that begin with squash!/fixup! under -i
    --committer-date-is-author-date
                          passed to 'git am'
    --ignore-date         passed to 'git am'
    --whitespace ...      passed to 'git apply'
    --ignore-whitespace   passed to 'git apply'
    -C ...                passed to 'git apply'

Actions:
    --continue            continue
    --abort               abort and check out the original branch
    --skip                skip current patch and continue

not ok - 56 running "git rebase -i --exec git show HEAD"
#	
#		git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
#		(
#			FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
#			export FAKE_LINES &&
#			git rebase -i HEAD~2 >expected
#		) &&
#		sed 1,9d expected >expect &&
#		mv expect expected &&
#		test_cmp expected actual
#	

expecting success: 
	git reset --hard execute &&
	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
	(
		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
		export FAKE_LINES &&
		git rebase -i HEAD~2 >expected
	) &&
	sed 1,9d expected >expect &&
	mv expect expected &&
	test_cmp expected actual

HEAD is now at f0f177e three_exec
error: unknown option `exec'
usage: git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
   or: git rebase [-i] [options] --onto <newbase> --root [<branch>]
   or: git-rebase [-i] --continue | --abort | --skip

Available options are
    -v, --verbose         display a diffstat of what changed upstream
    -q, --quiet           be quiet. implies --no-stat
    --onto ...            rebase onto given branch instead of upstream
    -p, --preserve-merges
                          try to recreate merges instead of ignoring them
    -s, --strategy ...    use the given merge strategy
    --no-ff               cherry-pick all commits, even if unchanged
    -m, --merge           use merging strategies to rebase
    -i, --interactive     let the user edit the list of commits to rebase
    -k, --keep-empty	     preserve empty commits during rebase
    -f, --force-rebase    force rebase even if branch is up to date
    -X, --strategy-option ...
                          pass the argument through to the merge strategy
    --stat                display a diffstat of what changed upstream
    -n, --no-stat         do not show diffstat of what changed upstream
    --verify              allow pre-rebase hook to run
    --rerere-autoupdate   allow rerere to update index with resolved conflicts
    --root                rebase all reachable commits up to the root(s)
    --autosquash          move commits that begin with squash!/fixup! under -i
    --committer-date-is-author-date
                          passed to 'git am'
    --ignore-date         passed to 'git am'
    --whitespace ...      passed to 'git apply'
    --ignore-whitespace   passed to 'git apply'
    -C ...                passed to 'git apply'

Actions:
    --continue            continue
    --abort               abort and check out the original branch
    --skip                skip current patch and continue

not ok - 57 running "git rebase --exec git show HEAD -i"
