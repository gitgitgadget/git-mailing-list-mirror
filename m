From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git attributes ignored for root directory
Date: Thu, 13 Oct 2011 10:38:31 -0700
Message-ID: <7vfwiw6bc8.fsf@alter.siamese.dyndns.org>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu>
 <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E961626.4030201@alum.mit.edu>
 <7vfwix7qk2.fsf@alter.siamese.dyndns.org> <4E96C220.5050601@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Thu Oct 13 19:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REPEt-0006ZT-Vn
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 19:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241Ab1JMRig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 13:38:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236Ab1JMRie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 13:38:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD9C5F69;
	Thu, 13 Oct 2011 13:38:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KnTHcGhsBkuTEcJcx0c0z0RI58g=; b=nln9yZ
	gNmU7agBZYHIWzORfzu8xx1s+25/OnBIGo3a0Wo2pUviBi11aAsCh/oF++Qu35IB
	/J5t0OkKk3c+GBgTHmC2WNJMVEkHhqQmaGTh2iIvJmtaMPKQax1SORcqA5H3W/ca
	wt0y6/PXI4Hx09ayjw6qcXCOGNIBXzYhPdsWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z1JYSzqOKtm77dX9iNoVx9sZAdoRV9+N
	IVEav/B5ws8ckpJ61latYjeLGtU5x+Y0PYi+0YAh3Kp2Ad95oAa2tIIZgbWUvuIO
	DKS2sNlburzXZVGJKhOtWAugQXrdKQuVVpDh0FfcgYQLKUraOCDC52B3pkyQovbY
	/pjFip+4lmY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D521D5F68;
	Thu, 13 Oct 2011 13:38:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DF455F67; Thu, 13 Oct 2011
 13:38:33 -0400 (EDT)
In-Reply-To: <4E96C220.5050601@svario.it> (Gioele Barabucci's message of
 "Thu, 13 Oct 2011 11:49:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C215D7E-F5C2-11E0-839B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183501>

Gioele Barabucci <gioele@svario.it> writes:

> On 13/10/2011 00:12, Junio C Hamano wrote:
> ...
>> How would you say the same thing if the directory to be ignored weren't
>> "foo" but at the top-level of the working tree? There is no such level
>> higher than the top-level where you can say "<the name of your project>/"
>> in its .gitignore file.
>
> Shouldn't `/.` or `/./` work?
>
> I see that `/*/` in `.gitignores` successfully ignores all the
> non-hidden directories in the root project directory. Another
> accidental success? :)

Hannes correctly explained how /*/ works already; armed with that
knowledge, we can understand that:

        /.      would mean "what matches dot only in this directory."

        /./     would mean "what matches dot only in this directory
                but the thing that matches must be a directory."

        ./      would mean "what matches dot in this directory and its
                subdirectories, but the thing that matches must be a
                directory."

Given that "." does _not_ match the directory that has the .gitignore or
the .gitattribute file with the current system, none of the above patterns
can be used to match everything in the top level directory in a way
similar to how you can say "foo/" to match everything in "foo" directory
from the top-level directory.

The answer to your question is no, it shouldn't work.

Without adding a rule to the "Pattern Format" section as I suggested in my
message that Michael quoted in his question, that is.
