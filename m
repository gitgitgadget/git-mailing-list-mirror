From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix premature free of ref_lists while writing temporary
 refs to file
Date: Tue, 26 Feb 2008 18:07:36 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261752160.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802261358.33357.johan@herland.net> <200802261437.18950.johan@herland.net> <200802261635.51407.johan@herland.net> <alpine.LSU.1.00.0802261542080.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8uG-0000MK-8B
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 00:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761714AbYBZXHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 18:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924AbYBZXHj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 18:07:39 -0500
Received: from iabervon.org ([66.92.72.58]:34897 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbYBZXHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 18:07:38 -0500
Received: (qmail 734 invoked by uid 1000); 26 Feb 2008 23:07:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 23:07:36 -0000
In-Reply-To: <alpine.LSU.1.00.0802261542080.22527@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75189>

On Tue, 26 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 26 Feb 2008, Johan Herland wrote:
> 
> > We cannot call write_ref_sha1() from within a for_each_ref() callback, 
> > since it will free() the ref_list that the for_each_ref() is currently 
> > traversing.
> > 
> > Therefore rewrite setup_tmp_ref() to not call write_ref_sha1(), as 
> > already hinted at in a comment.
> 
> I guess the reason was to use a much of an API as possible.
> 
> If you already avoid that, why not write into .git/packed-refs directly?

Actually, it looks to me like the really right thing to do is tell 
for_each_ref() to also include these refs temporarily, and not actually 
write them to disk, read them back, and then delete them.

	-Daniel
*This .sig left intentionally blank*
