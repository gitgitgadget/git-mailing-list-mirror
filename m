From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 54/94] builtin/apply: make parse_chunk() return a
 negative integer on error
Date: Sun, 15 May 2016 23:04:58 -0400
Message-ID: <CAPig+cQkKijp_Mg0Ho0wAFSxmLin0EPA_a5PwV9DaHkHLJKNMA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-55-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon May 16 05:05:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b28qG-0000nd-4V
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 05:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbcEPDFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 23:05:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32818 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcEPDE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 23:04:59 -0400
Received: by mail-io0-f196.google.com with SMTP id x35so23473822ioi.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 20:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0MV0R+HAOjkKeyk+wO365G9KNSnEyrUy2XNlkeoXbB0=;
        b=qUEYB+Yj3Ce05ceLwuFpR9qw3I8r7bXK+uaSma1cMYH+6EvLsoA39a6syL/DqbGzoV
         rSgKPBsykzuNxRE3iEPTUJcESBViHsOU/1JhzV2KfwV/6bNZyevaI2DtNx+Y9gsTPMLS
         Ti8RAdUbjfDeUNtpVl7N20KQvusoUj8P3BmGwEqsHcmVbo1dMv4Q9Bejtd4Drj+9YlNT
         tU5Bn6pfut1WLvrN5umpH4wFsPeJ95B5p6o4GK9ZMGdmHMS/BkFJcSSj1BYM84zh9vDz
         mRd6l7OtzlQ/Lis7Ca5yZosst+ijSoLHHJ0BSnfwrDi/dPpiOteMHOtTF1Hd8e4enxTj
         ye4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0MV0R+HAOjkKeyk+wO365G9KNSnEyrUy2XNlkeoXbB0=;
        b=hw+w0cyZMzsFBvabngagpfbqBWK1nyLZqkO8/M6zVdeJid8NaE+DEgJnMfQ54N21Xv
         mWwUDxSFvvrhgwXh4RvzqK8hm7fnTB+vc/wOQfEi83AIA3bEWVbNZD/dgl6OxjVJpP8w
         3pLomBvCoauOgvvka+oT9fMJDU4oJrstVWyvc/2K1QVWBNuogFAYIPj/FGiEZWnXX8eb
         PgbRs2RsY/+0jTR8k2PlXPFk1U5+MjGYVxZW7kOYmfdJYSHS7/RTOeO8toAJqra3tPPg
         BEOiBnKrszu38s3SSHlnllfgpBliOE+fxMlFoQ+s8p7VnIv+JcUgNEhTRnWW8dSEfe39
         cdvA==
X-Gm-Message-State: AOPr4FW0I2+VnQdQkv5twlKNsosrr7rOmdhbqI5DouBqzuWMm7ngtKRiAO/jU+a1hMEuMBnaGQCPOBfrcAw5uw==
X-Received: by 10.36.55.144 with SMTP id r138mr7612475itr.73.1463367898690;
 Sun, 15 May 2016 20:04:58 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 20:04:58 -0700 (PDT)
In-Reply-To: <20160511131745.2914-55-chriscool@tuxfamily.org>
X-Google-Sender-Auth: VK9a_o4qgfBLBsrk5TZBCA21pTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294716>

On Wed, May 11, 2016 at 9:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To libify `git apply` functionality we have to signal errors to the
> caller instead of die()ing or exit()ing.
>
> To do that in a compatible manner with the rest of the error handling
> in builtin/apply.c, find_header() should return -1 instead of calling
> die() or exit().

Why is this talking about making find_header() return -1? Didn't that
happen in the previous patch?

> As parse_chunk() is called only by apply_patch() which already
> returns -1 when an error happened, let's make apply_patch() return -1
> when parse_chunk() returns -1.
>
> If find_header() returns -2 because no patch header has been found, it
> is ok for parse_chunk() to also return -2. If find_header() returns -1
> because an error happened, it is ok for parse_chunk() to do the same.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -2176,8 +2176,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>                  * empty to us here.
>                  */
>                 if ((state->apply || state->check) &&
> -                   (!patch->is_binary && !metadata_changes(patch)))
> -                       die(_("patch with only garbage at line %d"), state->linenr);
> +                   (!patch->is_binary && !metadata_changes(patch))) {
> +                       return error(_("patch with only garbage at line %d"), state->linenr);
> +               }

Unnecessary braces.

>         }
>
>         return offset + hdrsize + patchsize;
