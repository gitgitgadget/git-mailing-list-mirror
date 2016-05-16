From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 52/94] builtin/apply: read_patch_file() return -1
 instead of die()ing
Date: Sun, 15 May 2016 21:56:30 -0400
Message-ID: <CAPig+cQrLZiwZm34+hFZXPmFGVtyPCvCEv4TwsTeL__cfzuORA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-53-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 03:58:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b27no-00088p-3X
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 03:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbcEPB4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 21:56:31 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34203 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcEPB4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 21:56:31 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so12019752iof.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 18:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=zDdWB+dMwqbZIs3eIVrFa7O21kW1ixckimliKwQAPdI=;
        b=HCr1+ejS3zJlQVR++5FJfQFzqWL5EDKIoX8ZocYJm08u80JLgqRXVFUUVJP093LIuD
         EjLVDrLNo5LARMdg76GR/Bjqg3Di5LU+B2ss4rNAbVWXd0inKDjS34V7qoJfsyKUu3Bk
         CD+I3VoeATmPh8A3eO7yS4jMAb/o/Mq7arqNYrWo4iEfwEOfDYjo7eeVkA80aVL7XO2q
         ChZp5K4KLOF2MkehzZmGYovudkLhZeSpcbnxeVX8KFSmel2JA9yLEcvzXNjfCgHVHuQf
         yPmPAvm1znSw16kfO7L78Xy5jTHykeBD5iHP3CczsQscfDozrwWpkBLRL59yJTRJc2rX
         e+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zDdWB+dMwqbZIs3eIVrFa7O21kW1ixckimliKwQAPdI=;
        b=jBNNyh3RFeicdgFCvEBalARNC0AUe9JRPIe5Vpdf5SbbqDxsC1CKFnU/kJ9gp7h4cx
         Zs6UFkLldnfz8pJlRbSOpiL4xBszYjafbHB5sTAElIg5qetvXwbkU0wKsFvQbuxtv93Z
         AJIhWcb4zUkBAXW8kAu0sr4yQtxIFulVNJvrS40DBQV497MKc/BSVJRMdGJeyLL+G+dn
         yGMKUlLKxGQRO7J52AKDwZJjporJ991agrgG5nw12fM6kmtcxCSGSfuH3fqRgYxKpEaR
         ACEI/T7d5uPhmFYZxN50jDnDOfmvdi28UuKAZ9aP1mecg14xDntD8KhDeeyQ1O58xS8w
         AQdA==
X-Gm-Message-State: AOPr4FVKtT9BUV+tEFzfbjbRxxTSEsTfsCwZdP+t/URPln01GOSRB8pJPZALFSsIq+uFERRGwFmWVmV4+q6wvQ==
X-Received: by 10.36.55.81 with SMTP id r78mr8779926itr.73.1463363790260; Sun,
 15 May 2016 18:56:30 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 18:56:30 -0700 (PDT)
In-Reply-To: <20160511131745.2914-53-chriscool@tuxfamily.org>
X-Google-Sender-Auth: eqe1OvtgeHj5trEj6H4BUbysCIc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294714>

On Wed, May 11, 2016 at 9:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To libify `git apply` functionality we have to signal errors to the
> caller instead of die()ing. Let's do that by using error() instead
> of die()ing in read_patch_file().
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -445,10 +445,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
> -static void read_patch_file(struct strbuf *sb, int fd)
> +static int read_patch_file(struct strbuf *sb, int fd)
>  {
>         if (strbuf_read(sb, fd, 0) < 0)
> -               die_errno("git apply: failed to read");
> +               return error("git apply: failed to read: %s", strerror(errno));

When Duy's nd/error-errno series, which is in 'next', gets promoted to
'master', then this could become:

    return error_errno(...);

>         /*
>          * Make sure that we have some slop in the buffer
> @@ -457,6 +457,7 @@ static void read_patch_file(struct strbuf *sb, int fd)
>          */
>         strbuf_grow(sb, SLOP);
>         memset(sb->buf + sb->len, 0, SLOP);
> +       return 0;
>  }
