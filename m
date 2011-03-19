From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Fri, 18 Mar 2011 21:22:30 -0400
Message-ID: <AANLkTimH6ZKkTZ0MiJWzHpZywSy6Hk3caLQ5S+rE0uqg@mail.gmail.com>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu> <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org> <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org> <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org> <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
 <7vvczpff89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ksl-0002ZR-DH
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 02:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab1CSBXC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 21:23:02 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35764 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043Ab1CSBXB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 21:23:01 -0400
Received: by vws1 with SMTP id 1so4122501vws.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=PgT6DlHZG/juGe5IfGAc9xQIPZCWuJsJhskDwXb1GIA=;
        b=ShaoaWvmzK6h25H/QNNp4I9EEytljqRJUqzi1aBtM/yaX/kaEKJtpmRFwqEwPrcN+0
         BUlPqoojf5Kat5mUIhob495pd4/03JkK3tXD2w0QwcIT/M1C4lNZxLy/xJbjdpE2xHn5
         guIZoFoh9ulzVnb190mUI84IoAjYG8qe0TmS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ombL6IfuNoMVbsUXk9hEWjxyLtLkI/sYV4iJxE6vPwDfO6lryAnf49INs5A8zMUmQq
         hidPyiC0buoPU+mtKNqpQlIJRYVTFyHvS84t4+HpVv8rSypAFF1wbB0Gy3FzvlvFNB5A
         3E4y9EuTVy0nMmCGqRrU8Ag9unVe89PoYNK20=
Received: by 10.220.199.133 with SMTP id es5mr510984vcb.19.1300497780107; Fri,
 18 Mar 2011 18:23:00 -0700 (PDT)
Received: by 10.220.166.78 with HTTP; Fri, 18 Mar 2011 18:22:30 -0700 (PDT)
In-Reply-To: <7vvczpff89.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169382>

On Fri, Mar 11, 2011 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> +core.abbrevLength::
> + =C2=A0 =C2=A0 =C2=A0 Set the length object names are abbreviated to=
=2E =C2=A0If unspecified,
> + =C2=A0 =C2=A0 =C2=A0 many commands abbreviate to 7 hexdigits, which=
 may not be enough
> + =C2=A0 =C2=A0 =C2=A0 for abbreviated object names to stay unique fo=
r sufficiently long
> + =C2=A0 =C2=A0 =C2=A0 time.
> +

Isn't this the minimum length though? i.e. a longer length is used as
needed for uniqueness. If so, at least the description is misleading,
and I'd argue the option name too. Perhaps core.abbrevMinLength?

j.
