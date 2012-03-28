From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odd behavior with git-rebase
Date: Wed, 28 Mar 2012 10:08:44 -0700
Message-ID: <7viphowt43.fsf@alter.siamese.dyndns.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org>
 <20120324165536.GA17932@neilslaptop.think-freely.org>
 <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
 <20120326172028.GB12843@hmsreliant.think-freely.org>
 <4F70E53E.6060608@gmail.com>
 <CABURp0oP3YBEhpDrAL-mvt1dR+ZH3av-P_sqDQAdgcN10WS2ig@mail.gmail.com>
 <4F72AD25.2090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 19:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCwMe-0002rD-LD
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758303Ab2C1RIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 13:08:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab2C1RIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 13:08:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61DAA77AF;
	Wed, 28 Mar 2012 13:08:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQKzoKVjvMjq9SpVk+d93mJgCq4=; b=pDtHob
	cFPArTHtOhkjpTPl7B+L1Vm2G9ysk6f5rlmUFne3zHMMckQdK1CSQ9iNZ6c7QZVk
	SG49r1xwngnHcGukMv2GSAwksko8VnuncZ7/o+MBDEvV+1L8ySZSNicLrEJ1uyJA
	h73AOb7pSGkc9oD9DDvYg451GtvhNsCcsG350=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IamPJyo+uAqYKuDvpbcl+ame9NZHx/b5
	9rF27q9l1gwyW5vivnXNHS+euenZgED+N5ktfRPoT9I64UebewjBPqISAGXLWEiD
	T07kEx8hTZAmvKHihLaSqX2cdDej5qW8CnbKp5nKW/ivEVlTW5K0fuEF7R+g7XTA
	Tiw3NQ2NN5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54AB177AE;
	Wed, 28 Mar 2012 13:08:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D843A77AD; Wed, 28 Mar 2012
 13:08:45 -0400 (EDT)
In-Reply-To: <4F72AD25.2090102@gmail.com> (Neal Kreitzinger's message of
 "Wed, 28 Mar 2012 01:18:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADAEDC54-78F8-11E1-A79E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194145>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> On 3/26/2012 5:53 PM, Phil Hord wrote:
> ...
>>  2. There is a rerere autoresolved conflict git wants me to approve
>>  examine / test / --continue
>
> You trust rerere?  I take back my earlier comment,...

He does "rerere" and then "examine"s, doesn't he?  So it is not "blindly
trust", but "trust and verify".

>>  I really wanted something like this:
>>
>>  $ git rebase --purge-empty --accept-rerere-authority -i master
>>
> --accept-rerere-authority sounds like another recent thread (maybe
> from you).

It was from a different person and on a different command, but I think
they are going in the same direction.  The "--rerere-autoupdate" option of
"git am", "git rebase" and "git merge" could learn to be a bool-plus, a
stronger form than "yes/no", such that it makes a commit if everything
auto-resolves cleanly (and rerere.autoupdate configuration could learn to
be a bool-plus as well).

While I am hesitant to endorse such a mode of operation, as it can invite
sloppy users hurt themselves, I do not fundamentally oppose it as an
option.  It could save time for diligent users who know when to examine
and verify the result, in order to avoid casting the result with blind
faith in mechanical merges.
