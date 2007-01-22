From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 17:52:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
References: <17843.29798.866272.414435@lisa.zopyra.com> <ep00nl$mop$1@sea.gmane.org>
 <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org> <17843.55730.456139.247155@lisa.zopyra.com>
 <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org> <17844.5120.316805.794579@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 02:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8oMI-0004Zm-5C
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbXAVBw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbXAVBw1
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:52:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49449 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbXAVBw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:52:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M1qNhB010315
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 17:52:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M1qMPk014303;
	Sun, 21 Jan 2007 17:52:23 -0800
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17844.5120.316805.794579@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.66 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37382>



On Sun, 21 Jan 2007, Bill Lear wrote:
> 
> I applied the patches and I get failure.  I have appended the entire
> test case after my sig.  The last part reads:

Ok, that's different. It worked for me, several times. As far as I can 
tell, the biggest thing is just a difference in OS and the fact that I'm 
not running the git daemon from xinetd, but directly by hand as myself.

> % git push
> updating 'refs/heads/master'
>   from fee4efae4f3b98cce0fe85efc746291157fffbcd
>   to   e1179a3bf842ddcf4643740a396b46ce7ebd4ada
> Generating pack...
> Done counting 5 objects.
> Result has 3 objects.
> Deltifying 3 objects.
>  100% (3/3) done
> Writing 3 objects.
>  100% (3/3) done
> Total 3 (delta 0), reused 0 (delta 0)
> unpack unpacker exited with error code
> ng refs/heads/master n/a (unpacker error)

Umm. Your git daemon is probably running as "nobody", and simply doesn't 
have write permissions to the archive, does it?

> % cat /etc/xinet.d/git-daemon
> service git
> {
>         user            = nobody

iow, I think you simply need to make sure that git-daemon will have write 
permission to the thing. Either by making the whole repository writable by 
nobody, or by running git-daemon as the proper user.

		Linus
