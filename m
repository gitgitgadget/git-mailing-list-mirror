From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH v2 00/13] bash prompt speedup
Date: Tue, 18 Jun 2013 21:35:51 +0200
Message-ID: <20130618193551.GB13480@xs4all.nl>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
 <7vsj0f5pr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER G?bor <szeder@ira.uka.de>, git@vger.kernel.org,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 21:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up1hK-0002q2-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 21:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041Ab3FRTgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 15:36:06 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:3618 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728Ab3FRTgF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 15:36:05 -0400
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id r5IJZui4096149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 21:35:57 +0200 (CEST)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id r5IJZt1x018323;
	Tue, 18 Jun 2013 21:35:55 +0200
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id r5IJZp3c018315;
	Tue, 18 Jun 2013 21:35:51 +0200
Content-Disposition: inline
In-Reply-To: <7vsj0f5pr7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228308>

* Junio C Hamano <gitster@pobox.com> [2013-06-18 09:48:28 -0700]:

> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > This patch series eliminates many command substitutions and command=
s
> > in __git_ps1() from top to bottom by replacing them with bash built=
ins
> > or consolidating them.  A few timing results are shown in the log
> > message of patch 10.
>=20
> Nice.  I think I saw Peff's comment and discussion between you two
> already resuted in a fixup, so perhaps I'll see a reroll sometime
> later when the dust settles?
>=20
> Also, could you help review the other topic by Eduardo R. D'Avila
> about colored prompt (Sion Oosthoek, who did the color support,
> CC'ed)?
>=20
>     http://thread.gmane.org/gmane.comp.version-control.git/228017
>=20
> The impression I got when the PROMPT_COMMAND series was discussed
> last October was that you need to use \[...\] pairs to get the
> cursor position right for the purpose of command line editing, and
> D'Avila's series seemed to only do so in PROMPT_COMMAND mode.
>=20

Hi Junio e.a.

Unfortunately I'm very busy with lots of stuff, so hardly time to look =
at this. (I didn't read the full patch or resulting file)

The PROMPT_COMMAND business was not something I was glad to use, I was =
unable to get command substitution mode to work with colours and keep b=
ash happy about the prompt string length. The thing to test is not whet=
her or not colours appear when using substitution in PS1, but to see wh=
ether bash will not mess up the commandline when browsing through the h=
istory. This is especially inconvenient with very long commandlines (as=
 you can imagine).

An optimisation which I've not yet had time to work on would be to do a=
 lot of the processing in separate functions and use the result in sepa=
rate functions for pcmode and subst. mode. The idea being that the main=
tainability of the logic for generating the prompt goes up (no duplicat=
e code, clear separation, etc.) and the size of the called functions to=
 gerenate the prompt goes down. And perhaps most important that it woul=
d be very easy to build a customised version of __git_ps1() using those=
 functions from the standard code.=20

I know this is pretty vague, I wish it wasn't so...

If it's somehow possible to eliminate the PROMPT_COMMAND mode, I'm all =
for it. But I doubt it can be done while keeping commandline browsing w=
orking ok... (please go ahead and prove me wrong!)

Cheers

Simon
