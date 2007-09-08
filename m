From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] Rework pretty_print_commit to use strbufs instead
 of custom buffers.
Date: Sat, 08 Sep 2007 20:40:08 +0200
Message-ID: <46E2EC88.6000500@lsrfire.ath.cx>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org> <1189252399316-git-send-email-madcoder@debian.org> <11892523992038-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 20:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU5EF-0008Po-Hw
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 20:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbXIHSkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Sep 2007 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbXIHSkR
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 14:40:17 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:48026
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754231AbXIHSkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 14:40:16 -0400
Received: from [10.0.1.201] (p57B7D967.dip.t-dialin.net [87.183.217.103])
	by neapel230.server4you.de (Postfix) with ESMTP id 2EDAB873B5;
	Sat,  8 Sep 2007 20:40:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11892523992038-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58131>

Pierre Habouzit schrieb:
>   Also remove the "len" parameter, as:
>   (1) it was used as a max boundary, and every caller used ~0u
>   (2) we check for final NUL no matter what, so it doesn't help for s=
peed.
>=20
>   As a result most of the pp_* function takes 3 arguments less, and w=
e need
> a lot less local variables, this makes the code way more readable, an=
d
> easier to extend if needed.
>=20
>   This patch also fixes some spacing and cosmetic issues.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-branch.c      |   15 +--
>  builtin-log.c         |   12 +-
>  builtin-rev-list.c    |   13 +-
>  builtin-show-branch.c |   13 +-
>  commit.c              |  330 ++++++++++++++++++---------------------=
----------
>  commit.h              |    6 +-
>  log-tree.c            |   56 +++------
>  7 files changed, 171 insertions(+), 274 deletions(-)

Nice!  I wonder if we should #include strbuf.h from git-compat-util.h
(just like e.g. string.h) instead of from commit.h, in order to have
strbuf available everywhere in git.

Please be aware of the changes to commit.c already in next which your
patch conflicts with: format_commit_message() has been exported and is
used in builtin-archive.c there.

Ren=E9
