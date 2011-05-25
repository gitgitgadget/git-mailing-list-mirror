From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Tue, 24 May 2011 21:19:28 -0700
Message-ID: <20110525041926.GB21810@gmail.com>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
 <1306058229-93800-1-git-send-email-davvid@gmail.com>
 <BANLkTi=ssDA=y1CnMAZtvk6dTyMmd4LjrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 06:19:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP5ZM-0004WY-6y
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 06:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab1EYETf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 00:19:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39767 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1EYETe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 00:19:34 -0400
Received: by pwi15 with SMTP id 15so3289365pwi.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 21:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9r0mZmQdVTqEkmCHAj53b7xgPqZAKl26eTqGSyZiESI=;
        b=lPfYb37pAQnpD1e4kaoAtJwBOLTurLz7rKHRxX+rBad+a9t3PMT654knuRzs3O/eXe
         aUkWyHmMhCKJloc7psYV6FWHhRaMs/ZQ12+Dfo8W9LgUbyVMR9CopSE6QgEP7KYZiAig
         BEbIwb53Ig/7fKPmLbTPZE7wBEocfAVPF/Kjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RIL9mdFXSDTt2Raxu0yfiCK/5GlJBJX5QWFV2KBR0mlYY/UK2/8DygtFNonMue9XwA
         tDJgPFYob0NWwVhPAf4BvSPoZxB0QFQaGDDkhLjP4SraTIlYh2LHgtwWI0b5m08FPDpL
         zlvE6zvUGEh5J+6jjy+yXfTffe43gfEauzj5c=
Received: by 10.68.60.104 with SMTP id g8mr2917615pbr.47.1306297173930;
        Tue, 24 May 2011 21:19:33 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k3sm5426100pbc.0.2011.05.24.21.19.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 21:19:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=ssDA=y1CnMAZtvk6dTyMmd4LjrQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174371>

On Mon, May 23, 2011 at 02:09:40PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> On Sun, May 22, 2011 at 11:57, David Aguilar <davvid@gmail.com> wrote=
:
> > + =C2=A0 =C2=A0 =C2=A0 printf "#!/bin/sh\n" >diff &&
> > + =C2=A0 =C2=A0 =C2=A0 printf "printf \"\$GIT_PREFIX\"\n" >>diff &&
>=20
> If you're going to use /bin/sh (which might be a non-POSIX shell) it'=
s
> probably better to use echo than rely on printf understanding \n.

I'll reroll a v2 of these patches using echo instead of printf.
The mergetool--lib patch will make the test -z "$GIT_PREFIX"
check happen unconditionally as you suggested, Junio.

Another thought was that I could have implemented the
mergetool--lib patch without $GIT_PREFIX at all and just called
rev-parse --show-prefix explicitly.  The change has merits,
though, and I'll consider mergetool--lib not using rev-parse
as an optimization.  Afterall, fork+exec is expensive on
Windows so doing without an additional call is nicer for our
msysgit brothers.

Thank you both.
--=20
					David
