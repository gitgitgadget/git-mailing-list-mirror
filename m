From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 09:56:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608040953260.5167@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> 
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> 
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>  <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
  <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> 
 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> 
 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
 <44D36F64.5040404@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 04 18:56:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G92y6-0004Tb-Fs
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWHDQ4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161300AbWHDQ4L
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:56:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161299AbWHDQ4K (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 12:56:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k74Gu6nW029986
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Aug 2006 09:56:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k74Gu5Wg007326;
	Fri, 4 Aug 2006 09:56:05 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44D36F64.5040404@gmail.com>
X-Spam-Status: No, hits=-0.451 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24809>



On Fri, 4 Aug 2006, A Large Angry SCM wrote:
> 
> Why don't you just write the pack file directly? Pack files without deltas
> have a very simple structure, and git-index-pack will create a pack index file
> for the pack file you give it.

Pack-files without deltas are really huge. You really really don't want to 
do this for some medium-large file that has several thousand revisions.

The reason you want to generate the deltas early is that then, once you've 
generated all the simple and obvious deltas (and within each *,v file from 
CVS, they are all simple and obvious), doing a "git repack -a -d" will be 
able to re-use the deltas you found, making it a much cheaper operation.

NOTE! For that "git repack -a -d" to work, you'd obviously only do it at 
the very end, when you've tied together all the blobs with trees and 
commits (since "git repack" wants to follow the reachability chain).

		Linus
