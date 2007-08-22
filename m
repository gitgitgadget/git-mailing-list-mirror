From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-remote for ActiveState Perl
Date: Wed, 22 Aug 2007 13:19:24 -0700
Message-ID: <7vr6lviapf.fsf@gitster.siamese.dyndns.org>
References: <20070822161307.GA3528@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INwgG-0004Ox-ME
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 22:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763241AbXHVUTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759962AbXHVUTe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 16:19:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763221AbXHVUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 16:19:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BB5541265F6;
	Wed, 22 Aug 2007 16:19:53 -0400 (EDT)
In-Reply-To: <20070822161307.GA3528@steel.home> (Alex Riesen's message of
	"Wed, 22 Aug 2007 18:13:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56417>

Alex Riesen <raa.lkml@gmail.com> writes:

> For reason unknown a package in ActiveState Perl 5.8.7 must implement
> READLINE method differently for scalar and array context. The code
> tested to work for more sane and recent version of perl (5.8.8 shipped
> with Ubuntu), so maybe it was always a requirement.

Well spotted.

Unfortunately, the manual perltie.pod is very sketchy on this
issue, and only says:

    This method will be called when the handle is read from via <HANDLE>.
    The method should return undef when there is no more data.

The default implementation in Tie::StdHandle (Tie/Handle.pm)
does agree with you by doing this:

    sub READLINE { my $fh = $_[0]; <$fh> }

So I am fairly confident that your patch is the right fix.

Interestingly, CPAN::Tarzip::READLINE (CPAN.pm) gets it wrong ;-)
and caters only to calls in scalar context if I am reading the
code correctly.

Thanks.  Will apply.
