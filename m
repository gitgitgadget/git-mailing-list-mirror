From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git as a backup system?
Date: Mon, 8 Nov 2010 21:25:43 +0100
Message-ID: <AANLkTikK+owARQoNxpF=CzcY_s-OChdkCgj6WbD=_eNW@mail.gmail.com>
References: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:25:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYHn-0001Au-Se
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab0KHUZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:25:46 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34658 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab0KHUZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:25:45 -0500
Received: by fxm16 with SMTP id 16so4372178fxm.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 12:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UOOwxaqVMxVpZOTeMQFilU2AC7cxtH44ZjNHOdBv5i0=;
        b=YP24Ev03Nq6qwbcuAYWiaqGS8+bvJyVQcFW+mo5P87uPkFFjfx7tAT7YLmTZphz8u/
         MmeW7HmlgH0gr1U85cy5gvoTpVZ0We9rQ77PzMeLNzXp3u2+Eu5RsJdGIQ/RsARwUzCl
         mOR4323Li90D1QWpz2wJPPLYZa/n7j1rDcroU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UqPm8UqCNekE9s+x+Q5c+Ll2+F+t+B0J/TLoo4xsioNcfPsGSkZKQHDm3JKh+S3zBb
         mlZt7yYwji4drgrK1Uop3SSdY+x4nVneRtHFoEm9tCyCYcPHTl0LmKmh6J+Q4aHSszek
         t7dWOhDMgvL+e5W7EIRJw2B1n4fcwkHzVxKGg=
Received: by 10.223.69.134 with SMTP id z6mr4361291fai.19.1289247943812; Mon,
 08 Nov 2010 12:25:43 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 8 Nov 2010 12:25:43 -0800 (PST)
In-Reply-To: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160984>

On Mon, Nov 8, 2010 at 19:01, Eric Frederich <eric.frederich@gmail.com> wrote:
> I maintain a corporate MediaWiki installation.
> Currently I have a cron job that runs daily and tar's up the contents
> of the installation directory and runs a mysqldump.
> I keep backups of the past 45 days.
> Each backup is about 200M, so all in all I always have about 9.0G of backups.
> Most of the changes are in the database, so the mysqldump file is
> changed every day.
> Other than that, there can be new files uploaded but they never
> change, just get added.
> All configuration files stay the same.
>
> I wrote a script that untar'd the contents each backup, gunziped the
> mysql dump, and made a git commit.
> The resulting .git directory wound up being 837M, but after running a
> long (8 minute) "git gc" command, it went down to 204M.
>
> == Questions ==
> What mysqldump options would be good to use for storage in git?
> Right now I'm not passing any parameters to mysqldump and its doing
> all inserts for each table on a single huge line.
> Would git handle it better if each insert was on its own line?

I use git to back up all my data. It works great. But how big the
dumps get depends very much on the database.

Here's a graph of the size of my mysql backup directories:
http://munin.nix.is/nix.is/v.nix.is/dirs_var_backup_mysql.html

I use this little wrapper script:
https://github.com/avar/linode-etc/blob/master/bin/cron/mysqldump-to-git-all

Which calls this:
https://github.com/avar/linode-etc/blob/master/bin/cron/sqldump-to-git

I find with MySQL --skip-extended-insert and --compact work really well.

Then I use this to repack + gc the repos:
https://github.com/avar/linode-etc/blob/master/bin/cron/git-repack-and-gc-dir
