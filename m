From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 0/6] merge summary and diffstat options cleanup
Date: Sun,  6 Apr 2008 03:23:41 +0200
Message-ID: <1207445027-3152-1-git-send-email-szeder@ira.uka.de>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 03:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJd9-0004kF-Bc
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbYDFBYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 21:24:18 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbYDFBYQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:24:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51317 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbYDFBYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:24:11 -0400
Received: from [127.0.1.1] (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1JiJbm2lNQ-0002V2; Sun, 06 Apr 2008 03:23:50 +0200
X-Mailer: git-send-email 1.5.5.rc3.9.gba703
In-Reply-To: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
X-Provags-ID: V01U2FsdGVkX18+l88iKrU1LxpxN5RFshu7+siJxs8U461S4pB
 g7kVlNUdBjq4BPVO2EB7YVgV3OxB65vxf5rppzsPPoEnkDqzq1
 POdNB5nmGoTPujI1DpIEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78880>

On Sat, Apr 05, 2008 at 11:51:51AM -0700, Junio C Hamano wrote:
> I'd favor, in the longer run:
>=20
>  * --stat option to mean "show the diffstat between ORIG_HEAD and mer=
ge
>    result" (i.e. current --summary);
I have only looked at the 'merge.diffstat' config variable, and wanted
to make the command line option consistent with it.  But you are right,
'--stat' is better, because it's in sync with other commands as well.

>  * perhaps a new configuration merge.stat to control the default for =
the
>    above;
>=20
>  * merge.log configuration to mean "add list of one-line log to the m=
erge
>    commit message" (i.e. current merge.summary);
>=20
>  * perhaps a --log option to override the config default for each
>    invocation.
>=20
>  * deprecate --summary and merge.summary and remove them long after p=
eople
>    are used to the above new set.
>=20
> Transition needs to happen over time and across a major release bump.
>=20
> We can do the first four in 1.5.6, and immediately declare
> deprecation,
> and removal of --summary/merge.summary perhaps in 1.6.0. =20

The first patch is an independent documentation cleanup that could be
merged regardless of the other patches, but the others depend on it.

Patches 2-5 are implementing your first four point.  Patch 4 not only
adds the 'merge.log' config variable, but also adds corresponding
command line options.

=46inally, the last patch removes all the deprecated stuff.


SZEDER G=C3=A1bor (6):
  doc: moved merge.* config variables into separate merge-config.txt
  merge, pull: introduce '--(no-)stat' option
  add 'merge.stat' config variable
  fmt-merge-msg: add '--(no-)log' options and 'merge.log' config
    variable
  merge, pull: add '--(no-)log' command line option
  merge: remove deprecated summary and diffstat options and config
    variables

 Documentation/config.txt               |   32 +-----------------------=
-----
 Documentation/git-fmt-merge-msg.txt    |   10 ++++----
 Documentation/git-merge.txt            |   15 +-----------
 Documentation/merge-config.txt         |   35 ++++++++++++++++++++++++=
++++++++
 Documentation/merge-options.txt        |   15 +++++++++++--
 builtin-fmt-merge-msg.c                |    8 +++---
 contrib/completion/git-completion.bash |    2 +-
 git-merge.sh                           |   18 ++++++++++------
 git-pull.sh                            |   20 +++++++++---------
 t/t6200-fmt-merge-msg.sh               |    6 ++--
 t/t7600-merge.sh                       |   22 ++++++++++++++++---
 11 files changed, 102 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/merge-config.txt
