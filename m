From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 23/34] mailinfo: move [ps]_hdr_data to struct mailinfo
Date: Wed, 21 Oct 2015 13:30:45 -0700
Message-ID: <CAGZ79kaTBtb_4fFSa4b83Lu0x1N-0PvSODvuxGGLdUfZ1SkMnw@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-24-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:31:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp02F-0004td-6c
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbbJUUas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:30:48 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35054 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbbJUUar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:30:47 -0400
Received: by ykaz22 with SMTP id z22so62387360yka.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hWC1CBdQcj36ViT3VvoDaSyd/Dh2n1fDoh4XauQExcA=;
        b=a48qZjhD1MR8a07ZnYZlFJVNfiTuprLCLEY56v8EKKIpUr3znXuurTx9kU5PIX7O1A
         VujC9dq8OMMOU9jxULOb7nkgsOQY/q4QId91KPUflmwXzXNXJ6douFc/9o+a1aeKasn9
         p9YpqPSQFGjcwIzIcI6brxXS3Ip9OaVCztKbnKOuU0z6aezXLcwq2CJveBcFAIhNvRud
         Uc5a12ZF5nMo23WbLd3bGgeKkJYsHeBEa0hxPlmKembDWUZ2ZXAqhuObQ4FXuGgtsfFm
         i3fZBmU9LpivrJTiLGMXlRH6QctuxQndOgxWLjmHHJ+s0cgQXv/ewFTRMhClBTkRx/xZ
         /aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hWC1CBdQcj36ViT3VvoDaSyd/Dh2n1fDoh4XauQExcA=;
        b=WoFa4YKl5iy+vSDHlNCpTC/TomA8p5MAWi4cXXqKuH8Enh+8d6mNK8TNBQVnh6YZ7S
         DPbH1/fZ94CK0oDg2z3P9ZGMxaz5pGRo1eFguEjdj923idsPoHeriUKmoT4B8RtwGeVK
         VLf2yNazIAa//TAunnqy82JaErZWBSEfKJCSnJeROcpMrkbRB75u3oUOZWOyKNxJ9SW6
         WC7l4lZ6dWE5UDJLILy4/F6CeigR/2Sxk1JuKRcF2coUgu3oYw6SLQ2KPLxAHz09GXJE
         eF+nJ1H1eju3bPLDOwPEtT7s9NoKs768CrcvHuysQV8clmtbYrqVh21KpugEyeGZ9LJK
         Q66A==
X-Gm-Message-State: ALoCoQmXvic73rb8fESLxgswLXTWB0nwz386ML3heDDf6UK4c2OC/ASZnecMhT5NZTPXmodLkVBN
X-Received: by 10.129.155.130 with SMTP id s124mr6536378ywg.68.1445459446039;
 Wed, 21 Oct 2015 13:30:46 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 13:30:45 -0700 (PDT)
In-Reply-To: <1445239731-10677-24-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280015>

On Mon, Oct 19, 2015 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> @@ -733,7 +733,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>         }
>
>         if (mi->use_inbody_headers && mi->header_stage) {
> -               mi->header_stage = check_header(mi, line, s_hdr_data, 0);
> +               mi->header_stage = check_header(mi, line, mi->s_hdr_data, 0);

Would it make sense to get rid of the third argument for check_header instead?
We already pass in mi, so check_header can access s_hdr_data?

>                 if (mi->header_stage)
