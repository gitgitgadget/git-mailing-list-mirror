From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] git-send-email: Validate recipient_cmd (to-cmd,
 cc-cmd) addresses
Date: Wed, 20 Apr 2011 15:45:11 -0700
Message-ID: <1303339511.24766.41.camel@Joe-Laptop>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	 <20110419215239.GA22632@elie> <1303268630.24766.9.camel@Joe-Laptop>
	 <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
	 <1303336253.24766.34.camel@Joe-Laptop>
	 <BANLkTikuC1V1U-c0wyThOZAn6gVXr7S_cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 00:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCg9A-00013y-UM
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 00:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab1DTWpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 18:45:14 -0400
Received: from mail.perches.com ([173.55.12.10]:4857 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab1DTWpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 18:45:13 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id B740724368;
	Wed, 20 Apr 2011 15:45:08 -0700 (PDT)
In-Reply-To: <BANLkTikuC1V1U-c0wyThOZAn6gVXr7S_cQ@mail.gmail.com>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171878>

On Thu, 2011-04-21 at 00:29 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> On Wed, Apr 20, 2011 at 23:50, Joe Perches <joe@perches.com> wrote:
> > +       my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ =
/^\s*(.*?)\s*(<[^>]+>)/);
> In Perl you can write (<.*?>) instead of (<[^>]+>)

Hey =C3=86var.  That matches <>.  Not a good email address.

This is what linux/scripts/get_maintainers.pl uses:

sub parse_email {
    my ($formatted_email) =3D @_;

    my $name =3D "";
    my $address =3D "";

    if ($formatted_email =3D~ /^([^<]+)<(.+\@.*)>.*$/) {
	$name =3D $1;
	$address =3D $2;
    } elsif ($formatted_email =3D~ /^\s*<(.+\@\S*)>.*$/) {
	$address =3D $1;
    } elsif ($formatted_email =3D~ /^(.+\@\S*).*$/) {
	$address =3D $1;
    }

    $name =3D~ s/^\s+|\s+$//g;
    $name =3D~ s/^\"|\"$//g;
    $address =3D~ s/^\s+|\s+$//g;

    if ($name =3D~ /[^\w \-]/i) {  	 ##has "must quote" chars
	$name =3D~ s/(?<!\\)"/\\"/g;       ##escape quotes
	$name =3D "\"$name\"";
    }

    return ($name, $address);
}

There's probably some weakness in that.

> If this program doesn't have some extract_emails_from_string()
> function already it probably should.

Maybe it does.  It currently uses "sanitize_address".
