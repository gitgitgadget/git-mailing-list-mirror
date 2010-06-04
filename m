From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 3/3] commit::print_summary(): set rev_info.always_show_header 
	to 1
Date: Fri, 4 Jun 2010 16:34:28 +0800
Message-ID: <AANLkTilv7gR6ewVpvwS0PPaNAj4FC446PYZAX2RKLT8O@mail.gmail.com>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
	<1274974492-4692-4-git-send-email-rctay89@gmail.com>
	<AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>
	<1275639660-5344-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 10:34:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKSMQ-000504-L4
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 10:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab0FDIec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 04:34:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65058 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab0FDIea convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 04:34:30 -0400
Received: by iwn37 with SMTP id 37so758982iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Wfn1OYvmDLQpv/zk/e/NQxknvqFDnHcx2rRjaSw0q+o=;
        b=mnH2/v5vKZhnWsIZnb4dHozFouVyzchzBnPkXMtDEP3jReyWbP7Yzm6tcBTYtlMJFW
         EQoRe3sqHWS8HUnV5Ovv7JhfKvXeI4p7ivrOK8plTVl3aKKx6nZXJA2czlsvD1VPoKJZ
         r3h9AsAUfUFigFrQtECYbdDxqf69LaQDgXiMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tiInQO7PFf1ti2wFiFWKWRw6JNVY7wJ6tw28RhjqB5rpClMRtOjZZHSCkvuv6D3f6D
         UoKnlnwgHhw8zx3iGJobPKugubSnAAo9RFtEGukue5xtfZSD0diL4USla+Bk7YSbKVIE
         dYjE/Ad6aiLPz4MrcMDkkkvxpACNWZS6hnJLA=
Received: by 10.231.211.134 with SMTP id go6mr533925ibb.143.1275640468928; 
	Fri, 04 Jun 2010 01:34:28 -0700 (PDT)
Received: by 10.231.14.199 with HTTP; Fri, 4 Jun 2010 01:34:28 -0700 (PDT)
In-Reply-To: <1275639660-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148386>

Hi Will,

sorry, I forgot to Cc you for this new version.

--=20
Cheers,
Ray Chuan

On Fri, Jun 4, 2010 at 4:21 PM, Tay Ray Chuan <rctay89@gmail.com> wrote=
:
> This attempts to fix a regression in git-commit, where non-abbreviate=
d
> SHA-1s were printed in the summary.
>
> One possible fix would be to set ctx.abbrev to DEFAULT_ABBREV in the
> `if` block.
>
> However, we remove this codeblock altogether, and set
> rev.always_show_header. This way, we use back the same show_log()
> mechanism (instead of format_commit_message()).
>
> Quoting log-tree.c:560:
>
> =A0 =A0 =A0 =A0shown =3D log_tree_diff(opt, commit, &log);
> =A0 =A0 =A0 =A0if (!shown && opt->loginfo && opt->always_show_header)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0log.parent =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show_log(opt);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0shown =3D 1;
> =A0 =A0 =A0 =A0}
>
> This is the only area that always_show_header is checked, so the
> setting of this flag should only affect this area.
>
> Also, we now die() if log_tree_commit() returns false. Based on the
> existing underlying codepaths (log_tree_commit(), log_tree_diff(),
> log_tree_diff_flush(), to name a few), this should not occur; changes=
 to
> these codepaths may warrant a revision of our handling of this
> situation. Tests #2 and #3 in t7502 should aid in detecting such
> breakages.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
> This is a reworked version of the third patch of the
> 'tc/commit-abbrev-fix' series; there are no changes to the first and
> second patches.
>
> Changes from v2:
> =A0- shift around 2nd and 3rd paras.
> =A0- mention the die() and our assumption that it won't be triggered,=
 as
> =A0 suggested by Junio.
>
> =A0builtin/commit.c =A0| =A0 13 ++++---------
> =A0t/t7502-commit.sh | =A0 =A04 ++--
> =A02 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a4e4966..2884d0c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1148,7 +1148,7 @@ static void print_summary(const char *prefix, c=
onst unsigned char *sha1)
> =A0 =A0 =A0 =A0rev.verbose_header =3D 1;
> =A0 =A0 =A0 =A0rev.show_root_diff =3D 1;
> =A0 =A0 =A0 =A0get_commit_format(format.buf, &rev);
> - =A0 =A0 =A0 rev.always_show_header =3D 0;
> + =A0 =A0 =A0 rev.always_show_header =3D 1;
> =A0 =A0 =A0 =A0rev.diffopt.detect_rename =3D 1;
> =A0 =A0 =A0 =A0rev.diffopt.rename_limit =3D 100;
> =A0 =A0 =A0 =A0rev.diffopt.break_opt =3D 0;
> @@ -1162,14 +1162,9 @@ static void print_summary(const char *prefix, =
const unsigned char *sha1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0head,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0initial_commit ? " (root-commit)" : ""=
);
>
> - =A0 =A0 =A0 if (!log_tree_commit(&rev, commit)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pretty_print_context ctx =3D {0}=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx.date_mode =3D DATE_NORMAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 format_commit_message(commit, format.bu=
f + 7, &buf, &ctx);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("%s\n", buf.buf);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_release(&buf);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!log_tree_commit(&rev, commit))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to print summary");
> +
> =A0 =A0 =A0 =A0strbuf_release(&format);
> =A0}
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index b10541d..08c0247 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -36,12 +36,12 @@ test_expect_success 'output summary format' '
> =A0 =A0 =A0 =A0check_summary_oneline "" "a change"
> =A0'
>
> -test_expect_failure 'output summary format for commit with an empty =
diff' '
> +test_expect_success 'output summary format for commit with an empty =
diff' '
>
> =A0 =A0 =A0 =A0check_summary_oneline "" "empty" "--allow-empty"
> =A0'
>
> -test_expect_failure 'output summary format for merges' '
> +test_expect_success 'output summary format for merges' '
>
> =A0 =A0 =A0 =A0git checkout -b recursive-base &&
> =A0 =A0 =A0 =A0test_commit base file1 &&
> --
> 1.7.1.189.g07419
>
>
