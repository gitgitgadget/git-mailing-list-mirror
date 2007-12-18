From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
Date: Tue, 18 Dec 2007 01:12:51 +0100
Message-ID: <200712180112.52094.jnareb@gmail.com>
References: <200712151534.50951.jnareb@gmail.com> <200712151536.33296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 01:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Q5L-0003ey-DZ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933660AbXLRANA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 19:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756589AbXLRANA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:13:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:38130 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbXLRAM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:12:59 -0500
Received: by fg-out-1718.google.com with SMTP id e21so327074fga.17
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 16:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9ni3nExIt+5a4KWXyhxt7cAs0fqwHia5vsF9M0NvNO8=;
        b=FIWsQn89JNSQ1fRh2IvK2oh2jxCWOwLpDCNTq0cUcfb5IYBfAyJRWUZ7N5UW5BTKyDeHpfjbx+sENKhW4v3CbIYhb4qqRogVl27IUfBwwnPRJv29yBir80e4dM9+DpJpeO9jxRDXRcdXfxlPnM96/y8f6qZ9dsugbt8Vwz1e9vM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iW7xD4oCNCG1Qhhf7WBObzdm/pC/F5igSLk38I8e+bgXX/nyp+fyVJx7AxjrdcqKqJasLYWrN1XqH71LgdG6+JTYr871AQf5bctlzzbBwe6e0Eacjbv2i87zKZ5f/IjFPs175MMclGTZ4ucltzB1TU2f6apLM/jYb73luM3wmz4=
Received: by 10.86.100.7 with SMTP id x7mr7003874fgb.42.1197936777313;
        Mon, 17 Dec 2007 16:12:57 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.196.52])
        by mx.google.com with ESMTPS id y34sm16464432iky.2007.12.17.16.12.55
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Dec 2007 16:12:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712151536.33296.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68669>

On Sat, 15 Dec 2007, Jakub Narebski wrote:

> This is important for the list of clone urls, where if there are
> no per-repository clone URL configured, the default base URLs
> are never used for URL construction without this patch.
>=20
> Add tests for different ways of setting project URLs, just in case.
> Note that those tests in current form wouldn't detect breakage fixed
> by this patch, as it only checks for errors and not for expected
> output.

The patch applied to master bc8b95ae4a4b21753e84bbfd28cbcbf1b3f6e0a8
does have above paragraph in commit message, but DOES NOT have the
tests itself.
=20
> I have added tests _then_ I have realized that in current form they
> cannot detect regression corrected by this patch. So if you want, you
> can not apply changes to test (and remove paragraph about test from
> commit message).

See above...

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 24b3158..a746a85 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1511,7 +1511,7 @@ sub config_to_int {
> =C2=A0sub config_to_multi {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $val =3D shift;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 return ref($val) ? $val : [ $val ];
> + =C2=A0 =C2=A0 =C2=A0 return ref($val) ? $val : (defined($val) ? [ $=
val ] : []);
> =C2=A0}

And somehow (I don't know how[*1*]) patch got whitespace corrupted,
and now the line is indented with spaces, instead of with tab.

[*1*] Other patches are fine.
--=20
Jakub Narebski
Poland
