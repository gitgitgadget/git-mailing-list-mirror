From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] t0050: Set core.ignorecase case to activate case
 insensitivity
Date: Sun, 11 May 2008 10:10:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805111005260.3330@woody.linux-foundation.org>
References: <1210522602-4724-1-git-send-email-prohaska@zib.de> <1210522602-4724-2-git-send-email-prohaska@zib.de> <1210522602-4724-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 11 19:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvF5G-0000VG-Rj
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbYEKRKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbYEKRKt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:10:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52254 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751245AbYEKRKs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 13:10:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BHAfYC025248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 May 2008 10:10:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BHAe2T015499;
	Sun, 11 May 2008 10:10:41 -0700
In-Reply-To: <1210522602-4724-3-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81797>



On Sun, 11 May 2008, Steffen Prohaska wrote:
>
> Case insensitive file handling is only active when
> core.ignorecase = true.  Hence, we need to set it to give the tests
> in t0050 a chance to succeed.  Setting core.ignorecase explicitly
> allows to test some aspects of case handling even on case sensitive file
> systems.

The patch series looks fine to me, but I just wanted to underline the use 
of that "*some*aspects*" part.

On a filesystem that is case sensitive, doing "core.ignorecase = true" 
doesn't magically make git act as if the filesystem was insensitive to 
case. In particular, since the filesystem very much can contain two 
different versions of a filename in different case, git will actually 
notice that, and notice that "CamelCase" and "camelcase" are not 
necessarily the same file.

To emulate case insensitivity on filesyststems that are actually 
sensitive, we could do some tests that do things like

	echo Hello > CamelCase
	ln CamelCase camelcase

and now git will see something that is *closer* to a real case-insensitive 
filesystem: two names that resolve to the same stat information.

It's still obviously not identical (because "readdir()" will get two 
entries), and as such a test that succeeds in a true case-insensitive 
environment will not necessarily work in the above fake kind of situation, 
but at least you can test some cases.

Renaming the same file to a case that is different is also a worthwhile 
thing to try to "emulate" case insensitivity.

			Linus
