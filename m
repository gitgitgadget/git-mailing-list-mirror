From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] read-cache: new extension to mark what file is watched
Date: Tue, 14 Jan 2014 08:39:31 +0700
Message-ID: <CACsJy8C9uWkbeHNeTp6WBaj2dh98hXe6q3_V_Ys067jAn1QFbQ@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com> <1389524622-6702-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 02:40:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2szJ-0005Qm-7X
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 02:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaANBkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 20:40:07 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:49683 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaANBkC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 20:40:02 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so4920593qcx.35
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 17:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kBTfRK9bcfondVvYUsefBCsViddXSLeau0WXdlF1ri8=;
        b=Hc71q0Vs794up2QNRDSTy6jk6h5i0Lb4TnllWFPYtBdQTFX3Ye3qwU6i39aJ64eDU3
         AsR1xrWM9x/dFsAbuxdj+9xUiAMTlm2aVHEmetwK12w1mGZPeCMv7CVadYheKMgx8B0h
         jIFZOnMwAZacAgYMVzdbEWUjZrsdB9u+MTMBJY3/W2RndVozRSF+iIYDIYIV5twyreDO
         EhyKXqbC63aIA++nIIEXXctJzyiGbBmsiFQE6MNScu6KJj+RUZRUuEmGdPoAy3pVhlHF
         OeBpNM6mxNDte2IvHo7mac/ZbcrtWHrpAQzem44hOKyfL0NmSx0ZwL0DP8uVYqpDAe+d
         556g==
X-Received: by 10.224.165.12 with SMTP id g12mr44580516qay.89.1389663601453;
 Mon, 13 Jan 2014 17:40:01 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 13 Jan 2014 17:39:31 -0800 (PST)
In-Reply-To: <1389524622-6702-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240385>

On Sun, Jan 12, 2014 at 6:03 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> We are running out of on-disk ce_flags,

Correction, we're not. I saw

/*
 * Extended on-disk flags
 */
#define CE_INTENT_TO_ADD     (1 << 29)
#define CE_SKIP_WORKTREE     (1 << 30)

followed by

/* CE_EXTENDED2 is for future extension */
#define CE_EXTENDED2         (1 << 31)

and panicked, but on-disk flags could be added backward (e.g. bit 28,
27...). Anyway using extended flags means 2 extra bytes per entry for
almost every entry in this case (and for index v5 it means redoing
crc32 for almost every entry too when the bit is updated) so it may
still be a good idea to keep the new flag separate.

> so instead of extending
> on-disk entry format again, "watched" flags are in-core only and
> stored as extension instead.
--=20
Duy
