From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use strncpy to protect from buffer overruns.
Date: Wed, 9 Jun 2010 14:44:51 +0200
Message-ID: <AANLkTikID-cEqdDD8XEEYmClSYEkcxdAU-rjYA2LoRVe@mail.gmail.com>
References: <1276078921-25429-1-git-send-email-smichalske@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 14:45:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMKeR-0002Fx-Ja
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab0FIMoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 08:44:54 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:37362 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0FIMox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 08:44:53 -0400
Received: by ywh42 with SMTP id 42so5318291ywh.15
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bijHiTKnKWLqbpvddL8J7Oho3wZyoeDpuESGc1TP0Mc=;
        b=rknJAuj5glO/tVdwtq4QoTn8OezExvuM3jrFKaAn5nUUSxwKgJ0AIPRDh8Pr17OdbT
         m5JCmO7WRS5yft0cbPk25bLneXz4OU4+dIx9dqud9/SkSDSHHjYvdUsQtTYUzSf1Dfre
         1uF/Anhp8RmsoCdMUasqI6YWT8wyfBQ7L+s8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k7yQUgwDo9KOmeFb2WihWqbaFbf1hFjTBOeAhKuComjcSnj3ONFyeIAkgHdJOBKf2u
         Kie87aKKynWvAam6gtZmfeg5SkmIZ5DKhC25HDLLaoXZb9qPDreJZPUeY04ToI1Ko7z0
         Kw797CTGTLRhifX7wpvJ4gBazPwN6BVM3lKVk=
Received: by 10.101.173.28 with SMTP id a28mr17864570anp.229.1276087491482; 
	Wed, 09 Jun 2010 05:44:51 -0700 (PDT)
Received: by 10.100.229.5 with HTTP; Wed, 9 Jun 2010 05:44:51 -0700 (PDT)
In-Reply-To: <1276078921-25429-1-git-send-email-smichalske@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148764>

On Wed, Jun 9, 2010 at 12:22, Steven Michalske <smichalske@gmail.com> w=
rote:
> is_git_directory() uses strcpy with pointer arithmitic, protect it fr=
om
> overflowing. =C2=A0Even though we currently protect higher up when we=
 have the
> environment variable path passed in, we should protect the calls here=
=2E

Why? The function is static.

> - =C2=A0 =C2=A0 =C2=A0 strcpy(path, suspect);
> + =C2=A0 =C2=A0 =C2=A0 path[sizeof(path) - 1] =3D '\0';
> +
> + =C2=A0 =C2=A0 =C2=A0 strncpy(path, suspect, sizeof(path) - 1);

And we have strlcpy for such things.
