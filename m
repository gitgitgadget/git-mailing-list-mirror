From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Thu, 31 May 2012 10:29:57 -0700
Message-ID: <7vy5o86yy2.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
 <7vipfmzfel.fsf@alter.siamese.dyndns.org>
 <7vehqazf9d.fsf@alter.siamese.dyndns.org> <4FBD6EC2.3000804@cisco.com>
 <7v62bmzdmy.fsf@alter.siamese.dyndns.org>
 <7vipfe1ihg.fsf@alter.siamese.dyndns.org> <4FC6AFE3.5070805@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu May 31 19:30:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9CL-0005Qb-Si
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 19:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab2EaRaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 13:30:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab2EaRaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 13:30:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7FE8AC5;
	Thu, 31 May 2012 13:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ctQmvM4cL7yp7Qu5XHyydQIhgG4=; b=ozIKUW
	sjgiiibrQebukBYGgWyTnw5Q6IcMojtndRXoLbvsZHbzT145IY2OKch2Mfe3SFcl
	Y0glkHD90XpQR+6RvAb7BFvKgz6sF4HwjDEYM/5ItIK5oEVvL6hEriVrHdLYlB4K
	CbA7O+mmXobc+kC/kzxNDxnOTyPf1ObvAvZbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S9BbMDcchMne9hGh3BMu77+vQBvH8dyy
	upIW/IRYThr+VU2nkes2uZ929wPvCw3aFrzxGurDVGIMT9AbY5CUXAXQW6QUBkqm
	xSPVrCLHBfoKNJpi8izwnypGW85pyLjQ0A04C3aZqYhntw0bIg84/Qjb2Jndie3E
	5KE5XQQrLSE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72978AC4;
	Thu, 31 May 2012 13:29:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28C438AC3; Thu, 31 May 2012
 13:29:59 -0400 (EDT)
In-Reply-To: <4FC6AFE3.5070805@cisco.com> (Phil Hord's message of "Wed, 30
 May 2012 19:40:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F0E2E1E-AB46-11E1-B677-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198926>

Phil Hord <hordp@cisco.com> writes:

> Junio C Hamano wrote:
>
>> Instead of reverting the entire thing, perhaps we can fix the
>> regression like this.
>>
>> With this, we no longer unconditionally give "--allow-empty" when we
>> run "git commit", when --allow-empty (which is only about commits
>> that are originally empty) is given to cherry-pick; specifically,
>> when the user did not ask for --keep-redundant-commit, we do not
>> give "--allow-empty" if the original commit is not.
>>
>> Thinking about it again, I _think_ we do not even have to check if
>> the result is an empty commit ourselves ("git commit" will do that
>> for us anyway), so we might want to rip "is_empty_commit()" out of
>> the problematic patch and keep only "is_index_unmodified()" bit, but
>> for now I think this may be good enough.
>>
>> Phil, does it fix your issue?
>
> Yes, it appears to fix my issue.  I don't have the original condition in
> play anymore, but it fixes the test case I cooked up earlier.

OK, I'm planning to merge the fix down before 1.7.11 final. It may
have broken the use case Neil wanted to support as a side effect (I
tried to be careful but I did not do anything beyond the test cases
as I do not deliberately add empty commits to my history); Neil may
want to double check the result.

Thanks.
