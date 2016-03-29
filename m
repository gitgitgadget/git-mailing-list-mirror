From: John Keeping <john@keeping.me.uk>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 13:33:07 +0100
Message-ID: <20160329123306.GD1578@serenity.lan>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akspm-0004Fm-B3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 14:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbcC2MdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 08:33:20 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:37387 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcC2MdT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 08:33:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BD322CDA5A9;
	Tue, 29 Mar 2016 13:33:17 +0100 (BST)
X-Quarantine-ID: <dNINaEQnNeQR>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dNINaEQnNeQR; Tue, 29 Mar 2016 13:33:14 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 7DAAACDA62D;
	Tue, 29 Mar 2016 13:33:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290123>

On Tue, Mar 29, 2016 at 06:53:35AM -0500, Elliott Cable wrote:
> On Tue, Mar 29, 2016 at 6:42 AM, Elliott Cable <me@ell.io> wrote:
> > So, I find this behaviour a little strange; I can't determine if it=
's
> > a subtle bug, or intentionally undefined/=E2=80=98fuzzy=E2=80=99 be=
haviour ...
>=20
> Oh lord, it gets worse ...
>=20
> $ cd a-repo
> $ git rev-parse --is-inside-work-tree; git rev-parse --is-inside-git-=
dir
> true
> false
> $ cd .git
> $ git rev-parse --is-inside-work-tree; git rev-parse --is-inside-git-=
dir
> false
> true

I believe these are working correctly, the .git directory is not part o=
f
the working tree.

> $ export GIT_WORK_TREE=3D"$(git rev-parse --show-toplevel)"   # !!!

Did you check the value of GIT_WORK_TREE here?  When I try it's the
empty string.

If I set the core.worktree config variable to ".." then rev-parse does
find the working tree correctly.  I recall some previous discussion
about this but I can't find it in the list archives from a quick search=
=2E

> $ git rev-parse --is-inside-work-tree; git rev-parse --is-inside-git-=
dir
> true
> false
> $ # !!?!?
>=20
> So, basically, if `$GIT_WORK_TREE` is set at all, it appears that the
> `rev-parse --is-inside...` flags don't function reliably at all.

If you set GIT_WORK_TREE you're telling Git to override all of the
normal detection logic.  What version of Git are you using?  When I try
this it says:

	fatal: The empty string is not a valid path

If I set GIT_WORK_TREE to the correct value for this repository then it
behaves the same as with the auto-detection logic.
