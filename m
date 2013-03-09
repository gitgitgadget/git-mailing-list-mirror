From: Bernhard Posselt <mail@bernhard-posselt.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Sat, 09 Mar 2013 11:54:36 +0100
Message-ID: <513B14EC.4040504@bernhard-posselt.com>
References: <5139D76D.80703@bernhard-posselt.com> <20130308212831.GA9217@sigill.intra.peff.net> <513A7D80.5000501@bernhard-posselt.com> <20130309044850.GB12167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 09 11:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEHR5-00063L-30
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 11:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260Ab3CIKzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 05:55:02 -0500
Received: from suou.newyork.w1r3.net ([204.62.14.108]:59325 "EHLO
	suou.newyork.w1r3.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584Ab3CIKzB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 05:55:01 -0500
Received: from [192.168.1.139] (194-208-147-142.tele.net [194.208.147.142])
	by suou.newyork.w1r3.net (Postfix) with ESMTPSA id 10E6E41A04;
	Sat,  9 Mar 2013 11:54:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130309044850.GB12167@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217719>

On 03/09/2013 05:48 AM, Jeff King wrote:
> On Sat, Mar 09, 2013 at 01:08:32AM +0100, Bernhard Posselt wrote:
>
>>> The problem is likely happening in a sub-command of git-pull, so
>>> valgrind isn't reporting it. Can you try re-running with
>>> "valgrind --trace-children=yes", or alternatively narrow down the
>>> problematic command by setting GIT_TRACE=1 in the environment?
>> Heres the output with GIT_TRACE=1, the valgrind log has 4000 lines.
>> If you should still require the valgrind log, please tell me.
> Hmm, the GIT_TRACE output was less clear than I had hoped; it's unclear
> to me which git program is actually dying (my guess is "git apply", and
> we are squelching stderr, which is where the GIT_TRACE output is going).
>
> Can you try it once again with something like GIT_TRACE=/tmp/foo.out,
> which will make sure we record the trace directly, even if stderr ends
> up redirected?
>
> Also, I can almost reproduce here, as PatrickHeller/core.git is public.
> However, I suspect the problem is particular to your work built on top,
> which looks like it is at commit 0525bbd73c9015499ba92d1ac654b980aaca35b2.
> Is it possible for you to make that commit available on a temporary
> branch?
>
> -Peff
 > commit available on a temporary branch?
What do you mean exactly by that?

I've made copies of both repositories on github.

Heres a copy of the basic repo: 
https://github.com/Raydiation/memorycorruption
Heres my clone of the repo that i pull from: 
https://github.com/Raydiation/core

Basically:

git clone https://github.com/Raydiation/memorycorruption
cd memorycorruption
git pull --rebase https://github.com/Raydiation/core

Heres the output of the GIT_TRACE file

trace: built-in: git 'branch'
trace: built-in: git 'branch' '--no-color'
trace: built-in: git 'status'
trace: exec: 'git-pull' '--rebase' 'https://github.com/Raydiation/core' 
'master'
trace: run_command: 'git-pull' '--rebase' 
'https://github.com/Raydiation/core' 'master'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-bare-repository'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'ls-files' '-u'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'config' '--bool' 'branch.master.rebase'
trace: built-in: git 'config' '--bool' 'pull.rebase'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '-q' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
trace: built-in: git 'diff-index' '--cached' '--quiet' 
'--ignore-submodules' 'HEAD' '--'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'rev-parse' '-q' '--verify' 
'refs/remotes/https://github.com/Raydiation/core/master'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'fetch' '--update-head-ok' 
'https://github.com/Raydiation/core' 'master'
trace: run_command: 'git-remote-https' 
'https://github.com/Raydiation/core' 'https://github.com/Raydiation/core'
trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' 
'--quiet'
trace: exec: 'git' 'rev-list' '--objects' '--stdin' '--not' '--all' 
'--quiet'
trace: built-in: git 'rev-list' '--objects' '--stdin' '--not' '--all' 
'--quiet'
trace: run_command: 'fetch-pack' '--stateless-rpc' '--stdin' 
'--lock-pack' '--thin' 'https://github.com/Raydiation/core/'
trace: exec: 'git' 'fetch-pack' '--stateless-rpc' '--stdin' 
'--lock-pack' '--thin' 'https://github.com/Raydiation/core/'
trace: built-in: git 'fetch-pack' '--stateless-rpc' '--stdin' 
'--lock-pack' '--thin' 'https://github.com/Raydiation/core/'
trace: run_command: 'unpack-objects' '--pack_header=2,3'
trace: exec: 'git' 'unpack-objects' '--pack_header=2,3'
trace: built-in: git 'unpack-objects' '--pack_header=2,3'
trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all'
trace: exec: 'git' 'rev-list' '--objects' '--stdin' '--not' '--all'
trace: built-in: git 'rev-list' '--objects' '--stdin' '--not' '--all'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'show-branch' '--merge-base' 'refs/heads/master' 
'd686039828089d53fb42e42046d7a9a3992a0507'
trace: built-in: git 'fmt-merge-msg'
trace: built-in: git 'rev-parse' '--parseopt' '--' '--onto' 
'd686039828089d53fb42e42046d7a9a3992a0507' 
'd686039828089d53fb42e42046d7a9a3992a0507'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-bare-repository'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'config' '--bool' 'rebase.stat'
trace: built-in: git 'config' '--bool' 'rebase.autosquash'
trace: built-in: git 'rev-parse' '--verify' 
'd686039828089d53fb42e42046d7a9a3992a0507^0'
trace: built-in: git 'rev-parse' '--verify' 
'd686039828089d53fb42e42046d7a9a3992a0507^0'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'master^0'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '-q' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
trace: built-in: git 'diff-index' '--cached' '--quiet' 
'--ignore-submodules' 'HEAD' '--'
trace: built-in: git 'merge-base' 
'd686039828089d53fb42e42046d7a9a3992a0507' 
'0525bbd73c9015499ba92d1ac654b980aaca35b2'
trace: built-in: git 'checkout' '-q' 
'd686039828089d53fb42e42046d7a9a3992a0507^0'
trace: built-in: git 'update-ref' 'ORIG_HEAD' 
'0525bbd73c9015499ba92d1ac654b980aaca35b2'
trace: built-in: git 'format-patch' '-k' '--stdout' '--full-index' 
'--ignore-if-in-upstream' '--src-prefix=a/' '--dst-prefix=b/' 
'--no-renames' 
'd686039828089d53fb42e42046d7a9a3992a0507..0525bbd73c9015499ba92d1ac654b980aaca35b2'
trace: exec: 'git-am' '--rebasing' '--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".
'
trace: run_command: 'git-am' '--rebasing' '--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".
'
trace: built-in: git 'rev-parse' '--parseopt' '--' '--rebasing' 
'--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase 
--abort".
'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-prefix'
trace: built-in: git 'rev-parse' '--is-inside-work-tree'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'var' 'GIT_COMMITTER_IDENT'
trace: built-in: git 'rev-parse' '--verify' '-q' 'HEAD'
trace: built-in: git 'config' '--bool' '--get' 'am.keepcr'
trace: built-in: git 'mailsplit' '-d4' 
'-o/srv/http/owncloud/.git/rebase-apply' '-b' '--'
trace: built-in: git 'update-index' '-q' '--refresh'
trace: built-in: git 'diff-index' '--cached' '--name-only' 'HEAD' '--'
trace: built-in: git 'cat-file' '-t' 
'48bb53030c657e1133da47765c7c778a069af665'
trace: built-in: git 'cat-file' 'commit' 
'48bb53030c657e1133da47765c7c778a069af665'
trace: built-in: git 'config' 'i18n.commitencoding'
trace: built-in: git 'show' '-s' '--pretty=raw' '--encoding=UTF-8' 
'48bb53030c657e1133da47765c7c778a069af665' '--'
trace: built-in: git 'diff-tree' '--root' '--binary' '--full-index' 
'48bb53030c657e1133da47765c7c778a069af665'
trace: built-in: git 'apply' '--index' 
'/srv/http/owncloud/.git/rebase-apply/patch'
trace: built-in: git 'write-tree'
trace: built-in: git 'rev-parse' '--verify' '-q' 'HEAD'
trace: built-in: git 'commit-tree' 
'd785d568d8b4649dfdcc01e03d6c8e87b036ea5a' '-p' 
'd686039828089d53fb42e42046d7a9a3992a0507'
trace: built-in: git 'update-ref' '-m' 'pull --rebase 
https://github.com/Raydiation/core master: distinguish between touch and 
write' 'HEAD' '3b7aa1e847993b2afdbaf19cd8ed50b81d37fc5b'
trace: built-in: git 'cat-file' '-t' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24'
trace: built-in: git 'cat-file' 'commit' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24'
trace: built-in: git 'config' 'i18n.commitencoding'
trace: built-in: git 'show' '-s' '--pretty=raw' '--encoding=UTF-8' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24' '--'
trace: built-in: git 'diff-tree' '--root' '--binary' '--full-index' 
'45869afa5ac718e11c3d2e3bccdb501a022cfc24'
trace: built-in: git 'apply' '--index' 
'/srv/http/owncloud/.git/rebase-apply/patch'
