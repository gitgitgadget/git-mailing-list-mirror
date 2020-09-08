Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C4C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E042074B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="B4tTBfGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbgIHQ2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:28:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:34125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731960AbgIHQ1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599582438;
        bh=hVaNtkkosjkp6LIph1i8FUGRDZTtrvFTnXfeU3ctJLI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B4tTBfGaAmh4dkfirjoG9W3rRE0okq4WgR0DM1ZRBAI9LAmNLoYhEH2wB4JcBG8qk
         R/MMaL8VpZjJsVpVpAtkfRtleka2Zcb48/feEeOZ7izxyVbGYVpvNk/cZbAST/sRj2
         tsXm52iXRdlD+f/BoRPamBc0/3ZUwcbcr1FZ4FuE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.189]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1k0eEY0GkI-00WXXz; Tue, 08
 Sep 2020 14:09:52 +0200
Date:   Tue, 8 Sep 2020 14:09:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add -p: fix memory leak
In-Reply-To: <pull.729.git.1599491041170.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009081409300.54@tvgsbejvaqbjf.bet>
References: <pull.729.git.1599491041170.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kCd88FMiGjSD3HC6O1pxq+xIzxX8QUMu0G6C/1EcTvUyputugT8
 umb5NjDO++xkEZ2Rduh66d1YTJndxAjNiln3h3BuXJrVv0kOzjB7YzX1Lu6PZUw1pT46/JR
 zWpByfim4U23UIx2nAjPXdd1AfsHt3+rmCsuJcFCnEt24t1KR24hY3O9Bxn5CaljeeRdEn0
 I0lRa8UgF+STiOGZLc7Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAa3ZcQiMcA=:kJiN3BCeULa1QyX7qvRryU
 9HWjjgxwrChOAFIql5U8+x+i65bn3iMLj+9Us5RApZ9IkNsp02h11DxG/0vhKMydVIH9SXfMe
 EQwemh/YVO8jw3xGfcpo54IEwxnozO9JKuCirP2Gx9IoxkbdJKyEsFjTd9roa6WkWa3mtkyjR
 N9gpb9CoKFFoU2VaoY0QlJ2ysKVAIDnPMUi1icAe1kl/QnXgrtVhWvtg8Hrdhksdn8umdPg4L
 ev5xDbndcwhh67vAl9sFJAc2lts6Wr8UsRX3HX4lVWnS7YrmsYXHA/6saX1YOp9MLme0ZuR4U
 /WeL7eoytoDCC3kH+yq3zHRFQMZ78s4kUK/xhSwHTbfkNbcCpnpXne5DvqEWOaXjqxRoIWyY0
 p66J6ulNXRT6lDlvUsqPLg1UDiyYPSe7aHp2UZFDW8pLZcOPpKWKG9xW/CeeP06kBNT3xU43g
 sa7hzM81AaQ+oTT/9fETSKUpZ1/Y+6cmcZkLYOSCLH8R4kbPanRYSne4ZWKhp6sVrsxjrEii6
 IT1mMELGcEgM1Y1W6kOLzpQGTizuxgipxAsXKq4fYoQv/XJS/s3Q5mmEDyYgoL5y0w9Ox2b0E
 lQPsyxfoNHt6osdyEtU/bKvrco1Ic9ITxEbdT28mKiNkz6aLSek3ghL5qgYVPjOOHUjZai/qG
 K5mDXSM6ZNDly1gmezp0kgaXqL4hxzGvVUlsnXH1mQf3yu6oZKCLNJi26iB4cpkYHFiiLGWti
 E81CYT3odgPKWgYNa5oZjIzax7zg94IEnudKw9vbDBMp5XA4BqeZUYD2BiG/TmoKHGERsHuvr
 TO49mbz0GmSyq1tQT+9k5mr00Z0Y3nivzBs3iVZjwcbZfONLQ5krno7rnCQEIjeAqL3USNnYw
 nM8RgJPdaf7I5McvbiQuOiu94la8U2fvanfglAHuPeydeOnS1HXECMaMtlzmgBOoYYi66EOb9
 NAdBrQAwnc7fqRDKmltMHXtWCJ2rFb1in1YVAnqGHOTHdcjU3Xk9N8kIpTA0JwG9Xw+7xsDGD
 qvTJtFTIzE5c8BVyYg0rIcRaTRVwP4CmK6y3MkHV++Cchkr6HscZntyYl6PpNU1Wipm1Bdv/T
 BnJCApANfDO7gC0j+EQVstjeiP16lEipLSijXjN9UjZlCaEW1NAGIuBRKQ2/G2HC/4yYePltw
 /bU5UcnOQlhzLOaJz6CikEPsoD8CRH+JKoBo62Psy3OlA/RuUWpkOn7dhOtkRUcIhLSgqhC34
 6US8yuu9gyoe35c61kX+41OeOKpR6bt/lazaVqQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 7 Sep 2020, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> asan reports that the C version of `add -p` is not freeing all the
> memory it allocates. Fix this by introducing a function to clear
> `struct add_p_state` and use it instead of freeing individual members.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

ACK! And thanks for fixing bugs I introduced,
Dscho

> ---
>     add -p: fix memory leak
>
>     It seems to be the season for add -p fixes. This patch fixes a memor=
y
>     leak in the C version found with asan.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-729%2F=
phillipwood%2Fwip%2Fadd-p-fix-memory-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-729/phill=
ipwood/wip/add-p-fix-memory-leak-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/729
>
>  add-patch.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 457b8c550e..2fcab983a6 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -266,6 +266,20 @@ struct add_p_state {
>  	const char *revision;
>  };
>
> +static void add_p_state_clear(struct add_p_state *s)
> +{
> +	size_t i;
> +
> +	strbuf_release(&s->answer);
> +	strbuf_release(&s->buf);
> +	strbuf_release(&s->plain);
> +	strbuf_release(&s->colored);
> +	for (i =3D 0; i < s->file_diff_nr; i++)
> +		free(s->file_diff[i].hunk);
> +	free(s->file_diff);
> +	clear_add_i_state(&s->s);
> +}
> +
>  static void err(struct add_p_state *s, const char *fmt, ...)
>  {
>  	va_list args;
> @@ -1690,9 +1704,7 @@ int run_add_p(struct repository *r, enum add_p_mod=
e mode,
>  	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
>  					  NULL, NULL, NULL) < 0) ||
>  	    parse_diff(&s, ps) < 0) {
> -		strbuf_release(&s.plain);
> -		strbuf_release(&s.colored);
> -		clear_add_i_state(&s.s);
> +		add_p_state_clear(&s);
>  		return -1;
>  	}
>
> @@ -1707,10 +1719,6 @@ int run_add_p(struct repository *r, enum add_p_mo=
de mode,
>  	else if (binary_count =3D=3D s.file_diff_nr)
>  		fprintf(stderr, _("Only binary files changed.\n"));
>
> -	strbuf_release(&s.answer);
> -	strbuf_release(&s.buf);
> -	strbuf_release(&s.plain);
> -	strbuf_release(&s.colored);
> -	clear_add_i_state(&s.s);
> +	add_p_state_clear(&s);
>  	return 0;
>  }
>
> base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
> --
> gitgitgadget
>
