From: Geoff Nixon <geoff@geoff.codes>
Subject: =?UTF-8?Q?Bug:_`git-filter-branch_=E2=88=92=E2=88=92subdirect?=
 =?UTF-8?Q?ory=E2=88=92filter`_fails_on_Darwin,_others=3F?=
Date: Wed, 11 May 2016 06:47:20 -0700
Message-ID: <154a01265c2.c271895e226206.8641058706319152212@geoff.codes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "geoff@geoff.codes" <geoff@geoff.codes>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 15:47:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0UUI-0000sO-CG
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbcEKNr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:47:26 -0400
Received: from sender163-mail.zoho.com ([74.201.84.163]:24040 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932562AbcEKNrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 09:47:24 -0400
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1462974440954103.63048898398188; Wed, 11 May 2016 06:47:20 -0700 (PDT)
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-ZohoMail: Z_39703662 SPT_1 Z_39703661 SPT_1 SLF_D
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294345>

May 11, 2016
Geoff Nixon
geoff@geoff.codes

To Whom It May Concern:

    I believe I have found a bug in git. On Mac OS X (at least 10.9 thr=
ough 10.11), and versions of git from the current HEAD down through at =
least 1.8.x, `git filter-branch =E2=88=92=E2=88=92subdirectory=E2=88=92=
filter ...` fails. Using, e.g., the following example (from the docs fo=
r git-filter-branch), `git filter-branch --subdirectory-filter foodir -=
- --all`, and using the git repository as the example repository, `git =
filter-branch --subdirectory-filter Documentation -- --all`, the "error=
 message" one receives is "fatal: bad revision '=E2=88=92=E2=88=92subdi=
rectory=E2=88=92filter'".

    I have tried to find and eliminate the bug myself, but despite my e=
fforts it has proved elusive. Here is what I can tell you:

    - It is apparently Darwin specific, or at least, I cannot reproduce=
 on Linux
    - It applies across a wide swath of versions of git and Mac OS X.
    - Debugging is a challenge, because the code is pretty wack sauce,
    - I.e., I don't understand how it `s
     Doesn't matter which version of the OS or which version of git, at=
 least going back to 10.9 and 1.8, I believe.
    - There is some extremely strange magic going on here, i.e.,
      - I don't understand how it sources `git-sh-setup` on line 90, wh=
ile still in $PWD
      - It begins with a heredoc of fuctions which are then immediately=
,
      - `eval`'d, for no apparent reason.
      - There's way to many uses of `eval` to follow, many of them need=
less, and it resets its own positional arguments to the result of the e=
xpansion of command substitution in places, withought saving the origin=
al parameters=20
      - It possibly seems to be expanding '-' to an octal sequence at s=
ome point?
    - Exporting PS4 to 'WTF: $LINENO ' and setting `-x` is practically =
of no use, except that the last line before it fails appears to be `git=
 rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD $=
'=EF=BF=BD\210\222=EF=BF=BD\210\222subdirectory=EF=BF=BD\210\222filter`=
 (including the octal sequences and bad-unicode character, those are no=
t email artifacts)

Thank you for you time and consideration.

Yours,

Geoff Nixon
