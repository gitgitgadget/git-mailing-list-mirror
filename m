From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] Refactor skipping DOS drive prefixes
Date: Fri, 8 Jan 2016 16:51:11 -0500
Message-ID: <CAPig+cRRaMbEGibYnQBTfGFQT6fybNU8e6ZAkX11V-TLAo9AfA@mail.gmail.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 22:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHewH-0001Ib-Gg
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 22:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbcAHVvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 16:51:13 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33081 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634AbcAHVvN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 16:51:13 -0500
Received: by mail-vk0-f68.google.com with SMTP id n1so2771947vkb.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aZxxTpqy3pjVKntBHdh7zmbFfJAbOD1/SYy0f0NgjJI=;
        b=LQqZpRYnD9WCsYJ37P4v14zWXDD8aViA1P7JDlHVfFGVobqpmXtTsx/KwFxlpV1yO4
         quM25lPSLh31JcAn94QKC8B5wQNs2+0PFosI/rP2nfnALmlQaTElKoONfsUkQPR48Yoy
         oiNCJwqtSjhfW5OmhQgHb99aCn3aMkg3TLOWOxg4PVxgwQw0RuDCNw76Z4kzH8gP8uEz
         9PbGh60EchLhtIL6Z3fsW75TVA77+QwROmn1aUR9rTpgXDY8NgNwxwk1q+O6nBjHSQ1N
         9XJiwjG+lHbpVwAT+dlGKG+n4+tiP6VGqNwZ0hZ5YM8q2vgo9FHK6jziX2iwWCK6g265
         7pKA==
X-Received: by 10.31.58.142 with SMTP id h136mr79680452vka.115.1452289872007;
 Fri, 08 Jan 2016 13:51:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 8 Jan 2016 13:51:11 -0800 (PST)
In-Reply-To: <c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452270051.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: X5O-LsJtKAPPWEWSYDePY8TE9XQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283583>

On Fri, Jan 8, 2016 at 11:21 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Junio Hamano pointed out that there is an implicit assumption in pretty
> much all the code calling has_dos_drive_prefix(): it assumes that the
> DOS drive prefix is always two bytes long.
>
> While this assumption is pretty safe, we can still make the code more
> readable and less error-prone by introducing a function that skips the
> DOS drive prefix safely.
>
> While at it, we change the has_dos_drive_prefix() return value: it now
> returns the number of bytes to be skipped if there is a DOS drive prefix.

With this change, code such as:

    for (i = has_dos_drive_prefix(src); i > 0; i--)
        ...

in path.c reads a bit oddly. Renaming the function might help. For instance:

    for (i = dos_drive_prefix_len(src); i > 0; i--)
        ...

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
