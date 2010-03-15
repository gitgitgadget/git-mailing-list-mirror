From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Mon, 15 Mar 2010 16:39:35 +0100
Message-ID: <36ca99e91003150839r3b159befr9086fa47eec61a8d@mail.gmail.com>
References: <cover.1268664693.git.grubba@grubba.org>
	 <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 16:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCON-0007KK-HL
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935123Ab0COPji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 11:39:38 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41328 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab0COPji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 11:39:38 -0400
Received: by bwz1 with SMTP id 1so3016883bwz.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lxX7LLKGDQE0lkHa8MRP6iA6s6Dg87vy2mPPcpM+V0Y=;
        b=WigGlwDqz6KjtdOynrzwzCVHaHTM1gEE0Q0fU+eRRHx4QyORGjtAk3gOSH39ak4vqY
         DO+RQjfo6t3rIrd85C1D/DsPFUFC+vf/SuaUj1lVZUXkP3NnKOHnD6d6wYTFln/KlB+Y
         9sJpzV/PfSTvdFFyLus+M2NYppuXCUc9nq7Eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RoerGAaNRETuApQUoIrvJbwK/C+sIOBI/jG39XkURbcoTG4w9C+/yfFAvSVJLyhsjk
         NMA7AvtpqToudplKaVV7WiByjFbQsauUqIRtNKT6G2alMvW6RTw9VYR1WgqdqHoljmH/
         KYLDKOW+lv2LHsxL2AKSGEyvrkAId+EArMLns=
Received: by 10.204.33.132 with SMTP id h4mr232681bkd.103.1268667576125; Mon, 
	15 Mar 2010 08:39:36 -0700 (PDT)
In-Reply-To: <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142216>

2010/3/15 Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>:
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 6cb8d60..a21a8d2 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -65,17 +65,21 @@ test_expect_success expanded_in_repo '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "\$Id:NoS=
paceAtFront \$"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "\$Id:NoS=
paceAtEitherEnd\$"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "\$Id: No=
TerminatingSymbol"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: Foreig=
n Commit With Spaces $"

Missing \ for second $.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: NoTerm=
inatingSymbolAtEOF"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} > expanded-keywords &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "File wit=
h expanded keywords"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: 4f2172=
3e7b15065df7de95bd46c8ba6fb1818f4c \$"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: 4f2172=
3e7b15065df7de95bd46c8ba6fb1818f4c \$"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: 4f2172=
3e7b15065df7de95bd46c8ba6fb1818f4c \$"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: 4f2172=
3e7b15065df7de95bd46c8ba6fb1818f4c \$"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: 4f2172=
3e7b15065df7de95bd46c8ba6fb1818f4c \$"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: 4f2172=
3e7b15065df7de95bd46c8ba6fb1818f4c \$"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "\$Id: No=
TerminatingSymbol"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: fd0478=
f5f1486f3d5177d4c3f6eb2765e8fc56b9 $"

Ditto.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\$Id: NoTerm=
inatingSymbolAtEOF"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} > expected-output &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add expanded-keywords &&
