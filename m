From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 11:23:39 +0200
Message-ID: <4C63BD9B.6000608@viscovery.net>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 11:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjU0u-000726-07
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 11:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759212Ab0HLJXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 05:23:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55798 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab0HLJXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 05:23:45 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OjU0h-0004T4-Uq; Thu, 12 Aug 2010 11:23:40 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AAFEA1660F;
	Thu, 12 Aug 2010 11:23:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153356>

[Sorry for the Cc spam; I lack the time to conduct individual messages.]

I compiled many topics in pu and ran the test suite on Windows,
particularly those that "look good" and "will merge to next". Here's a report.

Today's next produces this warning:

merge-recursive.c: In function 'process_df_entry':
merge-recursive.c:1246: warning: unused variable 'o_sha'

(line number may be different) because o_sha is only used inside assert().
I don't know how you would like this fixed.

Am 8/12/2010 1:35, schrieb Junio C Hamano:
> * en/rebase-against-rebase-fix (2010-08-06) 2 commits
>  - pull --rebase: Avoid spurious conflicts and reapplying unnecessary patches
>  - t5520-pull: Add testcases showing spurious conflicts from git pull --rebase

This should not use "sed -i" in the test suite.

> * jn/svn-fe (2010-08-09) 10 commits
>  - svn-fe manual: Clarify warning about deltas in dump files
>  - Update svn-fe manual
>  - SVN dump parser
>  - Infrastructure to write revisions in fast-export format
>  - Add stream helper library
>  - Add string-specific memory pool
>  - Add treap implementation
>  - Add memory pool library
>  - Introduce vcs-svn lib
>  - Export parse_date_basic() to convert a date string to timestamp
> 
> There was a screw-up on my part---I should have dropped the first one and
> branched this off of jn/parse-date-basic (I'll fix it up before merging
> this to 'next').

This fails to build under MinGW because we don't have strtok_r() and a
whole lot of other things that I didn't even look at. Can we have an
opt-in or opt-out for this?

> * gb/shell-ext (2010-07-28) 3 commits
>  - Add sample commands for git-shell
>  - Add interactive mode to git-shell for user-friendliness
>  - Allow creation of arbitrary git-shell commands

This needs work on Windows because we do not have geteuid(), perhaps just
a compiler flag -Dgeteuid=getuid

> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>  - apply: Handle traditional patches with space in filename
>  - t4135 (apply): use expand instead of pr for portability
>  - tests: Test how well "git apply" copes with weird filenames
>  - apply: Split quoted filename handling into new function
> 
> Looked Ok.  Will merge to 'next'.

The test cases that work with files with tabs must have a prerequisite;
see t3600-rm.sh.

> * il/rfc-remote-fd-ext (2010-07-31) 4 commits
>  - Rewrite bidirectional traffic loop
>  - gitignore: Ignore the new /git-remote-{ext,fd} helpers
>  - New remote helper: git-remote-ext
>  - New remote helper git-remote-fd

We do not have EWOULDBLOCK on Windows. Is it needed or could the
respective write() loop in remote-ext.c not be replaced by write_in_full()?

> * en/d-f-conflict-fix (2010-07-27) 7 commits
>   (merged to 'next' on 2010-08-03 at 7f78604)
>  + t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
>  + fast-import: Improve robustness when D->F changes provided in wrong order
>  + fast-export: Fix output order of D/F changes
>  + merge_recursive: Fix renames across paths below D/F conflicts
>  + merge-recursive: Fix D/F conflicts
>  + Add a rename + D/F conflict testcase
>  + Add additional testcases for D/F conflicts

The new tests in t/t3509-cherry-pick-merge-df.sh and t9350-fast-export.sh
need SYMLINKS prerequisite.

-- Hannes
