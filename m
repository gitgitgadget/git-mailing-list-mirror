From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Fri, 29 Aug 2008 12:17:02 +0200
Message-ID: <87tzd4p1lt.fsf@mid.deneb.enyo.de>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de>
	<20080829082311.GA7128@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 12:18:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ13U-0003zF-2C
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 12:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYH2KRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 06:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYH2KRG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 06:17:06 -0400
Received: from mail.enyo.de ([212.9.189.167]:52291 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbYH2KRG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 06:17:06 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KZ12M-0007Sx-Em; Fri, 29 Aug 2008 12:17:02 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KZ12M-0003Xb-2d; Fri, 29 Aug 2008 12:17:02 +0200
In-Reply-To: <20080829082311.GA7128@yp-box.dyndns.org> (Eric Wong's message of
	"Fri, 29 Aug 2008 01:23:11 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Eric Wong:

> Florian Weimer <fw@deneb.enyo.de> wrote:
>> Looking at my network traffic and the Perl code, it seems to me that
>> git-svn fails to create a diff (delta) before sending data to the
>> server.  As a result, a few changes in a multi-megabyte file lead to a
>> large upload (similar to the situation with CVS).  git-svn should be
>> able to compute this diff in all cases because it has got an up-to-date
>> copy of the current revision in the Subversion repository.
>> 
>> As far as I can tell, this can't be fixed with a one-liner; some handles
>> need to be passed down to the code that actually handles the upload.
>
> Odd.  Can you verify that svn(1) does not send full files in this case,
> too?

These two are pcap files of single-line edits to the same file:

-rw-r--r-- 1 root root 1.3M 2008-08-29 11:54 /tmp/git
-rw-r--r-- 1 root root  40K 2008-08-29 11:53 /tmp/svn

> It's been too long since I've looked at the SVN TxDelta API, but I
> thought SVN::TxDelta::apply would take care of the delta computation for
> us...

SVN::Git::Editor::M does not seem to make use of the base text.
