From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revisiting large binary files issue.
Date: Tue, 11 Jul 2006 10:09:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 19:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0LqQ-00046e-2p
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 19:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGKRQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 13:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWGKRQR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 13:16:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751126AbWGKRQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 13:16:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BH9nnW011846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 10:09:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BH9mWs029550;
	Tue, 11 Jul 2006 10:09:49 -0700
To: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060711145527.GA32468@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23716>



On Tue, 11 Jul 2006, Carl Baldwin wrote:
>
> I'd like to get my hands dirty and see for myself where the issue lies.
> I hope to have some time next week to devote to this.  Is it reasonable
> to hope for a solution that is at least a lot lighter weight than the
> current status quo?

Ok, I decided to see how nasty an object database change would be.

It doesn't look too bad. The following three patches implement what looks 
like a workable model.

NOTE NOTE NOTE! It makes the new "binary headers" the default, and that 
will mean that unless you have applied the first two patches, any 
repository that has had objects added with the new git version WILL NOT BE 
READABLE BY AN OLDER GIT VERSION!

So I think that the first two patches can be added to the main git branch 
pretty much immediately (after people have tested this all a _bit_ more, 
of course), because the first two patches just add the capability to 
_read_ a mixed-format repository.

The third patch is the one that actually starts _writing_ new-format repo. 
It should be applied with extreme care, although it can basically be 
de-fanged by setting the default initial value of the "use_binary_headers" 
to 0, which will make it not write the binary headers by default.

I have _not_ verified that the actual object format is identical to the 
pack-file one, but it should be. It's simple enough.

The three patches will be sent as replies to this email.

		Linus
