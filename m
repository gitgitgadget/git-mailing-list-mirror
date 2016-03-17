From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 00:22:41 -0700
Message-ID: <xmqqfuvp36wu.fsf@gitster.mtv.corp.google.com>
References: <56E9F5B3.6030903@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <pclouds@gmail.com>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Durham Goode <durham@fb.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:22:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agSGn-0002Fo-IV
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 08:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbcCQHWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 03:22:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753153AbcCQHWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 03:22:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C54B841FD5;
	Thu, 17 Mar 2016 03:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eLzsVJhcpFJkm7gV6rS1158u8Ps=; b=dLf67o
	8r8o01mv1RwGpEPfE9De/kgQYp0s5Y8Qf4iBoZ4/rqmhwtyWk09kViS+NpoFHtQk
	6Y++cjZdhZTN3t09X/2xYozvUKx9tFgmwOi1OkzGZuOnhg698i5IJjRFlIEMipKg
	mfNTROZSGOgMLPYCHQyt6/xTf6QQ3EDcRp6RM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVsOKGc/U3vsUu916zaj0TV2ZrqOE6g/
	fmrN8BrUGYuMQEKqLGGqllUhG2482cNgpKvwaFpQu4sYIkExpYvBKR4hEtdewgWn
	3zZqg0h7keEjFUJPlh1s/QAvkvJFn5qfla6nsw3zvm6Cf/KHgsI63KfiBoN0YPzy
	MRJdfFiv2gY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC5F541FD3;
	Thu, 17 Mar 2016 03:22:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3FEEF41FD2;
	Thu, 17 Mar 2016 03:22:43 -0400 (EDT)
In-Reply-To: <56E9F5B3.6030903@fb.com> (Durham Goode's message of "Wed, 16 Mar
	2016 17:09:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A1A0402-EC11-11E5-AFE1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289080>

Durham Goode <durham@fb.com> writes:

> Using git 2.8.0-rc2, given a repo with the following files:
>
> - one/hideme
> - one/donthide
> - two/foo
>
> A sparse config of:
>
> cat > .git/info/sparse-checkout <<EOF
> /*
> !one/hideme
> EOF
>
> Results in a repository that only has `one/donthide` in it.  I would
> expect `two/foo`to be present as well.  This worked in 2.6,...

2.6 is a tad too old as a reference, as the "!reinclusion" has been
in flux in recent releases.  Can you test these?

 - 2.7.0
 - 2.7.1
 - e79112d

I suspect that v2.7.0 would be broken, v2.7.1 is OK and e79112d
would also be OK (I am guessing this from [1]).  e79112d is the last
version on the 'master' branch without the topic that contains the
commit you bisected down to, but between 2.7.0 and 2.7.1 there was a
reversion of a commit that introduced the original issue.

The commit you bisected down to that is on 'master', IIUC, was a
(faulty) attempt to fix the breakage in a different way.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/288228/focus=288273
