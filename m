From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH 2/2] blame: honor core.abbrev
Date: Sat, 02 Apr 2011 10:37:08 +0900
Message-ID: <1301708228.1507.34.camel@leonhard>
References: <1301622896-5836-1-git-send-email-namhyung@gmail.com>
	 <1301622896-5836-2-git-send-email-namhyung@gmail.com>
	 <7vbp0pegmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 03:37:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5pmG-0005Xq-Oj
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 03:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab1DBBhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 21:37:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45921 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1DBBhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 21:37:14 -0400
Received: by iwn34 with SMTP id 34so4052673iwn.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=18wM8tokeBoGTijWl1XMUTEpybxJpY8H14KIJP+EwHk=;
        b=ktM7VdwWvU7YhnAypr0ng/rqyVPE5Vzuwp8mAmLftKPgiwQwWxphcpM+4Vw1p8hhru
         vBIIJFyGbvMcFssQBQshzL5fjUd/YNGyXX6WiPsKm/05IU5XBvrqj+mcsjO0YsM7QpFf
         MP4/qWLu23OC4nXY678ZlXCVnZ8KS5vl2ZNJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=UMXa+Z8M+yfP3oJCwdsIk0iAAqcJ8loOLYZEoUE/UQvxR/WaJtKFRLLXneXNNdwRoa
         COFrkx8Wqh9dRR3hNc/+BNvKYUHD43Dk2spQIDQUfjeFgSBfN0lMsZ/jj+57YOcFPkx3
         utYrKv3urZFvGNfizMBHsFtFl97r86A5RKhZc=
Received: by 10.43.69.197 with SMTP id yd5mr3358408icb.362.1301708234259;
        Fri, 01 Apr 2011 18:37:14 -0700 (PDT)
Received: from [118.176.76.239] ([118.176.76.239])
        by mx.google.com with ESMTPS id i20sm1818862iby.48.2011.04.01.18.37.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 18:37:13 -0700 (PDT)
In-Reply-To: <7vbp0pegmb.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170637>

Hello, Junio-san.

2011-04-01 (=EA=B8=88), 15:44 -0700, Junio C Hamano:
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > If user sets config.abbrev option, use it as if --abbrev was given.
> > We can't set abbrev to default_abbrev unconditionally IMHO, because
> > historically default abbrev length of the blame command is 8 and
> > DEFAULT_ABBREV is 7.
>=20
> Isn't the one-letter difference because we sometimes need to show the
> boundary commit with a caret at the beginning?
>=20

Yeah, I guessed so.


> I think the way this patch initializes orig_abbrev using DEFAULT_ABBR=
EV is
> wrong (at that point, I don't think you have called git_config() to g=
et
> the user config for DEFAULT_ABBREV).
>=20

My intention was that I want to check whether the user sets the option
or not and apply the value only if it is set (ig. different from "7").
Please see below.


> See the patch to describe.c in dce9648 (Make the default abbrev lengt=
h
> configurable, 2010-10-28) for the right way to do this.
>=20
>  - initialize the variable to -1;
>  - call git_config() to get correct value in DEFAULT_ABBREV;
>  - call parse_options() to potentially update the variable; then
>  - if variable is still -1, assign DEFAULT_ABBREV to it.
>=20
> After all that, add 1 to it to account for the possible boundary care=
t.
>=20

I saw the patch already, and, yes, it would be a simple and probably th=
e
right way to do. But it could give a bit of confusion to the users IMHO=
=2E
Say, A user specify --abbbrev=3D10 then he/she might expect 10 hexdigit=
s
in the output but actually [s]he will get 11.

So I decided to use the number as is, not adding 1. And this would be a
constant behavior from the patch 1/2 and all other git command which us=
e
--abbrev option, I guess. But I kept to use 8 in case the user doesn't
give the config or command-line option, just for backward compatibility=
=2E

I'm not sure this is really a concern. Maybe we can give them 11 as you
said and document the behavior in the manual page.

Thanks.


--=20
Regards,
Namhyung Kim
