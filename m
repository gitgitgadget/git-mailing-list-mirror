From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 00/18] git-remote-mediawiki: Follow perlcritic's recommandations
Date: Thu,  6 Jun 2013 21:34:05 +0200
Message-ID: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfxC-0008WM-SL
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab3FFTec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:34:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44512 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab3FFTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:34:31 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYRh3031827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:27 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JYTV7021378;
	Thu, 6 Jun 2013 21:34:29 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTon023108;
	Thu, 6 Jun 2013 21:34:29 +0200
X-Mailer: git-send-email 1.7.9.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 21:34:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYRh3031827
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152067.61729@AKV5UNzLcl4/6tt6qk9aOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226533>

Hi,
This series of commits intends to follow most of perlcritic's recommand=
ations
in order to make the code more maintainable and readable.
I followed most recommandations from level 5 (most critical ones )to 2,=
 but=20
left a great part of the level 1 ones, as they were more about personal=
 choices
of coding style and less about actually improving maintainability and p=
reventing
bugs. Among those I did *not* take into account were:
- ValuesAndExpressions::ProhibitNoisyQuotes: use q(*) instead of '*' fo=
r quoting
  some characters
- RegularExpressions::ProhibitEnumeratedClasses: e.g., use [0-9] instea=
d of \d
- CodeLayout::ProhibitParensWithBuiltins: don't use parentheses with bu=
iltin
  functions
- RegularExpressions::RequireExtendedFormatting,=20
  RegularExpressions::RequireDotMatchAnything and
  RegularExpressions::RequireLineBoundaryMatching: use s, m and x flags=
 for
  *every* regexp
- and some others. Run perlcritic -1 on patched file to so what is left=
=2E
Please tell me if you think some of them should be applied anyway.

On the other hand, if quite not sure of the relevance of some commits:
- Add newline in the end of die() error messages [3/18]: are die() mess=
ages
  correctly handled already?
- Place the open() call inside the do{} struct and prevent failing clos=
e
  [17/18]: current code fails to close the filehandle (try adding a=20
  "or warn(..)" after the close() to check this). However, perlcritic c=
omplains
  as well if you don't put an explicit close(), which fails when you pu=
t it.
  I'm not sure of what's happening and what's the best solution for thi=
s.

I checked Documentation/CodingGuidelines and none of these modification=
s should
contradict it.
This is my first patch, so don't hesitate to point to me anything wrong=
 with it.

C=C3=A9lestin Matte (18):
  Follow perlcritic's recommendations - level 5 and 4
  Change style of some regular expressions to make them clearer
  Add newline in the end of die() error messages
  Prevent local variable $url to have the same name as a global
    variable
  Turn double-negated expressions into simple expressions
  Remove unused variable
  Rename a variable ($last) so that it does not have the name of a
    keyword
  Explicitely assign local variable as undef and make a proper
    one-instruction-by-line indentation
  Check return value of open and remove import of unused open2
  Put long code into a submodule
  Modify strings for a better coding-style
  Brace file handles for print for more clarity
  Remove "unless" statements and replace them by negated "if"
    statements
  Don't use quotes for empty strings
  Put non-trivial numeric values (e.g., different from 0, 1 and 2) in
    constants.
  Fix a typo ("mediwiki" instead of "mediawiki")
  Place the open() call inside the do{} struct and prevent failing
    close
  Clearly rewrite double dereference

 contrib/mw-to-git/git-remote-mediawiki.perl |  558 ++++++++++++++-----=
--------
 1 file changed, 298 insertions(+), 260 deletions(-)

--=20
1.7.9.5
