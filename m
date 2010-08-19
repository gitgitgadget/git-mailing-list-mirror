From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 to deepen into
 full repo again
Date: Fri, 20 Aug 2010 08:11:45 +1000
Message-ID: <AANLkTinQZxpLdFiCFH3kDTFVQ-ZLjJ1PEdmmsJSb=0YD@mail.gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com>
	<1282214437-16384-3-git-send-email-pclouds@gmail.com>
	<m362z6pact.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, computerdruid <computerdruid@gmail.com>,
	joey <joey@kitenet.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 00:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmDKz-0006MZ-AO
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 00:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab0HSWLr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 18:11:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47307 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab0HSWLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 18:11:46 -0400
Received: by eyg5 with SMTP id 5so1723065eyg.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vqhdmt2wwMnt4IKJXlUK1T54ry3MTXtcDZ3SoOfPr7o=;
        b=fYeU7ngN5r6Ih3jWsO7Z5CnnubsNh6sVR7JQSbZ4bI/AfsPnmPo9Rmk4BMBBH1zxJ0
         mxj+X6fZAAadJQ8HMr6JNXAwEPS1QEX9iAtWW2upGLmbNx+ZIR4VS5Ijuq5BPm2lYzuj
         MzfaWb1elKhSgOtJWTStoNIIORFN+0dxcfk4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K9D9mi7KGe1vj0IbSeBJJxWP24YixRIB76PqL2q5NdMVMly+aNN7hQGQrQ4yUushp7
         BinQKL4zR0QCzT2P1mjOD9try6cK5DH+Cm/PnHG1noDMIi9eZvP2BtGKAIhU1eHUgu3G
         3CIzw2zz9gQp76dIfB8EedAtf3ic+uZIQWWmw=
Received: by 10.216.232.144 with SMTP id n16mr422598weq.1.1282255905207; Thu,
 19 Aug 2010 15:11:45 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Thu, 19 Aug 2010 15:11:45 -0700 (PDT)
In-Reply-To: <m362z6pact.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153962>

On Fri, Aug 20, 2010 at 7:22 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0The funny thing is, even with --depth=3D0, I still have two co=
mmit grafts
>> =C2=A0in $GIT_DIR/shallow, which are grafts of tags. I think there i=
s a bug
>> somewhere..
>>
>> =C2=A0builtin/fetch-pack.c | =C2=A0 =C2=A02 +-
>> =C2=A0shallow.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02 +-
>> =C2=A0upload-pack.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 ++++=
----
>> =C2=A03 files changed, 6 insertions(+), 6 deletions(-)
>>
>
> Fist, it lacks documentation update that --depth=3D0 means infinite
> depth (making repository not-shallow).

Yeah. I would do documentation and tests later once I figured out why
--depth=3D0 did not give me full repo. It turns out I need --tags to
(refetch?) tags and have full repo.

> Second, it would be nice (though probably not easy with parseopt, as
> it would require hacks/extensions) to be able to use --depth=3Dinf
> (like wget supports '-l inf') to mean infinite depth...

Hmm.. make --depth a string parameter and fetch-pack should parse the
parameter itself, like git-clone. Good idea.
--=20
Duy
