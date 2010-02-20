From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Configuring git to for forget removed files
Date: Sat, 20 Feb 2010 10:41:02 -0500
Message-ID: <c115fd3c1002200741l25f32685t998a19e76922a2d2@mail.gmail.com>
References: <4B7FBB73.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Benton <b3nton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 16:41:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NirST-0001Cf-FB
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 16:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab0BTPlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 10:41:24 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:48267 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab0BTPlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 10:41:23 -0500
Received: by gxk9 with SMTP id 9so1308021gxk.8
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=tZXrBft79ER9CENxKUhLwgSqEwYsDrLg5ZyCDhB/W2w=;
        b=ft1XvsRoq68XF1i6NDKvthTnzzpkN3DTIjDPiF9DVo49W7v4sCO+O9EipIjUBdTHch
         ZgvCts67LPaNFbVMww20FGECbwQA4JfARbM1bKd6GMj9kYZlUuCxFLsOnFsQNVfnX3lD
         o5XOY6HZyDuDHs1EjETmJPDKz5xs65E2BUWFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xsPfkU2xgH7Xpm3FUFX3H+bR0YkKV+8Wr7iPjZOYnfBiKiH96TGd4uwChs6g1fwOqh
         UuioM81wpkPVR3swuXe+lsOuJW9ivcaqo7jaxqwsS0DZP/1ZIqfAuausYf5+nHgXuV06
         Pi/qNfBIPiPDqIfxJ/iltG7OGiwjZ6zBhd98Y=
Received: by 10.100.17.12 with SMTP id 12mr46995anq.179.1266680482414; Sat, 20 
	Feb 2010 07:41:22 -0800 (PST)
In-Reply-To: <4B7FBB73.70004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140533>

Hi Andy,

On Sat, Feb 20, 2010 at 5:37 AM, Andrew Benton <b3nton@gmail.com> wrote:
> I have a project that I store in a git repository. It's a bunch of source
> tarballs and some bash scripts to compile it all. Git makes it easy to
> distribute any changes I make across the computers I run. The problem I have
> is that over time the repository gets ever larger. When I update to a newer
> version of something I git rm the old tarball but git still keeps a copy and
> the folder grows ever larger. At the moment the only solution I have is to
> periodically rm -rf .git and start again. This works but is less than ideal
> because I lose all the history for my build scripts.
>
> What I would like is to be able to tell git to not keep a copy of anything
> that has been git rm. The build scripts never get removed, only altered so
> their history would be preserved. Is it possible to make git delete its backup
> copies of removed files?

I don't know if I can really speak to your hoped for conclusion
although `git filter-branch` is where you want to look for rewriting
history.  However, that's also an entirely impractical solution if
your repo is at all public because it would completely break sharing.

That being said, have you thought of changing your repo strategy?
IMHO, storing binary blobs that change at all regularly in _any_ SCMS
is a problem waiting to happen.  It's different if you have assets
that are fairly stable like images for a system's UI or dependencies
that have been stabilized, but that doesn't sound like your situation.

As a thought, why not try to do something along the lines of
maintaining a symlink to whatever tarballs your project currently
depends on as a 'foolib-latest' and then having a separate directory
that has a file that you can change.  You could maintain backups of
that using a tool like rsync (since you obviously aren't concerned
with maintaining history there) rather than git.  Then you could
decide arbitrarily how many backups you want to make and try to
maintain what version of the file went with which commit in your repo.
 The main problem I see with that is that you loose a lot of the
advantages of having a SCMS because you can't reliably checkout a
previous commit and build it; at least not without some very serious
effort.

Another possible solution if you maintain the sources that are
generating the tarballs is to treat the tarballs as artifacts of the
build rather than as assets that should be managed by the SCMS.  In
that way, you might spend more time during each build but your repo
would be much cleaner and would have the added advantage of being able
to completely build itself at every commit point.

Anyway, just food for thought.


-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
