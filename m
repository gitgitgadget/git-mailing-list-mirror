From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Thu, 22 Nov 2007 02:02:09 -0800
Message-ID: <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	<200711211752.40264.jnareb@gmail.com>
	<Pine.LNX.4.64.0711211658510.27959@racer.site>
	<200711211811.34391.jnareb@gmail.com>
	<Pine.LNX.4.64.0711211719330.27959@racer.site>
	<8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8tJ-00009y-Fm
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXKVKCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 05:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbXKVKCT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:02:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60637 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbXKVKCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:02:19 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B4A0A2EF;
	Thu, 22 Nov 2007 05:02:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 30150965F8;
	Thu, 22 Nov 2007 05:02:34 -0500 (EST)
In-Reply-To: <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Thu, 22 Nov 2007 10:42:42
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65769>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> Sorry but I do not understand this. I think this two lines could be e=
quivalent:
>
> git push --bundle bundle.bdl "refs/heads/master:refs/remotes/bundle/m=
aster"
> git bundle create bundle.bdl refs/heads/master ^refs/remotes/bundle/m=
aster

Interesting.

	$ git push $something ours:theirs

has defined semantics for any value of $something.

 * give $something objects it lacks, so that the object $ours
   become complete in there;

 * set the ref in $theirs to point at the object $ours.

So "git push bundle.bdl refspec" should:

 * First read bundle.bdl, to find out what objects it gives to
   the recipients;

 * Add missing objects to it to make it up to date wrt "ours",
   iow, fetching from the updated bundle would now give "ours";

 * Record the object "ours" as "theirs" ref, iow, listing
   the updated bundle would show "theis" ref pointing at that
   object.

If bundle.bdl does not exist yet, it is like pushing into a
freshly initialized empty repository.
