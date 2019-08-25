Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E54E1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 12:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfHYMfg (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 08:35:36 -0400
Received: from mout.web.de ([212.227.15.14]:54025 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfHYMfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566736522;
        bh=wg+7aZaD5uFDTxd3PD6y5ihHiMgI0POshL8k1EP/Qbc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UfENyhvShaOXiyGe55Ns0DNu050qF0aD/TeoX9vvoQAxwmz3Te7vfuEMqUmttiwkl
         mEYI2EQ2kHlrnZG3bRkl0hYHX2Q2eXqSvzRDl2NfBHmsUc0G//0BAmjFCuJoQWhJIB
         ecpE4bORSDONTqvSp4s3oXZ4OxhPeihba90Sokw4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeNUV-1hrnHB20IJ-00QBE4; Sun, 25
 Aug 2019 14:35:22 +0200
Subject: Re: [PATCH] fast-import: Reinitialize command_buf rather than detach
 it.
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20190825041348.31835-1-mh@glandium.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <94de2333-fc0c-1eb1-6542-32c2971512fc@web.de>
Date:   Sun, 25 Aug 2019 14:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825041348.31835-1-mh@glandium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gFD/fHhlBDTzEtXEi9qU4umkRpA/IlOEONpaEoKbKNbQD5YvPi6
 uZekx8qMth+P2yr2NY0m/tGrSZxlnS7Znop22SEFNVi05p9IJxHRD41msJ6U4YW2jHns7SD
 cj0ZstsmQYEu/lvCRgj4BZnnu8kxvNvFM76y5xJs/mEGsAuSZ3EQxbue8XXOsmrFFeb4zqM
 z9F1Y98h/3Y1O463REjtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nkQWmY9lkhE=:TWi3A02Q7Ww7lSC5Uy18XR
 bSYMYztanmSkF8qrjdjypGeFgQMhzN0MA8rucliREqF6l9Gf2lgwVSYL7ztF21rNbk1v/e/Cb
 5sKmE+87QdhToD7f1JCJMSbgHZ3tWnDTSY0DR22n7S59m/OyB/t0/laMQc0b4h+vKIW6XGlMQ
 Xexb8BJ7kTwhzXAybizIP5R4FqPEsLp28PrWwZF8ufFXCcdPD506u295HjzMr7q8QLuG4dDsv
 xGnKyx+xKWrPYiKEs3H7ErGaVwNLo/8ethbnwFc5XESz88vEkjnVP+xMnhdLdWQNF7tCB8QZF
 kG3+Fks7+VYf3UrA2JMzHj/ciuJmREwJxvhJJ+zrqUtu71GbNRBkeGhbx5QkV+CNXvh3kW6Be
 vfKXEeS9Z4cNh7rfYxKVECnKjTeJoWxmbZGDUv19jI4lqxMwd7JkUP0ryxxkcnL2G9m7uDKb/
 wfpVaM+IwBBwouCpyB+npVj0tMGwnOEvfAvHthKSDs2KqF3dIZm0HsQjEiW2nKMc4hiRBs/50
 qf6kCHff/JjuV9Bl0ILKWN+PTJkbf2/41egL/Ji5VbKR3MBYUbkdNUPNw3m3OT8ubqzO2ANm4
 qUBE8JGjTyGtJWz5WqB+NNZEtoxWOY1hf2tC2FqwFh7m4InJ3lbq7xw3vZu7EA5OSfMvm9epb
 Y9O4jkjfxNpQ3Up2gNKLyW9gosF78P+KtzlHO8X++W517+A4Op3dqCCurCUIMnGdJC50tVoMw
 MXoC+XTd1rXRm3eGqZJMEMUzc0w7r80p6OOgRAmv0fjHIC2JK18EZrfSrEOvTUrko0KsmOpr7
 0NJXcJEYmmVM3b7xMR0c3//Fp6j71R9Yy5fmVhPT2eexnyWVyykr/oIzdn8E6Qnrs/AQLT8Eq
 K0SfW9MRwjkb33Vg2Dvt+QyDHAUDXmXUYKe8fGMrtPYs0XiknsMJW+ghAeiaMn6oJBtodhS3N
 adGBCwnypdG5HH9dU5zz03zTkhikFEPpFkdI5BzKhbYfNRNzHtipPFSrtMJ6Hab6q6z3sJpIs
 A2gposofaaQ7t+5YvqXuH2X+Qv+lZBhP0xz9sP9dkq91EyxXB8p++FCzd0tGgf5UC70THV+rn
 pHoHMLz3ICeISI/iD6OYe+8cMbMqCO8nd8q1ck2CSFmsFBH7QKTsR+QLb/uH21ff9uyPboK9j
 O0ZxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.08.19 um 06:13 schrieb Mike Hommey:
> command_buf.buf is also stored in cmd_hist, so instead of
> strbuf_release, the current code uses strbuf_detach in order to
> "leak" the buffer as far as the strbuf is concerned.

Hmm.

> However, strbuf_detach does more than "leak" the strbuf buffer: it
> possibly reallocates it to ensure a terminating nul character. And when
> that happens, what is already stored in cmd_hist may now be a free()d
> buffer.
>
> In practice, though, command_buf.buf is most of the time a nul
> terminated string, meaning command_buf.len < command_buf.alloc, and
> strbuf_detach is a no-op. BUT, when it's not (e.g. on the first call),
> command_buf.buf is &strbuf_slopbuf. In that case, strbuf_detach does
> allocate a 1 byte buffer to store a nul character in it, which is then
> leaked.

And that's why a pointer to a strbuf buf is valid until the next strbuf_
function call.

>
> Since the code using strbuf_detach is assuming it does nothing to
> command_buf.buf, it's overall safer to use strbuf_init, which has
> the same practical effect in the usual case, and works appropriately
> when command_buf is empty.
> ---
>  fast-import.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index b44d6a467e..b1d07efe8c 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1763,7 +1763,9 @@ static int read_next_command(void)
>  		} else {
>  			struct recent_command *rc;
>
> -			strbuf_detach(&command_buf, NULL);
> +			// command_buf is enther empty or also stored in cmd_hist,
> +			// reinitialize it.
> +			strbuf_init(&command_buf, 0);

This is a no-op; strbuf_detach already re-initializes the strbuf.

(And double-slash comments are avoided in Git code..)

((s/enther/either/))

>  			stdin_eof =3D strbuf_getline_lf(&command_buf, stdin);
>  			if (stdin_eof)
>  				return EOF;
> @@ -1833,7 +1835,9 @@ static int parse_data(struct strbuf *sb, uintmax_t=
 limit, uintmax_t *len_res)
>  		char *term =3D xstrdup(data);
>  		size_t term_len =3D command_buf.len - (data - command_buf.buf);
>
> -		strbuf_detach(&command_buf, NULL);
> +		// command_buf is enther empty or also stored in cmd_hist,
> +		// reinitialize it.
> +		strbuf_init(&command_buf, 0);

Same here.

>  		for (;;) {
>  			if (strbuf_getline_lf(&command_buf, stdin) =3D=3D EOF)
>  				die("EOF in data (terminator '%s' not found)", term);
>

strbuf_detach() is handing over ownership of the buffer.  Its return
value should be stored; grabbing the pointer beforehand is naughty
because it can get stale, as you noted.  I doubt there is a good reason
for ignoring the return value of strbuf_detach(), ever.

Ren=C3=A9
