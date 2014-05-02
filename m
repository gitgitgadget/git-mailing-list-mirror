From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v6 1/7] pull: rename pull.rebase to pull.mode
Date: Fri, 02 May 2014 19:51:57 -0400
Message-ID: <53642F9D.3040606@bbn.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com> <1398988808-29678-2-git-send-email-felipe.contreras@gmail.com> <53640403.30600@bbn.com> <53640a26569a5_135215292ec43@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 01:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgNFW-0000gp-6V
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbaEBXwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:52:09 -0400
Received: from smtp.bbn.com ([128.33.0.80]:41205 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbaEBXwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:52:07 -0400
Received: from socket.bbn.com ([192.1.120.102]:41350)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WgNFF-000P9x-Vt; Fri, 02 May 2014 19:51:58 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 9883A3FE73
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53640a26569a5_135215292ec43@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248010>

On 2014-05-02 17:12, Felipe Contreras wrote:
> Richard Hansen wrote:
>> Should branch.autosetuprebase be replaced with a new
>> branch.autosetupmode setting?
> 
> Maybe. But if so, I think that should be done in another series.
> Otherwise we'll never have a chance to change anything.

Sure.

>>>                                  The possible values are 'merge',
>>> +	'rebase', and 'rebase-preserve'.
>>
>> While the name 'merge' is mostly self-explanatory, I think it needs
>> further clarification:  Does 'merge' imply --no-ff?  Or --ff?  Or the
>> value of merge.ff?
> 
> 'pull.mode=merge' will do the same as `git merge`, I don't see where or
> how it can be explained more clearly.

How about:

branch.<name>.pullmode::
	Determines how 'git pull' integrates the fetched branch into
	branch <name>.
	Defaults to the value of `pull.mode`.
	Supported values:
+
--
	`merge`:::
		Merge the fetched branch into <name>.
		See also `merge.ff`.
	`rebase`:::
		Find the point at which <name> forked from the fetched
		branch (see the `--fork-point` option of
		linkgit:git-merge-base[1]), then rebase the commits
		between the fork point and branch <name> onto the
		fetched branch.
	`rebase-preserve`:::
		Like `rebase` but passes `--preserve-merges` to 'git
		rebase'.
--
+
*NOTE*: `rebase` and `rebase-preserve` are potentially dangerous; do
*not* use them unless you understand the implications (see
linkgit:git-rebase[1] for details).

pull.mode::
	See `branch.<name>.pullmode`.  Defaults to `merge`.

> 
>> Which side will be the first parent?
> 
> The same as things currently are: the pulled branch into the current
> branch (current branch is first parent).

This was a rhetorical question -- I was trying to point out that the
current behavior should be documented.

> 
> We should probably change this, but that's out of scope of this series,
> and hasn't been decided yet.

Agreed.  If this series is merged, a future series could add a
'merge-there' pull mode.

>> Also, rather than copy+paste
>> the description from branch.<name>.pullmode, I'd prefer a brief
>> reference.  For example:
>>
>> pull.mode::
>>     See branch.<name>.pullmode.  Defaults to 'merge'.
> 
> I'd say pull.mode is the important one.

Either way works for me.  How about this:

branch.<name>.pullmode::
	Overrides the value of `pull.mode` for branch <name>.

pull.mode::
	Determines how 'git pull' integrates the fetched branch into
	the current branch.
	Supported values:
+
--
	`merge`:::
		(default)
		Merge the fetched branch into the current branch.
		See also `merge.ff`.
	`rebase`:::
		Find the point at which the current branch forked from
		the fetched branch (see the `--fork-point` option of
		linkgit:git-merge-base[1]), then rebase the commits
		between the fork point and the current branch onto the
		fetched branch.
	`rebase-preserve`:::
		Like `rebase` but passes `--preserve-merges` to 'git
		rebase'.
--
+
*NOTE*: `rebase` and `rebase-preserve` are potentially dangerous; do
*not* use them unless you understand the implications (see
linkgit:git-rebase[1] for details).

-Richard
