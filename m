From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Wed, 28 Jul 2010 16:26:54 +0200
Message-ID: <vpq1van3cnl.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTinvVFvu7WvwrRC0sg8vhoepFXKewmuTr7S94LWk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jul 28 16:27:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7b7-0006kP-Ri
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0G1O07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 10:26:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41245 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab0G1O06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:26:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6SEP8mk008361
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 16:25:08 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oe7aw-00048b-Mg; Wed, 28 Jul 2010 16:26:54 +0200
In-Reply-To: <AANLkTinvVFvu7WvwrRC0sg8vhoepFXKewmuTr7S94LWk@mail.gmail.com>
 ("Santi =?iso-8859-1?Q?B=E9jar=22's?= message of "Wed\, 28 Jul 2010
 16\:12\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 16:25:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6SEP8mk008361
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280931910.58211@XAbnap6EGkZK0ScXmqqWdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152092>

Santi B=E9jar <santi@agolina.net> writes:

> $ git run HEAD^4.. command arguments
>
> (I'm not quite sure about the syntax). Something like "git bisect run=
"
> but for all the commits in the range.
>
>  I know you said "given points in history", maybe each approach is
> useful for each use case.

Yes, I think both approaches make sense.

The cool thing with my version is that you're already in an
interactive rebase, which means:

* You can re-order commits, rebase them on upstream branch, and check
  the result in one pass.

* You're ready to ammend commits if they need fixing.

Also, you may not need to re-check everything for each commit. You may
want a todo-list like this

pick deadbee log.c: do something
run make
pick c0ffeee Documentation for something
run make doc

or whatever. Note also that this "git run" can easily be implemented
on top of my patch:

GIT_EDITOR=3D"sed -i 's/^[^#].*/\0\nrun make/'" git rebase -i

we can also imagine a "git rebase -i --run=3Dcmd" that would prepare a
todo-list with "run cmd" after each pick line.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
