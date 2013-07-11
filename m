From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 11 Jul 2013 18:31:54 +0100
Message-ID: <51DEEC0A.9060001@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net> <51CBD2FD.5070905@alum.mit.edu> <51CCC643.1050702@ramsay1.demon.co.uk> <51D06AC8.70206@ramsay1.demon.co.uk> <51DBEDAF.30708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 11 19:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxKrK-0001W3-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 19:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab3GKRkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jul 2013 13:40:35 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:51196 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753783Ab3GKRkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 13:40:33 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 8492CA64901;
	Thu, 11 Jul 2013 18:40:31 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id A7685A648F1;
	Thu, 11 Jul 2013 18:40:30 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Thu, 11 Jul 2013 18:40:28 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51DBEDAF.30708@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230121>

Torsten B=C3=B6gershausen wrote:
> On 30.06.13 19:28, Ramsay Jones wrote:

[ ... ]

>>> You have just described my second patch! :D
>> Unfortunately, I have not had any time to work on the patch this wee=
kend.
>> However, despite the patch being a bit rough around the edges, I dec=
ided
>> to send it out (see below) to get some early feedback.
>>
>> Note that it passes the t3210, t3211, t5500, t3200, t3301, t7606 and=
 t1301
>> tests, but I have not run the full test suite.
>>
>> Comments welcome.
>>
>> ATB,
>> Ramsay Jones
>>
>> -- >8 --
>> Subject: [PATCH] cygwin: Add fast_[l]stat() functions
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>  builtin/apply.c        |  6 +++---
>>  builtin/commit.c       |  2 +-
>>  builtin/ls-files.c     |  2 +-
>>  builtin/rm.c           |  2 +-
>>  builtin/update-index.c |  2 +-
>>  check-racy.c           |  2 +-
>>  compat/cygwin.c        | 12 ------------
>>  compat/cygwin.h        | 10 +++-------
>>  diff-lib.c             |  2 +-
>>  diff.c                 |  2 +-
>>  entry.c                |  4 ++--
>>  git-compat-util.h      | 13 +++++++++++--
>>  help.c                 |  5 +----
>>  path.c                 |  9 +--------
>>  preload-index.c        |  2 +-
>>  read-cache.c           |  6 +++---
>>  unpack-trees.c         |  8 ++++----
>>  17 files changed, 36 insertions(+), 53 deletions(-)
>>

[ ... ]

> I managed to apply your patch on next, and run the test suite before =
and after
> your patch.
> The performance running "git status" on a linux kernel is the same as=
 in v1.8.3.
>=20
> Running test suite did not show new failures.
> The following test cases had failed, and are fixed now:
> < t1400-update-ref
> < t3210-pack-refs
> < t3211-peel-ref
> < t3306-notes-prune
> < t5304-prune
> < t5404-tracking-branches
> < t5500-fetch-pack
> < t5505-remote
> < t5514-fetch-multiple
> < t5515-fetch-merge-logic
> < t6030-bisect-porcelain
> < t9300-fast-import
> < t9903-bash-prompt
>=20
> In short: Thanks, This looks good to me.

Thank you for testing this! It is much appreciated.

I sent a v2 patch to the list last night. It passes the full
test suite for me on cygwin 1.5, although there appears to be
a slight performance problem on MinGW (perhaps!). :(

ATB,
Ramsay Jones
