From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update_linked_gitdir writes relative path to .git/worktrees/<id>/gitdir
Date: Sun, 07 Feb 2016 15:56:06 -0800
Message-ID: <xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
References: <1454789548.23898.223.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Matt McCutchen <matt@mattmccutchen.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 00:56:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSZBj-0003pQ-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 00:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbcBGX4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 18:56:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752807AbcBGX4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 18:56:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FBC9434F4;
	Sun,  7 Feb 2016 18:56:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=35gFFlRZxFXR
	7AnbPpzI5fqxlfk=; b=kEDRm+OHtYB8PpQBWubisfb5AATgMtLJJVrkOACQ65du
	YP+RmZRNp+Q4TWSnDjxsZRaIoo3LC7QXeZiX8LQTsNGY0j/HWpvMZzvKCiafA/Ul
	ebp00J/IO9u0XJloOFXlQ7hYJbQZRntkM+SWEhQe/kmkR1smnd36i894wrZqbUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=knbiUh
	T9RSz9irHVGqYXQa21oCcdupsrNpWkBIDfQpErp/Dm1VVN3WJRbG1lSN31QwBkHv
	eVtca4sLI238ItzctwHPBQcTlJk5gSRmBE+SzmKBpzNqRekaBHIvPhZC4me4ys+Z
	9SNURsJUGy9xaZ1wgeX2xbMCB6J4pZW5Fj6tY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5727D434F3;
	Sun,  7 Feb 2016 18:56:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0746434F2;
	Sun,  7 Feb 2016 18:56:07 -0500 (EST)
In-Reply-To: <1454789548.23898.223.camel@mattmccutchen.net> (Matt McCutchen's
	message of "Sat, 06 Feb 2016 15:12:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B18AE8C-CDF6-11E5-BD8C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285739>

Matt McCutchen <matt@mattmccutchen.net> writes:

> I noticed that when update_linked_gitdir chooses to update
> .git/worktrees/<id>/gitdir, the path it writes is relative, at least
> under some circumstances. =C2=A0This contradicts the gitrepository-la=
yout
> man page, which says:

Duy, is it safe to say that the fix has already been cooking in
'next' as nd/do-not-move-worktree-manually topic, we are about to
solve this by merging down to 'master', _and_ it is very much
appreciated when reporting bugs people check if a presumed fix is
already cooking in 'next', try it to verify if it really fixes their
problem, and send in a "OK fix is good" / "No that does not fix my
case"?

>
> worktrees/<id>/gitdir::
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A text file containin=
g the absolute path back to the .git file
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0that points to here.
>
> IIUC, this behavior defeats one of the three safeguards that is
> supposed to prevent "git worktree prune" from pruning information for
> worktrees that still exist.
>
> A simple script to reproduce:
>
> #!/bin/bash
> set -e -x
> rm -rf repo worktree2
> git init repo
> cd repo
> touch foo
> git add foo
> git commit -m 'dummy commit'
> git worktree add ../worktree2 -b branch2
> cat .git/worktrees/worktree2/gitdir
> touch -d '2 days ago' .git/worktrees/worktree2/gitdir
> (cd ../worktree2 && git status)
> cat .git/worktrees/worktree2/gitdir
>
> Trying this on master as of earlier today (ff4ea60), I get:
>
> [...]
> /PATH/REDACTED/worktree2/.git
> [...]
> .git
>
> Matt
