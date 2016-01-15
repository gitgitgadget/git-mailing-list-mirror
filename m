From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 15/21] clone/sha1_file: read info/alternates with strbuf_getline()
Date: Thu, 14 Jan 2016 20:52:49 -0500
Message-ID: <CAPig+cSoi3S5HJVyVW4-qs8BsZ7E5iF_cq5Z3zJiMgk4O4LvZg@mail.gmail.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-16-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:52:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJtZP-00071R-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbcAOBwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 20:52:51 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36625 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbcAOBwu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 20:52:50 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so6309236vkg.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 17:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K9ZCaMvJyc68IHLOZfCZcb8JT8fRTKETGdd0cq9ZOoY=;
        b=bZyulJ+P9sxBW0B0KQWRVNyFrIg7iFhyeoK4WK8VL6dh6NJT2IPDJLzGcbWQEI5l+R
         wi6A29OEivGin0u4iug1HT0uN2bV61mjajld7HDI678a+tvUW+tHUkyN2HWmonOaaSCK
         PM+H2Jfthi2eU71CmSPT5lKJxESSnTUemG/ET4byRw1rlgut0YcP9DQAFze25zs/KP5r
         va6wH02u6wIya74/jL6WwuZTkpV62JO1wkkk64bjLULTEoYtlAbmgGVoUC74p4UdNVp7
         wZU5PtWglDool1/9KcnQDOc03zK3zl9x5Zw1nRuJvBzI3UtjPbvB5bCKEh5MH+L/K/TC
         h9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K9ZCaMvJyc68IHLOZfCZcb8JT8fRTKETGdd0cq9ZOoY=;
        b=O27DBUNpw0f3CAJ9AgZBu0r1QkvewdjljTtI/uLPBZnNTTks2Cb4488dnJAF4Nwpso
         mfVnloz1Vx46JzqCU+dmV+tpa2EdjaaMqVu/LnVAoJ5eBCY0Z+t891pihrzjKh2Zep19
         TMf7PnmvyO5futMey7dOCyyhY7nEoQtigc0ewwnq2o6vpFVDdLY0iSa84wPC04ag2y21
         Eq0mFIeHaDodjh5HV511b+b7kW9fVg1LQkl3iwhpDZwbdal9OHSRLgg5PQotObzDhi0D
         OeKOu5IErV7dqKSKy6SSMhu+SKicipU2JLr22rn3yNB0VEi0nQTyGf0DSaE/ixaxyWEC
         7XOQ==
X-Gm-Message-State: ALoCoQmksg/fko0wdJxaj8FdnTgrHwUfx0A3hufoyyFvJcja3XmA8cZM3kTuX2zqUHx7hfPxBho8aVazPv0KlSXulMIEn5mdgQ==
X-Received: by 10.31.47.130 with SMTP id v124mr5781229vkv.117.1452822770031;
 Thu, 14 Jan 2016 17:52:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 14 Jan 2016 17:52:49 -0800 (PST)
In-Reply-To: <1452815916-6447-16-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: eUY3v1PlytwMhfP6nKqXBpyOEgs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284133>

On Thu, Jan 14, 2016 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> $GIT_OBJECT_DIRECTORY/info/alternates is a text file that can be
> edited with a DOS editor.  We do not want to use the real path with
> CR appeneded at the end.

s/appeneded/appended/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 29741f4..43b4c99 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -339,7 +339,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
>         FILE *in = fopen(src->buf, "r");
>         struct strbuf line = STRBUF_INIT;
>
> -       while (strbuf_getline_lf(&line, in) != EOF) {
> +       while (strbuf_getline(&line, in) != EOF) {
>                 char *abs_path;
>                 if (!line.len || line.buf[0] == '#')
>                         continue;
> diff --git a/sha1_file.c b/sha1_file.c
> index 86b5e8c..aab1872 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -396,7 +396,7 @@ void add_to_alternates_file(const char *reference)
>                 struct strbuf line = STRBUF_INIT;
>                 int found = 0;
>
> -               while (strbuf_getline_lf(&line, in) != EOF) {
> +               while (strbuf_getline(&line, in) != EOF) {
>                         if (!strcmp(reference, line.buf)) {
>                                 found = 1;
>                                 break;
> --
> 2.7.0-250-ge1b5ba3
