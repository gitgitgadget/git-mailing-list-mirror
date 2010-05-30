From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/5] Add internationalization support to Git
Date: Sat, 29 May 2010 20:46:07 -0500
Message-ID: <20100530014607.GA27387@progeny.tock>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 03:50:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIXf1-0005jr-24
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 03:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0E3Bph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 21:45:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44386 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab0E3Bpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 21:45:36 -0400
Received: by gwaa12 with SMTP id a12so1929016gwa.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u3TLw3+HfGlThkn4H9oSkKhgqw1+pEYkcXmMJGb+nNE=;
        b=i1H3sx4/sBFyUKiSJUVZvJ7d8V8jNUwr7LrmsD6UggjFvm00NM2nymJa8e4xj+1hrD
         zSNsElBpkZfAigGpftL0rPxf9YLlYp+nRVUtVsS3TTaVvukiwq+5pd+b5OvxyS+pyz9/
         meFUVWL2W3Bt3oqkkapMeWDZq7MUHtP4YxYwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=E5az+Tq2f62tTt2pUN00rwV7rlTURB/BViq+I/Dj9E7qK7dypYpC9/yf5Qzi4wIsbU
         I+muOrYB78CJ67QqNiGOCdMatbnis1riJJHjspkQ3odUd/WX7a/2X4xllXKanyWc4ZgG
         xBNCacvqOeJZCp1l7agPgvinyKsj71L06Azzc=
Received: by 10.231.125.223 with SMTP id z31mr3168407ibr.78.1275183935166;
        Sat, 29 May 2010 18:45:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm18679061ibg.15.2010.05.29.18.45.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 18:45:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147981>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>     I made three strings in git-pull.sh translatable as a proof of
>     concept. One problem that I ran into is that xgettext(1) seems
>     very particular when picking up translation strings. It accepts
>     this:
>=20
>         gettext "hello world"; echo

Does =E2=80=98gettext -s "hello world"=E2=80=99 work, too?  (Just curio=
us.)

>     but not this:
[...]
>=20
>         gettext <<"END";
> hello world
> END
>=20
>     Maybe there's a way to make it play nice. But I just used a large
>     multiline string as a workaround.

Not so nice, but it seems that gettext expects a message id as
an argument (i.e., it will only replace echo and not cat).

>     I don't know what to do about
>     'die gettext' other than define a 'die_gettext' wrapper function
>     and use `xgettext --keyword=3Ddie_gettext'.

Sounds sensible.

> One thing I haven't done is to try to go ahead and make massive
> changes to the Git source code to make everything translatable.

I am vaguely worried about performance.  Suppose a function does

	for (i =3D 0; i < 1000000; i++)
		printf(_("Some interesting label: %s\n"), foo(i));

Will this compile to the equivalent of

	const char *s =3D _("Some interesting label: %s\n");
	for (i =3D 0; i < 1000000; i++)
		printf(s, foo(i));

Suppose someone decides to make that change by hand (maybe the
loop is too large for the compiler to notice the potential
winnings).  Then presumably gcc cannot be able to type-check the
format any more.  Is there some way around this that avoids
both speed regressions and loss of type-safety?

Apologies if this was already answered in the earlier discussion.

Thanks,
Jonathan
