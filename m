From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv5 3/3] status: don't suggest "git rm" or "git add" if not appropriate
Date: Fri, 1 Jun 2012 08:15:58 -0400
Message-ID: <CABURp0qS-bDYTTgz75mQOOZsXzM1TkF_CNjaRNcXa4MYXAg0kA@mail.gmail.com>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1338477344-15940-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 14:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaQmI-0004j2-Vz
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 14:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759547Ab2FAMQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 08:16:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42444 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544Ab2FAMQT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 08:16:19 -0400
Received: by yhmm54 with SMTP id m54so1527820yhm.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kIFNsxjf2r2fZPDcdYTytZN1YDYUiM79TC6eMJsuSs8=;
        b=h/FAwCnxnAREiOpy/lBARONsQ8aJ7X9REF2YaGNH8pO3IyxAqzKzx9XERzGW5gAsUn
         tPLAG6yunyt4Lz3csR+MTD/20sRd0kPazzInw56PPCZdOJb8V1vyRd6mI6m1wG/SYQaE
         S28IpvD4Gy5eDPZR+KFnEFr6+wXAeLdcut6yJdhIuzpLJc1MCQnctAVyFHfMRA/Syrzs
         XHwcCRshq9PimvVemhAw0zsKnNeYyBnwIoUC1KHS+K8B1jV7rE922bE+HCCLCqWqk//e
         bacu/gRyDgBTQ2Pc9Zdl3my3cIq6WYgXeqpsIw61+UvylE8pPcAVhZt2O3lcYqVTzavb
         pyXw==
Received: by 10.236.76.133 with SMTP id b5mr2592777yhe.3.1338552978904; Fri,
 01 Jun 2012 05:16:18 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 1 Jun 2012 05:15:58 -0700 (PDT)
In-Reply-To: <1338477344-15940-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198983>

On Thu, May 31, 2012 at 11:15 AM, Kong Lucien
<Lucien.Kong@ensimag.imag.fr> wrote:
> The display of the advice '(use git add/rm [...])' (when there are
> unmerged files) after running 'git status' is now depending of the
> mark, whether it's 'both deleted', 'deleted by us/them' or others. Fo=
r
> instance, when there is just one file that's marked as 'both deleted'=
,
> 'git status' shows '(use git rm [...])' and if there are two files,
> one as 'both deleted' and the other as 'added by them', the advice is
> '(use git add/rm [...])'.
>
=2E..
diff --git a/wt-status.c b/wt-status.c
=2E..
> @@ -142,7 +167,17 @@ static void wt_status_print_unmerged_header(stru=
ct wt_status *s)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status_printf_ln(s, c, _(" =A0(use \"g=
it reset %s <file>...\" to unstage)"), s->reference);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status_printf_ln(s, c, _(" =A0(use \"g=
it rm --cached <file>...\" to unstage)"));
> - =A0 =A0 =A0 status_printf_ln(s, c, _(" =A0(use \"git add/rm <file>.=
=2E.\" as appropriate to mark resolution)"));
> +
> + =A0 =A0 =A0 if (!both_deleted) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!del_mod_conflict)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status_printf_ln(s, c, =
_(" =A0(use \"git add <file>...\" to mark resolution)"));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status_printf_ln(s, c, =
_(" =A0(use \"git add/rm <file>...\" as appropriate to mark resolution)=
"));
> + =A0 =A0 =A0 } else if (!del_mod_conflict && !not_deleted) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status_printf_ln(s, c, _(" =A0(use \"gi=
t rm <file>...\" to mark resolution)"));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status_printf_ln(s, c, _(" =A0(use \"gi=
t add/rm <file>...\" as appropriate to mark resolution)"));
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0status_printf_ln(s, c, "");
> =A0}


This brings a frequent frustration to the front.  It is not the fault
of this commit, so please don't think I am blaming you, Lucien.  Thank
you for highlighting it.

> +       } else if (!del_mod_conflict && !not_deleted) {
> +               status_printf_ln(s, c, _("  (use \"git rm <file>...\"=
 to mark resolution)"));

Why should I be bothered when both sides delete the same file?  Does
this case only occur when each side has made different changes to the
file prior to deleting it, or does it occur any time each commit has
deleted the same exact file?

As this patch highlights, the only expected resolution is to 'git rm'
the file; why can't git figure this out for me and continue on?

Is there a config option to alter this behavior?

Phil
