From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] t7004 (master) busted on Leopard
Date: Thu, 15 Nov 2007 16:12:44 +0100
Message-ID: <A3467E97-601B-45EE-816D-376F4FFE69E8@wincent.com>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 16:13:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsgOv-0005Pg-8Q
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 16:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbXKOPMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbXKOPMt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 10:12:49 -0500
Received: from wincent.com ([72.3.236.74]:39744 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbXKOPMs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 10:12:48 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFFCjvb022274;
	Thu, 15 Nov 2007 09:12:45 -0600
In-Reply-To: <Pine.LNX.4.64.0711151434060.30886@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65127>

El 15/11/2007, a las 15:37, Johannes Schindelin escribi=F3:

> Hi,
>
> On Thu, 15 Nov 2007, Wincent Colaiuta wrote:
>
>> Commit 4d8b1dc850 added a couple of tests to t7004, and my testing =20
>> reveals
>> that this one has been broken on Leopard since then:
>>
>> * FAIL 83: message in editor has initial comment
>> GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
>> test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>
> I think this is our good old friend, MacOSX' sed.

Yes, that's exactly what I said in the part of my post that you didn't =
=20
quote.

> I imagine that it is that MacOSX' sed is adding a trailing newline =20
> (not
> the regexp like you suggested).  Which means that "wc -l" would =20
> print "1".
> (You can see for yourself if you run the script with "sh -x ...".)

Unless I am misreading the test, any output from "wc -l" that is =20
greater than 0 will cause the test to pass, so even if it outputted =20
"1" as you suggest then that wouldn't be the cause of the failure.

I do think the cause of the failure is the limited regexp syntax that =20
sed accepts on Leopard; witness: on Mac OS X the following prints 0:

   echo "# hello" | sed -n "/^\(#\|\$\)/p" | wc -l

Whereas the following prints 1:

   echo "# hello" | sed -n "/^[#\$]/p" | wc -l

Here's the output for the failing test run under "sh -x" as you =20
suggest, although I must admit that I can't really parse it myself.

+ test_expect_success 'message in editor has initial comment' '
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
+ test 2 =3D 2
+ test_skip 'message in editor has initial comment' '
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
++ expr ./t7004-tag.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=3Dt7004
++ expr 82 + 1
+ this_test=3Dt7004.83
+ to_skip=3D
+ case "$to_skip" in
+ false
+ say 'expecting success:
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
+ say_color info 'expecting success:
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
+ case "$1" in
+ tput setaf 3
+ shift
+ echo '* expecting success:
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
+ tput sgr0
+ test_run_ '
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
+ eval '
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
+ eval_ret=3D1
+ return 0
+ '[' 0 =3D 0 -a 1 =3D 0 ']'
+ test_failure_ 'message in editor has initial comment' '
	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
'
++ expr 82 + 1
+ test_count=3D83
++ expr 0 + 1
+ test_failure=3D1
+ say_color error 'FAIL 83: message in editor has initial comment'
+ case "$1" in
+ tput bold
+ tput setaf 1
+ shift
+ echo '* FAIL 83: message in editor has initial comment'
* FAIL 83: message in editor has initial comment
+ tput sgr0
+ shift

> IMHO a good solution would be
>
> 	test -z "$(grep -e '^#' -e '^$' actual)"
>
> Could you test, please?

Yes, the test passes with that, although it has to be written as =20
follows in the actual test file seeing as it's inside a single-quoted =20
string:

test -z "$(grep -e \"^#\" -e \"^$\" actual)"

Will follow this up with a patch that implements your proposed fix.

Cheers,
Wincent
