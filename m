From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2] Fix git-tag test breakage caused by broken sed on
	Leopard
Date: Fri, 16 Nov 2007 17:59:44 +0100
Organization: glandium.org
Message-ID: <20071116165944.GB29272@glandium.org>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site> <90D416F6-A3CA-43C8-B71F-38EA955A762B@wincent.com> <C9DFAD77-DFEF-47AC-83D5-CFDF245D95E4@wincent.com> <7v4pfm3h6f.fsf@gitster.siamese.dyndns.org> <7A6820DE-C6EE-4E3E-A97F-97766F682B85@wincent.com> <03D3DFCD-B5F7-47CF-AFD2-F1408BB11AB3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:01:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It4Zn-00025o-24
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 18:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXKPRBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 12:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbXKPRBi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 12:01:38 -0500
Received: from vawad.err.no ([85.19.200.177]:57558 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbXKPRBh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 12:01:37 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1It4Z5-0001NB-2p; Fri, 16 Nov 2007 18:01:13 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It4Xg-0000vO-5f; Fri, 16 Nov 2007 17:59:44 +0100
Content-Disposition: inline
In-Reply-To: <03D3DFCD-B5F7-47CF-AFD2-F1408BB11AB3@wincent.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65231>

On Fri, Nov 16, 2007 at 02:48:09PM +0100, Wincent Colaiuta wrote:
> El 16/11/2007, a las 14:45, Wincent Colaiuta escribi=F3:
>=20
> > El 16/11/2007, a las 6:14, Junio C Hamano escribi=F3:
> >
> >> Wincent Colaiuta <win@wincent.com> writes:
> >>
> >>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> >>> index 096fe33..b54c2e0 100755
> >>> --- a/t/t7004-tag.sh
> >>> +++ b/t/t7004-tag.sh
> >>> @@ -1007,7 +1007,7 @@ test_expect_failure \
> >>> test_expect_success \
> >>> 	'message in editor has initial comment' '
> >>> 	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
> >>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> >>> +	test $(grep -e "^#" -e "^\$" actual | wc -l ) -gt 0
> >>> '
> >>
> >> Heh, doesn't grep exit with zero only when it found some lines
> >> that match the pattern already?  What's that "wc -l" for?
> >
> >
> > I was just trying to make the minimal change (swapping grep for =20
> > sed), but if you want a shorter version then we don't even need the=
 =20
> > "test"; it could just be:
> >
> > -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> > +	grep -e "^#" -e "^\$" actual
>=20
> Although I don't know if we should be testing for empty lines there =20
> because an 0-byte empty "actual" file would spuriously pass the test.=
 =20
> Perhaps this would be better:
>=20
> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> +	grep -e "^#" actual

Matching both would as in your previous pseudo patch wouldn't catch
empty file. On the other hand, both my initial bloated version and your=
s
won't catch a file that doesn't contain the comment.

grep -e "^$" actual && grep -e "^#" actual would actually be a better
test.

Mike
