Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42166C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D2F20706
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zo3ycZib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLFOia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:38:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:49031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfLFOi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 09:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575643099;
        bh=/nVRQBZ/viVBV9HNmLDoddHuqAGct4EjzsJPJ6HsyXY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zo3ycZib39pXWHoFhl5A/9DBKhNbThdtH8eE/KxpemwKZQXI4dfUKgmDypJ4cNDLx
         OU6EskhTIGk8iBQzeHKs/UMPz+Z608rVKO0Us6ZMhGsEXVwbno9Eh421Po4AflKbpY
         Jy3Mt2QDcyQCCqQe4GmHu/xyTeL5cblUQknHV3yg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1iGsFE2sRX-00ViWr; Fri, 06
 Dec 2019 15:38:19 +0100
Date:   Fri, 6 Dec 2019 15:38:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] sequencer: move check_todo_list_from_file() to
 rebase-interactive.c
In-Reply-To: <20191202234759.26201-2-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912061533590.31080@tvgsbejvaqbjf.bet>
References: <20191104095449.9964-1-alban.gruin@gmail.com> <20191202234759.26201-1-alban.gruin@gmail.com> <20191202234759.26201-2-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/amLxmmInrf8fxloBZhFCRjEJKsTcAWxb6le1g/Jc8AqntwyC1W
 6uwqRiJI/z+p1u/o4YqaSjcdo3+VnDZjWQVY4HeZAsyBeMUe6gbajE1XmgngxbrNV/+A3kf
 UEHssVgeAd8AwZw4Ua4/tBhCT+fwa295yi3x9lgdjomBEdAkJx6EttyWUsl4O/VvYJSJmyF
 mV2RFetPaVAgWU4eRv9sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUqOmoT7D7c=:881o0jrSLfwEHwNTa3yW6g
 uzyerblcz4pRq8b0mRSgbTTrFd//g7QmlPFrNW9tdJ+oHrWYEoU8dYwZmcs/q3Gd26Q0+jJDt
 pICpqis5WSbL14SoZ3c/skGFZXZ0IUtwJRLpLQJ/rIcHYAlkGCQxQlSyIHpg7bRyxsBY08ur6
 pCkoDcw9ck9djv4zFslshEzX7/K85debGLcuJDauf1JmPXO/0+WQO1lqAXRV7RzBf3mr/jzJq
 KP1r7fYjkVc4vgIFTNUv4fIfzBgNffSfjbsW+Q8u8OOQSBW22AjUUg+1qkFDt1JT4o/xwZnse
 4XPD2bUGVg5mtkr6pBS4na1aq4GnuWKpCQcTs1gkyvXXS3ESdJNVaqfprKLppNHJvDnJaYxOV
 OfLPwcD1qKz2jN/7on0Ms/7hC8iuxQTHNj3EfaghOB00TT3/WFLHSRhgEi3PKeu7BO7Unac5P
 Gnd/dMv24m/Mxmen4Qx9vyd/+0E6XkJLJgcePM/OXsEdOhM56WoH1nQzIhYckL/6TJJFMDqaW
 KcdPc0vYo3zNPR+vbc4vN2bmzODM9u/weWTht+/Y2IdkEYr0m0gl1IQvSzatMHQweYQ/j8CD9
 /dS+67LGzLSUBppdflSR77SrLQpZW25CC2ZFQBr44eL5Kgb9Vm6Zr1zWXdtvBVFbHvayaHeoH
 jxkbWLg0gduJGSTgAd+SfWwCI92H6faDXD8fILg0B1vRgWvscKprrb7m8iCK4VxO71BIZ14gf
 NKEtslKy7M8NKl2ej3i4UjfPjrHwKJPqAM6jxDNpgp043qEaNACzPyyFkhJeIu3fDXArcRs0/
 GsdKMJITH77n984Ff1YNgcrGihUSokcluX7xPN/MPfsl86UztI/Bz7xkA/28Ou8WqzyThXujc
 ksL/+0Qs7ClWaA5LMCp7SUpWYOkDmeU77UTUWjwPNIHOdQ8vr/o9B1mkM4WIOY+fTXTtjMDKg
 SNWCIzc4ZiuY1fslqiUm47eVVG89v6cJhzkaW6JZDukndTFI51Ek0yzibVzsI/z8BHhoHfEDV
 el0SNa72hD+u8zvALHFsRoRFav3Fc3fF28cc2oHYVhV5USrfNn5hzj6EAE1plRcOqrG2csGm6
 gwaH/0t7gVCpUBGe6LeLrS1ZqaGbn03Ao/Wb/dAMNN06d+jccuQjraLpLMJ24ErGVWtWV8Fwu
 NCdOGRVLeqNdTOeOHw/aFridvkgQsChW16kxduJTT0LEPLN8tPPV1ygd3n8Pd+D7zV56WwN8t
 osyaRMc10ZdykMG5SKTVVQZHoC5iT9jpk0Gjgolc7ix7T2Wq5lWJp0fYcZ08=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 3 Dec 2019, Alban Gruin wrote:

