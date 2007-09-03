From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix and simplify "split patch" detection
Date: Mon, 3 Sep 2007 11:47:32 +0200
Message-ID: <200709031147.32910.jnareb@gmail.com>
References: <200709022218.43042.jnareb@gmail.com> <7vmyw4ob7z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 12:52:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS9XH-0007Na-4l
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 12:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbXICKvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 06:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbXICKvx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 06:51:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7004 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbXICKvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 06:51:52 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1173352nfh
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 03:51:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VbLozvWCP6tq1TWvWPKxFAzlnJ8vOLuJRTDZ5ayiopPMUYxh1RDnRWDrpgaeIV13Xsahh/tz9HIHDel2oMNd3I7IjSskvcfXIMHB03wWtPK71jfuTwzeMirgxbFeobKHBnaEYWBevz5tRvgjYGjQoAWdqz67JlJtjCahDcu8QpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KMjE20VnzsSffLw41t5v24apUK/TiRB21AOO+mny9nBdWU+bWhoFJnsoA0mnnmGVVkhKlmKN6g+SJb4OScV2S+QTC8aqRz7s9Dg5E0hWQyVNrSj293tO/tfF9SsM+lBbCguzTImbiHQCWAEFCWEDeybSpqpOIPRWrh+gDMXtPZU=
Received: by 10.78.172.20 with SMTP id u20mr3117815hue.1188816710704;
        Mon, 03 Sep 2007 03:51:50 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p30sm1044865hub.2007.09.03.03.51.48
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Sep 2007 03:51:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmyw4ob7z.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57463>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Alternate solution, which we did chose, is to check when git splits
> > patches, and do not check if parsed info from current patch corresponds
> > to current or next raw diff format output line.  Git splits patches
> > only for 'T' (typechange) status filepair, and there always two patches
> > corresponding to one raw diff line.
> 
> Not that I can think of a better way offhand than what you
> already mentioned, but I have to say that I am not entirely
> happy with this implementation.

I'm also bit unhappy with tying git_patchset_body code to the
minute details of git-diff output.

>                                    A really old git showed two 
> patches (one creation and one deletion) for "complete rewrite",
> which was corrected long time ago.  I do not think we will
> change the typechange output in a similar way in the future, but
> relying on that level of detail feels somewhat ugly.

Gitweb requires git with --git-dir at least, so I don't think it
(it meaning "complete rewrite" patch being "split patch") is
a problem here.

> As you are reading from --patch-with-raw, you already know the
> order of patches that will be given to you when you finished
> reading the "raw" part.  The patches will come in the same
> order.  So it might be possible to keep track of patches to what
> path you are expecting and decide if it is part of what you are
> processing at the point you process "diff --git" line.

I'll try to come with the second solution.

I wonder if the post-image name is unique in raw format of diff
output, and can be used alone to check if there are two patches
per one raw output format line...

-- 
Jakub Narebski
Poland
