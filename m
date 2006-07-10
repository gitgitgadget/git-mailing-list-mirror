From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revisiting large binary files issue.
Date: Mon, 10 Jul 2006 16:28:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 01:34:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G05HE-0001eE-25
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWGJXex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWGJXex
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:34:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965042AbWGJXew (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 19:34:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6ANSSnW015671
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 16:28:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6ANSORi026304;
	Mon, 10 Jul 2006 16:28:26 -0700
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23668>



On Mon, 10 Jul 2006, Carl Baldwin wrote:
> 
> When I set the window to 0 I one more issue.  Even though the blobs are
> already compressed on disk I still seem to pay the penalty of inflating
> them into memory and then deflating them into the pack.  When the window
> size is 0 this is just wasted cycles.  With large binary files these
> wasted cycles slow down the push/fetch operation considerably.  Couldn't
> the compressed blobs be copied into the pack without first deflating
> them in this 0 window case?

The problem is that the individual object disk format isn't actually the 
same as the pack-file object format for one object. The header is 
different: a pack-file uses a very dense bit packing, while the individual 
object format is a bit less dense.

Sad, really, but it means that right now you can only re-use data that was 
already packed (when the format matches).

		Linus
