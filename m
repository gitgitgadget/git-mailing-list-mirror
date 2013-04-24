From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git submodule repository locatio
Date: Wed, 24 Apr 2013 17:11:19 +0200
Message-ID: <20130424151119.GB25888@paksenarrion.iveqy.com>
References: <5177EFCD.1020300@sher.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jens.lehmann@web.de
To: Adam Stankiewicz <sheerun@sher.pl>
X-From: git-owner@vger.kernel.org Wed Apr 24 17:07:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV1I7-0007f9-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 17:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab3DXPHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 11:07:21 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:59893 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab3DXPHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 11:07:20 -0400
Received: by mail-la0-f46.google.com with SMTP id ep20so1670309lab.5
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mOMsN5PbfphD1DqhaOkd5kBOJSS6LbyyWv1/aIht95E=;
        b=exuQy9tcdVVgMyiQEN2/khtcFt6UhMYWlf+e4rsTMH3P2flDDIyZuG1GFNBlNXtTeU
         AK6gTBUmaTDsiXBjbQJjt2SquKaAeOULc9Z3MyzatUtyHoG6VP3xyQTQuWbezHzErf8J
         +0iOGLNZdoAueCAw41pntWQRPrVfzmu9sS+2LFGpIZ8zlza4dNme7Q6zyBkrGyeOTDPk
         lQ+TQxc1mSfg20wfCKRCR2P09FOjZLn5+90yNfMjMOxx1OqpL9NNf5cJBNnBsympcTRC
         2XGH6zgn/MlosfhwfIUY0N11X8L1Ub3Sf6Sho8eKfZZYmQoufHP22CEGPhdhpdyKF39R
         uVww==
X-Received: by 10.112.161.38 with SMTP id xp6mr17805615lbb.32.1366816038370;
        Wed, 24 Apr 2013 08:07:18 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id xw14sm1311009lab.6.2013.04.24.08.07.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 08:07:17 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UV1Lr-0007C8-52; Wed, 24 Apr 2013 17:11:19 +0200
Content-Disposition: inline
In-Reply-To: <5177EFCD.1020300@sher.pl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222255>

On Wed, Apr 24, 2013 at 04:44:29PM +0200, Adam Stankiewicz wrote:
> My proposal is to move default bare repository location from .git/mod=
ules
> to .git directory inside submodule, like every normal git repo do.

That's the way it was in old versions of git. The git-file approach was
implemented so git could deal with adding or removing submodules. For
example, if a submodule is not in version HEAD~ and you do a checkout
HEAD~ your working dir should not contain the submodule. (Unfortunately
we are not there quite yet).

> These are my arguments:
>=20
> 1. Why git submodule needs to know in which project it is embedded in=
? Or
> even that it's generally submodule? When cd to submodule, it behaves =
like
> normal repository. Only repository needs to know about its submodules=
=2E

A git submodule doesn't know about it's superproject. All git repos can
be used with git-files. I wouldn't say that a .git-file makes a git rep=
o
aware that it's a subproject (which doesn't even had to be true).

The superproject needs to work with the working-tree, having repo data
in the worktree like svn and cvs is a bad thing. I really like having
all meta data in the same spot.

And there's the "checkout old commit without submodule" problem but
of course, your "mv-approach" would solve this.

> 2. You can't move submodule outside git repository and use it as norm=
al git
> repo. You have to copy bare repo from .git/modules dir.

You can, if you edit .git-file. However in either case your can't use
your superrepo in a sane way if you move out your submodule. So why
would you do that?

If you only need the submodule repo, just clone the submodule repo.

> 3. It's not enough to delete submodule from workingdir to "refresh" i=
t
> later. You have to go to .git/modules directory and delete appropriat=
e
> folder.
>=20
> What about performance on checkouts?

I think that performance penalty is too small to be cared about, if you
look at all the other file access stuff that git does every time.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