> The message contained in `edit_todo_list_advice' (sequencer.c) is
> printed after the initial edit of the todo list if it can't be parsed or
> if commits were dropped.  This is done either in complete_action() for
> `rebase -i', or in check_todo_list_from_file() for `rebase -p'.
>
> Since we want to add this check when editing the list, we also want to
> use this message from edit_todo_list() (rebase-interactive.c).  To this
> end, check_todo_list_from_file() is moved to rebase-interactive.c, and
> `edit_todo_list_advice' is copied there.  In the next commit,
> complete_action() will stop using it, and `edit_todo_list_advice' will
> be removed from sequencer.c.

Makes sense to me.

> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index aa18ae82b7..ad5dd49c31 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -187,3 +193,32 @@ int todo_list_check(struct todo_list *old_todo, str=
uct todo_list *new_todo)
>  	clear_commit_seen(&commit_seen);
>  	return res;
>  }
> +
> +int check_todo_list_from_file(struct repository *r)
> +{
> +	struct todo_list old_todo =3D TODO_LIST_INIT, new_todo =3D TODO_LIST_I=
NIT;
> +	int res =3D 0;
> +
> +	if (strbuf_read_file(&new_todo.buf, rebase_path_todo(), 0) < 0) {
> +		res =3D error(_("could not read '%s'."), rebase_path_todo());
> +		goto out;
> +	}
> +
> +	if (strbuf_read_file(&old_todo.buf, rebase_path_todo_backup(), 0) < 0)=
 {
> +		res =3D error(_("could not read '%s'."), rebase_path_todo_backup());
> +		goto out;
> +	}
> +
> +	res =3D todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
> +	if (!res)
> +		res =3D todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
> +	if (!res)
> +		res =3D todo_list_check(&old_todo, &new_todo);
> +	if (res)
> +		fprintf(stderr, _(edit_todo_list_advice));
> +out:
> +	todo_list_release(&old_todo);
> +	todo_list_release(&new_todo);
> +
> +	return res;
> +}

No need to address the following concern in this patch series, but I do
think that a #leftoverbits project could be to simplify this to

	if (strbuf_read_file(&new_todo.buf, rebase_path_todo(), 0) < 0)
		res =3D error(_("could not read '%s'."), rebase_path_todo());
	else if (strbuf_read_file(&old_todo.buf, rebase_path_todo_backup(), 0) < =
0)
		res =3D error(_("could not read '%s'."), rebase_path_todo_backup());
	else if ((res =3D todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_t=
odo)) ||
		 (res =3D todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo)) |=
|
		 (res =3D todo_list_check(&old_todo, &new_todo)))
		fprintf(stderr, _(edit_todo_list_advice));

Ciao,
Dscho
