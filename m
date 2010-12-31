From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Fix expected values of setup tests on Windows
Date: Fri, 31 Dec 2010 17:11:06 +0100
Message-ID: <201012311711.06989.j6t@kdbg.org>
References: <201012302205.13728.j6t@kdbg.org> <AANLkTi=uCCfBFBpC=+V9RpaXRXiiPYp-tZXBxAVNB7+e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 17:11:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYhZk-0006V4-6Z
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 17:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab0LaQLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 11:11:11 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:65111 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751682Ab0LaQLK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 11:11:10 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4FE21130045;
	Fri, 31 Dec 2010 17:11:07 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2179B19F69E;
	Fri, 31 Dec 2010 17:11:07 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=uCCfBFBpC=+V9RpaXRXiiPYp-tZXBxAVNB7+e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164389>

On Freitag, 31. Dezember 2010, Nguyen Thai Ngoc Duy wrote:
> 2010/12/31 Johannes Sixt <j6t@kdbg.org>:
> > On Windows, bash stores absolute path names in shell variables in POSIX
> > format that begins with a slash, rather than in drive-letter format; such
> > a value is converted to the latter format when it is passed to a non-MSYS
> > program such as git.
>
> Hmm.. from test-lib.sh:
>
> TEST_DIRECTORY=$(pwd)
> test="trash directory.$(basename "$0" .sh)"
> TRASH_DIRECTORY="$TEST_DIRECTORY/$test"
>
> I'm just curious how these lines make $TRASH_DIRECTORY in POSIX format,
> while
>
> here=$(pwd)
>
> in your patch does not. Does bash auto convert value in
> TRASH_DIRECTORY="$TE..." line?

No. When this line is executed:

TEST_DIRECTORY=$(pwd)

$(pwd) still has its default behavior to return the POSIX style path. pwd is 
redefined to pwd -W only later.

I'm hesitant to redefine pwd earlier in test-lib.sh, though, because we would 
have to audit all uses of TEST_DIRECTORY for whether POSIX style paths or 
drive-letter paths are needed.

-- Hannes
