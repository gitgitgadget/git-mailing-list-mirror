From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 4/5] gitweb: Selecting diffs in JavaScript
Date: Sun, 26 Aug 2007 18:17:01 +0200
Message-ID: <20070826161701.GA3300@auto.tuwien.ac.at>
References: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121315-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121911-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926122089-git-send-email-mkoegler@auto.tuwien.ac.at> <20070826011742.GF1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKna-00030a-9o
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbXHZQRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbXHZQRI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:08 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33427 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8961C73B5FB5;
	Sun, 26 Aug 2007 18:17:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFXgAASzSsmw; Sun, 26 Aug 2007 18:17:02 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 010A06870AD3; Sun, 26 Aug 2007 18:17:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070826011742.GF1219@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56695>

On Sun, Aug 26, 2007 at 03:17:43AM +0200, Petr Baudis wrote:
> On Sun, May 20, 2007 at 10:23:31PM CEST, Martin Koegler wrote:
> > The adds support for selecting arbitrary diffs, if the client brows=
er supports
> > JavaScript.
> >=20
> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
>=20
> JFYI, I've just enabled it on repo.or.cz experimentally. Please anyon=
e
> tell me what you think.

I would also be interessed in this.

> (Just click at almost any view in gitweb and marvel at the extra base
> and diff links smiling everywhere.)
>
> I'll dump my mind state here, horribly sleepy. Sorry for the
> incomprehensible rant. :-)

I can't see them.

http://repo.or.cz/w/git/repo.git?a=3Dsearch&h=3DHEAD&st=3Dgrep&s=3DGitA=
ddLinks
reveals, that the function GitAddLinks is never called.
You should add a call to GitAddLinks in fixBlameLinks or call
both functions in <body onload=3D"...">.

> One thing for certain is that I would get rid of GitAddLinks and inst=
ead
> have href() add the extra links there, by default display: none and
> javascript code making it show.

display: none will only work in CSS capable browses, but not text
browsers. Also why do we want do increase the size of each generated
page?

> Also, there are obvious UI bugs, like
> commit and tree entries for commits having redundant base/diff links;

Is this really a bug? I think it makes the interface more consistent.

Would it be clear for a (new) user, why some tree entries have the
base/diff links and some not?

> and Firefox doesn't expand table cells properly for the additional
> links. None of these bugs is easily fixable I think.

In which context?

In eg. http://repo.or.cz/w/git.git?a=3Dlog;h=3Dgitgui-0.8.1, there are
display errors (even without the base/diff links), if the font size is
zommed.  In this case, the problem is that there is no real
table. The links (div.log_link) are position: relative, so they don't
increate the height of the enclosing div. Additionall it has an hardcod=
ed
width in pixels.

> But maybe it needs more general overhaul and the links added explicit=
ly
> in the views, because it really makes sense to have only a single
> linkpair per entry and it would be good to have this always at the sa=
me
> place, and perhaps in a different color. Hmm. And it seems that it's
> getting in the way, overally.

Unless this should be come part of the official gitweb, adding each
link explicitly would be a maintaince nightmare.

Changing the color of the base/diff links is no problem. If somebody
is interessed in this (and tells me, which colors I should use), I can
adapt my patch.

> What about having another item in the main action menu, 'diff'?
> Base/diff links are by default display: none but show up when you cli=
ck
> at 'diff', in green. They will keep showing up until you click 'diff'
> again. When you click 'base', both the selected base link and main
> 'diff' link changes color to red.

We could call GitAddLinks, if the user clicks on the diff link instead
of calling GitAddLinks at page load time.

I could rewrite the JavaScript for this, if you think it is so more use=
ful.

mfg Martin K=F6gler
