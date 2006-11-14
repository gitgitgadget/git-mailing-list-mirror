X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 20:37:26 +0100
Message-ID: <20061114193726.GG7201@pasky.or.cz>
References: <20061114134958.5326.qmail@science.horizon.com> <200611141815.24236.jnareb@gmail.com> <20061114173657.GC5453@diana.vm.bytemark.co.uk> <200611141845.18930.jnareb@gmail.com> <20061114174939.GB4299@spearce.org> <Pine.LNX.4.64.0611141037120.3327@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 19:38:24 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611141037120.3327@woody.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31365>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk469-0004jD-4l for gcvg-git@gmane.org; Tue, 14 Nov
 2006 20:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966296AbWKNTh3 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 14:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966297AbWKNTh3
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 14:37:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54229 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S966296AbWKNTh2 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 14:37:28 -0500
Received: (qmail 13060 invoked by uid 2001); 14 Nov 2006 20:37:26 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 14, 2006 at 07:40:30PM CET, Linus Torvalds wrote:
> On Tue, 14 Nov 2006, Shawn Pearce wrote:
>=20
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > > Dnia wtorek 14. listopada 2006 18:36, Karl Hasselstr=F6m napisa?:
> > > >
> > > > For example, we could skip the "bisect" branch, since
> > > > you aren't supposed to commit to that anyway.
> > >=20
> > > Well, to have "branch" to which you could not commit, just put re=
f
> > > outside refs/heads.=20
> > >=20
> > > Another solution would be to be able to put non-head ref in HEAD,
> > > but allow to commit only if the prefix is refs/heads/
> >=20
> > That's not a bad idea.  Then you can checkout a tag and have
> > 'ref: refs/tags/v1.11' in HEAD, which means anyone who puts
> > $(git-symbolic-ref) calls into their PS1 will see "refs/tags/v1.11"
> > as their current branch, reminding them they are looking at the pas=
t.

  There's been a brief discussion on a related topic in

	http://news.gmane.org/find-root.php?message_id=3D%3cPine.LNX.4.58.0507=
120938240.17536%40g5.osdl.org%3e

(apparently the Linus-has-another-totally-awesome-idea kind (no irony
(*))).  Before, Cogito did basically what's proposed above to permit
again: storing a random sha1 in the HEAD when it is seeked away to some
historical commit. It switched to using a temporary branch for this
purpose, but I'm not sure about the Linus' reasoning that

	"in order for a "git checkout" to not get confused and possibly
	throwing a cogito temporary head away ..."

which has been apparently clear to me back then. :-(

> I agree. This would probably be a good way to do "read-only branches"=
=2E
>=20
> Allowing people to do a "git checkout" on anything committish, but th=
en=20
> not allowing them to commit to that, is probably the right thing to d=
o.

  So, the basic relaxation is that "again after a year, HEAD does not
have to be a ref at all".

> Together with a nice readable error message from "git commit" (and me=
rge,=20
> and pull - although you might well allow "fetch" to update the thing =
that=20
> current HEAD points to, though), this would be a lot easier to use fo=
r=20
> people who just follow somebody elses branch.

  Hmm, so that there would be something like refs/tracking/master as an
alternative to refs/heads/master? I'm not really sure if it is a good
idea. On one hand, you can relax my favorite fastforward restrictions o=
n
those tracking branches, but I think the net worth is negative since yo=
u
will have to burden new users with yet another concept of "readonly
branches", tell them things like "either do git clone --no-tracking or
the first time you will want to commit something locally, create a
'head' using git checkout -b master HEAD" (you are already on a "master=
"
branch but it's a different "master", you know?) etc.


  (*) You never are ironical about Linus, the Chuck Norris of CS. (And =
a
hero, too!)

--=20
				Petr "Pasky the Wow Pruit Igoe is
					Awesome Too!" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
