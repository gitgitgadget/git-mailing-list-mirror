From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t0050-filesystem.sh unicode tests borked on dash shell
Date: Tue, 21 Dec 2010 21:29:38 +0100
Message-ID: <201012212129.39141.trast@student.ethz.ch>
References: <4D1105B5.5070703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <prohaska@zib.de>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 21 21:29:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8qC-0001KK-8m
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 21:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab0LUU3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 15:29:43 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:31939 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab0LUU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 15:29:42 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 21 Dec
 2010 21:29:34 +0100
Received: from pctrast.inf.ethz.ch (213.55.131.181) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 21 Dec
 2010 21:29:40 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <4D1105B5.5070703@ramsay1.demon.co.uk>
X-Originating-IP: [213.55.131.181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164055>

Ramsay Jones wrote:
>     $ ls trash\ directory.t0050-filesystem/unicode/
>     \x61\xcc\x88

The printf at the top evidently does not interpolate \xAA sequences.
Since my 'man 1p printf' POSIX manpage only mandates \AAA octal
sequences, maybe we should use that instead.  Can you verify that the
patch below works for you?

Judging from

  git grep '\\x[0-9a-f][0-9a-f]' t

this is the only instance of this problem, the rest are in Perl code.

--- 8< ---
Subject: t0050: replace \xAA by \AAA in printf

POSIX does not mandate the hex escape sequences, and thus dash's
built-in printf does not expand them.  Use octal escapes instead.

diff --git c/t/t0050-filesystem.sh i/t/t0050-filesystem.sh
index 057c97c..87bf1ff 100755
--- c/t/t0050-filesystem.sh
+++ i/t/t0050-filesystem.sh
@@ -4,8 +4,8 @@ test_description='Various filesystem issues'
 
 . ./test-lib.sh
 
-auml=`printf '\xc3\xa4'`
-aumlcdiar=`printf '\x61\xcc\x88'`
+auml=`printf '\303\244'`
+aumlcdiar=`printf '\141\314\210'`
 
 case_insensitive=
 unibad=

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
