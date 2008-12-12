From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] gitweb: Optional grouping of projects by category
Date: Fri, 12 Dec 2008 03:03:55 +0100
Message-ID: <200812120303.56997.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <200812120113.47051.jnareb@gmail.com> <87zlj2xm35.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-1?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxPF-00032E-1d
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbYLLCEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2008 21:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbYLLCEK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:04:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:54343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367AbYLLCEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:04:09 -0500
Received: by ug-out-1314.google.com with SMTP id 39so380254ugf.37
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 18:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=W00RvbjOy1evm6G2VAQM+2+zTQeuyUzcpXDbBkON9T0=;
        b=TJmzNOLIsMYwkgt+B7xB3W1WCN/M0F6zHorbql+GGeskHoUaM8EkPAGsx9JANTH6Fe
         v1wWgCMNVy+RZWS/2h9ks8wC3BO9ZxX6PQ1yAqGSIHnQ2715hhm6BhjkPye62c+lYjmx
         w2TFczrTwGJ0JGmuh6zHb+id2txt7hD57nIJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jeJ//t+RY7gDSFFyEv6uawmsQrSAuXyzGXlpNLcXrD/BjPjmDll87NykFm4ONAn/M3
         aRXh+q19DvTcN6Dz8KYWxZu2Cro4J8kSKOsGDH/IHX2fPPJLGXB4X2mjond4pEL4ox45
         GyH01JX0pcMuyb8Llb2dk/BIf+ee/8qe2Ek54=
Received: by 10.67.40.15 with SMTP id s15mr5464104ugj.89.1229047445576;
        Thu, 11 Dec 2008 18:04:05 -0800 (PST)
Received: from ?192.168.1.11? (abvq79.neoplus.adsl.tpnet.pl [83.8.214.79])
        by mx.google.com with ESMTPS id u7sm396134uge.48.2008.12.11.18.04.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Dec 2008 18:04:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87zlj2xm35.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102859>

On Fri, 12 Dec 2008, S=E9bastien Cevey wrote:
> At Fri, 12 Dec 2008 01:13:45 +0100, Jakub Narebski wrote:
>=20
> > I just tried, it works but we first need to sort @projects by
> > category.
> >=20
> > I don't understand.
> > [...]
> > I propose to change it to:
>=20
> Well in my previous iteration of the patch (v3), the printing of
> projects with categories is done using:
>=20
>   foreach my $cat (sort keys %categories) {
>=20
> So everything was already sorted by category (and then by whichever
> property you picked inside each category).  You seemed okay with it,
> but requested that I documented that behaviour in the commit log.

But this does not mean that sorting by categories is necessary, or
even wanted (see below). This foreach _sorts_ by categories as primary
key using kind of bucket sort algorithm.
=20
> To maintain the same result with your proposed change (which is what =
I
> submitted in my patch), we need to sort by categories first (AFAIK
> Perl sort retains the original order inside equivalence classes of
> comparison key?), otherwise splice(projlist, from, to) doesn't return=
=20
> the expected subset.

Perl requires "use sort 'stable';" pragma to ensure stable sort.

And no, we don't need to sort by categories first.  Let me explain
in more detail a bit.

Let us assume that $from and $to is actually used to divide projects
list into categories (which goal is incompatible with searching
projects, limiting to given tag/tagset and hiding forked as it is done
now, at the display time; it has to be done _before_ pagination).
They are used to display first page, i.e. repositories numbered 1..N
in current ordering, or N..2*N, or 2*N..3*N to show next pages. Let us
have the following project list:

  Project       Category
  ---------------------------
  1             a
  2             b
  3             b
  4             a

If categories are not shown, and page limit is 2, then project would
be displayed like this:


  page 1          page 2
  ------          ------
  1               3
  2               4

Now _without_ sorting by category upfront, those pages would look like
the following if grouping by category is enabled:

A.page 1          page 2
  ------          ------
  [a]             [a]
  1               4
  [b]             [b]
  2               3

What is not visible in this example is that projects inside category
would be sorted by given order.


Now if you would sort by categories _before_ pagination, like you
(from what I understand) proposed, you would have (assuming that
you used "use sort 'stable'" inside block):

  Project       Category
  ---------------------------
  1             a
  4             a
  2             b
  3             b

Pagination would then look like the following:

B.page 1          page 2
  ------          ------
  [a]             [b]
  1               2
  4               3


Now which result you consider correct depends on the point of view.
=46irst is sort, paginate, sort; second is sort, sort, paginate.
=46irst have first N repositories in given order on first page, perhaps
reordered a bit by categories, second doesn't have this feature.
I think that the case A is more correct, but you might disagree.


Let us change example a bit:

  Project       Category
  ---------------------------
  1             b
  2             a
  3             a
  4             b

A.page 1          page 2
  ------          ------
  [a]             [a]
  2               3
  [b]             [b]
  1               4

B.page 1          page 2
  ------          ------
  [a]             [b]
  2               1
  3               4

P.S. It is IMHO better to use

 	for (my $i =3D $from; $i <=3D $to; $i++) {

than the style which is not used elsewhere in gitweb, from what
I remember

 	foreach my $i ($from..$to) {

I might also be inefficient as it generates temporary array which
might be quite big; I don't know if Perl 5.8.x, the oldest version
one can sensibly use with gitweb I think, has this bug or not.
--=20
Jakub Narebski
Poland
