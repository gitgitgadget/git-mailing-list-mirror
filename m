From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH WIP 0/4] Special code path for large blobs
Date: Tue, 2 Jun 2009 14:46:33 +1000
Message-ID: <fcaeb9bf0906012146t7eab8dafm2b2b58aa96fb6220@mail.gmail.com>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com> 
	<alpine.LFD.2.00.0905281349320.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 06:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBLuJ-00042H-HZ
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 06:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758953AbZFBEqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2009 00:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758051AbZFBEqw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 00:46:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:3910 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbZFBEqw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 00:46:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so4558251ywb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 21:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WQ4w2gLfNwDSVGG4ZeVvIcpD27GF/VEhyci1kEGcDGA=;
        b=ZSgkghsiCD9lpxOJCTB6xTzR08uHuKmuintM4LPNyoEIi+LkiU59e4Gxqmrzb+Eu4W
         DjIgZsb/DN86xgasXGMo0r1RL8ippb+cPL5KH2SOIuAkOrrwQEuyxrPEDyPDjGJFFDuJ
         kBgHosyDHYO9rcLU2DsMi+MYaeLaXLRars4jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qWxSxDnlIFnazROgb4SB5ohspeK9v5ycEQAbj+gSn72YLov46gk76pLBe6X7JNc87P
         3wRiKHxxsC4wa/j/aF8nRuOtChJhFjpMG25RXTAFxT6+LGOn6wtlV+BoTisrV5c9brq+
         MYa3ivy/0wwT/tKsf9tAaglmKA5DeW9rO9jlg=
Received: by 10.100.107.17 with SMTP id f17mr8322458anc.82.1243918013747; Mon, 
	01 Jun 2009 21:46:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0905281349320.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120494>

2009/5/29 Nicolas Pitre <nico@cam.org>:
> However, like I said previously, I'd encapsulate large blobs in a pac=
k
> right away instead of storing them as loose objects. =C2=A0The reason=
 is that
> you can effortlessly repack/fetch/push them afterwards by simply
> triggering the pack data reuse code path for them. =C2=A0Extracting l=
arge and
> undeltified blobs from a pack is just as easy as from a loose object.

Makes sense. And the code looks nice too.

> To accomplish that, you only need to copy write_pack_file() from
> builtin-pack-objects.c and strip it to the bone with only one object =
to
> write.

write_pack_file() is too scary to me, I ripped from fast-import.c
instead. BTW, how does git handle hundreds of single object packs? I
don't know if prepare_packed_git scales in such cases.
--=20
Duy
