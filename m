From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v4 1/4] t6006 (rev-list-format): don't hardcode SHA-1 in
 expected outputs
Date: Fri, 25 Jan 2013 13:20:28 +0400
Message-ID: <20130125132028.1cd55df2@ashu.dyn1.rarus.ru>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com>
	<7v38xqba04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfSy-0006mP-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab3AYJUf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 04:20:35 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:38363 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3AYJUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 04:20:32 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so336091lbb.12
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Nn72rzDcClFGmi93DXlGSWIsYsnq9zSOjC3USyKderg=;
        b=XR6cCSueXKzDoZkFiC14A2P3kQvUSS3B43Rj95plTujeJhYU5XGCnoSTqak9yDRIFs
         bPAIBqkbEJ8i30ASA3LEWLNL1zy1KzkEiYsWKYc1JabwNXZjk5mGX0ZI+tP0/6OZkRio
         oFcglYjzPGhuOiQK1NTL9mz790Y7WU0RLtc7F1nalwfzOloPcAFAeP8WZ1YXRs0o5Q8F
         pifHYv4Xn4BFAvekKLFUTwO95QptBVtzoYXKh735B2TVj15JXZoudK8/TjNOdsPRP+yS
         AAlmS1wVjbgePM3Iu/O18DZWsyz195ME06Bv9l7DNrFvOm855JbEYD1Mzu7Uypl2YmNT
         OVGA==
X-Received: by 10.112.11.33 with SMTP id n1mr1961533lbb.18.1359105630994;
        Fri, 25 Jan 2013 01:20:30 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id ft8sm182619lab.9.2013.01.25.01.20.30
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:20:30 -0800 (PST)
In-Reply-To: <7v38xqba04.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214524>

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>=20
> > The expected SHA-1 digests are always available in variables.  Use
> > them instead of hardcoding.
> >
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > ---
> >  t/t6006-rev-list-format.sh | 130
> > +++++++++++++++++++++++++-------------------- 1 file changed, 72
> > insertions(+), 58 deletions(-)
> >
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.s=
h
> > index f94f0c4..c248509 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > @@ -6,8 +6,19 @@ test_description=3D'git rev-list --pretty=3Dformat
> > test'=20
> >  test_tick
> >  test_expect_success 'setup' '
> > -touch foo && git add foo && git commit -m "added foo" &&
> > -  echo changed >foo && git commit -a -m "changed foo"
> > +	touch foo &&
>=20
> This is inherited from the original, but these days we try to avoid
> touch, unless it is about setting a new file timestamp.  The
> canonical (in the script we write) way to create an empty file is:
>=20
>     : >foo
>=20
> with or without ": ", it does not matter that much.
Ok!

>=20
> > +	git add foo &&
> > +	git commit -m "added foo" &&
> > +	head1=3D$(git rev-parse --verify HEAD) &&
> > +	head1_7=3D$(echo $head1 | cut -c1-7) &&
>=20
> Why do we want "whatever_7" variables and use "cut -c1-7" to produce
> them?  Is "7" something we care deeply about?
I did not spend too much time to think of names of variables at the
moment I was writing this code )
>=20
> I think what we care a lot more than "7" that happens to be the
> current default value is to make sure that, if we ever update the
> default abbreviation length to a larger value, the abbreviation
> shown with --format=3D%h is consistent with the abbreviation that is
> given by rev-parse --short.
>=20
>     head1_short=3D$(git rev-parse --short $head1)
>=20
> perhaps?
It's an inherited code from 1.5 years ago Git ;) taken from some other
tests
I'll change it as you propose )

>=20
> > +	echo changed >foo &&
> > +	git commit -a -m "changed foo" &&
> > +	head2=3D$(git rev-parse --verify HEAD) &&
> > +	head2_7=3D$(echo $head2 | cut -c1-7) &&
> > +	head2_parent=3D$(git cat-file -p HEAD | grep parent | cut -f
> > 2 -d" ") &&
>=20
> Do not use "cat-file -p" that is for human consumption in scripts,
> unless you are testing how the format for human consumption should
> look like (we may later add more pretty-print to them), which is not
> the case here.
>=20
> Also be careful and pay attention to the end of the header; you do
> not want to pick up a random "parent" string in the middle of a log
> message.
>=20
>     head2_parent=3D$(git cat-file commit HEAD | sed -n -e
> "s/^parent //p" -e "/^$/q")
>=20
> would be much better.
yep! you're definitely right

>=20
> > +	head2_parent_7=3D$(echo $head2_parent | cut -c1-7) &&
> > +	tree2=3D$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ")
> > &&
>=20
> Likewise.
>=20
> > +	tree2_7=3D$(echo $tree2 | cut -c1-7)
>=20
> Likewise.
>=20
> > @@ -131,39 +142,42 @@ This commit message is much longer than the
> > others, and it will be encoded in iso8859-1. We should therefore
> >  include an iso8859 character: =C2=A1bueno!
> >  EOF
> > +
> >  test_expect_success 'setup complex body' '
> > -git config i18n.commitencoding iso8859-1 &&
> > -  echo change2 >foo && git commit -a -F commit-msg
> > +	git config i18n.commitencoding iso8859-1 &&
> > +	echo change2 >foo && git commit -a -F commit-msg &&
> > +	head3=3D$(git rev-parse --verify HEAD) &&
> > +	head3_7=3D$(echo $head3 | cut -c1-7)
> >  '
>=20
> Likewise.
>=20
> Thanks.
