From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 08 Jun 2010 18:06:34 +0200
Message-ID: <4C0E6A8A.70608@web.de>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006080912.31448.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:06:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1KA-0006GE-Nd
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab0FHQGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:06:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:43868 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0FHQGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:06:40 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0A092154CFB83;
	Tue,  8 Jun 2010 18:06:39 +0200 (CEST)
Received: from [80.128.58.232] (helo=[192.168.178.26])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OM1K2-0000OI-00; Tue, 08 Jun 2010 18:06:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006080912.31448.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19T4Em9E90D1vDFl8HJUTryFNqnvABiNraTW85R
	9WnL83q++A1MGWowPKomYkWOjb5pXe6o4mx41WbFJ4DahoBo88
	ImShIi6rqRZ5GwjZ4nJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148682>

Am 08.06.2010 09:12, schrieb Johan Herland:
> - When switching branches in the superrepo, you sometimes also want to 
> switch branches in the submodule. This is signalled by changing the 
> submodules.subthing.branch variable in .gitmodules between the two branches. 
> However, it means that the submodule's update/pull operation must also be 
> done on 'checkout' in the superrepo.

Hm, I always want the submodules to switch branches along with the super-
project (I posted a RFC patch for that), but i can see other people don't
want that at all or just for some submodules. But am I wrong assuming that
it's either "switch branches in submodules too every time" or "never do
that" for a single submodule?


> - How to handle local/uncommitted (staged or unstaged) modifications in a 
> submodule when pulling or switching branches in the superrepo? The right 
> answer here is probably to do the same as in the no-submodule case, i.e. to 
> refuse if it would clobber/conflict with the local modifications.

Yup. I thing one goal for submodules is that they should blend in with
the superprojects as far as possible (unless configured to not to).


> - When you track submodule branches instead of commits, the actual commit 
> referenced in the superrepo is no longer as important (provided it's part of 
> the ancestry of the submodule branch you're tracking). However, diff/status 
> will still list the submodule as changed because you checked out a different 
> commit from what Git has recorded. This raises two concerns: (1) What 
> _should_ be considered "changed" from the diff/status perspective when 
> tracking submodule branches? and (2) When do you update the commit reference 
> in the submodule? "never" would work (since you're checking out a different 
> commit anyway), "always" would also work (for the same reason), but would 
> litter the superrepo history with submodule updates. There may be a better 
> alternative somewhere in between.

Don't record a commit in the first place, following a branch is not bound
to a special commit, so pretending to do that might do more harm than good.
Just putting the 0-hash there might be the solution.


> - If you want to give the illusion of "one big repo" then maybe it should 
> also be possible to trigger submodule commits from a superrepo commit? (i.e. 
> having a single toplevel "git commit" also trigger commits in submodules). 
> Some users will want to specify the commit message for each submodule 
> separately (IMHO the better approach), while some will want to give only one 
> commit message that is reused in every submodule commit.

Hm, personally I am fine with first committing in the submodules and then
in the superproject.
