From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 30 Apr 2012 18:53:15 +0200
Message-ID: <20120430165315.GO4023@login.drsnuggles.stderr.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl> <1335468843-24653-1-git-send-email-matthijs@stdin.nl> <20120427082118.GA7257@dcvr.yhbt.net> <20120427082559.GC4023@login.drsnuggles.stderr.nl> <20120429082341.GA32664@dcvr.yhbt.net> <7vvckihyqm.fsf@alter.siamese.dyndns.org> <7vk40yhv5q.fsf@alter.siamese.dyndns.org> <20120430081939.GA27715@dcvr.yhbt.net> <7vipghgq9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zKUxl9r+ULyk9DO"
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 18:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOtqr-0007t0-OU
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 18:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab2D3QxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 12:53:25 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:38754 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab2D3QxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 12:53:24 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SOtqd-0008C2-A1; Mon, 30 Apr 2012 18:53:17 +0200
Received: (nullmailer pid 31496 invoked by uid 1000);
	Mon, 30 Apr 2012 16:53:15 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
Content-Disposition: inline
In-Reply-To: <7vipghgq9a.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196578>


--6zKUxl9r+ULyk9DO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I could reproduce this problem (after installing half a dozen Ubuntue perl
packages on my Debian system ;-p). It seems the problem is because the
version comparison is wrong:

        if ($SVN::Core::VERSION gt '1.6.12') {

This does textual comparison, so 1.6.6 > 1.6.12. To do proper version
comparison, I think the version numbers should be split into
major/minor/revision and each be compared numerically.

This is not the only place where this comparison happens in this way,
there are 6 more comparisons in this way, which would have to be fixed
as well.

We could introduce a helper function for comparing version numbers by
splitting and comparing the parts separately, but that might be hard to
get right (especially when non-numeric version parts are involved).

An alternative would be to use the Sort::Versions perl module [1] for
this, but that would add an external dependency.

I'd be happy to code and test both approaches, just let me know which
would be preferred.

[1]: http://search.cpan.org/~edavis/Sort-Versions-1.5/Versions.pm

Gr.

Matthijs

--6zKUxl9r+ULyk9DO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+ew3sACgkQz0nQ5oovr7z6LwCfX8T1JTkPmZmf7uajolWZbFgH
UCgAoKVBRNWbODCQ4WOyW+C06QtzKHN0
=2CYp
-----END PGP SIGNATURE-----

--6zKUxl9r+ULyk9DO--
