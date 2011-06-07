From: Alex Neronskiy <zakmagnus@google.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow repositories and --depth commands.
Date: Tue, 7 Jun 2011 22:31:12 +0000 (UTC)
Message-ID: <loom.20110608T001220-765@post.gmane.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com> <7vvcwi95yi.fsf@alter.siamese.dyndns.org> <loom.20110606T213817-376@post.gmane.org> <7v1uz55r24.fsf@alter.siamese.dyndns.org> <loom.20110607T224355-216@post.gmane.org> <7vr57547sj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 00:31:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU4o8-0003TT-6b
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 00:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758864Ab1FGWb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 18:31:27 -0400
Received: from lo.gmane.org ([80.91.229.12]:56418 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab1FGWb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 18:31:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QU4o1-0003Qz-Ik
	for git@vger.kernel.org; Wed, 08 Jun 2011 00:31:25 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:31:25 +0200
Received: from zakmagnus by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:31:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.239.45.4 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175275>

Junio C Hamano <gitster <at> pobox.com> writes:

> Ah, I overlooked that codepath, but if that if statement triggered, that
> would mean fetching is still 0, which in turn means that you never sent
> any "want", so "Once all the 'want's' (and optional 'deepen') are
> transferred" is not even true, is it?

If you want to get pedantic, it IS true that "all" the 'want's are sent; the
correct set of wants to send just happens to be empty. What DOES seem incorrect
is the part about the 'deepen' (as well as the 'shallow's I'm proposing to add);
that part of the code isn't even reached if this termination happens. So, either
I'm mistaken and that is NOT the right codepath, or this is a mistake already
present in the documentation. 

Alternatively, the problem there is that it's just deceptively worded. It
implies that a 'deepen' can be sent and that termination can still happen
afterwards; but I don't believe this is possible. If a depth argument is
present, everything_local is not called and COMPLETEness is not set, so it's
impossible to skip any refs except in the corner case where there aren't any to
begin with. The second version of this patch addresses this better.
