From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 69/83] builtin/apply: make add_conflicted_stages_file()
 return -1 on error
Date: Mon, 2 May 2016 03:36:51 -0400
Message-ID: <CAPig+cRBgj29ugY0qYS9eB09CDKcJXeBKg3KqPaoZFSzCwftZw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-70-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon May 02 09:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax8PY-0007NA-HT
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbcEBHgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:36:53 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32789 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbcEBHgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:36:52 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so22001490ioi.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=fqa6QMkIkTywNUJR9WlAW2bCpwqkRRo0zuatCFovxyE=;
        b=jmT1Xz5jMz/3o+5hJqbMIl2/7q6CpMgjss3/hAns49cxLwTeTslmA9KtrcJNT0MQJZ
         BwBXk1C56uTskPSBr0bWjBuILLHGX455Sa1aQrwVsD3m17gO7e+jkHBnqFR552yWeBBg
         S4GxxAMIuHT2dHi2e7orA2UwuSDu9jJE16q7QW6kOiP5RFH4ODWRTLxu2qxs6oFsRXOm
         KXpbdWlkf/wHSCmLzuzoYmo+cF1ohnD9HtFG4iaahdFpakkQEUTgajf+YKoAfoMErwlQ
         DSBtoRTvEGMMYYSiYc88PbVEYpSMrg1tkL6fyIKCQcycUEsBkU22ho7VuCj5SbBEu6CU
         pQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fqa6QMkIkTywNUJR9WlAW2bCpwqkRRo0zuatCFovxyE=;
        b=ZvZ7Fobpl+g/2haie0tXFGlOLqhTGWUl18nNqzGeaq9mP7SQehQpXHI7JE3KhkfWTB
         ZXd/qjZQoglqDMSF5xD9Q1j+lJgiR4nJ/78VfeWOaLXJsmJEcec9rCtPX72hMQZtlC7n
         lvexxme86pXeFXjMl/g9mT3nsCJoU23PIaaXbXhY5FtatE7vti+q431ojvQlvNTXsW5b
         h8+rZbBzi/x4mEHzH/jPBDa+ouvx8Zkz+e7YmrrtfdlEQJZVU0Bpish1v1K4t6PiHcDQ
         bSykz7P5rSZT+R1xBd5uWkvSPt7j1ZEya8tf0jPswTNWwY9kSGR7lx5FW4kzkvObv+/Z
         6irw==
X-Gm-Message-State: AOPr4FXjLe3/NlXBqO8nijzbhTb/EAd+cVikFsxKaT1NPtyLBiC7Jk4QWvlAGaQNxcItMFB9dJmy5d7Y1NOwrg==
X-Received: by 10.107.47.37 with SMTP id j37mr36754971ioo.168.1462174611340;
 Mon, 02 May 2016 00:36:51 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 00:36:51 -0700 (PDT)
In-Reply-To: <1461504863-15946-70-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: 74XB1HILHsus4I6WzWXhNlezw98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293227>

On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4234,8 +4234,11 @@ static void add_conflicted_stages_file(struct apply_state *state,
>                 ce->ce_namelen = namelen;
>                 hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
>                 if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
> -                       die(_("unable to add cache entry for %s"), patch->new_name);
> +                       return error(_("unable to add cache entry for %s"),
> +                                    patch->new_name);

Is this leaking 'ce' (which is allocated a few lines above the shown context)?

>         }
> +
> +       return 0;
>  }
