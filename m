From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 1/4] fix bsd shell negation
Date: Tue, 13 May 2008 19:27:54 -0700
Message-ID: <7viqxhr55h.fsf@gitster.siamese.dyndns.org>
References: <20080513084338.GA23729@sigill.intra.peff.net>
 <20080513084452.GA23799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 14 04:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw6kA-0006YG-BI
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 04:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbYENC2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 22:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYENC2M
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 22:28:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYENC2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 22:28:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7410A4D52;
	Tue, 13 May 2008 22:28:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 88CCF4D4F; Tue, 13 May 2008 22:28:05 -0400 (EDT)
In-Reply-To: <20080513084452.GA23799@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 May 2008 04:44:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6403C598-215D-11DD-8AFE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82066>

Jeff King <peff@peff.net> writes:

> On some shells (notably /bin/sh on FreeBSD 6.1), the
> construct
>
>   ! foo | bar
>
> does not negate the exit value of the pipeline, but rather
> of 'foo', producing the opposite of the expected value. We
> can work around this by specifying it as
>
>   ! (foo | bar)

After applying this patch, we still seem to have fair number of hits:

    $ git grep -n -e '![^(]* |' -- '*.sh'

t/t5302-pack-index.sh:68:	! echo "$msg" | grep "pack too large .* off_t"
t/t7002-grep.sh:111:		! git grep -c test $H | grep -q /dev/null
t/t7600-merge.sh:378:	if ! grep "^ file |  *2 +-$" diffstat.txt
t/t7600-merge.sh:392:	if ! grep "^ file |  *2 +-$" diffstat.txt
t/t9400-git-cvsserver-server.sh:160:    ! cat request-anonymous |
t/t9400-git-cvsserver-server.sh:169:    ! cat request-anonymous |
t/t9400-git-cvsserver-server.sh:187:    ! cat request-anonymous |

Didn't you have trouble with them, or the tests themselves are broken in
some other way that these did not triggger?



    
    
