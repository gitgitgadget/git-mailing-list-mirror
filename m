From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Thu, 8 Mar 2012 11:56:42 +0100
Message-ID: <87399jnyxh.fsf@thomas.inf.ethz.ch>
References: <1331203358-28277-1-git-send-email-domq@google.com>
	<1331203358-28277-2-git-send-email-domq@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <gitster@pobox.com>, <git@vger.kernel.org>
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5b1f-0003WD-0U
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab2CHK4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:56:45 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:58331 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985Ab2CHK4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:56:44 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:56:42 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:56:42 +0100
In-Reply-To: <1331203358-28277-2-git-send-email-domq@google.com> (Dominique
	Quatravaux's message of "Thu, 8 Mar 2012 11:42:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192560>

On a general note: you are submitting a completely new feature touching
a heavily-used tool (and code path) during -rc0 time.  As a rule of
thumb: Don't do that.  If you do it, don't Cc Junio unless it's his area
of code.

Dominique Quatravaux <domq@google.com> writes:

> If set, the second column of the rebase todo contains named revisions (obtained
> with git name-rev) instead of short SHA1s.

Hum.  I'm not sure yet if I find that very useful, since frequently the
names will just be 'topic', 'topic~1', ...., 'topic~N' if you are
rebasing a topic with N+1 commits not in master.  But you might, so who
am I to judge.

> +--name-rev::
> +--no-name-rev::

The --no- version is implicitly always supported, see gitcli(1).

> +configuration variable `rebase.interactivenamerev`, this option can be

You should spell it in a more readable way such as
rebase.interactiveNameRev.  The config machinery internally downcases
everything so the cosmetics won't prevent it from working.

> -	shortsha1=$(echo $sha1 | cut -c1-7)
> +	if test t = "$name_rev"
> +	then
> +		rev="$(git name-rev $sha1 | cut -d\  -f2)"
> +	else
> +		rev=$(echo $sha1 | cut -c1-7)
> +	fi

In the spirit of your previous patch, wouldn't it be faster to run 'git
name-rev --stdin' within the pipeline?

How does this interact with --autosquash?

> +test_expect_success 'Symbolic revisions in --name-rev' '
> +	exec > debug.log 2>&1 &&
> +	FAKE_LINES="exec_cp_.git/rebase-merge/git-rebase-todo_rebase-todo 1 2" git rebase -i --name-rev HEAD~2 &&
> +	test_cmp expect-rebase-todo rebase-todo
> +'

In line with the --autosquash concern, please write a test that uses
both option (and verifies that *both* work!).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
