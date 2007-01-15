From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Mon, 15 Jan 2007 17:57:12 +0100
Message-ID: <87bql0449j.fsf@morpheus.local>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net> <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 15 23:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6aGP-0006OJ-6z
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXAOWZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 Jan 2007 17:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAOWZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:25:09 -0500
Received: from main.gmane.org ([80.91.229.2]:34549 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbXAOWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:25:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H6aGE-0003fA-Bn
	for git@vger.kernel.org; Mon, 15 Jan 2007 23:25:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:25:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:25:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:Q7tU5X4dWJY3vDXBus3+dX9u/xg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36894>

Junio C Hamano <junkio@cox.net> writes:

> -static int add_rfc2047(char *buf, const char *line, int len)
> +static int add_rfc2047(char *buf, const char *line, int len,
> +		       const char *encoding)
>  {
>  	char *bp =3D buf;
>  	int i, needquote;
> -	static const char q_utf8[] =3D "=3D?utf-8?q?";
> +	char q_encoding[128];
> +	const char *q_encoding_fmt =3D "=3D?%s?q?";

This goes against the old principle of being forgiving in what you
accept, and strict in what you send.  The names of the encoding in the
headers should probably be normalized before putting them in an
e-mail.  I.e. we might accept "utf-8", "utf8", "UTF-8", and "UTF8"
(this depends on iconv, I suppose), but the RFC2047 encoding should be
the one blessed by RFC4027.  But I admit that I haven't read the RFC,
and I'm writing this offline so I can't check right now.

--=20
David K=C3=A5gedal
