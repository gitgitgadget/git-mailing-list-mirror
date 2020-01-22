Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4191BC2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085EA24655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cceWeGZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgAVOBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:01:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:50301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgAVOBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 09:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579701661;
        bh=D4ig2qOETvjuGMGZWN6jV+/C+n6d26IbBW3lzsnb2z4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cceWeGZMzbQMYLuy6iibOiWkJzBshMimeZyqWsaS5/yEUR6dHU6atOkuzzQqkVn3B
         hKXHrp7n29uFtasrneVydM8UGsJvscvkdD7bodl3TJeHUH8zEcxDLO+vxpdfbs3HlU
         3dtb8RhKLz5ysAKgCtLzf5PRMMcqaloLEORfeDsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1izCVb0usU-0054UW; Wed, 22
 Jan 2020 15:01:01 +0100
Date:   Wed, 22 Jan 2020 15:00:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] builtin/rebase: remove a call to get_oid() on
 `options.switch_to'
In-Reply-To: <20200121193226.24297-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001221500210.46@tvgsbejvaqbjf.bet>
References: <20200121193226.24297-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yNB/XMAKuI2AktLdOf/NquVnYLXTY6AUUSKNv0EkOOQw1DqwAqJ
 tZ/mw4EaQ4GshyP+kx0CGTj/ib3zxPfRN1ULZ2fk26hDCo2A9RY+rauHA1L2auDmnbsXJwC
 Ez45LL7UrO+z1vlcnp2tF/WQu9DadO70qXOU3HSx+4B1/v+miVttjvVjIPCYdkb3t2jJbms
 DNzG7+k75ydnP5OMLylyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJjRDixJ57E=:roYr9YIWn2dAYTHAfRBfq6
 Qh6BKxXO1FGVbPZT3xGuuYJrDn677zANtT/rK6s5yVLO1VbZk3/91xYngRBS42U5T24Yq2Gg0
 BCw+I79wNuLfrEBZ1db/HUq4G46WtK7rUPqqPn4S/1XABK5zYuFJRmMrHVpX76/haCATJBM6n
 Os7VOYIeOkRdS4fj15A5gnt2LOdUkEkg5beuL1cTcRn3bqGVWmAeyGshUlr1MfGQpyhwUc1e9
 biK7kh2w9lAyQPprJLK5UcbOA/tJ5pxbwBp5U0fy6H3WQQtaGBbFkp10gLzxOgJUOrAHGk2ws
 /LHn6VCvi1rASP9qVUSRp9hHzyIoIxsSsiyzBsopLS9jEkq63MULfv1o4SiOnOtBMewYgVUNk
 BEhUauUfdr8gS/jcwvmkq4VZcTsa7q2gEYJSMCvoHPkcJiTVgajIi1uDo00nyBNBzb5XJkNai
 kHdi7Rq8NXa2KdteTSqtALbsB1cYQSOsMv7Jn3xyp6ImtLO0Mkf4ZO9K+HaowAhfNRLfh7RT0
 YFg5Z/zdl7rlu4RfQ2lYFBqnTAbWkbco5PSw/myxzj/9xWq+RWvdlZxxHcKOW9tbSNmr5u57R
 Bcu2KGyNRVQdyflTKMvfVYvkB1PA3PWdrYaJrx7wZo5vb8CNByIMrKNw+THeZ9uCd1NVGSGo2
 Z3Lid4eX6fGIeqOMNIOtB2zrtNYRZdbezkJ2+75UT9DZ+Ql6yn2vKUCufvnLwlrh16k2/zxDc
 TkREBme9zh1hnLIxIlVGhaR/XTHrU/h/8lBlmzIqU0JLT+1UJuGYU628mcHYrfk21xgUQhYXo
 Sosvgianx8TwPMlu63JghjQyt9HXr9RX4pw4714HvxzL01PwniOyirAPVib1yTu4LtcXIoBHy
 4E9YCnc4ArJINs7rLNN5XvOdUTd9NybhqzMo3j9coNaIVcNnj707jWPVUemksTGGvPamHbUFD
 3QhygwgzrbLpS7RFPKpAiJu2zQcUzzbkgytN7VshkAu3mlP6lUd0zE0NPWGvQTqaCCi2rqC3N
 yovT0M4NT+SJEgFT8hVC4Dk5Mdrp/ubrQraATjXPXDfP4fnQDwJJvOBsXQlwIGvX1n22i2NSh
 8PvVjo0FrSE92oyzViZv0aBAGXV1y+Baw+55oU1u0evdfkOtyFe0kQ59PMjmEq/HBFz3XolLw
 MJk8G/0gxpOELwJ8XKviJWal23OkR8W0rIkn+H2x9FX6QPDvyB07QiGarvrPWWs3bPJbyAVw8
 CXwV3r0KMFGDIlTNs
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 21 Jan 2020, Alban Gruin wrote:

> When `options.switch_to' is set, `options.orig_head' is populated right
> after.  Therefore, there is no need to parse `switch_to' again.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>

ACK!
Dscho

> ---
>  builtin/rebase.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6154ad8fa5..16d2ec7ebc 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -2056,19 +2056,11 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  		if (!(options.flags & REBASE_FORCE)) {
>  			/* Lazily switch to the target branch if needed... */
>  			if (options.switch_to) {
> -				struct object_id oid;
> -
> -				if (get_oid(options.switch_to, &oid) < 0) {
> -					ret =3D !!error(_("could not parse '%s'"),
> -						      options.switch_to);
> -					goto cleanup;
> -				}
> -
>  				strbuf_reset(&buf);
>  				strbuf_addf(&buf, "%s: checkout %s",
>  					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  					    options.switch_to);
> -				if (reset_head(&oid, "checkout",
> +				if (reset_head(&options.orig_head, "checkout",
>  					       options.head_name,
>  					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>  					       NULL, buf.buf) < 0) {
> --
> 2.24.1
>
>
