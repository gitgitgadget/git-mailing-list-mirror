From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Fri, 18 Oct 2013 21:40:29 +0100
Organization: OPDS
Message-ID: <03C57561C4664D048C2F28134019C391@PhilipOakley>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com> <xmqqeh7k51vg.fsf@gitster.dls.corp.google.com> <29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley> <xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com> <3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley> <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com> <5A09FF55D37146E7A02DF2F640A46406@PhilipOakley> <1390B0AFBE7F4C4A875987C7469B0791@PhilipOakley> <20131017224834.GW9464@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>,
	"Git List" <git@vger.kernel.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 22:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXGqZ-0000jR-UV
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 22:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab3JRUkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 16:40:32 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:21346 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752613Ab3JRUkb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 16:40:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At4LADacYVJOl3+a/2dsb2JhbABagwc4iTq1NAQEAoEkF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAw4HDCUUAQQIEgYHFwYTCAIBAgMBh2MDCQoItwwNiWuMZoFNgSODJoEKA4kHhhKHBYMaiyGFN4E6LIE/Ow
X-IPAS-Result: At4LADacYVJOl3+a/2dsb2JhbABagwc4iTq1NAQEAoEkF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAw4HDCUUAQQIEgYHFwYTCAIBAgMBh2MDCQoItwwNiWuMZoFNgSODJoEKA4kHhhKHBYMaiyGFN4E6LIE/Ow
X-IronPort-AV: E=Sophos;i="4.93,524,1378854000"; 
   d="scan'208";a="440125059"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip03ir2.opaltelecom.net with SMTP; 18 Oct 2013 21:40:28 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236371>

From: "Jonathan Nieder" <jrnieder@gmail.com>
> Philip Oakley wrote:

It was Dale that had the problem, I was just suggesting where he might 
want to look... ;-)

>
>> A bit more looking gave that the cd_to_toplevel () in git-sh-setup.sh
>> directly uses `git rev-parse --show-toplevel`, which simply returns
>> work_tree (static char *work_tree; in environment.c, with comment /*
>> This is set by setup_git_dir_gently() and/or git_default_config()
>> */), apparently without a check for the GIT_WORK_TREE.
>
> Getting closer. :)
>
> The usual way to use GIT_WORK_TREE is along with GIT_DIR.

When re-checking the manual's git(1) env variable section the comment 
that implies this didn't read well "The value will not be used in 
combination...". The section probably needs that to be stated explicitly 
("an exported GIT_WORK_TREE is ignored if GIT_DIR is not set").

>   That takes
> you into the setup_explicit_git_dir() codepath, which does respect
> GIT_WORK_TREE as it should.  (setup_discovered_git_dir does, too.)
>
> The strange behavior you ran into is that unlike, say, git-pull.sh and
> git-am.sh, filter-branch does not set SUBDIRECTORY_OK, store the
> prefix from 'git rev-parse --show-prefix', and then cd_to_toplevel at
> the top of the script.  In other words, nobody bothered to make it
> work from anywhere other than the toplevel of the worktree to begin
> with, and nobody wanted it enough to fix it later.
>

I maybe wrong, but I thought that in Dale's case he was already at the 
same level as the GIT_WORK_TREE he had set, so may not have expected to 
need a cd_to_toplevel


Dale did propose a patch in 
http://thread.gmane.org/gmane.comp.version-control.git/236260 as the 
error was from later in the setup script.

> Hope that helps,
> Jonathan
>

Philip 
