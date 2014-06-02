From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] pack-objects: use free()+xcalloc() instead of xrealloc()+memset()
Date: Mon, 02 Jun 2014 22:40:44 +0200
Message-ID: <878upf9h9v.fsf@fencepost.gnu.org>
References: <538B0969.9080409@web.de>
	<20140602194246.GD2510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:41:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZ2b-0004Ut-LY
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 22:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbaFBUlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2014 16:41:04 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:38611 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbaFBUlC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jun 2014 16:41:02 -0400
Received: from localhost ([127.0.0.1]:37650 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WrZ2T-0008Dz-N6; Mon, 02 Jun 2014 16:41:01 -0400
Received: by lola (Postfix, from userid 1000)
	id 205CAE053B; Mon,  2 Jun 2014 22:40:44 +0200 (CEST)
In-Reply-To: <20140602194246.GD2510@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Jun 2014 15:42:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250594>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 01, 2014 at 01:07:21PM +0200, Ren=E9 Scharfe wrote:
>
>> Whenever the hash table becomes too small then its size is increased=
,
>> the original part (and the added space) is zerod out using memset(),
>> and the table is rebuilt from scratch.
>>=20
>> Simplify this proceess by returning the old memory using free() and
>> allocating the new buffer using xcalloc(), which already clears the
>> buffer for us.  That way we avoid copying the old hash table content=
s
>> needlessly inside xrealloc().
>>=20
>> While at it, use the first array member with sizeof instead of a
>> specific type.  The old code used uint32_t and int, while index is
>> actually an array of int32_t.  Their sizes are the same basically
>> everywhere, so it's not actually a problem, but the new code is
>> cleaner and doesn't have to be touched should the type be changed.
>>=20
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>
> Looks good to me.
>
> BTW, the code does git-blame to Vicent's 2834bc2 (which I also worked
> on), but actually originated in 7a979d9 (Thin pack - create packfile
> with missing delta base., 2006-02-19). Not that it matters, but I was
> just surprised since the code you are changing did not seem familiar =
to
> me. I guess there was just too much refactoring during the code movem=
ent
> for git-blame to pass along the blame in this case.

Without -M, "too much refactoring" for git-blame may just be moving a
function to a different place in the same file.

--=20
David Kastrup
