From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Who created a branch - reflog
Date: Tue, 8 Mar 2011 06:57:38 -0800
Message-ID: <AANLkTimsz7OPfUF5j=xY6ro4uX4AQty+PzW-tG6TQbuW@mail.gmail.com>
References: <20110308143846.GV3609@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 15:58:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwyMP-0004tf-Qi
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 15:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab1CHO6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 09:58:00 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37823 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab1CHO57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 09:57:59 -0500
Received: by vxi39 with SMTP id 39so4746883vxi.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 06:57:58 -0800 (PST)
Received: by 10.52.0.107 with SMTP id 11mr7420242vdd.236.1299596278124; Tue,
 08 Mar 2011 06:57:58 -0800 (PST)
Received: by 10.52.162.33 with HTTP; Tue, 8 Mar 2011 06:57:38 -0800 (PST)
In-Reply-To: <20110308143846.GV3609@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168665>

On Tue, Mar 8, 2011 at 06:38, Miklos Vajna <vmiklos@frugalware.org> wrote:
> We have a repo where multiple users have push access, they access the
> repo via ssh. Now let's say one of the developers ("A") accidently create a
> branch named "foo" in the shared repo. Of course the tip of "foo" may
> not point to a commit authored by "A".
>
> IIRC reflogs could be used in that case when the push is done via http,
> as the HTTP username is recorded in the reflog, so we can know who to
> blame.
>
> Unfortunately - as far as I see - this is not true for ssh, there simply
> the author of the tip commit is used.
>
> Have I missed something? Would it be possible to have the username of
> the user in the reflog, even when pushing via ssh?

reflog identity entries are derived from GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL in the environment at the time that the log event
takes place. If these aren't set, they are derived from the current
user's gecos, or from $GIT_DIR/config or ~/.gitconfig as the
user.name/user.email variables.

Perhaps over SSH one of these is triggering for a user, allowing the
user to fill in their own identity... or someone else's. If you want
to enforce an identity you should set these environment variables on
the SSH server side before invoking git-receive-pack, perhaps by way
of a forced SSH command the way gitosis or gitolite is installed.

-- 
Shawn.
