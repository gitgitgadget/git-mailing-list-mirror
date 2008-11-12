From: Junio C Hamano <gitster@pobox.com>
Subject: Re: overly smart rebase - bug or feature?
Date: Wed, 12 Nov 2008 14:04:35 -0800
Message-ID: <7v63msmwi4.fsf@gitster.siamese.dyndns.org>
References: <20081110212333.GU6799@sun.com>
 <7vod0n41i5.fsf@gitster.siamese.dyndns.org> <20081112213920.GB5018@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roman.Shaposhnick@Sun.COM
X-From: git-owner@vger.kernel.org Wed Nov 12 23:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Nqh-0002ox-GB
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYKLWEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYKLWEw
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:04:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKLWEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:04:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B90797C0C6;
	Wed, 12 Nov 2008 17:04:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03C2E7C0C5; Wed,
 12 Nov 2008 17:04:42 -0500 (EST)
In-Reply-To: <20081112213920.GB5018@sun.com> (Fedor Sergeev's message of
 "Thu, 13 Nov 2008 00:39:21 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECD7245E-B105-11DD-9CD2-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100818>

Fedor Sergeev <Fedor.Sergeev@Sun.COM> writes:

> Please, correct me if I'm wrong:
>
>   - by default rebase uses "simplified" merge, which (roughly speaking) 
>     simply goes around patching parent with changes from either branches A and B
>
>   - rebase -m applies 'recursive' merge (default merge strategy) which is 
>     kind of smarter and determines a conflict in my case
>
>   - literally the same happens when I do merge instead of rebase 

If "the same" means "always use 'recursive' merge, without 'am -3'
(mis)behaviour seen in rebase", then yes.

>   - cherry-pick fails just because "patch B" can not apply to A and that is
>     literally why rebase started falling out to *some* merge first hand

I do not know about this part.  Rebase _conceptually_ does cherry-pick but
uses a different implementation.

> If the above is true then can you, please, answer the following questions:

I'll answer the one that cannot be answered without knowing history.  I
suspect answers to your other questions are found in the doc set.

>   - does rebase perform simplified merge only because of speed considerations?

Historical accident.  Originally rebase was only "format-patch | am",
i.e. lift a patch from the commits to be rebased, apply them in order.

Later, "am -3" was invented that allows you to apply patches with fuzz by
using 3-way merge at the content level, which was successfull and rebase
was taught about using it.
