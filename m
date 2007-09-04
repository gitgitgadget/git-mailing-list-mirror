From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 0/5] gitweb: Support for arbitrary diffs
Date: Tue, 4 Sep 2007 08:31:51 +0200
Message-ID: <20070904063151.GA17799@auto.tuwien.ac.at>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> <fbfjtl$7gh$1@sea.gmane.org> <20070903013330.GR1219@pasky.or.cz> <200709031023.42366.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 08:32:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRxB-00088H-EX
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 08:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXIDGb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 02:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXIDGb4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 02:31:56 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58009 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXIDGb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 02:31:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C8A85680D668;
	Tue,  4 Sep 2007 08:31:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBo2nk+Pa2nb; Tue,  4 Sep 2007 08:31:51 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 51D81680D42B; Tue,  4 Sep 2007 08:31:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200709031023.42366.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57534>

On Mon, Sep 03, 2007 at 10:23:41AM +0200, Jakub Narebski wrote:
> On Mon, 3 September 2007, Petr "Pasky" Baudis wrote:
>=20
> > To hijack this post a bit, another patch in the queue (the incremen=
tal
> > blame thingie) introduces blame.js. Do you think that we should kee=
p the
> > .js files separate, or instead have one big gitweb.js with everythi=
ng?
> > I'm inclined to the second possibility in order to reduce the numbe=
r of
> > requests, but it comes at a price of slightly worse maintainability=
=2E

Why is the maintainablility reduced?

gitweb.perl is also a collection of different function, which are kept
in one file. Where is the difference to a javascript file?

Keeping everything into one file will make it more likely, that the
code is not developed totally different (in the terms of code style,
variable/function names, ...).

In the moment, there is the problem, which patch should introduce the
js file. We need a common base patch, which introduces an empty
gitweb.js.

Keeping the two functions separate has problems. Every patch need to
hook into the onload event. To avoid merge conflicts, my current patch
saves the old handler and overwrite it with its on version, which
calls back into the saved handler.

If we would have on js file, we can add in the base patch an empty
JavaScript function for this.

Then Hooking in the onload event would mean, to only add some new
lines to the function. The resulting merge conflicts are
easier to resolve (as they affect independet lines) compared to
the current '<body onload=3D"hook1(); hook2();">'

> On the other hand if we have blame.js separate, we could load it
> (require it) only for the 'blame' view, it means only when needed.
>=20
> gitweb.js would contain JavaScript code used by all (or almost all)
> views, then...
>=20
> I don't think gitweb.js would be as large as gitweb.perl, if we are
> talking about maintability ;-)

The size of gitweb.js should not matter. On a modern browser, the
first request will fetch the whole Javascript file. For subseqent
request, the webserver returns "not modified". Having two javascript
file means two checks.

mfg Martin K=F6gler
