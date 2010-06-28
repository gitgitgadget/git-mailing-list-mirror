From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too
 early
Date: Mon, 28 Jun 2010 05:40:34 -0400
Message-ID: <20100628094033.GA18629@coredump.intra.peff.net>
References: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 11:41:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTApo-00041k-Uy
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 11:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab0F1Jkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 05:40:45 -0400
Received: from peff.net ([208.65.91.99]:34190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab0F1Jko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 05:40:44 -0400
Received: (qmail 18381 invoked by uid 107); 28 Jun 2010 09:41:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 28 Jun 2010 05:41:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jun 2010 05:40:34 -0400
Content-Disposition: inline
In-Reply-To: <20100626192203.GA19973@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149825>

On Sat, Jun 26, 2010 at 02:22:03PM -0500, Jonathan Nieder wrote:

> Here=E2=80=99s a fix from the famous setup cleanup series[1].
>=20
> The problem it fixes is somewhat obscure: =E2=80=98git -p foo=E2=80=99=
 is not paying
> attention to the repository-local =E2=80=98[core] pager=E2=80=99 conf=
iguration when
> run from a subdirectory.  But it is a real bug, and the fix gives
> an example of how to deal with repository setup and should be safe.
>=20
> Patch is against master.  There is a small semantic conflict with
> jn/grep-open: SIMPLEPAGER should be changed to SIMPLEPAGERTTY in the
> prerequisites for the test_default_pager function.  Please let me
> know if I should push a merge commit to help resolve that.

I just read through the patches, and it seems like a reasonable fix. So
in that sense, ACK.

But reading the message for patch 4/4, I can't help but wonder if the
right way forward is for the git wrapper to _always_ find the repositor=
y
as the very first thing. I.e., make finding the repository a
non-destructive thing (especially don't end in a different directory),
and just do it before we run any other code.

=46or a few commands like "init" or "clone", we would end up just
ignoring this information, but the worst case should be a little bit of
wasted effort.

And then all these silly setup and timing issues could just go away, as
we would know that GIT_DIR and GIT_WORK_TREE would be set properly.

-Peff
