From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 59/83] builtin/apply: move init_apply_state() to apply.c
Date: Sun, 1 May 2016 15:37:49 -0400
Message-ID: <CAPig+cTxZf=oMB=V5JoZNUO6eTtnabv7LinNo1LUeah6ofrbEA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-60-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 21:37:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awxBi-0003Jy-Gh
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 21:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbcEAThv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 15:37:51 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34573 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbcEAThu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 15:37:50 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so21182213iof.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/i9RNMVUyTPBAMgjzncLbixo+p7hy8jIhtkgLrVH858=;
        b=Pwc+AGuwFXGCLrOj8305re2lngBTpD19XLKy7w8DIAfv1io3jcpCCcWgHzCo8TSSMf
         ji3R92QTegt2PQNLYVU1lZuySI6qhA7cfUgeHrgqW0FrCp4sp7SzF3QxGyLudGyx1kOu
         qhN+yLExAiXXuHEqtdoFbl6wdIxQ657516iWNBa/nNdQqqk0GuSW/wS3ZGoQ1LoJgURd
         Go1/gO7u1lJGksqGDvKqbCeZfesGXClFkSoeXHKv9fNkA9WgktS+skwptvtNeY9ulSl7
         ViN5YYQlcxZijIu4vw1fnpvfaQngwDbq2nqCqcm6aE8iiXqNNL0VaTz0TdzF9dTgrSv5
         4KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/i9RNMVUyTPBAMgjzncLbixo+p7hy8jIhtkgLrVH858=;
        b=KBh5CQcQWZCK9lDePJmVERlJXH1HA1/4vdXfz386J2Zi6oco2VkaREiTkcV2J/RERS
         x0VaZV+yIxuhLpO1wlUM6t1TirGsio5VkCUaUtedQk5/+wrHz2Cnk38esOW5ncgJQu9T
         gA2V1t3hGuK8AgLQHiNhan2SgbkELnLINPo/JfUw8p2tpfTIdgUzaUldisAhjJKFa32X
         L2WDyFZQE2e3olE8hicnLAuAiMADjY8RN1HfIt2ueyEujRrCd6B9Lm21cp3thN1VoA5o
         7T+pWbgisFIEpl/7LhaiyPZXb0zCn3kSvWJv7QxCQ5BjfDAFqYmfPSXoD6NeblNnXukN
         M4Xg==
X-Gm-Message-State: AOPr4FV1zxJtrGGa5nD7Bii3P3BM/3bAw0tZbvDtwCPSqwhzzqkNSmK8HABn+ccI4qpwqVfuvL3zREj0AxYnOQ==
X-Received: by 10.107.47.37 with SMTP id j37mr34625190ioo.168.1462131469420;
 Sun, 01 May 2016 12:37:49 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 12:37:49 -0700 (PDT)
In-Reply-To: <1461504863-15946-60-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: WoP0uA9ae63SuJZuzJqwGeZGlYk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293211>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/apply.c b/apply.c
> @@ -0,0 +1,80 @@
> +#include "cache.h"
> +#include "apply.h"
> +
> +
> +

Too many blank lines?

> +static void git_apply_config(void)
> +{
> +       git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
> +       git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
> +       git_config(git_default_config, NULL);
> +}
