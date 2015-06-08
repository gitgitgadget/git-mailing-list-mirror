From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Mon, 08 Jun 2015 18:17:49 +0200
Message-ID: <vpqeglm41jm.fsf@anie.imag.fr>
References: <1433775308-5451-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio Hamano <gitster@pobox.com>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:18:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zkg-0001xc-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbbFHQSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 12:18:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38825 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbbFHQR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:17:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58GHmVB001716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 18:17:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58GHn9K008505;
	Mon, 8 Jun 2015 18:17:49 +0200
In-Reply-To: <1433775308-5451-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Mon, 8 Jun 2015
 16:55:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 18:17:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58GHmVB001716
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434385070.2652@BAd2e9zaHA3NKAJGvaCAxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271065>

Please, include a version number in the subject. git send-email -v2 doe=
s
this for you.

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> +static void show_rebase_information(struct wt_status *s,
> +				    struct wt_status_state *state,
> +				    const char *color)
> +{
> +	if (state->rebase_interactive_in_progress) {
> +		int i, begin;
> +		int lines_to_show_nr =3D 2;
> +
> +		struct strbuf buf =3D STRBUF_INIT;
> +		struct string_list have_done =3D STRING_LIST_INIT_DUP;
> +		struct string_list yet_to_do =3D STRING_LIST_INIT_DUP;
> +
> +		strbuf_read_file(&buf, git_path("rebase-merge/done"), 0);
> +		stripspace(&buf, 1);
> +		have_done.nr =3D string_list_split(&have_done, buf.buf, '\n', -1);
> +		string_list_remove_empty_items(&have_done, 1);
> +		strbuf_release(&buf);

I'd release buf one line earlier (meaning "I'm done with buf, now let's
talk about something else"), but it's OK like this too

> +		strbuf_read_file(&buf, git_path("rebase-merge/git-rebase-todo"), 0=
);
> +		stripspace(&buf, 1);
> +		string_list_split(&yet_to_do, buf.buf, '\n', -1);
> +		string_list_remove_empty_items(&yet_to_do, 1);
> +		strbuf_release(&buf);

Nice. Much simpler than the previous iteration.

> +		if (have_done.nr =3D=3D 0)
> +			status_printf_ln(s, color, _("No commands done."));
> +		else{

Missing space before {

> +			status_printf_ln(s, color,
> +				Q_("Last command done (%d command done):",
> +					"Last commands done (%d commands done):",
> +					have_done.nr),
> +				have_done.nr);
> +			begin =3D (have_done.nr > lines_to_show_nr) ? have_done.nr-lines_=
to_show_nr : 0;

Missing space around '-'

> +			for (i =3D begin; i < have_done.nr; i++) {
> +				status_printf_ln(s, color, "   %s", have_done.items[i].string);
> +			}

Useless braces.

> +			if (have_done.nr > lines_to_show_nr && s->hints)
> +			   status_printf_ln(s, color,

Indentation with space (open in Emacs, M-x whitespace-mode RET to see
this kind of things).

> +				_("  (see more in file %s)"), git_path("rebase-merge/done"));
> +		}
> +		if (yet_to_do.nr =3D=3D 0)
> +			status_printf_ln(s, color,
> +					 _("No commands remaining."));
> +		else{
> +
> +			status_printf_ln(s, color,
> +				Q_("Next command to do (%d remaining command):",
> +					"Next commands to do (%d remaining commands):",
> +					yet_to_do.nr),
> +				yet_to_do.nr);
> +			for (i =3D 0; i < lines_to_show_nr && i < yet_to_do.nr; i++) {
> +				status_printf_ln(s, color, "   %s", yet_to_do.items[i].string);
> +			}

Useless braces.

> +			if (s->hints)
> +			   status_printf_ln(s, color,

Indentation with space again.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
