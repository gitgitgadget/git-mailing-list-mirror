From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v5 4/4] rev-parse: make --flags imply --no-revs for
 remaining arguments.
Date: Sun, 26 Sep 2010 02:21:11 +1000
Message-ID: <AANLkTi=BuHRVQwTdpkdLNDPS7VKdy6s7VW+S85U5Mz7z@mail.gmail.com>
References: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
	<1285431515-21321-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 18:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXV6-00037c-Fn
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab0IYQVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 12:21:13 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33150 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab0IYQVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 12:21:12 -0400
Received: by qyk36 with SMTP id 36so2815216qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lZTtzD9ke71Szu0GmlX77azEuTUNRsix1M14BNBAcLQ=;
        b=gaP+rtHhgC+B1KEDIgmwsIFNDei1O4Hljo0HU/PJcISrAQvbqcPKRktDOH8cuX4Qjb
         9+60LWv1D18Zksd3YDWiW39r5wGbDkC6qH5YVM2fJzAhuyXWCL9Is2NMfVYzGCJhH61G
         Zw2dq4NSwe+i5gv5+EHeMDgvsbAUIvixmxrzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=If2kBiqhp5D39Nd6onw9bpu31TPVRYv55X/ORmvqZFOss+6wnCt4+tvDUTpj6mZp9p
         hcs0PEuy72kDgh7V2ZSsvMouWzDfETAruPF4R5HbzhWJcp3URZ1ab7csKKmBFaX43e8q
         YTU/Th8IBE/iIAUZy1IafodMc+0PQn9ilH5ag=
Received: by 10.224.115.146 with SMTP id i18mr3588263qaq.275.1285431671422;
 Sat, 25 Sep 2010 09:21:11 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 09:21:11 -0700 (PDT)
In-Reply-To: <1285431515-21321-5-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157165>

Apologies - it appears I missed on : > case. Will fix in next iteration=
=2E..

jon.

On Sun, Sep 26, 2010 at 2:18 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> This change ensures that git rev-parse --flags complies with its docu=
mentation,
> namely:
>
> =C2=A0 "Do not output non-flag parameters".
>
> Previously:
> =C2=A0 $ git rev-parse --flags HEAD
> =C2=A0 <sha1 hash of HEAD>
> =C2=A0 $
>
> Now:
> =C2=A0 $ git rev-parse --flags HEAD
> =C2=A0 $
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =C2=A0Documentation/git-rev-parse.txt | =C2=A0 24 +++++++++++++------=
-----
> =C2=A0builtin/rev-parse.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A06 +++++-
> =C2=A0t/t1510-rev-parse-flags.sh =C2=A0 =C2=A0 =C2=A0| =C2=A0 24 ++++=
+++++++++++++++++---
> =C2=A03 files changed, 39 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-=
parse.txt
> index f5e6637..f26fc7b 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -49,20 +49,22 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'git rev-list' command.
>
> =C2=A0--flags::
> - =C2=A0 =C2=A0 =C2=A0 Do not output non-flag parameters which are no=
t also revisions.
> - =C2=A0 =C2=A0 =C2=A0 +
> - =C2=A0 =C2=A0 =C2=A0 If specified, this option causes 'git rev-pars=
e' to stop
> - =C2=A0 =C2=A0 =C2=A0 interpreting remaining arguments as options fo=
r its own
> - =C2=A0 =C2=A0 =C2=A0 consumption. As such, this option should be sp=
ecified
> - =C2=A0 =C2=A0 =C2=A0 after all other options that 'git rev-parse' i=
s expected
> - =C2=A0 =C2=A0 =C2=A0 to interpret.
> + =C2=A0 =C2=A0 =C2=A0 Do not output non-flag parameters.
> ++
> +If specified, this option causes 'git rev-parse' to stop
> +interpreting remaining arguments as options for its own
> +consumption. As such, this option should be specified
> +after all other options that 'git rev-parse' is expected
> +to interpret.
> ++
> +If `--flags` is specified, `--no-revs` is implied.
>
> =C2=A0--no-flags::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Do not output flag parameters.
> - =C2=A0 =C2=A0 =C2=A0 +
> - =C2=A0 =C2=A0 =C2=A0 If both `--flags` and `--no-flags` are specifi=
ed, the first
> - =C2=A0 =C2=A0 =C2=A0 option specified wins and the other option is =
treated like
> - =C2=A0 =C2=A0 =C2=A0 a non-option argument.
> ++
> +If both `--flags` and `--no-flags` are specified, the first
> +option specified wins and the other option is treated like
> +a non-option argument.
>
> =C2=A0--default <arg>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If there is no parameter given by the user=
, use `<arg>`
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 2ad269a..0655424 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -521,7 +521,11 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!strcmp(arg, "--flags")) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filter &=3D ~DO_NONFLAGS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(filter & DO_FLAGS)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* prev=
ent --flags being interpreted if --no-flags has been seen */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filter &=3D ~(DO_NONFLAGS|DO_REVS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!strcmp(arg, "--no-flags")) {
> diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
> index ef0b4ad..7df2081 100755
> --- a/t/t1510-rev-parse-flags.sh
> +++ b/t/t1510-rev-parse-flags.sh
> @@ -29,10 +29,10 @@ test_expect_success 'git rev-parse --no-revs --fl=
ags HEAD -> ""' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> -test_expect_success 'git rev-parse --symbolic --flags HEAD -> "HEAD"=
' \
> +test_expect_success 'git rev-parse --flags HEAD -> ""' \
> =C2=A0'
> - =C2=A0 =C2=A0 =C2=A0 echo HEAD > expected &&
> - =C2=A0 =C2=A0 =C2=A0 git rev-parse --symbolic --flags HEAD >actual =
&&
> + =C2=A0 =C2=A0 =C2=A0 : > expected &&
> + =C2=A0 =C2=A0 =C2=A0 git rev-parse --flags HEAD >actual &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> @@ -106,4 +106,22 @@ test_expect_success 'git rev-parse --symbolic --=
no-flags --flags HEAD -> "HEAD"'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> +test_expect_success 'git rev-parse --no-revs file -> "file"' \
> +'
> + =C2=A0 =C2=A0 =C2=A0 echo foo >file &&
> + =C2=A0 =C2=A0 =C2=A0 echo file >expected &&
> + =C2=A0 =C2=A0 =C2=A0 git rev-parse --no-revs file >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected actual
> +'
> +
> +test_expect_success 'git rev-parse --no-revs -- not-a-file -> "-- no=
t-a-file"' \
> +'
> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-EOF &&
> +--
> +not-a-file
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 git rev-parse --no-revs -- not-a-file >actual =
&&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected actual
> +'
> +
> =C2=A0test_done
> --
> 1.7.3.4.g73371.dirty
>
>
