From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] log: Do not decorate replacements with --no-replace-objects
Date: Thu, 25 Aug 2011 20:55:56 +0700
Message-ID: <CACsJy8BOhU7-aTN2TPRRoQ=_mSfbOstXFRfpyoPmrr_Gbqg0pg@mail.gmail.com>
References: <ad41e81daa6f9fc4654ae4c312f293202519a5d0.1314279822.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 15:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwaQ5-0005er-2K
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 15:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab1HYN42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 09:56:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54037 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab1HYN41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 09:56:27 -0400
Received: by bke11 with SMTP id 11so1747683bke.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=P1EhwK5wUZJl7ahlPpptsnowxe1UlOqZQC0YliAkNx8=;
        b=XsMzN1jihy9pHw5yHFf2NclwzR3YWRemPhS8PCjjFs+Qz7VM4n2FBy/6UFasF2t53K
         72eKupcY2NmoN34XX8eV9tWng4etJF3AexxNB84SFi7qFDHbweIES3wW4ZC1xWP9fXfe
         2QiYGtiQVPLYLkWGA64Jxq/KjVMEVt5Bd7hdQ=
Received: by 10.204.132.23 with SMTP id z23mr3050754bks.383.1314280586102;
 Thu, 25 Aug 2011 06:56:26 -0700 (PDT)
Received: by 10.204.156.24 with HTTP; Thu, 25 Aug 2011 06:55:56 -0700 (PDT)
In-Reply-To: <ad41e81daa6f9fc4654ae4c312f293202519a5d0.1314279822.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180079>

2011/8/25 Michael J Gruber <git@drmicha.warpmail.net>:
> Make it so that additionally the use of --no-replace-objects is
> detected: I.e. replaced commits are only decorated as replaced when t=
hey
> are actually replaced.

Yeah.. I forgot about this.

> @@ -95,7 +95,7 @@ static int add_ref_decoration(const char *refname, =
const unsigned char *sha1, in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct object *obj;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum decoration_type type =3D DECORATION_N=
ONE;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(refname, "refs/replace/")) {
> + =C2=A0 =C2=A0 =C2=A0 if (read_replace_refs && !prefixcmp(refname, "=
refs/replace/")) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char =
original_sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_sha1_h=
ex(refname + 13, original_sha1)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0warning("invalid replace ref %s", refname);

You should put "if (!read_replace_refs) return 0;" inside "if
(!prefixcmp..", otherwise it'll come to the ref decoration code below
and my second paragraph in 5267d29's commit message will be reverted.

I thought my patch was
 - simple
 - replace is rarely used
therefore neglected the tests. Perhaps you can also add a few tests
here. It's not that simple after all.
--=20
Duy
