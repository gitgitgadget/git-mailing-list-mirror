From: Simon Josefsson <simon@josefsson.org>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Thu, 01 Mar 2007 16:23:35 +0100
Message-ID: <87y7mhrnrc.fsf@latte.josefsson.org>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 16:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMn8L-0007c1-Dm
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 16:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbXCAPXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Mar 2007 10:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbXCAPXu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 10:23:50 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:43843
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965202AbXCAPXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 10:23:49 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l21FNZQ7000348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Mar 2007 16:23:36 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070301:git@vger.kernel.org::o1xrwjEUY2Tw0+pV:/D+
X-Hashcash: 1:22:070301:johannes.schindelin@gmx.de::XlVepOBscnX0WFKN:1pkB
X-Hashcash: 1:22:070301:junkio@cox.net::NjepT+YR6X1oA4hn:6rhu
In-Reply-To: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue\, 27 Feb 2007 16\:21\:27 +0100
	\(CET\)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-0.8 required=4.0 tests=AWL,BAYES_50 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41100>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This outputs the log in GNU ChangeLog format.

Many thanks!  I ran this in my cvs->git repository for libtasn1, and
then did a diff against the output from cvs2cl in the old repository.
Here are some categories of differences:

1) Indentation should be under the '*'.  Compare (wrong):

        * src/asn1Coding.c, src/asn1Decoding.c, src/asn1Parser.c: Impro=
ve
          --help output.  Assume getopt_long, since gnulib provides it.

with (correct):

        * src/asn1Coding.c, src/asn1Decoding.c, src/asn1Parser.c: Impro=
ve
        --help output.  Assume getopt_long, since gnulib provides it.

2) Don't log anything for empty messages:

        * gl/.cvsignore: *** empty log message ***

Possibly, this should be an option.

3) Possible charset problem?  Compare this (correct):

        * configure.in: Fix -Wno-pointer-sign test to respect user-defi=
ned
        CFLAGS.  Reported by "Diego 'Flameeyes' Petten=F2"
        <flameeyes@gentoo.org>.

with (wrong):

        * configure.in: Fix -Wno-pointer-sign test to respect user-defi=
ned
          CFLAGS.  Reported

The git log do seem to contain the correct data, though, from git-log:

    Fix -Wno-pointer-sign test to respect user-defined CFLAGS.  Reporte=
d
    by "Diego 'Flameeyes' Petten=F2" <flameeyes@gentoo.org>.

4) Weird error, compare (correct):

        * lib/coding.c:
        (asn1_der_coding): For TYPE_NULL, increment counter even if we =
don't
        write any output.  Reported by Stephen Wrobleski
        <steve@localtoast.org>.

with (wrong):

        * lib/coding.c: (asn1_der_coding): For TYPE_NULL, increment cou=
nter
          even if we don't

Maybe this is related to the last one, and the problem really is '<' or=
 '>'?

Here is another one, compare (correct):

        * lib/coding.c:
        (asn1_octet_der): Work even if str_len is 0, i.e., write an ASN=
=2E1
        length of zero.  Otherwise encodings became garbled on 64-bit
        platforms, detected while running the Shishi self-tests on the
        Debian build robots.  A self test to reproduce this is in Test_=
tree.

with (wrong):

        * lib/coding.c: (asn1_octet_der): Work even if str_len is 0, i.=
e.,
          write an ASN.1

I'll let you fix these and resume the diff later. :)

Can I pull your git tree from somewhere?  Applying patches from e-mail
is kind of boring.

/Simon
