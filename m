From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Mon, 19 Mar 2007 23:03:39 +0100
Message-ID: <20070319220339.GA26080@auto.tuwien.ac.at>
References: <20070317151731.GA32571@auto.tuwien.ac.at> <Pine.LNX.4.63.0703171902200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318141451.GA9607@auto.tuwien.ac.at> <200703190020.55806.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTPxD-0004TM-HQ
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 23:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbXCSWDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Mar 2007 18:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030687AbXCSWDo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 18:03:44 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58983 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030624AbXCSWDm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 18:03:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4A13B7128018;
	Mon, 19 Mar 2007 23:03:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1slEljMZE5fF; Mon, 19 Mar 2007 23:03:39 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 82EBB7128010; Mon, 19 Mar 2007 23:03:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200703190020.55806.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42673>

I tried to merge the two thread.

On Sun, Mar 18, 2007 at 10:55:59PM +0100, Jakub Narebski wrote:
> On Sun, Mar 18, 2007, Martin Koegler wrote:
> > On Sat, Mar 17, 2007 at 10:51:51PM +0100, Jakub Narebski wrote:
> > Let's focus on the UI first:
> >=20
> > Using a select box, as shown above, exposes only a small part of al=
l
> > possible combinations, eg. how to compare commits on different
> > branches.
>=20
> I assume you meant "e.g. it doesn't provide a way to compare commits
> on different branches".

Yes

> We can easily add selectbox not only for shortlog and history views,
> but also for heads view (which would allow to compare tips of differe=
nt
> branches) and tags view (which would allow to compare [commits pointe=
d
> to by] different tags).
>=20
> Although there is yet another limitation, namely that shortlog and
> history views are divided into pages...

To avoid all those problems, I tried the generic approach with "(base |=
 diff)"
=20
> > In my solution, I add to each link to a compareable object (commit,
> > tree, blob) two new link, eg: link "commit" becomes "commit (base |
> > diff)". "base" stores the ID of the object in a cookie. "diff"
> > retrieves the cookie and compares it with it's associated object.
>=20
> Well, I haven't though of it being a problem, because _I_ can have
> always handcraft an URL to get requested diff from gitweb.

I want a comfortable solution. Additionally, this can only be done by
a user, who knows about the internals of gitweb.

> But after some thinking I guess that your idea has some merit
> _provided_ that "(base | diff)" (by the way, what would happen
> if someone would click "diff" without setting "base" first? is
> "diff" inactive, or is some "base" default?) is added _only_ when

In my JavaScript solution, the user gets a message box in this case:
"no base object selected".

> web browser supports it. It means that it should appear only when
> JavaScript is turned on (easy if links are added by JavaScript)
> and when cookies are turned on (I'm not sure if you are checking
> this).

No, there is no check at the moment. Buts this is basically checking
the navigator.cookieEnabled property. A user could only reject some
cookies, but catching this would probably be too complicated.

> I guess that we could (under control of gitweb configuration, %featur=
e
> hash or something like that) add links which would lead to server
> setting a cookie, or adding unused CGI parameters ('hp', 'hpb' and
> 'fp' are used only by 'diff' views).

Yes, but I would you a new set of parameters for it (eg bf, bh, bhb), s=
o that a
possible (future) fallback version without cookies can reuse them.
=20
> > Currently, only few combinations are implemented. Future version co=
uld
> > integrate tags (as an tag links to one commit). Additionally,
> > comparing tags/commits with a tree could be enabled, as a tag/commi=
t
> > link to one tree.
>=20
> Diffs makes sense only between two commit-ish (commit-ish being commi=
t
> or a tag; head also denotes a commit) for which we need 'h' and 'hp'
> params,  between two tree-ish (tree-ish being tree, commit or a tag)
> for which we need 'h'/'hb' and 'hp'/'hpb' and usually 'f', sometimes

=46or tree diffs, I currently only support h/hp. Using hb/hbp and f/fp
would require, that both trees share the same file name.

> 'fp', and finnally between two blobs, for which we need 'h'/'hb' and
> 'hp'/'hpb' and usually 'f', sometimes 'fp'.

=46or blob diffs, I prefer to use only h/bp (and f/fp for showing nice
file names). I fall back to hp/hb and f for the blobs in the history
views (where h is not available), which has the drawback, that both
blobs must have the same name.

> There makes no sense to compare tree-ish with blob, for example.

Yes.

> By the way, I'm not that sure if gitweb handle correctly request for
> diff of two _different_ tree-ish, or two arbitrary different files.

