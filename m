From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 00/12] merge summary and diffstat options cleanup
Date: Wed, 16 Apr 2008 02:38:59 +0200
Message-ID: <1208306351-20922-1-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:04:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvgw-0007Zm-4U
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbYDPAjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 20:39:15 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbYDPAjO
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:54592 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYDPAjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:14 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1Jlvg70tOr-0003ul; Wed, 16 Apr 2008 02:39:12 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
X-Provags-ID: V01U2FsdGVkX18X9rowsrwcVIeRB1Na+oOz2o9FSMmjh6fJJXt
 jjuFx5Q7P8Fw4pKbmpsuNcuK6eWQ6IIrYrHdIXn5U/KR1qBx2J
 /1JxE40UxOWXGjeQJdA1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79658>

On Sat, Apr 05, 2008 at 07:36:57PM -0700, Junio C Hamano wrote:
> ...this hunk removes the original options from OPTIONS_SPEC, I suspec=
t you
> would get "unknown option 'stat'" from underlying "git rev-parse --pa=
rseopt".
>=20
> You probably haven't noticed the breakage because you replaced all
> existing --summary with --stat in the tests, though.  Oops.
It was not clear to me that this OPTIONS_SPEC is used for parsing,
too.  This series fixes the problem.

> We would want to take a three-stage approach where we (1) start accep=
ting
> both forms without changing the official names shown to the users, (2=
)
> deprecate the old names and make the new ones official, and then (3)
> finally remove the old ones.  Your 2 thru 5 roll (1) and (2) into one
> step.
>=20
> I would not have major problem with this "hasty deprecation" in "usag=
e"
> strings, but I find it somewhat problematic to stop mentioning the ol=
d
> names in the documentation and bash completion from day one.  People =
learn
> old names elsewhere (e.g. in somebody's blog entry) and then try to f=
ind
> the description in their manual and they are already removed from you=
r
> copy.  Oops.
Yeah, you are right that deprecated options should not be removed from
the documentation.

However, I think that rolling (1) and (2) into one step is better than
having them separate.  If we have the two steps separate will also
cause confusion, as users learning merge & co. between (1) and (2)=20
might wonder, why are there two options for the same thing and which
one should they prefer.  They might even suspect that one of the=20
options will be deprecated in the future, but they will not be able to
tell which without looking at e.g. the mailing list archives.  I would
also prefer to remove the deprecated options and config variables from
bash completion, because their users will then notice earlier that the
options are deprecated.

But anyway, in this patch series steps (1) and (2) are split into
separate set of patches, so you can decide to have steps (1) and (2)
separately or not.

The first six patches are adding the new options and config variables
to merge, pull, and fmt-merge-msg, but are not deprecating the old
ones.  They are also updating documentation, tests, and bash
completion accordingly.  (Patches 1 and 4 are independent cleanups
that could be merged regardless of the other patches, but the others
are depending on them.)

Patches 7-9 are marking the old options and config variables as
deprecated.

And finally, patches 10-12 are removing all the deprecated stuff, but
they are there only for illustration purposes at the moment, to see
how things will look like after the deprecation period.


SZEDER G=C3=A1bor (12):
  doc: moved merge.* config variables into separate merge-config.txt
  merge, pull: introduce '--(no-)stat' options
  add 'merge.stat' config variable
  t6200-fmt-merge-msg: put expected messages into different files
  fmt-merge-msg: add '--(no-)log' options and 'merge.log' config
    variable
  merge, pull: add '--(no-)log' command line option
  merge, pull: mark '--(no-)summary' options as deprecated
  merge, pull: mark the config variable 'merge.diffstat' as deprecated
  fmt-merge-msg: mark summary-related option and config variable as
    deprecated
  merge, pull: remove deprecated '--(no-)summary' options
  merge, pull: remove deprecated 'merge.diffstat' config variable
  fmt-merge-msg: remove deprecated summary-related options and config
    variable

 Documentation/config.txt               |   32 +------------------
 Documentation/git-fmt-merge-msg.txt    |   10 +++---
 Documentation/git-merge.txt            |   17 ++--------
 Documentation/merge-config.txt         |   35 ++++++++++++++++++++
 Documentation/merge-options.txt        |   15 +++++++--
 builtin-fmt-merge-msg.c                |    8 ++--
 contrib/completion/git-completion.bash |    6 ++-
 git-merge.sh                           |   18 ++++++----
 git-pull.sh                            |   20 ++++++------
 t/t6200-fmt-merge-msg.sh               |   54 ++++++++++++++++++++++++=
-------
 t/t7600-merge.sh                       |   24 +++++++++++---
 11 files changed, 146 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/merge-config.txt
