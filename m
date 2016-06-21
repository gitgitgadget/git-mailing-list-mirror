Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2320F1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 07:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbcFUHPu (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 03:15:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:50350 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbcFUHPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 03:15:15 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lu2F0-1bPTFS3ZQc-011VJW; Tue, 21 Jun 2016 09:15:08
 +0200
Date:	Tue, 21 Jun 2016 09:15:05 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
In-Reply-To: <xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606210906190.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de> <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com> <alpine.DEB.2.20.1606200814510.22630@virtualbox>
 <xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gj8WrO8mixALwBk9umu8gs2AeQe/rDI15t50Pj1Up3pWCXyS1xo
 ieHsVP6N5smfOeDm5BTXGhOjdaUaZArdFniPcxo19Mg0yEXAg5ZRORC3RSO8LjYGTVEeXSY
 Y4l3lOCTJiaerjZFqseFdrbrWBZ75dWH8uNraBVfU00AowqPyyqUL4LhwJX9clqm5MeDeuL
 SU6tj2GNJtgUfmoAe2nzQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WLu8FK4Z4Tw=:4cm68Qxw7mmY2iai9LHKhY
 H0gnIpHpCex/UoQoc5nxLV3bf0T6hFHKZCOeONZf41+WwA7IPC1gftZP6Y1LChO5U5YRdIpRz
 60nczNT8bcc6Ko8jkrXy1RkhbORDx5qae1HsyuL0FSmb0wPswAr19B+OT599BxX9FylPLhYO+
 SkpMnvCekiiXzX+WKvLjmcldfbVSMlCVfxIF7mu2OA71a7MAdACBIad0xYYqN9Zn7nRPN2yWP
 uMl1zvAk54Yg2n4e+Oto9YX/1pv3TGKwo1UIqMAdNw5nq1XvhWCRwLv6wNm+n/ITm1BZTVstK
 FSYOVUKFDcmcCtkBTNnLh13O+u7ebg0RWh6JIQuXDn1DMqNmMHXhf2DxMdHFFp8WV86xJRk0d
 nFHK6+jM70aPPSlwcvHJ2vPK0S35qMmxNc+gdlsdKSGm4IPSuNqT4dVkwzSp/Tmtl9VsM0Quq
 cJo9foAFvqj0Zvz16H1O6Qqpr0DZyKDmkpFIHJluqUZoxMs/eBEXiH+e4hBa9SxPKQw+kqBFJ
 yS45p6AHb0RD67NHvGcWIWSEn3csoIEpfcp0qW1W3fwM1mSQA4F4DO3MHYvrYqyqRBWLIG9eR
 C/hT+DPrcyCMlpbxEbYA+DgI7vBQ1BWK6kzKXvjMM0SvRLMEOWL6Lj+DvqiFs3Q9U8/55evRi
 6WQnU1oLHj2qRT8EqgzM8IlJrlBKiOdW7n5dooripC7qTBGETyl2FBAEMT4/KlassUu+H72f+
 CTM35KBAH6WYcfd6oDmJOXqIt0sNoKB/r38ixH982eDC6G7dJL4bzq5GsatFX3u+I+dWUfWcF
 lkDBQ94
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 20 Jun 2016, Junio C Hamano wrote:

> You can probably sell "when giving out put to file, we will never color
> the output" as an improved new world order, but if that is what this
> change wants to do, it probably deserves a separate patch.
> 
> I however think you can avoid breaking expectations by people who are
> not so sensible by overriding only when use_color is set to
> GIT_COLOR_AUTO, perhaps?

That is a very convincing argument. So convincing that I wanted to change
the patch to guard behind `diff_use_color_default == GIT_COLOR_AUTO`. But
that is the wrong variable: the variable that *has* that default value is
git_use_color_default, and is private to color.c.

But then I dug further to determine under which circumstances that
variable can be reset to any different value. It turns out that in
format-patch's case, it cannot:

	787570c (format-patch: ignore ui.color, 2011-09-13)

I hope you agree that it will be enough to augment the commit message with
this analysis and keep the patch as-is (as per v2, that is)?

Ciao,
Dscho
