From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 33/83] builtin/apply: move 'root' global into 'struct apply_state'
Date: Mon, 25 Apr 2016 14:54:37 -0700
Message-ID: <CAGZ79kaanAfW7wX-qP5Tog3B9gL_38aJEdMfHy8T5MXj2K9AgA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-34-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kaaATDzOHFOmCAANcZmrF_5JGAUYW3Ub1WJ7vSLODVP_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:54:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoSo-0007Ah-U8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbcDYVyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:54:39 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35244 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965002AbcDYVyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:54:38 -0400
Received: by mail-ig0-f173.google.com with SMTP id bi2so79859248igb.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cNGmWCkkw8paNj4mYb/jRbOq6UV8cXVlDkejtcYJNN4=;
        b=CF0YT4fs3FsKoFvlJcZt7b/53yOZ2AMt5HeP/LJ3Xl4rugn9mrKxtThDp9XQ/k0Rwe
         rAEyVV4AReoNy5g4yaPflTZjbSxD0B7X5AfCfQLclhY+UNy8crAv+QB+kK63pwycD+DX
         j16tqsFImwuElqo+eDj4cXBiUcIf9OEEMOmEh9lq4kKxizr1m3qtFh0hPwU+29USIjR5
         uExHO0+QCxdSwTUs+6imcmrzY9rRUEz1eg3VgolK4SFAwxtvkrZM/mX0IpS+zleM2Dkb
         PrW6GfMsNmA3DxDidPA4YhExi5WaznVhsNSvMdSu1UU9ORr14AQnOhDkne1K6W9Eom4Y
         guxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cNGmWCkkw8paNj4mYb/jRbOq6UV8cXVlDkejtcYJNN4=;
        b=BLUlatwj92m8QqKMMKXMYsf9fWIHAMbUR84qYnkLYdh606G3SLwZHubrz0l1gtb/DO
         CFAhpG2wDJWzUM5iWrEOgPvqOsLUsWNj9O808OtzHohI4p7qsPD6Ry/fWnkvfj+JEO7Q
         Qjw9JnBaknpdk+s+1QjSRTlkJq+EfsDVgS5ZjcEsBhHONSSXHb/MEVScKDittFXte7tO
         THnt/3ixnboFTg2ugn7EsCvndej9/JVL2XWYQ/xCgRPe77nAgwH1pFitPw4TQDzSpwBc
         UDzVn5JMgjQwmXAx1i6/AOcPmFeqsYuQZ2C6fn53LEWO8IS2poZMJLKOo0gH/q2VLyBw
         gShg==
X-Gm-Message-State: AOPr4FXsWt459HOpkPlghXkm0g/MjG3Qymg+WtINKyBnm4TbA0W7kfjXTUO+go09Isf4gy2u7icXZS927E3Wu3LL
X-Received: by 10.50.98.195 with SMTP id ek3mr15379606igb.85.1461621277670;
 Mon, 25 Apr 2016 14:54:37 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 14:54:37 -0700 (PDT)
In-Reply-To: <CAGZ79kaaATDzOHFOmCAANcZmrF_5JGAUYW3Ub1WJ7vSLODVP_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292573>

>
> Eventually we want to have some sort of `init_apply_state` function or
> a define which has all the values, I guess?
>
> Compare for example to sliding_window.h, where
> we have
>
>     struct sliding_view {
>         ...
>         struct strbuf buf;
>     };
>
>     #define SLIDING_VIEW_INIT(..., STRBUF_INIT }

Nevermind, just read patch
"builtin/apply: move 'state' init into init_apply_state()"
