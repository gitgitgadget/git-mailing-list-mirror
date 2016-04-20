From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 02/15] read-cache: allow to keep mmap'd memory after reading
Date: Wed, 20 Apr 2016 16:26:34 +0700
Message-ID: <CACsJy8D229ARqEjH29Gqd=u8KijGA_Fzk0cbUNRXB9GA0ittMg@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com> <1461108489-29376-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 11:27:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asoPg-0001cO-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 11:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbcDTJ1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 05:27:07 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35161 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbcDTJ1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 05:27:05 -0400
Received: by mail-lf0-f46.google.com with SMTP id c126so37158291lfb.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5AnzyU+/Q1NgW5cxqjcMm4R9JxvtjN1p249XiqNry5g=;
        b=00SX6AnzEzfLIc60LPYRmWURUV6VzYgfelfmJsRF2yJ1foGcTY8D25LuyfL0V1tQSp
         41ssgBte3Nt5MfLS9KMbyZmx9BwuvQQenMRDKwGMRCvtADnROI9oLjzC1k8839wIyPg/
         zf3yjzr44ALuIiVlWm1JCMcVL1TEXrcZHY94QjINGtLm1i/zmYfEhFHZirVNfiNso+zO
         RBrXqVEo5wTKrTRph3xQcUDtiK1fN7LUZGSLBnQr63+jXFVf/ygKs/ZWbwbcepiyFXHj
         Tgf7wkPgSiMuXCb+/3myO9N98UfDmQZKrtu57lJuUft2fZmCUlxr0o7KISHLIjF8o7+D
         p5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5AnzyU+/Q1NgW5cxqjcMm4R9JxvtjN1p249XiqNry5g=;
        b=CMsso9kvahYUiMquPfF+dSHKJPVCOH2Roglfl04I/g9lEP3ZefvZbQAeU/r7xc71z5
         pSvgMpOZfDIP+UMR6A9zGLaf6ZuiBZmJXRmDsDu4J9jcHEe4DXcrlK+3CHv0g8VWLBva
         YG8YaAvR1kJdyUknkDscZoUXItYlka3NnxUffGt16NUcLv1BbrWR/GgJCFTFTxL36xLu
         4UHRjyH5REJ2u2XMFM3RSWmo3heWlw/8AiNESqzpw0grK/a0+2Gjv7kKz1TxjI7ZtE6G
         4yO7GsM2J/JwRymej+kmAIG7oO2snhibhh67q6ZxQLPEJndV9J56oajV1bseoEMir/E4
         bdow==
X-Gm-Message-State: AOPr4FU5wqGGDKg3xVzRPrITTYKYHK3uybDLPeE+bp0V1sUfWRYIgZ81A6JBQniTO68CDVMi4lX5iUjjgWKKoQ==
X-Received: by 10.25.22.19 with SMTP id m19mr3254505lfi.118.1461144423740;
 Wed, 20 Apr 2016 02:27:03 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 02:26:34 -0700 (PDT)
In-Reply-To: <1461108489-29376-3-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291998>

On Wed, Apr 20, 2016 at 6:27 AM, David Turner <dturner@twopensource.com=
> wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Later, we will introduce git index-helper to share this memory with
> other git processes.
>
> Since the memory will be shared, it will never be unmapped (although
> the kernel may of course choose to page it out).

This is not entirely true. We do need to keep the mmap'd memory for
longer, even after read_index_from() finishes. But we do not share the
exact same address space to other processes (memcpy is used in
index-helper.c:share_index()). We could even discard_index() at the
end of share_index(), but I think we keep it anyway just in case
another process asks, or when index is not updated.
--=20
Duy
