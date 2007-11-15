From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Bisect reset: remove bisect refs that may have been packed.
Date: Thu, 15 Nov 2007 00:34:35 -0800
Message-ID: <7vsl376h5w.fsf@gitster.siamese.dyndns.org>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	<7vwssj6hw8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsaBe-0005hD-I2
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283AbXKOIem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756315AbXKOIem
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:34:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60071 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbXKOIel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:34:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 657472EF;
	Thu, 15 Nov 2007 03:35:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E568094E09;
	Thu, 15 Nov 2007 03:34:58 -0500 (EST)
In-Reply-To: <7vwssj6hw8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Nov 2007 00:18:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65088>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> If refs were ever packed in the middle of bisection, the bisect
>> refs were not removed from the "packed-refs" file.
>>
>> This patch fixes this problem by using "git update-ref -d $ref $hash"
>> in "bisect_clean_state".
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Thanks.  Just a few nits.
>
> On top of your patch...
>
>  - You forgot to remove one "removal of filesystem refs";

Ooops.  'test -d "$GIT_DIR/refs/bisect"' is used as a signal
that we are bisecting for the rest of the code, so we cannot
lose that rm -fr there.

I think a longer term clean-up would be not to treat "bisect" as
a reserved branch name but use detached HEAD while bisecting.
But that is a larger topic.
