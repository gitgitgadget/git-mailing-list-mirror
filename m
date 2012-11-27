From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: diff support for the Eiffel language?
Date: Tue, 27 Nov 2012 12:16:18 +0100
Message-ID: <50B4AF12020000A10000DA1F@gwsmtp1.uni-regensburg.de>
References: <508550E8020000A10000CF36@gwsmtp1.uni-regensburg.de>
 <CACBZZX4wF8C_9ok+zeTfO70BgZXufvQaJ+8B5EiOAmxvVwr54g@mail.gmail.com>
 <50854B90.50807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <avarab@gmail.com>, "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdJIW-0002aj-4R
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 12:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab2K0LZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 06:25:35 -0500
Received: from rrzmta5.uni-regensburg.de ([194.94.155.56]:36320 "EHLO
	rrzmta5.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2K0LZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 06:25:34 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 06:25:34 EST
Received: from rrzmta5.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 5591436F4
	for <git@vger.kernel.org>; Tue, 27 Nov 2012 12:16:20 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta5.uni-regensburg.de (Postfix) with ESMTP id 38D1236ED
	for <git@vger.kernel.org>; Tue, 27 Nov 2012 12:16:20 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Tue, 27 Nov 2012 12:15:34 +0100
X-Mailer: Novell GroupWise Internet Agent 12.0.1 
In-Reply-To: <50854B90.50807@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210556>

Hi!

I managed to have some success, although it's not perfect. Unfortunatel=
y the
Eiffel grammar does not allow a 100% solution. Example:

---
local
  x : BOOLEAN
---
declares a local variable named `x', while

---
  x : BOOLEAN
   do ... end
---

Declares a function named `x'. Formal generic parameters like `x :
ARRAY[ARRAY[STRING]]' make things more complicate. Anyway, here's my so=
lution
(probably incomplete):
---
% git config --local -e
[diff "Eiffel"]
xfuncname =3D
"!^[[:space:]]*(check|class|[Cc]reate|else|elseif|end|ensure|do|!|featu=
re|from|indexing|inherit|is|local|loop|note|require|then|until)[[:space=
:]]*\n\
^[[:space:]]*(class[[:space:]]*[[:alpha:]_][[:alnum:]_]*)\n\
^[[:space:]]*([[:alpha:]_][[:alnum:]_]*[[:space:]]*\\([^(\")]+:[^(\")]+=
\\)[[:space:]]*:[[:space:]*[[:alpha:]_][[:alnum:]_]*[[:space:]]*[^[:spa=
ce:]\"]?[^\"=3D]*)[[:space:]]*$\n\

^[[:space:]]*([[:alpha:]_][[:alnum:]_]*[[:space:]]*\\([^(\")]+:[^(\")]+=
\\))[[:space:]]*$\n\

^[[:space:]]*([[:alpha:]_][[:alnum:]_]*[[:space:]]*:[[:space:]*[[:alpha=
:]_][[:alnum:]_]*[[:space:]]*[^[:space:]\"]?[^\"=3D]*)[[:space:]]*$\n\
^[[:space:]]*([[:alpha:]_][[:alnum:]_]*)[[:space:]]*$"
% cat .git/info/attributes
*.e	diff=3DEiffel
---

Regards,
Ulrich

>>> Johannes Sixt <j.sixt@viscovery.net> schrieb am 22.10.2012 um 15:35=
 in
Nachricht <50854B90.50807@viscovery.net>:
> Am 10/22/2012 15:06, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> > On Mon, Oct 22, 2012 at 1:58 PM, Ulrich Windl=20
> > <Ulrich.Windl@rz.uni-regensburg.de> wrote:
> >> However there's one little thing I noticed with "git diff": The
> >> conte4xt lines (staring with "@@") show the current function (in P=
erl
> >> and C), but they show the current "feature clause" in Eiffel (as
> >> opposed to the expected current feature). I wonder how hard it is =
to
> >> fix it (Observed in git 1.7.7 of openSUSE 12.1).
> >=20
> > See git.git's e90d065 for an example of adding a new diff pattern.
>=20
> It's not necessary to wait until there is built-in support for a new=20
> language.
>=20
> For example, for Windows resource files, I have
>=20
> *.rc    diff=3Dwinres
>=20
> in .gitattributes or .git/info/attributes and
>=20
> [diff "winres"]
>         xfuncname =3D
>
"!^(BEGIN|END|FONT|CAPTION|STYLE)\n^[a-zA-Z_][a-zA-Z_0-9]*.*\n^[[:space=
:]]*(
> [[:alnum:]_]+,
> *DIALOG.*)"
>=20
> in .git/config (the xfuncname is all on a single line). The first par=
t
> beginning at ! up to \n tells to ignore the specified matches. The ot=
her
> parts separated by \n tell the things to put in the hunk header. You =
can
> have "ignore" parts (with exlamation mark) and "take this" parts (wit=
hout)
> in any order that is convenient, as long as the last one is "take thi=
s".
>=20
> -- Hannes
>=20

=20
=20