If you use not hb/hbp, this works.

> > 1) introduce git_treediff
>=20
> NOTE: git_treediff is in some parts very similar (I think) to
> git_commitdiff with the exception of not being there commit message,
> nor links to parents, and I'd like very much to avoid code repetition
> (duplication) betweem git_treediff and git_commitdiff if possible.
> On the other hand git_treediff is similar to git_blob in handling
> its parameters ('h', 'hp' but also 'hb', 'hpb' and 'f', 'fp').

I created git_treediff out of git_commitdiff.

> > If depending on cookies is a problem for some out there, the base
> > object can be passed in the URLs as fallback. It would require, tha=
t
> > the select base object is included in every link, which gitweb
> > generates.
>=20
> Not much of a problem. Generation of links is consolidated in href()
> subroutine, and it would be fairly easy to add passing through base
> parameters, if they are needed or not. It means that if 'shortlog' vi=
ew
> was passed 'hp' parameter then "diff" links (or "diff <sha1>" links,
> or "diff sel"/"diff selected" links) would lead to diff with given ba=
se.

> First, generating gitweb links in gitweb _all_ goes through href()
> subroutine, so it would be fairly easy to implement it server side,
> i.e. directly in gitweb.perl.=20

This has on complication: href only generats the url. The link is
generated in the caller. We would need a new wrapper for this.

[...]

> > For me, this would be no problem, but for high load servers (eg. gi=
tweb at
> > kernel.org), it would incread the system load.
>=20
> I think use JavaScript if possible, and server-side implementation
> if not would be good compromise.

I'll try to implement a solution for this.

> I'm just wondering why did you not used git for development. You have
> to have git installed to test gitweb, and it would be best to have
> git.git repository fetched to base your work on newest 'master' versi=
on
> (or rather 'origin/master' or 'origin' version). So it would be natur=
al
> to use git to work on gitweb, and to send git patches.

gitweb.cgi is generated out of gitweb.perl. Then I need to manually
change some parameters in it and put it on a webserver. For
developing, it's easier for me to edit the cgi-script on the
server. In a diff of gitweb.cgi, I have to remove the unrelated
changes, for eg. setting paths parameters.

I would be interessted, how git can help me in this workflow?

> > As I wrote in my last mail, I used blobdiff to generation tree diff=
s,
> > which results in wrong/missing file names. In the mean time, I've
> > create a first version of a treediff function for gitweb.
>=20
> Which is IMVHO long way from ready.
>=20
> > --- old/gitweb.js   2007-03-17 15:18:23.284317140 +0100
> > +++ gitweb.js        2007-03-17 22:25:18.254190096 +0100
>=20
> First, if you don't use git to generate diffs, could you _please_
> use equal depth paths patches, i.e. either=20

I'll try to produce better patches in the future.

> > @@ -1835,6 +1837,7 @@
> >  		close $fd;
> >  	}
> > =20
> > +	print '<script type=3D"text/javascript" src=3D"gitweb.js"></scrip=
t>';
> >  	print "</body>\n" .
> >  	      "</html>";
> >  }
>=20
> I'd rather have end of line after closing '</script>', and have scrip=
ts
> in the head section, not in body.

=46or my prototyp, it was easier put the script at the end. Putting it
in the header would require, that I call the JavaScript load function
in the body onload event. In the end version, I'll change that.

> > @@ -4191,6 +4194,106 @@
> >  	git_commitdiff('plain');
> >  }
> > =20
> > +sub git_treediff {
> > +	my $format =3D shift || 'html';
> [...]
>=20
> You base git_treediff on git_commitdiff. On one hand it is right, as
> treediff is like commmitdiff, but without commit message, nor link to
> commit parents.
>=20
> On the other hand you should be able to handle 'hb', 'hpb', 'f', 'fp'
> parameters like git_blobdiff does. And making git_difftree work betwe=
en
> two different trees from two different commits (e.g. git-gui/ in git.=
git
> mainline and / in git-gui.git mainline) is not that easy...

Compaing this (if git-gui.git history is part of git.git), already
works.  It's currently simple, as I ignore hb. The diff would be
relativ (that means, that git-gui/ in git.git would be a/ and / in
git-gui.git would be b/).=20

Do git-diff-tree offers an option to compare in two trees two
different file names? If not, using hb would require, that both trees
have the same name. In this case, as all tree links seems to have h, I
see no use for hb/hpb.

mfg Martin K=F6gler
