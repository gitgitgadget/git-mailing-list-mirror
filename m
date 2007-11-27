From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:58:33 -0500
Message-ID: <20071127015833.GL14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com> <20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwpiy-0000Xj-AK
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbXK0B6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 20:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXK0B6i
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:58:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43859 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbXK0B6h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 20:58:37 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IwpiS-0004Hy-SZ; Mon, 26 Nov 2007 20:58:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 06ECF20FBAE; Mon, 26 Nov 2007 20:58:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <fifstd$ilj$1@ger.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66158>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
>=20
> [git-gui in XUL]
>=20
> > But XUL doesn't support launching a process and connecting pipes
> > to its stdin and stdout. =C2=A0I started to try and create an XPCOM
> > extension to provide that functionality from NSPR and started to
> > run into major problems compiling the XPCOM plugin, getting the
> > necessary interfaces implemented, etc.
>=20
> What about Ajax / Comet support in XUL, Can this be used for that?
> (Just an [perhaps stupid] idea).

Yes, XUL fully supports AJAX.  If it didn't Google Maps and its
cool interface wouldn't exist.  :-)

The problem there is that AJAX requires HTTP.  So I'd have to
create a "micro HTTP server" that runs on the loopback interface
and listens for HTTP requests from the GUI, parses them, runs the
necessary Git action, then sends the results back to the GUI.

Sort of ugly.

My bigger concern is also for a shared machine; how do I secure
the HTTP server so only the git-gui process that is supposed to
be using it is able to access it?  I guess I could create a 600
~/.gitguicookie file or some such entity and throw random data into
it to initialize it.  That's basically all xauth is doing.


Actually I might revisit this XUL concept using an HTTP server and
AJAX.  I could actually link the damn HTTP server against libgit.a
(Junio will hate me).  If the server dies XUL can notice it and
simply restart it.  But there's a whole suite of actions that I
can run through the internal APIs with high chances of success,
and a lot quicker than forking the corresponding plumbing process,
especially on fork challenged machines like Windows.

--=20
Shawn.
