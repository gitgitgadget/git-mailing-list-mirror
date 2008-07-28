From: Sam Vilain <sam@vilain.net>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Mon, 28 Jul 2008 19:02:50 +1200
Message-ID: <1217228570.6750.24.camel@maia.lan>
References: <488D42B6.4030701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gittorrent@lists.utsl.gen.nz, git@vger.kernel.org,
	Jonas Fonseca <fonseca@diku.dk>
To: Joshua Roys <roysjosh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 09:04:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMmC-0000xJ-HN
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 09:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbYG1HDM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 03:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYG1HDL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 03:03:11 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49759 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbYG1HDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 03:03:10 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id C574E1BC527; Mon, 28 Jul 2008 19:03:08 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 4725F1BC1C8;
	Mon, 28 Jul 2008 19:02:56 +1200 (NZST)
In-Reply-To: <488D42B6.4030701@gmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90423>

Josh, I'm cc:'ing the main list with this one as well, as I think it
falls into the scope of discussions of wider interest than the rfc- and
implementation-specific discussions that (I envisaged would) happen on
the gittorrent list.

On Sun, 2008-07-27 at 23:53 -0400, Joshua Roys wrote:
> Here's some terms, as best as I understand them.
>=20
> The *Commit Reel* is a sequence of objects between two reference poin=
ts,=20
> sorted in a deterministic fashion.  The two reference points are=20
> *Reference* objects, or a signed tag containing a collection of git r=
efs=20
> (similar to the output from `git show-ref`).

Yes, that's right.  We have the two slightly ambiguous terms, "refs",
which mean the same thing as the rest of git, and "References", which
are more like .git/packed-refs.  Perhaps this is a good time to pick a
better name.  "Slice" would be an accurate term, though it's certainly
tempting to pick another term from the tape taxonomy, such as "Splice"=C2=
=B9
or "Mark"=C2=B2.

>   Commit reels can also, and generally do, include the objects requir=
ed
>  for a specific commit.

Yes.  The only times where they wouldn't contain all the objects
required for the commits within the reel, is when those objects happene=
d
to be contained by a previous reel.

This is one of the design decisions which I think may be a mistake; a
less expensive to calculate definition of a reel would be *all* objects
between the starting and ending Reference objects.  The current
definition requires a hash index of objects in each reel, which must be
consulted once for all objects when creating the reel index.

> As an example, a commit reel could be the set of objects between the=20
> v2.6.25 and v2.6.26 tags of the Linux kernel.  The only thing we woul=
d=20
> need added to those tags is the list of heads (and tags) at the time =
of=20
> the tagging.

Correct.  It represents all of the changes in a given repository over a
period of time.

> Those two structures form the basis for two *Peer Wire Protocol* (PWP=
)=20
> messages, Reels and References.
>=20
> Any questions, corrections, or rotten vegetables?

No, I think that's all good so far...

Cheers,
Sam.

=C2=B9 - see
http://en.wikipedia.org/wiki/Reel-to-reel_audio_tape_recording#Descript=
ion
=C2=B2 - as used by the old unix "mt", see eg
http://docs.sun.com/app/docs/doc/816-0210/6m6nb7mf3?a=3Dview
