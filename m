From: Yuri <yuri@rawbw.com>
Subject: 'git diff' command doesn't honor utf8 symbol boundaries, and doesn't
 use actual terminal width
Date: Fri, 24 Jan 2014 19:34:36 -0800
Message-ID: <52E330CC.10400@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 25 04:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6u15-0005f6-5l
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 04:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbaAYDeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 22:34:37 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:56349 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbaAYDeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 22:34:36 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0P3YaVf092624
	for <git@vger.kernel.org>; Fri, 24 Jan 2014 19:34:36 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241058>

The fragment of 'git diff' output looks like this:
- <translation>=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=B0=D0=B4=D1=80=
=D0=B5=D1=81 %1 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=B7=
=D0=B0=D0=BF=D1=80=D0=B5=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=D0=B8=
=D0=BC=D0=B2=D0=BE=D0=BB=D1=8B.=20
=D0=9F=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0, =D0=BF=D0=
=B5=D1=80=D0=B5=D0=BF=D1=80=D0=BE=EF=BF=BD
+ <translation>=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=B0=D0=B4=D1=80=
=D0=B5=D1=81 %1 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=B7=
=D0=B0=D0=BF=D1=80=D0=B5=D1=89=D1=91=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=D0=B8=
=D0=BC=D0=B2=D0=BE=D0=BB=D1=8B.=20
=D0=9F=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0, =D0=BF=D0=
=B5=D1=80=D0=B5=D0=BF=D1=80=D0=BE=EF=BF=BD

Two issues here:
1. Cyrilic text in utf8 got truncated not at utf8 boundary, causing thi=
s=20
garbage symbol in the end
2. Truncation is done at somewhat ~70% of the actual screen width. git=20
could go all the way to the whole screen with, but it didn't. Shrinking=
=20
terminal width causes the output truncation limit to shrink in the same=
=20
proportion. So some bad decision about truncation size is made somewher=
e=20
in 'git diff' command.

Suggested behavior:
1. git should respect utf8, and in case of truncation it should add =E2=
=80=A6=20
symbol.
2. truncation algorithm should read current terminal width and truncate=
=20
at width-1 length to allow for the above-mentioned symbol

Yuri
