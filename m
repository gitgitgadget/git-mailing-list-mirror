From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 11:19:21 -0700
Message-ID: <20100906181921.GN32601@spearce.org>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi> <AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com> <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com> <201009061049.38546.jnareb@gmail.com> <EC704F6E-3075-459C-9210-10C234523D80@gmail.com> <20100906145606.GM32601@spearce.org> <AANLkTikmU9_Vg2+=73yjPyaaDSqk73Bvs1HyNjFDWqNY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:19:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsgHx-0000kX-Q1
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab0IFSTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 14:19:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34383 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0IFSTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 14:19:24 -0400
Received: by pxi10 with SMTP id 10so1071621pxi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 11:19:23 -0700 (PDT)
Received: by 10.142.185.5 with SMTP id i5mr320646wff.225.1283797163811;
        Mon, 06 Sep 2010 11:19:23 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id q34sm4549130wfc.7.2010.09.06.11.19.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 11:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikmU9_Vg2+=73yjPyaaDSqk73Bvs1HyNjFDWqNY@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155595>

Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Mon, Sep 6, 2010 at 8:26 PM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> > That is, the following will trigger a correct error on the client:
> >
> > =A0200 OK
> > =A0Content-Type: application/x-git-upload-pack-advertisement
> >
> > =A0001e# service=3Dgit-upload-pack
> > =A00022ERR You shall not do this
>=20
> are those counts accurate for the specific example you show or just m=
ade up?
>=20
> It seems the first line has a count in hex that includes the newline
> at the end, and the second one has a count in decimal that does not
> include the newline nor even the 4-digits plus "ERR"

=46eh.  I can't count.  The first count is correct.  The second count
should also be 001e.  I guess that should be obvious by just looking
at the two lines, they are equal in length.  :-)
=20
> > Likewise if you wanted to do this with receive-pack, replace upload
> > with receive above and adjust the pkt-line lengths.
>=20
> ok... what about all the other service commands?  like /info/refs?
> What should I put there?

The only other command that matters is info/refs.

=46or smart clients, its what I said above.

=46or dumb clients, you have to use some sort of HTTP error status
that isn't 404.  Dumb clients pre-1.6.6 use a curl error message
buffer to print out an error.  But they don't check the format of
info/refs at all, and skip over garbage and/or interpret garbage
as valid input.  So we can't use a hack like "ERR blah" to even
trigger a parsing failure.

--=20
Shawn.
