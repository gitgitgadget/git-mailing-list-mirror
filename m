From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Mon, 2 Jul 2007 14:16:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:16:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5TG8-0004Cw-0o
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbXGBVQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbXGBVQd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:16:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49235 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516AbXGBVQc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 17:16:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62LGMvW008368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 14:16:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62LGG9J007600;
	Mon, 2 Jul 2007 14:16:16 -0700
In-Reply-To: <20070702125450.28228edd.akpm@linux-foundation.org>
X-Spam-Status: No, hits=-2.642 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51407>



On Mon, 2 Jul 2007, Andrew Morton wrote:
> 
> James's current git-scsi-misc has this commit in it:
> 
> commit a16efc1cbf0a9e5ea9f99ae98fb774b60d05c35b
> Author: Kars de Jong <jongk@linux-m68k.org>
> Date:   Sun Jun 17 14:47:08 2007 +0200
> 
> [SCSI] 53c700: Amiga 4000T NCR53c710 SCSI
>     
>     New driver for the Amiga 4000T built-in NCR53c710 SCSI controller, using the
>     53c700 SCSI core.
>     
>     Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
> 
> 
> When one pulls that diff out of git with `git-show' or whatever, it doesn't
> work - patch(1) has a heart attack over the "53c700":

There's really nothing git can do about this, this is a patch oddity about 
the free-form message. A really strange one too, because the line is 
literally four spaces followed by the 53c700, and the thing is, that's not 
even a valid olf-fashioned patch (_without_ the four spaces, I could see 
that "patch" might think that it's a really old ed-

I think you have two options:

 - tell patch to take it as a unified diff:

	git show | patch -p1 -u

   should work, since patch won't be trying to figure out what kind of 
   diff it is, and won't think that the 53c700 is some kind of odd ed 
   script.

 - suppress the free-form messages, by using (for example)

	git show --pretty=oneline | patch -p1

   and now "patch" doesn't get any random commit message except for the 
   first line (which always starts with the SHA1) and hopefully cannot 
   _possibly_ interpret that to be some strange patch format.

Or, of course, just use "git-apply" instead of patch to apply the thing.

			Linus
