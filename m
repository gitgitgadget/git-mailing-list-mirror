From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] environment.c: fix incorrect git_graft_file initialization
Date: Wed, 23 Jul 2014 14:22:44 -0700
Message-ID: <xmqqvbqndb2z.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA409-0005JF-Fg
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933941AbaGWVWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 17:22:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65234 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933568AbaGWVWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 17:22:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2ADB62AD3E;
	Wed, 23 Jul 2014 17:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IC/lWUjESC5c
	4BpvFomUtwXez9Y=; b=tbAl4mpQPN8iiptjsYliwjSDyYoKOUmZNFGwrypFSqoP
	G4VrE5SS09kLPybDjxts8dQzO1NcPYLox0Wa3GU7UYFFMxy3P6NI2dTJFBs/1zQl
	x80PYYs5Ayx8BDAkwjqnF0k8GsZIUTIa7Ysx49+zdvXuWp2MMuXfQfOWBb6v0i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PIN/iD
	c8dHlj0HTzeYb8s0OWrvgTWTbho9d8za5+Mlfre+oZGb38ggptVYcAvfo3RyjM+B
	ycgdF5h0jCUScUYSNoVbxLHweIaOmhRE1JzD9NlnEitS10wPUzb4MiPCZWvGQTpq
	syHvgNCP6S8ixw125l1wZXv1fr/Q6QK42ESGk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B1802AD39;
	Wed, 23 Jul 2014 17:22:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E36A2AD1F;
	Wed, 23 Jul 2014 17:22:46 -0400 (EDT)
In-Reply-To: <1406115795-24082-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23
 Jul 2014 18:43:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D74E27E-12AF-11E4-AD74-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254124>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "info/grafts" should be part of the "common repository" when accessed
> from a linked checkout (iow $GIT_COMMON_DIR/info/grafts, not
> $GIT_DIR/info/grafts).
>
> git_path("info/grafts") returns correctly, even without this fix,
> because it detects that $GIT_GRAFT_FILE is not set, so it goes with t=
he
> common rule: anything except sparse-checkout in 'info' belongs to com=
mon
> repo. But get_graft_file() would return a wrong value and that one is
> used for setting grafts up.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks Eric for sharp eyes and Duy for a quick fix.

Will queue all five.

>  environment.c          |  2 +-
>  t/t0060-path-utils.sh  |  1 +
>  t/t2025-checkout-to.sh | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/environment.c b/environment.c
> index 50ed40a..d5b0788 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -157,7 +157,7 @@ static void setup_git_env(void)
>  					   "objects", &git_db_env);
>  	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, git_dir,
>  					   "index", &git_index_env);
> -	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, git_dir,
> +	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, git_common_=
dir,
>  					   "info/grafts", &git_graft_env);
>  	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
>  		check_replace_refs =3D 0;
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index da82aab..93605f4 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -269,6 +269,7 @@ test_git_path GIT_COMMON_DIR=3Dbar logs/HEAD     =
           .git/logs/HEAD
>  test_git_path GIT_COMMON_DIR=3Dbar objects                  bar/obje=
cts
>  test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/obje=
cts/bar
>  test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info=
/exclude
> +test_git_path GIT_COMMON_DIR=3Dbar info/grafts              bar/info=
/grafts
>  test_git_path GIT_COMMON_DIR=3Dbar info/sparse-checkout     .git/inf=
o/sparse-checkout
>  test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remo=
tes/bar
>  test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/bran=
ches/bar
> diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
> index 8a00310..508993f 100755
> --- a/t/t2025-checkout-to.sh
> +++ b/t/t2025-checkout-to.sh
> @@ -81,4 +81,22 @@ test_expect_success 'checkout from a bare repo wit=
hout --to' '
>  	)
>  '
> =20
> +test_expect_success 'checkout with grafts' '
> +	test_when_finished rm .git/info/grafts &&
> +	test_commit abc &&
> +	SHA1=3D`git rev-parse HEAD` &&
> +	test_commit def &&
> +	test_commit xyz &&
> +	echo "`git rev-parse HEAD` $SHA1" >.git/info/grafts &&
> +	cat >expected <<-\EOF &&
> +	xyz
> +	abc
> +	EOF
> +	git log --format=3D%s -2 >actual &&
> +	test_cmp expected actual &&
> +	git checkout --detach --to grafted master &&
> +	git --git-dir=3Dgrafted/.git log --format=3D%s -2 >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
