From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Wed, 2 Dec 2009 00:12:17 +0800
Message-ID: <be6fef0d0912010812i54531ce0n18e4615c3f408569@mail.gmail.com>
References: <25718488.post@talk.nabble.com>
	 <20091127234110.7b7e9993.rctay89@gmail.com>
	 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
	 <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
	 <20091201160150.GB21299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Martin Storsj?" <martin@martin.st>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:12:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVL4-0001aw-5x
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbZLAQMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 11:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZLAQMM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:12:12 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:43810 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbZLAQML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 11:12:11 -0500
Received: by iwn1 with SMTP id 1so3166114iwn.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hqMhmKpo4+WWfXEmsA+ANZv/SEyf4ZDn9Ii9CIt529U=;
        b=EaKJ2ZuU7YSdkgrCdRq2lmBEgUPhcKCe+vxYvEz2B/TL6bTjKzsdgOg1d3STSKcwIo
         mM+pVNJhrrGmVLFkcu62l2fpcSAJTyeyI/7ZGic0wdWuBvQSTrX13fuQXK6KIMSlBLQB
         EbWIz31gRHI5vX4EGSbx1h80cJzC9p+P6uuK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hx+P2wji7tuu68QPtalMcb9/fL/NGmo/FK/RQqop1qZtX22WgRRg5O5NhbG8mUA9Fg
         gs28KiskkacPI7tSn0vYvtCkbQWh2Lemci+yK7twB72gPgrwTPTlK2oqSnLh/1o+43+R
         9/Z00mXM5e8rktjD3jusPugGX5kLsoPIn5B6w=
Received: by 10.231.123.216 with SMTP id q24mr147351ibr.43.1259683937731; Tue, 
	01 Dec 2009 08:12:17 -0800 (PST)
In-Reply-To: <20091201160150.GB21299@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134218>

Hi,

On Wed, Dec 2, 2009 at 12:01 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> In theory, since the cURL session stays active, we would have
> received the 401 authentication error during the initial
> "GET $GIT_DIR/info/refs?service=3Dgit-$service" request, and the subs=
equent
> "POST $GIT_DIR/git-$service" requests would automatically include the
> authentication data.
>
> That's theory. =A0Reality doesn't always agree with my theories. =A0:=
-)

that's because the curl session where the 401 was received (and thus
successful authentication takes place) is closed.

I sent out a patch series recently which contains a patch to maintain
at least one curl session throughout a http session (from http_init()
to http_cleanup()), you can see this here:

  http://www.spinics.net/lists/git/msg118190.html

--=20
Cheers,
Ray Chuan
