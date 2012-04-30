From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 30 Apr 2012 19:02:00 +0000
Message-ID: <20120430190200.GA27108@dcvr.yhbt.net>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
 <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
 <20120430081939.GA27715@dcvr.yhbt.net>
 <7vipghgq9a.fsf@alter.siamese.dyndns.org>
 <20120430165315.GO4023@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvrR-0007nV-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab2D3TCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 15:02:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51114 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756264Ab2D3TCB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 15:02:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEC61F426;
	Mon, 30 Apr 2012 19:02:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120430165315.GO4023@login.drsnuggles.stderr.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196593>

Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi folks,
> 
> I could reproduce this problem (after installing half a dozen Ubuntue perl
> packages on my Debian system ;-p). It seems the problem is because the
> version comparison is wrong:
> 
>         if ($SVN::Core::VERSION gt '1.6.12') {
> 
> This does textual comparison, so 1.6.6 > 1.6.12. To do proper version
> comparison, I think the version numbers should be split into
> major/minor/revision and each be compared numerically.
> 
> This is not the only place where this comparison happens in this way,
> there are 6 more comparisons in this way, which would have to be fixed
> as well.

Ah, thanks for the analysis, we were lucky in the past that all version
components only had a single character.

> We could introduce a helper function for comparing version numbers by
> splitting and comparing the parts separately, but that might be hard to
> get right (especially when non-numeric version parts are involved).
> 
> An alternative would be to use the Sort::Versions perl module [1] for
> this, but that would add an external dependency.
> 
> I'd be happy to code and test both approaches, just let me know which
> would be preferred.

I think the former is preferable for git.  Sort::Versions isn't used
anywhere else in git and I don't think it's widely installed.
