From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
	memory hog
Date: Sat, 23 Jul 2011 22:04:11 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110723180411.GA16463@tugrik.mns.mnsspb.ru>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru> <20110722170001.GB20700@sigill.intra.peff.net> <7vipquz0d0.fsf@alter.siamese.dyndns.org> <20110722173601.GA9422@sigill.intra.peff.net> <7vaac6ysd2.fsf@alter.siamese.dyndns.org> <20110722203614.GA13232@sigill.intra.peff.net> <7vk4baxas5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 20:05:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkgZp-0006RV-Mv
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 20:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab1GWSFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 14:05:21 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:34506 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab1GWSFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 14:05:20 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1QkgZh-0005pn-2E; Sat, 23 Jul 2011 22:05:17 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1QkgYd-0004Hp-WD; Sat, 23 Jul 2011 22:04:11 +0400
Content-Disposition: inline
In-Reply-To: <7vk4baxas5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177699>

On Fri, Jul 22, 2011 at 02:31:22PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > How about:
> >
> > -- >8 --
> > Subject: [PATCH] streaming: free git_istream upon closing
> >
> > Kirill Smelkov noticed that post-1.7.6 "git checkout"
> > started leaking tons of memory. The streaming_write_entry
> > function properly calls close_istream(), but that function
> > did not actually free() the allocated git_istream struct.
> >
> > The git_istream struct is totally opaque to calling code,
> > and must be heap-allocated by open_istream. Therefore it's
> > not appropriate for callers to have to free it.
> >
> > This patch makes close_istream() into "close and de-allocate
> > all associated resources". We could add a new "free_istream"
> > call, but there's not much point in letting callers inspect
> > the istream after close. And this patch's semantics make us
> > match fopen/fclose, which is well-known and understood.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Much nicer ;-)  Thanks.

Jeff, Junio,

Thanks for fixing this.


Kirill
