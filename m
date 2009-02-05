From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fix crash in path.c on Windows
Date: Thu, 05 Feb 2009 18:13:27 +0100
Message-ID: <498B1E37.2020302@viscovery.net>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498A9C01.6020602@viscovery.net> <498B1862.5070703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7os-0006DH-Fh
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZBERNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 12:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZBERNj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:13:39 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55472 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbZBERNi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 12:13:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LV7n5-00078F-KE; Thu, 05 Feb 2009 18:13:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5245869F; Thu,  5 Feb 2009 18:13:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <498B1862.5070703@lsrfire.ath.cx>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108583>

Ren=E9 Scharfe schrieb:
> Johannes Sixt schrieb:
>> Bash translates leading single-letter path components to drive prefi=
x
>> notation if it invokes a non-MSYS program; and it also translates ':=
' to
>> ';' if the value looks like a path list. Sometimes there is an ambig=
uity
>> and bash guesses wrong.
>=20
> Sure, but what rules or heuristics does it follow?  Do we need to
> post-process the results or can we simply change the test case in t15=
04?

Mingw git assumes that it operates in a typical Windows environment -
drive-letter notation for absolute paths, and ';' separates paths in
PATH-like environment variables. If a test case breaks because bash
guesses wrongly, and does not transform the environment or command line
argument correctly, change the test case. (For example if /c:c was mean=
t
as a two paths, then change it to /foo:bar, perhaps bash gets this righ=
t.)

Everything else, I don't know. Audit how sensible the test case is, and
whether it addresses a likely real-world case. If we don't care, skip i=
t.

We try hard not to place Windows specific code outside of compat/.

> Is is_absolute_path() too forgiving on Windows, i.e. should it stop
> classifying paths starting with a slash as absolute on that platform?

No. /foo/bar is a valid "absolute" path Windows - even though it is
relative to the current drive. The point is that it is not relative to =
the
current directory.

-- Hannes
