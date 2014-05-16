From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] pretty.c: format string with truncate respects logOutputEncoding
Date: Fri, 16 May 2014 20:44:47 +0700
Message-ID: <CACsJy8B20XMiNqtG9c-cLERd8-zahcvWU=UnY80ZJUmLD91ZKg@mail.gmail.com>
References: <cover.1400242108.git.Alex.Crezoff@gmail.com> <b8aa002298a5e96be3a79406b0d120f001364851.1400242108.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlIRy-0006TH-Ol
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 15:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbaEPNpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 09:45:19 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:62243 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbaEPNpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 09:45:18 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so4251226qcy.22
        for <git@vger.kernel.org>; Fri, 16 May 2014 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zAI7FHgOqPa0VtLBxu8Uen6B2Ot/0EYNSr3pJRbU4MQ=;
        b=qk/iqPLYgTGKwkg0ZcbBT/TWG9Tc0MeSpoNFUTkf804JuzA+vraUIYS51UxYaw52Ox
         7pg239mqu9/1ODyr8YDxDf/etOWQBhaR4cWdmi49YUMYyY5aUxRPuhCt8r6vuEI9zNAo
         SHRxoaVxL6Tyj5GyMJyXavQAa99W2MWhP5ljRWixVmwLJfb+m3yQpNRaKnnMTuOsYYEx
         o+6x9WiWocCBcYQqYBXftVNraJvD4Eph5h8Gc5SN4Am0lAOillW3XB6W/B9/SQfGCTMo
         TeUH85goqhg97tRcJY1/M0xFS9D+x259V+tidY1JLxZtROuRUGOBwfjP+kow/CNdJXFZ
         +gfA==
X-Received: by 10.140.107.198 with SMTP id h64mr24228662qgf.30.1400247917611;
 Fri, 16 May 2014 06:45:17 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 16 May 2014 06:44:47 -0700 (PDT)
In-Reply-To: <b8aa002298a5e96be3a79406b0d120f001364851.1400242108.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249305>

And I thought I was the only one using this :)

> diff --git a/pretty.c b/pretty.c
> index 6e266dd..7eb43c1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1500,16 +1500,19 @@ void format_commit_message(const struct commit *commit,
>                            const struct pretty_print_context *pretty_ctx)
>  {
>         struct format_commit_context context;
> -       const char *output_enc = pretty_ctx->output_encoding;
>         const char *utf8 = "UTF-8";
>
>         memset(&context, 0, sizeof(context));
>         context.commit = commit;
>         context.pretty_ctx = pretty_ctx;
>         context.wrap_start = sb->len;
> +       // convert a commit message to UTF-8 first
> +       // as far as 'format_commit_item' assumes it in UTF-8
>         context.message = logmsg_reencode(commit,
>                                           &context.commit_encoding,
> -                                         output_enc);
> +                                         utf8);
> +       // then convert to an actual output encoding
> +       const char *output_enc = pretty_ctx->output_encoding;
>
>         strbuf_expand(sb, format, format_commit_item, &context);
>         rewrap_message_tail(sb, &context, 0, 0, 0);

It looks ok except minor issues, use C comment syntax, not C++ and
variable declaration not in the middle of the body.
-- 
Duy
