From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Thu, 6 Oct 2011 08:50:22 -0700
Message-ID: <CAJo=hJvWbjEM9E5AjPHgmQ=eY8xf=Q=xtukeu2Ur7auUqeabDg@mail.gmail.com>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 17:50:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqDg-0000go-39
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 17:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940Ab1JFPun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 11:50:43 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42641 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935529Ab1JFPun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 11:50:43 -0400
Received: by ggnv2 with SMTP id v2so1840686ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 08:50:42 -0700 (PDT)
Received: by 10.42.153.6 with SMTP id k6mr5235966icw.30.1317916242314; Thu, 06
 Oct 2011 08:50:42 -0700 (PDT)
Received: by 10.42.4.68 with HTTP; Thu, 6 Oct 2011 08:50:22 -0700 (PDT)
In-Reply-To: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182961>

On Wed, Oct 5, 2011 at 17:56, Junio C Hamano <gitster@pobox.com> wrote:
> And this uses the gpg-interface.[ch] to allow signing the commit, i.e=
=2E
>
> =A0 =A0$ git commit --gpg-sign -m foo
> =A0 =A0You need a passphrase to unlock the secret key for
> =A0 =A0user: "Junio C Hamano <gitster@pobox.com>"
> =A0 =A04096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID=
 713660A7)
>
> =A0 =A0[master 8457d13] foo
> =A0 =A0 1 files changed, 1 insertions(+), 0 deletions(-)
>
> The lines of GPG detached signature are placed in new header lines, a=
fter
> the standard tree/parent/author/committer headers, instead of tucking=
 the
> signature block at the end of the commit log message text (similar to=
 how
> signed tag is done), for multiple reasons:

I like this approach better than the prior "push certificate" idea.
The signature information is part of the history graph, and won't be
stripped or forgotten to be published as commits flow through
development trees, provided that the commit SHA-1 was preserved by not
doing a rewrite. There is no merge race on the server side to get a
branch updated.

The signature is automatically stripped by older Git tools like commit
--amend, format-patch or rebase, where the signature would be made
invalid anyway by changing the tree, parent or committer. That is a
nice bit of backward compatibility there. Of course there is some
concern this signature data will show up incorrectly on clients that
are so ancient they don't understand the "encoding" header, but those
clients are already very ancient, and already do not process encoding
correctly.

--=20
Shawn.
