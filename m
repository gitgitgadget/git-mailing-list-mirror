From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Fri, 09 Dec 2011 05:33:18 -0800 (PST)
Message-ID: <m34nx9j2fc.fsf@localhost.localdomain>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
	<1323349817-15737-4-git-send-email-artagnon@gmail.com>
	<20111208163946.GB2394@elie.hsd1.il.comcast.net>
	<CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
	<20111208170319.GD2394@elie.hsd1.il.comcast.net>
	<CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
	<20111208175913.GK2394@elie.hsd1.il.comcast.net>
	<CALkWK0nCuFgS8PKkQLMzqpBsOWouSs5y=CEKS1r0x0=LkhqC9A@mail.gmail.com>
	<7viplqhbgs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 14:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ0aN-0004ss-3X
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 14:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab1LINdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 08:33:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56197 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab1LINdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 08:33:22 -0500
Received: by eaak14 with SMTP id k14so1720737eaa.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 05:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=N8NT5AtozF45hps7hHdxdn2L6uGLjk+slqxmsIBZF3A=;
        b=E9swrdEh2WbS5CPSAoabAy1jWfnY4TAAFy9D+KlQiaoWqO85rsQxklPzA+rI8yw94V
         ohhZwwdqYIuFEUeYC/HhDJaSdifyjqEcahPIoZI2s0jsNuvvddoEQL5TvgpNI1TWMUlD
         kQ9jhJW/80n2O01yjA7lJV9pteAdxB2z9R8d8=
Received: by 10.213.20.79 with SMTP id e15mr1688336ebb.149.1323437600607;
        Fri, 09 Dec 2011 05:33:20 -0800 (PST)
Received: from localhost.localdomain (aehn28.neoplus.adsl.tpnet.pl. [79.186.195.28])
        by mx.google.com with ESMTPS id q28sm31164052eea.6.2011.12.09.05.33.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 05:33:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pB9DWfYa018931;
	Fri, 9 Dec 2011 14:32:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pB9DWeJI018928;
	Fri, 9 Dec 2011 14:32:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7viplqhbgs.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186632>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>=20
> > That being said, do you see value in lifting the restriction on
> > opts->long_name and PARSE_OPTS_NODASH not allowed together?  The
> > restriction seems quite arbitrary, but I can't justify lifting it
> > unless I can show some valid usecase.
>=20
> True and true.
>=20
> As to the first "true", it is because the nodash was introduced only =
to
> parse "find ... \( ... \)" style parentheses as if they are part of o=
ption
> sequence, and that use case only needed a single letter.
>=20
> As to the second "true", it is because so far we didn't need anything
> longer.
>=20
> I do not think the name of a subcommand is not a good use case exampl=
e for
> it, by the way. Unlike parentheses on the command line of "find" that=
 can
> come anywhere and there can be more than one, the subcommand must be =
the
> first thing on the command line and only one subcommand is given at o=
ne
> command invocation.

Well, I think it doesn't have to be true: there can be some options
like e.g. '-n' / '--dry-run' that are common to all subcommands, and
in my opinion they could come before subcommand name.

But if restriction that subcommand name must be first simplifies code,
then let's do it this way.


I agree that subcommands are and must be mutually exclusive --
otherwise they better be implemented as options, not subcommands.

--=20
Jakub Nar=EAbski
