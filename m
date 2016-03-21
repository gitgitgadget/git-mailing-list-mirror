From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] git-compat-util: st_add4: work around gcc 4.2.x
 compiler crash
Date: Mon, 21 Mar 2016 05:56:56 +0100
Message-ID: <CAP8UFD0Kp55bpwdNrXY3KhpDiHVDReWKpuNJz7_Q537DXeUXHA@mail.gmail.com>
References: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
	<1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 05:57:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahrto-0005MW-6j
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 05:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbcCUE47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 00:56:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35967 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcCUE45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 00:56:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so19358112wml.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 21:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TIJO5IikAQNVzI53dNUuRzpmREwEtU2Fo+bSDCoJYOQ=;
        b=sJ6LnkLWgAqxypZRoelijJ3ynok2bUj3yjoO/7CiUgheJOX2FAoiCplp0h7W7nAOYH
         ZNhzNfC5uiHhHVoGVxpyxG+uyhXZ82kvylkLfIOPTIckN1luehPCShhOGXGiLTx1dFJC
         i2vKXbw2/PpSkEgzROqUBR+6GOu1ROeiyZL2Rt/rEdXyoQXFEVASiiJRvHC/mX12V3ic
         PYTN8NajQTRoY5Ul5OovpHbUeAPDdPAZRNimMwvH8vDjQZEBMWQDtoVrzu717Npn0QUN
         plAEumbL77Q+ZYdlJ41Q/Rtc7i1RNhZs0lXW/W26pSZtChnCikK+HezKdsZruYa2/qvp
         q1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TIJO5IikAQNVzI53dNUuRzpmREwEtU2Fo+bSDCoJYOQ=;
        b=Tf5ZifqgLZlMFSPWZyOhrj8rN5owZGAOBJtNNWPpk1s5lTd89yY/v2UU6cqzg0KKTF
         qhzmy+Lb5CbYsmsaixR6tif7lGP+Ocwk6GR1gC5h9rwRF8l2UahG3+jLC1Zn6AQnEUTW
         HCG/iqKrAvh2NsrSyWVKYftzSQB64H8fXbiYOqj8WWO2Ye76ZTwfKButHC9SARkM0LY5
         5jr8V+wbYtTF/NweIYWirmkTZ+Clu8QHpdoMeT3R7OMuqt2Vh5rKElwKQDkg2QLl6hlD
         Pjwnq/f+SkL6bf10lbibqPN99R5TECPqQtqIg49Nn4HglIunZC4z4HEgoPvRUeIVc5UN
         7qTg==
X-Gm-Message-State: AD7BkJJWHcP1OYj1q5DJW5TT6PH8NyUbWPRat+rZicrA3EEaSR0FqejIkAegtpUbL5qxz5l9mM3at+45ZqJLxQ==
X-Received: by 10.28.129.213 with SMTP id c204mr12017620wmd.89.1458536216193;
 Sun, 20 Mar 2016 21:56:56 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Sun, 20 Mar 2016 21:56:56 -0700 (PDT)
In-Reply-To: <1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289401>

On Mon, Mar 21, 2016 at 5:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c07e0c1..4743954 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -715,8 +715,8 @@ static inline size_t st_add(size_t a, size_t b)
>                     (uintmax_t)a, (uintmax_t)b);
>         return a + b;
>  }
> -#define st_add3(a,b,c)   st_add((a),st_add((b),(c)))
> -#define st_add4(a,b,c,d) st_add((a),st_add3((b),(c),(d)))
> +#define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
> +#define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))

Nit: maybe a comment around those lines would make sure that people do
not inadvertently change them back later.

Thanks,
Christian.
