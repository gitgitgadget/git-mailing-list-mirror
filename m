From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH/RFC 10/10] gitweb: Create links leading to
	'blame_incremental' using JavaScript
Date: Mon, 27 Jul 2009 20:10:46 +0200
Message-ID: <20090727181046.GA30365@auto.tuwien.ac.at>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <1248475450-5668-11-git-send-email-jnareb@gmail.com> <20090725104622.GA7337@auto.tuwien.ac.at> <200907261206.15646.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:11:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVUf7-0006BG-QM
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbZG0SKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 14:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbZG0SKs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:10:48 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:44473 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZG0SKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:10:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 99A30130397C;
	Mon, 27 Jul 2009 20:10:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFKBrr3kGMEf; Mon, 27 Jul 2009 20:10:46 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 852861000186;
	Mon, 27 Jul 2009 20:10:46 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id 7D2E96800645; Mon, 27 Jul 2009 20:10:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907261206.15646.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124177>

On Sun, Jul 26, 2009 at 12:06:11PM +0200, Jakub Narebski wrote:
> On Sat, 25 Jul 2009, Martin Koegler wrote:
> > On Sat, Jul 25, 2009 at 12:44:10AM +0200, Jakub Narebski wrote:
>=20
> > > TODO list:
> > > * Perhaps put fixLinks() function in separate file gitweb.js.
> > >   Should gitweb use single JavaScript file, or should it be split=
 into
> > >   more than one file?
> >=20
> > The same question can be asked for gitweb itself:
>=20
> Well, there is one important difference: gitweb itself is not send
> over network to client.  JavaScript is.  (Although I'm not sure how
> great it is of an issue, with browsers caching JavaScript.  Perhaps
> one single file would be better idea.)

More files mean more request on the server. If the browser is
configured to check at each request, it will issue a GET for each
JavaScript file, which will be answered by a 304 after the first
request. In the "automatic mode", the browser waits for some time
(determined by a heuristic), before it will issue a GET for each file
request again.

So in my option, on (bigger) file is better, as it means fewer request.

> >=20
> > Why is it a single perl file and not splited in many different
> > modules?
>=20
> 2. Having it all in single file make its easy to install and update.
>    Well, it made more sense when only way to configure gitweb was to
>    edit gitweb.cgi.  Now building gitweb.cgi is the task for build
>    system, and the only thing left is to copy files in correct place
>    (I think that there are distribution specific packages which makes
>    installing gitweb as easy as "xxx install gitweb").

Yes, there are gitweb packages, which automaticially server
repositories under a specific path (eg. /srv/git). For such packages,
the js layout is irrelavant.

When manually installing, copying only one javascript file simplifies
the deployment.

> 3. You would have to decide _how_ to split it into many different=20
>    modules.  Do you know any good examples?

Javascript uses on global namespace. If it is one file, its implicitly
clear, that everything (functions, variables) are in one scope.  If
you split it into multiple files, you have to remember, what the other
files contain.

mfg Martin K=F6gler
