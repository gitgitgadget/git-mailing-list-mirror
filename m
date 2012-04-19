From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 12:02:53 +0200
Message-ID: <4F8FE2CD.3070300@in.waw.pl>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com> <1334776680-23460-1-git-send-email-nhorman@tuxdriver.com> <1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 12:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKoCv-0003KC-68
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 12:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab2DSKDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 06:03:13 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35148 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355Ab2DSKDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 06:03:13 -0400
Received: from [193.0.104.36]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SKoCc-0003eG-Kg; Thu, 19 Apr 2012 12:03:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195933>

On 04/18/2012 09:18 PM, Neil Horman wrote:
> Add a command line switch to git-rebase to allow a user the ability to specify
> that they want to keep any commits in a series that are empty.
>
> When git-rebase's type is am, then this option will automatically keep any
> commit that has a tree object identical to its parent.
>
> This patch changes the default behavior of interactive rebases as well.  With
> this patch, git-rebase -i will produce a revision set passed to
> git-revision-editor, in which empty commits are commented out.  Empty commits
> may be kept manually by uncommenting them.  If the new --keep-empty option is
> used in an interactive rebase the empty commits will automatically all be
> uncommented in the editor.
>
> Signed-off-by: Neil Horman<nhorman@tuxdriver.com>

Hi,
this one seems to breaks many tests when /bin/sh=dash. (Both v6 in pu 
and this v7).

E.g. ./t3404-rebase-interactive.sh:

ok 1 - setup
not ok - 2 rebase -i with the exec command
not ok - 3 rebase -i with the exec command runs from tree root
not ok - 4 rebase -i with the exec command checks tree cleanness
not ok - 5 no changes are a nop
not ok - 6 test the [branch] option
not ok - 7 test --onto <branch>
not ok - 8 rebase on top of a non-conflicting commit
not ok - 9 reflog for the branch shows state before rebase
not ok - 10 exchange two commits
not ok - 11 stop on conflicting pick
not ok - 12 abort
not ok - 13 abort with error when new base cannot be checked out
not ok - 14 retain authorship
not ok - 15 squash
not ok - 16 retain authorship when squashing
not ok - 17 -p handles "no changes" gracefully
not ok 18 - exchange two commits with -p # TODO known breakage
not ok - 19 preserve merges with -p
not ok - 20 edit ancestor with -p
not ok - 21 --continue tries to commit
not ok - 22 verbose flag is heeded, even after --continue
not ok - 23 multi-squash only fires up editor once
not ok - 24 multi-fixup does not fire up editor
not ok - 25 commit message used after conflict
not ok - 26 commit message retained after conflict
not ok - 27 squash and fixup generate correct log messages
not ok - 28 squash ignores comments
not ok - 29 squash ignores blank lines
not ok - 30 squash works as expected
not ok - 31 interrupted squash works as expected
not ok - 32 interrupted squash works as expected (case 2)
not ok - 33 ignore patch if in upstream
not ok - 34 --continue tries to commit, even for "edit"
not ok - 35 aborted --continue does not squash commits after "edit"
not ok - 36 auto-amend only edited commits after "edit"
not ok - 37 clean error after failed "exec"
not ok - 38 rebase a detached HEAD
not ok - 39 rebase a commit violating pre-commit
not ok - 40 rebase with a file named HEAD in worktree
ok 41 - do "noop" when there is nothing to cherry-pick
ok 42 - submodule rebase setup
not ok - 43 submodule rebase -i
ok 44 - submodule conflict setup
not ok - 45 rebase -i continue with only submodule staged
not ok - 46 rebase -i continue with unstaged submodule
not ok - 47 avoid unnecessary reset
not ok - 48 reword
ok 49 - rebase -i can copy notes
not ok - 50 rebase -i can copy notes over a fixup
not ok - 51 rebase while detaching HEAD
not ok - 52 always cherry-pick with --no-ff
ok 53 - set up commits with funny messages
not ok - 54 rebase-i history with funny messages

The problem seems to be that git-rebase says "Nothing to do" and returns 1.

-
Zbyszek
