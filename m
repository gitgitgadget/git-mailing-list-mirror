From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 5/5] bulk-checkin: replace fast-import based implementation
Date: Thu, 1 Dec 2011 15:05:21 +0700
Message-ID: <CACsJy8D5BqqkXCa7kczcNBxjt=G2d2ZXUToncR2pBGRuZ3gPKg@mail.gmail.com>
References: <1322699263-14475-1-git-send-email-gitster@pobox.com> <1322699263-14475-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 09:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW1ea-0004Jp-Ds
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 09:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab1LAIFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 03:05:55 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59324 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab1LAIFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 03:05:54 -0500
Received: by bkas6 with SMTP id s6so2078821bka.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 00:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q3MtQAuO/5sj2khG/SVj3IAj2osfKOsYvtLEw1+zhno=;
        b=lGt4Kyj+t5FzspNvo4XNbqz5Hez5y2f0TGK/f6MT1S3zPYihVH+0vZl51tmID8AUdW
         regrNvi+32mdZdCS0NtcL8gEIDXHwgr6UQP9EbXXatbTh4ZY6xlDSSiaZJtIuCdHdXrM
         LVrWwG9riTk0vhiQ4tAuYlSaB9R3yRj7IU0MI=
Received: by 10.204.154.6 with SMTP id m6mr6298640bkw.20.1322726753189; Thu,
 01 Dec 2011 00:05:53 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Thu, 1 Dec 2011 00:05:21 -0800 (PST)
In-Reply-To: <1322699263-14475-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186165>

On Thu, Dec 1, 2011 at 7:27 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> @@ -458,11 +459,15 @@ int cmd_add(int argc, const char **argv, const =
char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(seen);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 plug_bulk_checkin();
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_status |=3D add_files_to_cache(prefix=
, pathspec, flags);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (add_new_files)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_status |=3D=
 add_files(&dir, flags);
>
> + =C2=A0 =C2=A0 =C2=A0 unplug_bulk_checkin();
> +
> =C2=A0finish:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (active_cache_changed) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write_cach=
e(newfd, active_cache, active_nr) ||

Also do the same for git-commit, except as-is commit case, for
updating large files?

update-index should also learn about this, although at plumbing level,
maybe we could have an option to let users choose what to stream (i.e.
skip size check for streaming).
--=20
Duy
