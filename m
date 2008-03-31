From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Sun, 30 Mar 2008 19:06:16 -0700
Message-ID: <7vr6drsl47.fsf@gitster.siamese.dyndns.org>
References: <20080330231408.GR11666@genesis>
 <20080330232612.GA23063@atjola.homenet>
 <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 04:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg9Qi-0000zc-D5
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 04:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYCaCGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 22:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbYCaCGe
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 22:06:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbYCaCGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 22:06:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DE1431A05;
	Sun, 30 Mar 2008 22:06:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 201AA1A00; Sun, 30 Mar 2008 22:06:25 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 30 Mar 2008 16:46:51 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78543>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 31 Mar 2008, Bj?rn Steinbrink wrote:
>>=20
>> The /proc stuff is already deprecated IIRC, the new file to check on
>> Linux is /sys/class/power_supply/AC/online.
>
> I would *seriously* suggest making this soem kind of generic callback=
 and=20
> not Linux-specific.=20
>
> How about making it more akin to a pre-auto-gc "hook" - run a script=20
> instead of hardcoding something like this!

That would be a sensible approach.

We also would need to make sure that Porcelain that call "gc --auto" do=
es
not have an assumption that auto is ultra-cheap, however, as we are
talking about potentially two fork-exec in the usual "noop" case with s=
uch
a change, but we need to do that regardless.

 * git-svn has "every 1000 commits and one at the end" which should be
   Ok.

 * git-cvsimport does "repack -a -d" every 1k commits and once more at =
the
   end if there are many remaining loose objects.

 * "git-rebase -i" does one at the end, which should be Ok.

 * "git commit" used to have one at the end in the scripted version, bu=
t
   seems to have lost it in C rewrite.

So I think we are Ok with an additional hook.

By the way, Linus, is your MUA UTF-8 challenged?  I see Bj=C3=B6rn's na=
me on
the To: header mangled.
