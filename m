From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 21:33:43 +0000
Message-ID: <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 28 23:33:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpT26-0004vi-Id
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 23:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0H1Vdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 17:33:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab0H1Vdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 17:33:44 -0400
Received: by iwn5 with SMTP id 5so3658031iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=woT30eiuaszdgwKfWfk0m0b/CfjU+qkPKVhAm4Pu9pM=;
        b=Tc+0PdCNHSmS6tET6OKma/+ycQ2VkhefDojVPtyFbuObGaraKX+so4hYrLcHc9jueB
         63k9Hj0oCRSWSljZ95zHDhiyRBEE0KoAl98mNxJw9QexBjwu64DviQwKE6Up4bGS03zz
         LZNAB9OmIuZ5ZTFSLrsjPkyVeLdJPY2oSkKZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q4+6nSxS4D99OTiAVC/n/Q8vJS6jRDktiSIrMxKcBloOhpSHps3Yqx/XZHv08GVCfw
         yZDx3JJjrVpa4XzILcV5uICGNLX9SdrLjQkqzmGVMyYQhhamJQ6+SD3k9RG9QS20qI6E
         H2MR6josUuYgaRpgXuu1SPLdC6rXK6oUug1lo=
Received: by 10.231.153.76 with SMTP id j12mr3005426ibw.66.1283031223445; Sat,
 28 Aug 2010 14:33:43 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 28 Aug 2010 14:33:43 -0700 (PDT)
In-Reply-To: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154658>

On Sat, Aug 28, 2010 at 21:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> I'm having an odd encoding issue with gettext on my
> gettextize-git-mainporcelain branch that hadn't been turned up before
> because none of the existing messages used non-ASCII translations.

Well, this is fun. It turns out that reverting 107880a makes it work,
i.e. you need to set LC_CTYPE since reading *.mo files in a
locale-awere manner involved character classification.

But as 107880a explains doing so broke other parts of Git.

I'll have to think about how to solve that, one way obviously would be
to fix up our vsnprintf() invocation, but there may be others like it
that I haven't spotted.
