From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 6 Jan 2013 01:57:57 -0800
Message-ID: <20130106095757.GC10956@elie.Belkin>
References: <2491041.bQ51Qu8HcA@thunderbird>
 <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black>
 <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin>
 <50E946EB.1000709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Eric Blake <eblake@redhat.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trmzp-0003kb-DX
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 10:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab3AFJ6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 04:58:05 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49862 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab3AFJ6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 04:58:04 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so10082403pad.8
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=woTHsTtK79TaKy/codwKJRCMPcbnpTHuBthzuSOGT2s=;
        b=RL0JtoO+UhudlyUYHeqi1WFWBtjZv3xCQXiyGQzdeOrF7XOnsyUhYLOHRaiVadWXby
         WY1GSU+q8G/vWpqENW+BKFB08AmV57EQ+jA11V25JCCwzRxrj0Ygzj9SUPfE9srRiTA4
         H35IVDhDUvERoeDsc8xzupoeYT/eTy9hjblkxnIVq+PMNyL026CKmC6zwgBg6esiQic8
         8mmScjwDAlMnKYn+iIA/UcC001mm3SWjr8gJ8WwooZgoXM3mnWpmtF5WGCmLt+ImCmqQ
         cLkkMJvZVtdwNw09JpPgHK9L+gktSWHpk1ZspTDHmduisMPwHvow7NlKFNiZFUG0p61I
         cnfw==
X-Received: by 10.68.137.131 with SMTP id qi3mr176633937pbb.114.1357466283006;
        Sun, 06 Jan 2013 01:58:03 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id wh8sm35553973pbc.75.2013.01.06.01.58.00
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 01:58:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E946EB.1000709@web.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212791>

Torsten B=C3=B6gershausen wrote:

> The short version:
> Cygwin versions  1.7.1 up to 1.7.16 use the same header files as cygw=
in 1.5
[...]
> I don't know if we want to improve the Makefile to enable=20
> CYGWIN_V15_WIN32API =3D YesPlease=20
> for cygwin versions 1.7.1 .. 1.7.16 (which are outdated)

Confusing.  Sounds like the condition in 380a4d92 (Update cygwin.c for
new mingw-64 win32 api headers, 2012-11-11) was too strict and the
Makefile should say something like

	# Cygwin versions up to 1.7.16 used the same headers
	# as Cygwin 1.5.
	ifeq ($(shell expr "$(uname_R)" : '1\.7\.[0-9]$$'),5)
		CYGWIN_V15_WIN32API =3D YesPlease
	endif
	ifeq ($(shell expr "$(uname_R)" : '1\.7\.1[0-6]$$'),6)
		CYGWIN_V15_WIN32API =3D YesPlease
	endif

	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
		CYGWIN_V15_WIN32API =3D YesPlease
		...
	endif

Is that right?
