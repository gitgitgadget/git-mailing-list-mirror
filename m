From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Mon, 28 Nov 2011 01:20:41 +0100
Message-ID: <CAKD0UuwJoRkd7J06d2mFgyN0tO8p8ETPrwW5DqX12m+c_tQz4A@mail.gmail.com>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
 <m339d9mbiu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 01:21:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUoy7-0001AL-MO
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 01:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab1K1AVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 19:21:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47493 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab1K1AVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 19:21:03 -0500
Received: by wwp14 with SMTP id 14so7849572wwp.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9405diVgrg6P1ln87OoIcxiKzFiAAa4qxpAavK2cMj4=;
        b=eE7DbwBJiqh9qiOEYpGD3COisbeksE+JakdlFDWsJlDZZg3hvCli4DsvJ/asywsZlR
         WyW0KJdeTuyCW7zFjSnIupnWLgZn4/+fA6yc6eRUi/VBTor2RHVR8leOKM4/HG+Tff7m
         w2QEjsTioWQzxfpUcl/sClmZi/dNig/Y1vi4A=
Received: by 10.180.24.65 with SMTP id s1mr42588200wif.59.1322439662115; Sun,
 27 Nov 2011 16:21:02 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sun, 27 Nov 2011 16:20:41 -0800 (PST)
In-Reply-To: <m339d9mbiu.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185997>

2011/11/27 Jakub Narebski <jnareb@gmail.com>:
> J=C3=BCrgen Kreileder <jk@blackdown.de> writes:
>
>> when gitweb.perl (208a1cc3d3) is run with mod_perl2 (2.0.5-2ubuntu1 =
on
>> Ubuntu 11.10) custom error pages don't work: Any page with status !=3D
>> 200 shows the plain Apache error document instead of a gitweb's erro=
r
>> page.
>
> Thanks for reporting it. =C2=A0I wonder if it worked at all anytime..=
=2E
>
> Anyway, does the following patch fixes this issue for you?

Not really.  It does make the errors appear inline on the standard gitw=
eb pages.
But the HTTP status code is broken now: It's always 200 OK.


> Reported-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
> =C2=A0gitweb/gitweb.perl | =C2=A0 =C2=A05 +++++
> =C2=A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..f51cce1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1239,6 +1239,11 @@ sub run {
>
> =C2=A0run();
>
> +if ($ENV{'MOD_PERL'}) {
> + =C2=A0 =C2=A0 =C2=A0 # mod_perl needs to be told that error page wa=
s already created
> + =C2=A0 =C2=A0 =C2=A0 my $r =3D $cgi->r;
> + =C2=A0 =C2=A0 =C2=A0 $r->status(200);
> +}
> =C2=A0if (defined caller) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# wrapped in a subroutine processing reque=
sts,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# e.g. mod_perl with ModPerl::Registry, or=
 PSGI with Plack::App::WrapCGI
> --
> 1.7.6
>
>

J=C3=BCrgen
