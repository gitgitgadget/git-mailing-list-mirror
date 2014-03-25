From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 12/19] tree-diff: remove special-case diff-emitting code
 for empty-tree cases
Date: Tue, 25 Mar 2014 13:20:40 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140325092040.GA3777@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <dad40b2cf785e5951c105cac936d86a7bc6db8a3.1393257006.git.kirr@mns.spb.ru>
 <xmqqior3pa7h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSNUB-0007bD-KW
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 10:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaCYJR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 05:17:26 -0400
Received: from forward19.mail.yandex.net ([95.108.253.144]:41634 "EHLO
	forward19.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaCYJRY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 05:17:24 -0400
Received: from smtp18.mail.yandex.net (smtp18.mail.yandex.net [95.108.252.18])
	by forward19.mail.yandex.net (Yandex) with ESMTP id 6FBE911216D8;
	Tue, 25 Mar 2014 13:17:21 +0400 (MSK)
Received: from smtp18.mail.yandex.net (localhost [127.0.0.1])
	by smtp18.mail.yandex.net (Yandex) with ESMTP id 0218B18A0136;
	Tue, 25 Mar 2014 13:17:20 +0400 (MSK)
Received: from unknown (unknown [78.25.121.154])
	by smtp18.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id IVH24XZonX-HIO8xrgp;
	Tue, 25 Mar 2014 13:17:18 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 6dd70793-94a8-4a5f-9273-6994e94bce28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395739040; bh=3Q+NwCzW8ASSpbDBTXSCw9LgoGjGIjaidMhc/iaT9QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:Organization:User-Agent;
	b=CAXgDwJszqfslaXwhAnz7NuOTI7+XGF9WxLfCVr9OdouxyHu//Q2bcPPlLqNUT5Qr
	 NkAgjKslfNk0ImHubHyAxJBwi8QHrnCbjX7dSVOLWxbldTo5vLkfTzwtZV4Ml25+Y3
	 FoCG3H9M5UFIJrRP5i2lSNX2lTbC+eW6wBZE/GYY=
Authentication-Results: smtp18.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WSNXE-0002yd-6n; Tue, 25 Mar 2014 13:20:40 +0400
Content-Disposition: inline
In-Reply-To: <xmqqior3pa7h.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245019>

On Mon, Mar 24, 2014 at 02:18:10PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
>=20
> > via teaching tree_entry_pathcmp() how to compare empty tree descrip=
tors:
>=20
> Drop this line, as you explain the "pretend empty compares bigger
> than anything else" idea later anyway?  This early part of the
> proposed log message made me hiccup while reading it.

Hmm, I was trying to show the big picture first and only then details..=
=2E


> > While walking trees, we iterate their entries from lowest to highes=
t in
> > sort order, so empty tree means all entries were already went over.
> >
> > If we artificially assign +infinity value to such tree "entry", it =
will
> > go after all usual entries, and through the usual driver loop we wi=
ll be
> > taking the same actions, which were hand-coded for special cases, i=
=2Ee.
> >
> >     t1 empty, t2 non-empty
> >         pathcmp(+=E2=88=9E, t2) -> +1
> >         show_path(/*t1=3D*/NULL, t2);     /* =3D t1 > t2 case in ma=
in loop */
> >
> >     t1 non-empty, t2-empty
> >         pathcmp(t1, +=E2=88=9E) -> -1
> >         show_path(t1, /*t2=3D*/NULL);     /* =3D t1 < t2 case in ma=
in loop */
>=20
> Sounds good.  I would have phrased a bit differently, though:
>=20
>     When we have T1 and T2, we return a sign that tells the caller
>     to indicate the "earlier" one to be emitted, and by returning
>     the sign that causes the non-empty side to be emitted, we will
>     automatically cause the entries from the remaining side to be
>     emitted, without attempting to touch the empty side at all.  We
>     can teach tree_entry_pathcmp() to pretend that an empty tree has
>     an element that sorts after anything else to achieve this.
>=20
> without saying "infinity".

Doesn't your description, especially "an element that sorts after
anything else" match what "infinity" is pretty exactly? :)

I agree it could read more clearly to those new to the concept, but we
are basically talking about the same thing and once someone is familiar
with infinity and its friends the second description imho is less
obvious.

Let's maybe as a compromise add your text as "In other words <textual
description ...>" ?

This way, it will hopefully be good both ways...


> > Right now we never go to when compared tree descriptors are infinit=
y,...
>=20
> Sorry, but I cannot parse this.

Sorry, I've omitted one word here. It should read

    "Right now we never go to when compared tree descriptors are _both_=
 infinity,..."

i.e. right now we never call tree_entry_pathcmp with both t1 and t2
being empty.


> > as
> > this condition is checked in the loop beginning as finishing criter=
ia,
>=20
> What condition and which loop?  The loop that immediately surrounds
> the callsite of tree_entry_pathcmp() is the infinite "for (;;) {" loo=
p,
> and after it prepares t1 and t2 by skipping paths outside pathspec,
> we check if both are empty (i.e. we ran out).  Is that the condition
> you are referring to?

Yes exactly. Modulo diff_can_quit_early() logic, we break from loop in
diff_tree (the loop in which special-case diff-tree emitting code was)
when both trees were scanned to the end, i.e.

        if (!t1->size && !t2->size)
                break;

in other words when both t1 and t2 are "+=E2=88=9E".

Because of that, at this stage we will never go into tree_entry_pathcmp
with (+=E2=88=9E,+=E2=88=9E) arguments, which could mean (!t1->size && =
!t2->size) case
could be unnecessary in tree_entry_pathcmp and should not be coded at
all...

> > but will do in the future, when there will be several parents itera=
ted
> > simultaneously, and some pair of them would run to the end.

=2E.. I was trying to say this case will probably be needed later, and =
that
it is better to have it for generality.

I hope this should be more clear once that prologue with "both" include=
d
is not confusing.


> > Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >
> > ( re-posting without change )
> >
> >  tree-diff.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> >
> > diff --git a/tree-diff.c b/tree-diff.c
> > index cf96ad7..2fd6d0e 100644
> > --- a/tree-diff.c
> > +++ b/tree-diff.c
> > @@ -12,12 +12,19 @@
> >   *
> >   * NOTE files and directories *always* compare differently, even w=
hen having
> >   *      the same name - thanks to base_name_compare().
> > + *
> > + * NOTE empty (=3Dinvalid) descriptor(s) take part in comparison a=
s +infty.
>=20
> The basic idea is very sane.  It is a nice (and obvious---once you
> are told about the trick) and clean restructuring of the code.

Thanks. I was surprised it is seen as a trick, as infinity is very hand=
y
and common concept in many areas and in sorting too.

>=20
> >   */
> >  static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_de=
sc *t2)
> >  {
> >  	struct name_entry *e1, *e2;
> >  	int cmp;
> > =20
> > +	if (!t1->size)
> > +		return t2->size ? +1 /* +=E2=88=9E > c */  : 0 /* +=E2=88=9E =3D=
 +=E2=88=9E */;
> > +	else if (!t2->size)
> > +		return -1;	/* c < +=E2=88=9E */
>=20
> Where do these "c" come from?  I somehow feel that these comments
> are making it harder to understand what is going on.

"c" means some finite "c"onstant here. When I was studying at school an=
d
at the university, it was common to denote constants via this letter -
i.e. in algebra and operators they often show scalar multiplication as

    c=C2=B7A     (or =CE=B1=C2=B7A)

etc. I understand it could maybe be confusing (but it came to me as
surprise), so would the following be maybe better:

        if (!t1->size)
        	return t2->size ? +1 /* +=E2=88=9E > const */  : 0 /* +=E2=88=9E=
 =3D +=E2=88=9E */;
        else if (!t2->size)
        	return -1;	/* const < +=E2=88=9E */

?


Thanks,
Kirill

> >  	e1 =3D &t1->entry;
> >  	e2 =3D &t2->entry;
> >  	cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
> > @@ -151,18 +158,8 @@ int diff_tree(struct tree_desc *t1, struct tre=
e_desc *t2,
> >  			skip_uninteresting(t1, &base, opt);
> >  			skip_uninteresting(t2, &base, opt);
> >  		}
> > -		if (!t1->size) {
> > -			if (!t2->size)
> > -				break;
> > -			show_path(&base, opt, /*t1=3D*/NULL, t2);
> > -			update_tree_entry(t2);
> > -			continue;
> > -		}
> > -		if (!t2->size) {
> > -			show_path(&base, opt, t1, /*t2=3D*/NULL);
> > -			update_tree_entry(t1);
> > -			continue;
> > -		}
> > +		if (!t1->size && !t2->size)
> > +			break;
> > =20
> >  		cmp =3D tree_entry_pathcmp(t1, t2);
