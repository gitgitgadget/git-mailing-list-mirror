From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 81/83] apply: roll back index in case of error
Date: Mon, 25 Apr 2016 18:06:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604251802480.2896@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <1461505189-16234-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:06:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auj27-0004Bb-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbcDYQGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 12:06:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:59474 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbcDYQGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:06:41 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ld4xA-1bctWn2Zo8-00iBW4; Mon, 25 Apr 2016 18:06:05
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1461505189-16234-2-git-send-email-chriscool@tuxfamily.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:00jiPeFSYaC7ZbgZqprcZfQ0fB9sCSjLuDb0A6EX8HoznOis5Vh
 HStj2bnrXTZI3Xgucw8f+TzFSamOSX87WIcTCRFYDtFc/yeSePD/vummBJIajmc5rc/qwTe
 F8CC7RjrMePUm08ku/e/MW+k5ZZbOSEYqYRTDHsNB0HnXJ7IjlbiZ5LoPLR6JnJ/mRTjA/0
 2QOIIEb36Bhg8sosF6mbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9n18S1yIYQg=:fl5EF/abkKEgb3k79k2bUg
 ltk5KX3AdZoReYJ6w6MCi78sd1FgmYCa4v8I4iq7oyEhDjU8pydpnp9kPv5HMpnoPrbafSK3i
 amsdVda4JwqNQvN1c2mDSg3WBOXmwSX+v03/Ga8AB/HsbFbmQrKTki61kmdc3CvaZu2s6irch
 37JilBQya/ENmkB8x8UA6ic7FjLqhfBXTmTVP2vjLriDA4ADaCof6R6S81RmJuefyYa37PLQU
 coyQpMnZxE1uZv8Do5MUW5aNmiEx6+AUYT5R66QBWjsMQrtore8ulS3chsmyjq+9CU7Kob3LM
 Ej95eF6I+67Bwerc77wpQMUz4uyhsu8zTjSxj5WgcmpP2qIcbUT5vtZcViS9ICfyb67LUhOE6
 dh6eqR+JD59uLbhUrINf1L0FpJupvT8EQkD8jVDdiVVXJFYnI1hFWIyNDho02dtaohRPVkLkr
 /6vmRbXRpELQhATzRwbO0FTZ0221hDXTjSEmphEgurv5up2w62yija0PpmgKJfWahMOUJJ1hH
 DyoArEvI91LUCi8mwq2tIHKY6UN93fSnUeKAvvFUGGIFVDQCHC5bIlYwMg5vDwx8wJLzxmjSQ
 b/ccRSvLsj8wfz8oZte9KkxUbxaj24w83m1tv0T8rTzAxkM7IwI+fVtDjWaHaE99jPtwN8MHG
 22wBzawRmJFy57d2EyJuOrIn2V/C4RU6jFyo922GC0w7/QRwdX0GTH3mr9TzmVp2/UiaiIO97
 t/n3M11r7xKrlP6AtV9kIbkgrZw7ZZcOWJv1HchKfFB2uc1i2Bzu9Ay2FieYbpsKURgfnn1K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292508>

Hi Chris,

On Sun, 24 Apr 2016, Christian Couder wrote:

> @@ -4734,16 +4737,22 @@ int apply_all_patches(struct apply_state *state,
>  		read_stdin = 0;
>  		set_default_whitespace_mode(state);
>  		res = apply_patch(state, fd, arg, options);
> -		if (res < 0)
> +		if (res < 0) {
> +			if (state->lock_file)
> +				rollback_lock_file(state->lock_file);
>  			return -1;
> +		}
>  		errs |= res;
>  		close(fd);

In case of error, this leaves fd open, which in the end will prevent the
"patch" file, and hence the "rebase-apply/" directory from being removed
on Windows. This triggered a failure of t4014 here (and possibly more, but
it took me quite a while to track this down, what with builtin/am.c's
am_destroy() not bothering at all to check the return value of
remove_dir_recursively(), resulting in the error to be caught only much,
much later).

Could you please review all open()/close() and fopen()/fclose() calls in
your patch series, to make sure that there are no mistakes? A passing test
suite does not really make me confident here, as our code coverage is not
quite 100%.

Thanks,
Dscho
