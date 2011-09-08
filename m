From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/3] remove prefix argument from pathspec_prefix
Date: Thu, 8 Sep 2011 09:12:37 +0200
Message-ID: <20110908071237.GA4408@ecki>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
 <1315132921-26949-2-git-send-email-drizzd@aon.at>
 <7vmxeh8pf4.fsf@alter.siamese.dyndns.org>
 <7vaaah8muf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 09:15:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1YpM-00050U-MV
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 09:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086Ab1IHHPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 03:15:05 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:39403 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758050Ab1IHHPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 03:15:04 -0400
Received: from localhost (p5B22C058.dip.t-dialin.net [91.34.192.88])
	by bsmtp.bon.at (Postfix) with ESMTP id BEE6A130058;
	Thu,  8 Sep 2011 09:14:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vaaah8muf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180946>

On Tue, Sep 06, 2011 at 12:58:16PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Is it because we no longer ever return "prefix" we pass in which is a
> > pointer to a constant memory region to begin with?
> >
> > We also didn't free() in the earlier code (because we do not know if it
> > can be freed) and leaking xmemdupz() if the function didn't return the
> > "prefix", but now you plugged the small leak. Isn't it something you
> > should advertise?
> 
> Nah, the leak is not necessarily plugged in all callers anyway, so scratch
> that part. I've rewritten it like this:

Ok.

The only other caller, though, is cmd_ls_files(). And it would be
trivial to plug that leak as well.

But is it considered a leak, if the program is going to terminate
right after the function returns? I recall that being used as an
argument against free'ing such memory on this list.

On the other hand, that practice makes it harder to analyze leaks
using memory leak detectors like for example valgrind.

Clemens
