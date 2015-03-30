From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2] config.c: split some variables to
 $GIT_DIR/config.worktree
Date: Tue, 31 Mar 2015 00:26:42 +0300
Message-ID: <20150330212642.GA28003@wheezy.local>
References: <CACsJy8CYgMDY_zGi6o=UtD7QV+DQUcaDgwxo6tGrfktRXj+QSw@mail.gmail.com>
 <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <20150326221906.GA6745@wheezy.local>
 <CACsJy8DqgX91KYd5m3PvYSTXYdCO8YV-5R+v6LnzerS6TOr+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 23:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YchCq-0003re-L0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 23:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbbC3V0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 17:26:39 -0400
Received: from p3plsmtpa08-07.prod.phx3.secureserver.net ([173.201.193.108]:46102
	"EHLO p3plsmtpa08-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753041AbbC3V0h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2015 17:26:37 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-07.prod.phx3.secureserver.net with 
	id 9xSV1q00N5B68XE01xSbSo; Mon, 30 Mar 2015 14:26:36 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8DqgX91KYd5m3PvYSTXYdCO8YV-5R+v6LnzerS6TOr+5A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266478>

On Sun, Mar 29, 2015 at 08:25:33AM +0700, Duy Nguyen wrote:
> I'm not sure if "it" means $GIT_DIR/config.worktree or
> $GIT_DIR/info/config.worktree. At this point $GIT_COMMON_DIR is not
> involved (i.e. you can still spit config even in a normal repo).
> .../info/config.worktree may be shared, I guess.

Yes, I meant info/config.worktree

> The "older versions of git (and other git implementations)" raises an
> issue with this patch. Older impl just ignore config.worktree. I think
> I need to bump core.repositoryformatversion up to avoid that.

As a user I would like to still use some older tools, so I
cannot say I like it.

And, I guess bumping repository verion is something the
whole git ecosystem has not experienced yet. So it should be
much more work and much more time, I cannot even imagine how
much. I would still search for option without bumping
version.

>> Also, probably the per-worktree variables should be searched
>> for in both common config and per-worktree config, and the
>> main repository should not have config.worktree, to be able
>> to work with implementations which are not aware of the
>> whole multiple worktrees feature. And in worktrees, if the
>> variable is not defined in config.wortree, the default
>> vaalue should come from common config. This though has
>> downside that worktree cannot use the more global vlue for
>> variable implicitly.
> 
> The main worktree may or may not use per-worktree config (it's
> technically possible): if we enforce config.worktree on the main
> worktree, we don't have to worry about the same variable defined in
> both common and per-worktree config. Enforcing may require more work:
> imagine the worktree list is updated, some in the common config may
> become per-worktree and need to be moved to config.worktree.. If we
> allow per-worktree vars in the common config, other worktrees should
> ignore them in common config.

Yes, probably always ignoring is good idea. They could be
initialized from the common config at worktree creation.

PS: I wrote that nearly all variables could be per worktree.
For maintainability probably a better idea would be to start
with as few as possible and extend their default list as
it's clear nothing will break.

-- 
Max
