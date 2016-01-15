From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 11/21] revision: read --stdin with strbuf_getline()
Date: Thu, 14 Jan 2016 20:50:36 -0500
Message-ID: <CAPig+cRJEUB-Fsage2G85g1s_TxSLbAmtDVqu8VDaNpBRWLkcQ@mail.gmail.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-12-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:50:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJtXL-0005Nk-PY
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbcAOBuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 20:50:39 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33624 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbcAOBuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 20:50:37 -0500
Received: by mail-vk0-f67.google.com with SMTP id n1so8549323vkb.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 17:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7PUxH4+7OymXA66OhsBtoXdfSl2qHahixRHwuy5dgWI=;
        b=n3it3d2AXEd33IjhdGu+9oqTJEevfWl3EH/oXX+boFDzTSPIpJQzEIWjG6XILJgGeA
         6PlSYbKmRosHIm5ySGzyv68QeJebcu1FGAwtLQWs2QPnTSHDALlZkEhMYHFZPBCNEAtm
         ydIwwo3cgoTnxoF9XPMxUzkmYgw/dFKNf9aYmzAODdPm0wibbiDrgmtly0Q1mr7YrDFl
         9qu9y4/qKu7fm705yp2yM0ECnaJm3hUMsCy9D8TDwBIrWCjmm6PIgY/alYQevlNHzODI
         4Ax0xn8zWMGiTJXPPVrmeu84BSfe3dzT8Lv+Zts1JyWgGUpQOxmqmVCs+jyuXsb4hBpe
         zeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7PUxH4+7OymXA66OhsBtoXdfSl2qHahixRHwuy5dgWI=;
        b=HovHFSB892FmqHFpDWGTQ0975BuQni/1Zgl6IjjfdeFt6jOqFmxec8+XtdcXQV89GZ
         yj4ZNg8SCGiGO/qRiAXhmHY4nv7hEnCEsyy57nVpmB9OwSxvfJBSGe5ZVMA/nCJSTxkj
         tlvlkcA6aTbRYrdvxBSCn70bEReARmpYURPrfkuzbMctkfB8esJ9VwctbSxagCLvsmAQ
         MQijBRLbIGAjW+tBhjPO9H92MlZhQvzQOpfkAS02sVyZD8GxcPobZmCORZSgmkCUq7X/
         gEwslKXyVWi9Frgo+xF4DFphFo+aDpDamNxsUxUMrfOBNgZJvU+uiMPOxEqWfRGuwrLJ
         ryLg==
X-Gm-Message-State: ALoCoQnu6ukeOd3vGhi63mu6PjeKMOiWeSZWEbbtbsyxmcz3l2Z0f3ZFEA1rIv1UjHUSFcpqyJwjHFH1BIx3KSo6xT7/nV0cGw==
X-Received: by 10.31.58.74 with SMTP id h71mr5723845vka.151.1452822636692;
 Thu, 14 Jan 2016 17:50:36 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 14 Jan 2016 17:50:36 -0800 (PST)
In-Reply-To: <1452815916-6447-12-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: mmya4ufdrbnkxkmBiVE_EcM1g4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284132>

On Thu, Jan 14, 2016 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Reading with getwholeline() and manually stripping the terminating
> '\n' would leave CR at the end of the line if the input comes from
> a DOS editor.
>
> Constrasting this with the previous few changes, one may realize

To what does "Contrasting this with the previous few changes" refer?
Did this patch previously come later in the series, or am I missing
something obvious?

> that the way "log" family of commands read the paths with --stdin
> looks inconsistent and sloppy.  It does not allow us to C-quote a
> textual input, and it does not accept NUL-terminated records.  These
> are unfortunately way too late to fix X-<.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  revision.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 0a282f5..8df4e11 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1635,10 +1635,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
>  static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
>                                      struct cmdline_pathspec *prune)
>  {
> -       while (strbuf_getwholeline(sb, stdin, '\n') != EOF) {
> -               int len = sb->len;
> -               if (len && sb->buf[len - 1] == '\n')
> -                       sb->buf[--len] = '\0';
> +       while (strbuf_getline(sb, stdin) != EOF) {
>                 ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
>                 prune->path[prune->nr++] = xstrdup(sb->buf);
>         }
> @@ -1655,10 +1652,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>         warn_on_object_refname_ambiguity = 0;
>
>         strbuf_init(&sb, 1000);
> -       while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
> +       while (strbuf_getline(&sb, stdin) != EOF) {
>                 int len = sb.len;
> -               if (len && sb.buf[len - 1] == '\n')
> -                       sb.buf[--len] = '\0';
>                 if (!len)
>                         break;
>                 if (sb.buf[0] == '-') {
> --
> 2.7.0-250-ge1b5ba3
