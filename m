From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Sat, 08 Aug 2009 23:19:18 -0700
Message-ID: <7vy6pta4rd.fsf@alter.siamese.dyndns.org>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan Flynn <parseerror@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 08:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma1ks-0001TH-Ke
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 08:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbZHIGTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 02:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZHIGTZ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 02:19:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbZHIGTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 02:19:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 149A022609;
	Sun,  9 Aug 2009 02:19:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09D5622606; Sun,  9 Aug 2009
 02:19:20 -0400 (EDT)
In-Reply-To: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
 (Ryan Flynn's message of "Sun\, 9 Aug 2009 00\:41\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9539A548-84AC-11DE-9771-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125320>

Ryan Flynn <parseerror@gmail.com> writes:

> given n, tried to find i greater than n via i=1, iterate i *= 10.
> given n sufficiently close to UINT_MAX this will overflow; which can
> produce i==0, which results in an infinite loop. iteratively dividing
> n /= 10 does not have this problem, and though division is slower than
> multiplication this only runs once per `git format-patch
> --cover-letter`
>
> Signed-off-by: pizza <parseerror@gmail.com>

Pizza?

This is somewhat amusing.

 - digits_in_number() is called only with opt->total that is "int";

 - opt->total is the total number of patches.

 - the return value is used like this:

     sprintf(buf, "%0*d", digits_in_number(opt->total), opt->nr);

   and opt->nr runs from 1 to opt->total; the use of "d" would be already
   wrong anyway even if you computed digits_in_number() correctly.

Perhaps we should get rid of this function altogether?
