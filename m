From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/11] Consolidate ref parsing code
Date: Wed, 15 Oct 2014 17:06:12 +0200
Message-ID: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAO-0002a7-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaJOPG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:06:58 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63023 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751694AbaJOPGr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:47 -0400
X-AuditID: 12074411-f79186d000005c59-bc-543e8d7714a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 24.9E.23641.77D8E345; Wed, 15 Oct 2014 11:06:31 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNS020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:29 -0400
X-Mailer: git-send-email 2.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqFveaxdisPOFikXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujGl/MwuOiFQcXfOJtYHxtEAXIyeHhICJxKZlt5ggbDGJC/fWs3UxcnEI
	CVxmlGg4BuMcZ5L49/kfG0gVm4CuxKKeZiaQhIhAA6PEoVcLwaqYBRYxSrSvusIMUiUsYCbx
	5ehpMJtFQFVi/vnvYDt4BZwl+r7+ZIHYJyexd/JqFoi4oMTJmU+AbA6gQeoS6+cJgYSZBeQl
	mrfOZp7AyDcLSdUshKpZSKoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSnd
	xAgJYMEdjDNOyh1iFOBgVOLh5ThgGyLEmlhWXJl7iFGSg0lJlDepxy5EiC8pP6UyI7E4I76o
	NCe1+BCjBAezkgjv/ASgHG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFadg0Pg
	yv5f4VIsefl5qUoSvLUg8wWLUtNTK9Iyc0oQKpk4OEH2cEmJFKfmpaQWJZaWZMSD4jG+GBiR
	ICkeoBM8Qdp5iwsSc4GiEK2nGBWlxHmzQBICIImM0jy4sbBk9YpRHOhhYd4wkCoeYKKD634F
	NJgJaPDEUFuQwSWJCCmpBkajlq115TOrHzu3aPwTUCyvvhYiu7HYOGfKQtuokycn393foJVh
	sUhp05bTKnYbN+7WFz8fK6bUlPwvcLmcwTXFLedWvAgQiXrQ/mr25PPx1kpvzCOe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a rif on Duy's oldish patch series [1]. I started reviewing
his patch series, but found that some of his patches did multiple
things, making it harder to review. I started pulling it apart into
smaller changes to aid my review, and I guess I got carried away :-/

As far as I know, Duy isn't actively working on this, so I hope my
reroll is not unwelcome.

As far as I can tell, Duy's patch series was correct aside from a
couple of minor cosmetic blemishes [2]. So if you want to accept Duy's
original patch series, I hereby endorse it.

This version does the following things beyond Duy's original:

* Split commits up into smaller pieces.

* Get rid of the MAXREFLEN limitation.

* Rename the parse_ref() parameter from "ref" to "refname".

* Inline resolve_gitlink_packed_ref() and handle_missing_loose_ref().

* Invert the "if" statement for dealing with symbolic references in
  parse_ref() to make the logic flow more linear.

* Change a couple of "while" loops to "do..while".

* Change resolve_refdup() to return strbuf_detach(&buf, NULL) instead
  of buf.buf directly (as suggested by Eric Sunshine).

I retained Duy as author on commits that are derived straightforwardly
from his. I hope I haven't broken any of them. I am calling this patch
series v2 because I propose it as a successor to Duy's version.

[1] http://thread.gmane.org/gmane.comp.version-control.git/254203/focus=
=3D254203

[2] Aside from the couple of things pointed out on the mailing list,

    * The parse_ref() parameter should be named "refname" instead of
      "ref", for consistency with other refs code.

    * The local variable "ref =3D result->buf" in resolve_ref() just
      obscures things and should be inlined.

Michael Haggerty (5):
  resolve_ref_unsafe(): reverse the logic of the symref conditional
  handle_missing_loose_ref(): inline function
  resolve_gitlink_ref_recursive(): drop arbitrary refname length limit
  resove_gitlink_packed_ref(): inline function
  resolve_gitlink_ref(): remove redundant test

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  strbuf_read_file(): preserve errno on failure
  handle_missing_loose_ref(): return an int
  resolve_ref_unsafe(): use skip_prefix() to skip over "ref:"
  refs.c: refactor resolve_ref_unsafe() to use strbuf internally
  refs.c: move ref parsing code out of resolve_ref()
  refs.c: rewrite resolve_gitlink_ref() to use parse_ref()

 cache.h  |  12 +++
 refs.c   | 371 +++++++++++++++++++++++++++++++------------------------=
--------
 strbuf.c |   7 +-
 3 files changed, 200 insertions(+), 190 deletions(-)

--=20
2.1.1
