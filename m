From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] send-pack: don't send a thin pack when the server doesn't
 support it
Date: Tue, 8 Oct 2013 16:44:49 +0700
Message-ID: <CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
References: <1381221884-27048-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Oct 08 11:45:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTTr2-0004Kl-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3JHJpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Oct 2013 05:45:20 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:60059 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab3JHJpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 05:45:19 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so7304392oag.41
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fvvxdd39yrHKJyqEByhm8amLu6wmpAF+UU6sbw2IwhI=;
        b=f8V0KGt9b63lobQOy1I8oMY4fp+a1KT5oEbw31GJZF5xcFpE28MIvUfPXEdQhX+ZZj
         /UkBsQEA+OCB+82IM9lF/PqeJo4e8fQ8ckInhrePnaTex8uKSp3F42cX8HeLO6vIbbb3
         O9OmFb/d14+BKXG9E6M5wq8WuDpLos5DWHqM0IiEx2/SOxKtdayEJPnK5A/zn8RXibH7
         CXx8iI/q4pqNtddOo55yw5aJzlRXFwESyJXBUEvqmFDdbBQg8RYf2RRiIzH0l4YIaow8
         SjRHGl86d02b8PTUf0cihetFh/epO2e5R2r4ewI613ufoyNPnQYluoDy0PVG0Je07ncg
         W7sw==
X-Received: by 10.182.129.42 with SMTP id nt10mr458698obb.19.1381225519137;
 Tue, 08 Oct 2013 02:45:19 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Tue, 8 Oct 2013 02:44:49 -0700 (PDT)
In-Reply-To: <1381221884-27048-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235767>

On Tue, Oct 8, 2013 at 3:44 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de>=
 wrote:
> diff --git a/send-pack.c b/send-pack.c
> index 7d172ef..7b88ac8 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -205,6 +205,8 @@ int send_pack(struct send_pack_args *args,
>                 quiet_supported =3D 1;
>         if (server_supports("agent"))
>                 agent_supported =3D 1;
> +       if (!server_supports("thin-pack"))
> +               args->use_thin_pack =3D 0;

Hmm.. I think this introduces a regression in C Git because
receive-pack never advertises "thin-pack" and so "git push" from now
on will never send thin packs. It's too late now to add thin-pack to
receive-pack, perhaps a new extension "no-thin-pack" for those
servers? Alternatively, just run git push --no-thin (you'll need
f7c815c (push: respect --no-thin - 2013-08-12) though).

>         if (!remote_refs) {
>                 fprintf(stderr, "No refs in common and none specified=
; doing nothing.\n"
--=20
Duy
