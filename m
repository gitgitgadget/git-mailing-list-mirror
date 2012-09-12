From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in
 "binary" merge driver
Date: Wed, 12 Sep 2012 08:58:01 -0400 (EDT)
Message-ID: <1734879571.321704.1347454681726.JavaMail.root@genarts.com>
References: <7vk3vzfwme.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 14:58:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBmWM-0003CD-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 14:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab2ILM6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 08:58:12 -0400
Received: from hq.genarts.com ([173.9.65.1]:12436 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758410Ab2ILM6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 08:58:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id AD58CBE12E8;
	Wed, 12 Sep 2012 08:58:07 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hBqYTbOoGRBm; Wed, 12 Sep 2012 08:58:01 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id BFF4DBE12E0;
	Wed, 12 Sep 2012 08:58:01 -0400 (EDT)
In-Reply-To: <7vk3vzfwme.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205284>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Wednesday, September 12, 2012 4:55:53 AM
> Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in "binary" merge driver
> 
> Jeff King <peff@peff.net> writes:
> 
> > On Sat, Sep 08, 2012 at 09:40:39PM -0700, Junio C Hamano wrote:
> >
> >> The built-in "binary" attribute macro expands to "-diff -text", so
> >> that textual diff is not produced, and the contents will not go
> >> through any CR/LF conversion ever.  During a merge, it should also
> >> choose the "binary" low-level merge driver, but it didn't.
> >> 
> >> Make it expand to "-diff -merge -text".
> >
> > Yeah, that seems like the obviously correct thing to do. In
> > practice,
> > most files would end up in the first few lines of ll_xdl_merge
> > checking
> > buffer_is_binary anyway, so I think this would really only make a
> > difference when our "is it binary?" heuristic guesses wrong.
> 
> You made me look at that part again and then made me notice
> something unrelated.
> 
> 	if (buffer_is_binary(orig->ptr, orig->size) ||
> 	    buffer_is_binary(src1->ptr, src1->size) ||
> 	    buffer_is_binary(src2->ptr, src2->size)) {
> 		warning("Cannot merge binary files: %s (%s vs. %s)",
> 			path, name1, name2);
> 		return ll_binary_merge(drv_unused, result,
> 				       path,
> 				       orig, orig_name,
> 				       src1, name1,
> 				       src2, name2,
> 				       opts, marker_size);
> 	}
> 
> Given that we now may know how to merge these things, the
> unconditional warning feels very wrong.
> 
> Perhaps something like this makes it better.

Patch didn't apply on top of the previous two for me, but after making the edits manually does what it claims to do (and makes the merge output much nicer to read, thanks!).  The only remaining question for me is should -Xtheirs resolve "deleted by them" conflicts?

Thanks,
Stephen
