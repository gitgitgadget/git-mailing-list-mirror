From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Sat, 1 Dec 2007 04:17:02 -0500
Message-ID: <BFDB9A00-6E92-4880-9FE7-3D0E392D18A9@mit.edu>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu> <7v3aup291c.fsf@gitster.siamese.dyndns.org> <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu> <7vmysv87jm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 10:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyOTZ-0003Yq-19
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 10:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbXLAJRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 04:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbXLAJRI
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 04:17:08 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:42678 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbXLAJRG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 04:17:06 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lB19H4qj004495;
	Sat, 1 Dec 2007 04:17:04 -0500 (EST)
Received: from [18.239.5.240] (MACGREGOR-TWO-FORTY.MIT.EDU [18.239.5.240])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lB19H3gh021612
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 1 Dec 2007 04:17:03 -0500 (EST)
In-Reply-To: <7vmysv87jm.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66707>


On 30 Nov 2007, at 9:37:01 PM, Junio C Hamano wrote:

> I'll queue your patch, but I think it should be enhanced to support
> post-update for consistency.

I'll send another patch that includes support for post-update.

> I'll queue your patch,

Will the old patch already be in place?

Also, I explicitly decided to pipe input into post-receive
by hand rather than relying on a system() call that someone
might exploit maliciously.

Unfortunately, it turns out that open() with a pipe essentially
invokes system(); the solution is to fork a child process and
then to turn the child into the process with which communication
is desired via a call to exec().

Because the rest of git-cvsserver.perl uses explicit system()
calls, I have been wondering if I am being overly cautious.
