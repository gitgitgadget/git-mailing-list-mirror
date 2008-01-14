From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Don't display crlf warning twice
Date: Mon, 14 Jan 2008 09:40:36 +0300
Message-ID: <20080114064036.GX2963@dpotapov.dyndns.org>
References: <1200241847776-git-send-email-prohaska@zib.de> <1200267979-17683-1-git-send-email-dpotapov@gmail.com> <B4297A2E-9F8F-4167-AB48-10AC1FB4E1D5@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJ0o-0002WS-JL
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 07:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbYANGkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 01:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYANGkm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 01:40:42 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:50878 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbYANGkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 01:40:41 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id CD7851870186;
	Mon, 14 Jan 2008 09:40:39 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id 3B62C187030D;
	Mon, 14 Jan 2008 09:40:37 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEIzs-0006GY-Up; Mon, 14 Jan 2008 09:40:36 +0300
Content-Disposition: inline
In-Reply-To: <B4297A2E-9F8F-4167-AB48-10AC1FB4E1D5@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70441>

On Mon, Jan 14, 2008 at 07:17:26AM +0100, Steffen Prohaska wrote:
> 
> Your traces reveal that it is a racy condition that can trigger
> the double warnings.

It is not a racy condition. It is just another branch in the
code, which happens when an existing file is modified. Your
tests always added a new file, so they could not reproduce
the problem.

> 
> Do you have a test case that reliably triggers the second call to
> convert_to_git()?

===========================================
git config core.autocrlf input

echo Hello > foo
git add foo
git commit -m 'add foo'

echo Hello >> foo
unix2dos foo
# This should trigger double crlf warning
git add foo
===========================================

Dmitry
