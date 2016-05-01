From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 54/83] builtin/apply: make parse_chunk() return a negative
 integer on error
Date: Sun, 1 May 2016 15:04:28 -0400
Message-ID: <CAPig+cQbF_Xq2oB5ALQkj_Zdw8VR8kyVyinq_K24zGGK7Xundw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-55-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun May 01 21:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awwfn-0004bn-NI
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 21:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbcEATEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 15:04:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34670 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcEATE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 15:04:29 -0400
Received: by mail-io0-f194.google.com with SMTP id d62so21137955iof.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=PKGDoaMA/t6Rb0V8ZMLTH5x/+v6iv0m5Gp9aZoH1KGw=;
        b=G5tmjaSckmLO4TlaYGkGp8rwP+k+LTAtjd+hWrVQJvabfBrBu/0jdmAWvT+bOD+eQS
         tQu8Fy/C8QQ2ttiBne8sHiykSuBJKx1ZBCeTVb8By2Jj0yKnumiYS7yqEWqjvP/nlqUS
         Yes2VmcovW+M1DnesCDPdxBtPvoBesolVuWqR5pWAruxdqaytN3DRDNfPezxS7jnZ3Rb
         GM+R6hXGXDGYY90Nv+Xd5u2sFXG+3I76ZL5G1IcKo5Wvat6LD4O3zK8jmfeClJKzdqFm
         R+dM7l1UccRMMDcSDeP8XEy58vbbaZiP65wJPWHF/g3GunS8zjxNylDcA/zX+1augGkQ
         d1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PKGDoaMA/t6Rb0V8ZMLTH5x/+v6iv0m5Gp9aZoH1KGw=;
        b=gJUcRR47HlogVFTCWoXCXlBNufCktxYKltzieQb0jjJqUHj6yHh2wYtHaPRyG16YCY
         AzmD7aLvWpcFTsxiRCrThovaj7UBuey6j5M7QDo1rSFOkiH8y4wsKFNK6qzJBbS3sXmU
         91svtlwgqNkST4h6oOGN/Vnw2p/c98971Ou6tb8ECiVKU5a24hBLyqJRvaAtYzoO6P8G
         gOL3MrRRfzyeYT+/G8XqaG18tVRtsyLrwCqwahirFT8n7ge3mCPDAQ+xi23u2pH4fVLO
         YH8S+dCacapPEf2PDBw4JI42CdpwoOQg17bfh3+6VyHb7gq/F+E0EnXJx4BBgfrauQXO
         pzoQ==
X-Gm-Message-State: AOPr4FXDFzoAukSL6ZWy+gbn0oYpo2035lqbXS1svDd8DaYGR5lrxDSBhTERtW4IC8ajJK2Jkc8OLQBsYs6w5Q==
X-Received: by 10.107.9.102 with SMTP id j99mr36076586ioi.104.1462129468798;
 Sun, 01 May 2016 12:04:28 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 12:04:28 -0700 (PDT)
In-Reply-To: <1461504863-15946-55-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: BZTfVNOeZzHgUAnYp7yjSmlImgM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293207>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> This negative number can be -2 if no patch header has been found,
> otherwise it is -1.
>
> As parse_chunk() is called only by apply_patch() which already
> returns -1 when an error happened, let's make it return -1 when
> parse_chunk() returns -1.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4566,6 +4567,8 @@ static int apply_patch(struct apply_state *state,
>                 nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
>                 if (nr < 0) {
>                         free_patch(patch);
> +                       if (nr == -1)
> +                               return -1;

Same comment as 51/83 about this leaking 'list', 'buf', and 'fn_table'.

>                         break;
>                 }
>                 if (state->apply_in_reverse)
