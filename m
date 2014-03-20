From: Michael Andreen <harv@ruin.nu>
Subject: Re: [PATCH] Make XDF_NEED_MINIMAL default in blame.
Date: Thu, 20 Mar 2014 22:21:04 +0100
Message-ID: <3088608.Qolv0cJMME@river>
References: <6555655.XSJ9EnW4BY@mako> <xmqq8us4y4ym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 22:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkOp-0008Nt-7u
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759680AbaCTVVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:21:09 -0400
Received: from n.ruin.nu ([213.180.83.247]:58006 "EHLO n.ruin.nu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759424AbaCTVVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 17:21:07 -0400
Received: from river.localnet (h-40-196.a336.priv.bahnhof.se [79.136.40.196])
	by n.ruin.nu (Postfix) with ESMTPSA id 2D3D81DC183E;
	Thu, 20 Mar 2014 22:21:04 +0100 (CET)
User-Agent: KMail/4.11.5 (Linux/3.12.13-gentoo; KDE/4.11.5; x86_64; ; )
In-Reply-To: <xmqq8us4y4ym.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244586>

On Thursday, March 20, 2014 01:45:21 PM Junio C Hamano wrote:
> There hasn't been any argument for this patch, either.
> 
> It is not like we are still in year 2007; timing result in a small
> project like Git itself is not a good enough argument to change a
> well established default at this late in the game, especially when
> there are ways like command line options for users to specify their
> preferred settings.

The main reason why I submitted it is because the current behavior is very 
unintuitive when you split big files into smaller ones. Like the one that was 
done in 2cf565c.

If you do:

 $ git checkout 2cf565c
 $ git blame -C -C -C -M Documentation/git-ls-files.txt

then blame will not be able to detect any moves, even though big chunks have 
been moved without whitespace changes. Worse is that if you do

 $ git gui blame Documentation/git-ls-files.txt

then that won't see any movies either, and there is no way to make git gui 
blame use --minimal.

I spent a lot of time at $work trying to code-review a big split like this, 
wondering why "git gui blame" and "git blame -C -C -C -M" couldn't detect 
moves when complete functions had been moved with no changes (not even 
whitespace). So by making it default it will hopefully help someone else from 
losing time investigating this.

It wasn't until I did a bisect on git, finding 582aa00 and later googling for 
XDF_NEED_MINIMAL to find 059a500, that I found out about --minimal. Which is 
not documented anywhere.

I guess it can be argued for just documenting --minimal and either patching 
"git gui blame" to use it, or make it configurable. However I think the 
current default is really confusing, and the reason for changing it back in 
2007 was for performance, so that was what I tried to focus on, hopefully 
showing that there aren't any noticeable differences.

/Michael
