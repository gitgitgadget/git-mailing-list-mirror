From: Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at>
Subject: Re: pre-push hook does not get input on non-fast-forward pushes
Date: Tue, 29 Mar 2016 00:09:08 +0200
Message-ID: <201603282209.u2SM98Zb010448@mail2.student.tuwien.ac.at>
References: <201603282056.u2SKuqDf031459@mail2.student.tuwien.ac.at>
	<xmqq1t6uxop7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 00:09:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfLc-00018N-4M
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbcC1WJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 18:09:15 -0400
Received: from mail2.student.tuwien.ac.at ([193.170.74.22]:56011 "EHLO
	mail2.student.tuwien.ac.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754750AbcC1WJO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:09:14 -0400
Received: from misery (chello080109083031.10.15.vie.surfer.at [80.109.83.31])
	(authenticated bits=0)
	by mail2.student.tuwien.ac.at (8.13.8/8.13.8) with ESMTP id u2SM98Zb010448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Mar 2016 00:09:08 +0200
In-Reply-To: <xmqq1t6uxop7.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290067>

On Mon, 28 Mar 2016 14:44:20 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at> writes:
>=20
> The pre-push hook is not the only thing that may prevent you from
> pushing a ref update.  As you noticed, non-fast-forward check may
> trigger and decide that a ref is not going to be pushed, and that
> may happen before we call the pre-push hook.
>=20
>     Information about what is to be pushed is provided on the hook's
>     standard input with lines of the form ...
>=20
> So when the pre-push is called, the refs that will not fast-forward
> may not be among the "what is to be pushed", hence not reported.
>=20
> We _could_ add something like this to the documentation, but we do
> not necessarily want to promise that the order of checks to stay
> "internal checks like non-ff check first before pre-push hook", so
> this update may not be an improvement.  The current text conveys
> enough information without making such a promise, but you need to
> read it carefully.

I understand but that behavior is quite surprising and the wording not
that clear (if one is not aware of the behavior already) IMHO. If the
fast forward check is done beforehand and no refs remain, why is the
script called at all? Or put otherwise, why isn't git aborting before
that? That would seem way more logical... consistency is a good
argument to call the hook with no refs anyway... but the abort/filter
order is remarkable and should be documented in some way IMHO.

>=20
>  Documentation/githooks.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 9ef2469..605ba4d 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -201,7 +201,9 @@ does not yet exist the `<remote SHA-1>` will be 4=
0 `0`.  If a ref is to be
>  deleted, the `<local ref>` will be supplied as `(delete)` and the `<=
local
>  SHA-1>` will be 40 `0`.  If the local commit was specified by someth=
ing other
>  than a name which could be expanded (such as `HEAD~`, or a SHA-1) it=
 will be
> -supplied as it was originally given.
> +supplied as it was originally given.  A request to update remote ref=
 that has
> +already been rejected for other reasons (e.g. failing to pass a fast=
-forward
> +test) does not appear in the input.
> =20
>  If this hook exits with a non-zero status, 'git push' will abort wit=
hout
>  pushing anything.  Information about why the push is rejected may be=
 sent

LGTM... if you don't want to promise anything then maybe something like
"may not appear" instead of "does not appear" is better. As long as the
reason for no input is stated more explicitly than currently I am happy=
=2E

--=20
Kind regards/Mit freundlichen Gr=C3=BC=C3=9Fen, Stefan Tauner
