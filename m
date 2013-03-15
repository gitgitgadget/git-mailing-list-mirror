From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 22:14:27 +0100
Message-ID: <51438F33.3080607@web.de>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com> <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org> <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com> <7vmwu6yqbd.fsf@alter.siamese.dyndns.org> <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com> <514343BA.3030405@web.de> <7vvc8svc2r.fsf@alter.siamese.dyndns.org> <51435D49.6040005@web.de> <7v4ngcv35l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 22:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGbxu-0007Qr-45
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 22:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337Ab3COVOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 17:14:35 -0400
Received: from mout.web.de ([212.227.15.4]:61151 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446Ab3COVOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 17:14:34 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MfHfy-1U58Zz0iqI-00PByU; Fri, 15 Mar 2013 22:14:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7v4ngcv35l.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:fCbQO86vWZHQo1W9Q4osKIWyF4ZPGqQEf/eSDxwQlCc
 eAE0g/Us3uMI5czmG4i+G+NGNcZTilBT9iIG/uOyLfxWZ4V2KN
 mKNndJwfu72PEi7uOckgAucgyqwGvOro5dQ9bzw7diwHiQRAUc
 GzVWgKQYtDLuKbYqCTWnZ9eTo2jhAv14bzUN66w9sg8zknzQ83
 n+7uzSq+Hr09jlgvG+sHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218261>

On 15.03.13 21:06, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> > Thanks, I like that much better than mine
>> > (and expere is probably a word not yet invented)
> OK, then how about redoing Duy's patch like this on top?
>=20
> I've moved the timing collection from the caller to callee, and I
> think the result is more readable.  The message looked easier to see
> with a leading blank line, so I added one.
>=20
> -- >8 --
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Date: Wed, 13 Mar 2013 19:59:16 +0700
> Subject: [PATCH] status: advise to consider use of -u when read_direc=
tory takes too long
>=20
> Introduce advice.statusUoption to suggest considering use of -u to
> strike different trade-off when it took more than 2 seconds to
> enumerate untracked/ignored files.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt |  4 ++++
>  advice.c                 |  2 ++
>  advice.h                 |  1 +
>  t/t7060-wtstatus.sh      |  1 +
>  t/t7508-status.sh        |  1 +
>  t/t7512-status-help.sh   |  1 +
>  wt-status.c              | 21 +++++++++++++++++++++
>  wt-status.h              |  1 +
>  8 files changed, 32 insertions(+)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d1de857..a16eda5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -163,6 +163,10 @@ advice.*::
>  		state in the output of linkgit:git-status[1] and in
>  		the template shown when writing commit messages in
>  		linkgit:git-commit[1].
> +	statusUoption::
> +		Advise to consider using the `-u` option to linkgit:git-status[1]
> +		when the command takes more than 2 seconds to enumerate untracked
> +		files.
>  	commitBeforeMerge::
>  		Advice shown when linkgit:git-merge[1] refuses to
>  		merge to avoid overwriting local changes.
> diff --git a/advice.c b/advice.c
> index edfbd4a..015011f 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -5,6 +5,7 @@ int advice_push_non_ff_current =3D 1;
>  int advice_push_non_ff_default =3D 1;
>  int advice_push_non_ff_matching =3D 1;
>  int advice_status_hints =3D 1;
> +int advice_status_u_option =3D 1;
>  int advice_commit_before_merge =3D 1;
>  int advice_resolve_conflict =3D 1;
>  int advice_implicit_identity =3D 1;
> @@ -19,6 +20,7 @@ static struct {
>  	{ "pushnonffdefault", &advice_push_non_ff_default },
>  	{ "pushnonffmatching", &advice_push_non_ff_matching },
>  	{ "statushints", &advice_status_hints },
> +	{ "statusuoption", &advice_status_u_option },
>  	{ "commitbeforemerge", &advice_commit_before_merge },
>  	{ "resolveconflict", &advice_resolve_conflict },
>  	{ "implicitidentity", &advice_implicit_identity },
> diff --git a/advice.h b/advice.h
> index f3cdbbf..e3e665d 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -8,6 +8,7 @@ extern int advice_push_non_ff_current;
>  extern int advice_push_non_ff_default;
>  extern int advice_push_non_ff_matching;
>  extern int advice_status_hints;
> +extern int advice_status_u_option;
>  extern int advice_commit_before_merge;
>  extern int advice_resolve_conflict;
>  extern int advice_implicit_identity;
> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index f4f38a5..52ef06b 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -5,6 +5,7 @@ test_description=3D'basic work tree status reporting'
>  . ./test-lib.sh
> =20
>  test_expect_success setup '
> +	git config --global advice.statusuoption false &&
>  	test_commit A &&
>  	test_commit B oneside added &&
>  	git checkout A^0 &&
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index e313ef1..15e063a 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -8,6 +8,7 @@ test_description=3D'git status'
>  . ./test-lib.sh
> =20
>  test_expect_success 'status -h in broken repository' '
> +	git config --global advice.statusuoption false &&
>  	mkdir broken &&
>  	test_when_finished "rm -fr broken" &&
>  	(
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index b3f6eb9..2d53e03 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -14,6 +14,7 @@ test_description=3D'git status advices'
>  set_fake_editor
> =20
>  test_expect_success 'prepare for conflicts' '
> +	git config --global advice.statusuoption false &&
>  	test_commit init main.txt init &&
>  	git branch conflicts &&
>  	test_commit on_master main.txt on_master &&
> diff --git a/wt-status.c b/wt-status.c
> index 2a9658b..6e75468 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -496,9 +496,14 @@ static void wt_status_collect_untracked(struct w=
t_status *s)
>  {
>  	int i;
>  	struct dir_struct dir;
> +	struct timeval t_begin;
> =20
>  	if (!s->show_untracked_files)
>  		return;
> +
> +	if (advice_status_u_option)
> +		gettimeofday(&t_begin, NULL);
> +
>  	memset(&dir, 0, sizeof(dir));
>  	if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
>  		dir.flags |=3D
> @@ -528,6 +533,14 @@ static void wt_status_collect_untracked(struct w=
t_status *s)
>  	}
> =20
>  	free(dir.entries);
> +
> +	if (advice_status_u_option) {
> +		struct timeval t_end;
> +		gettimeofday(&t_end, NULL);
> +		s->untracked_in_ms =3D
> +			(uint64_t)t_end.tv_sec * 1000 + t_end.tv_usec / 1000 -
> +			((uint64_t)t_begin.tv_sec * 1000 + t_begin.tv_usec / 1000);
> +	}
>  }
> =20
>  void wt_status_collect(struct wt_status *s)
> @@ -1011,6 +1024,14 @@ void wt_status_print(struct wt_status *s)
>  		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add=
");
>  		if (s->show_ignored_files)
>  			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f=
");
> +		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
> +			status_printf_ln(s, GIT_COLOR_NORMAL, "");
> +			status_printf_ln(s, GIT_COLOR_NORMAL,
> +				 _("It took %.2f seconds to enumerate untracked files."),
> +				 s->untracked_in_ms / 1000.0);
> +			status_printf_ln(s, GIT_COLOR_NORMAL,
> +				 _("Consider the -u option for a possible speed-up?"));
> +		}
>  	} else if (s->commitable)
>  		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not liste=
d%s"),
>  			advice_status_hints
> diff --git a/wt-status.h b/wt-status.h
> index 236b41f..09420d0 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -69,6 +69,7 @@ struct wt_status {
>  	struct string_list change;
>  	struct string_list untracked;
>  	struct string_list ignored;
> +	uint32_t untracked_in_ms;
>  };
> =20
>  struct wt_status_state {
> -- 1.8.2-279-g744670c -- To unsubscribe from this list: send the line=
 "unsubscribe git" in the body of a message to majordomo@vger.kernel.or=
g More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
Thanks, that looks good to me:

# It took 2.58 seconds to enumerate untracked files.
# Consider the -u option for a possible speed-up?

But:
If I follow the advice as is given and use "git status -u", the result =
is the same.


If I think loud, would it be better to say:

# It took 2.58 seconds to search for untracked files.
# Consider the -uno option for a possible speed-up?

or

# It took 2.58 seconds to search for untracked files.
# Consider the -u option for a possible speed-up?
# Please see git help status

/Torsten
