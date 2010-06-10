From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Thu, 10 Jun 2010 08:31:05 -0700
Message-ID: <87pqzyhpl2.fsf@yoom.home.cworth.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org> <87eiggiy8g.fsf@yoom.home.cworth.org> <7vaar3nds1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 17:31:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMjj8-000385-FU
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 17:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341Ab0FJPbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 11:31:25 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:42891 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0FJPbY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 11:31:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id C855D4196F2;
	Thu, 10 Jun 2010 08:31:23 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmF+LfXF8Vzd; Thu, 10 Jun 2010 08:31:13 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id DA919431FC1;
	Thu, 10 Jun 2010 08:31:12 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id 8D86A568E9B; Thu, 10 Jun 2010 08:31:12 -0700 (PDT)
In-Reply-To: <7vaar3nds1.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.3.1-61-ge870437 (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148883>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jun 2010 07:49:34 -0700, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Carl Worth <cworth@cworth.org> writes:
> Please disregard the above; I wasn't thinking straight.

No worries.

> If your format-patch quotes ">*From " in the log message, and you unquote
> it somewhere in mailsplit to mailinfo pipeline, then the only time any
> funny interaction between the current git and your git would happen is
> when your git formats a commit with a line in its log that begins with
> "From " that cannot be a mistaken as a UNIX-From line and you use "am"
> from the current git on the output; the resulting commit would get an
> extra ">" left in the message, but that is a small price to pay.

Correct. That's the only downside I see. And it's clearly not a huge
price. Checking the entire git.git history, I found only 12 messages
that have a line beginning with "From " in the commit message, (ignoring
the 5 I referred to earlier where the mbox line actually ended up in the
commit message). Of these, three already have a ">From" in them.

So clearly this kind of thing is happening already. People are sometimes
using systems that quote these lines and git isn't un-quoting. But it's
really not that objectionable in the end.

> There is
> no other downside I can see (and the upside is that the output from your
> format-patch won't be split incorrectly, of course).

Good. And this series does fix actual bugs like the failure to rebase
across a message with a "From ... <timestamp>" line as mentioned before.

> I find that the change to format-patch not to emit the UNIX-From line when
> generating one file per commit is somewhat iffy.  An upside is that the
> existing mailsplit-mailinfo pipeline already knows not to split such an
> input, so the change makes

This patch was written to reduce the likelihood of the downside
mentioned above. But I understand the potential costs you outlined.
I'll let you make the call on whether to include it. The rest of the
patch series will work fine without this one. But leaving it out will
lead to more occurrences of undesired ">From " in commit messages, (even
with new "git am" as send-email or some other MUA will see the quoted
">From " and treat it as the intended payload, not an escaped "From ").

> It is nice at the conceptual level, though.  By declaring individual file
> RFC2822 message (not mbox), it makes it very clear that it is MUA's
> responsibility to quote "From " in the payload when the output is used by
> MUA to compose and send a message.  IOW, we shouldn't be doing the quote
> in our output when operating in that mode.

I suppose we could maintain compatibility with any scripts, etc. by
still emitting the initial "From " line, but declaring these files as
messages (not mbox) and avoiding doing any quoting for them.

I think that gets us all the upsides with no downsides. I'll send one
last patch for that.

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMEQU56JDdNq8qSWgRAtyYAJ0QMg/OpLgT/EMihNq87TKcjo01HACfVs+V
OJ/fnedxKYJAFzIvnMJlK4A=
=AhsV
-----END PGP SIGNATURE-----
--=-=-=--
