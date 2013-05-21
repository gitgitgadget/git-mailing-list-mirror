From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 11:02:11 -0700
Message-ID: <7vfvxgnrdo.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<1369132915-25657-2-git-send-email-artagnon@gmail.com>
	<7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 20:02:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqtA-0004P3-D8
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab3EUSCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:02:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab3EUSCN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:02:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB3C20AC0;
	Tue, 21 May 2013 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crRoqjjbH5sFBerZWl0MBR5GpsM=; b=jYKR9P
	O7nZf03Q0B+y7iS9rIdf7Egzpbe5ihPVxWsXxPFr0Y+bTUz/LXiZr0xYHA3C099i
	5Q6RbswjuvzfWjMNJzLDImdTsFYLh3cp21aGuw5Dji6S5XVa7zaAbWU+Foh8WT5v
	Vs6xUoZgMQw0awoIAHD+LY2eNplmBF5apNlOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ykjp1RS8OFhI8+tEDnstYPxuxOwB9A5V
	xe/cXsEsPt8Obip1wNBLjB26ub4UuPKnEP/weiGji82w+Xr6M0e9DO8aeWw7DTp5
	eYHZHnO7HNf0+CDWMSjlMArNQLXN7rQCaPEysQSIkZx5iaSFstbV5ThZRi8+81l+
	F3VXcVoiefw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70C5F20ABE;
	Tue, 21 May 2013 18:02:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3DF920ABA;
	Tue, 21 May 2013 18:02:12 +0000 (UTC)
In-Reply-To: <CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 21 May 2013 23:26:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90468F08-C240-11E2-8F36-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225055>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Does a failure in interpret-branch-name that issue these error
>> messages always followed by die() in the caller?  I know you looked
>> at the cases you noticed as an end-user (like the above "git show @{u}"
>> example), but if some codepaths did this:
>>
>>         if (interpret-branch-name()) {
>>                 you do not seem to have upstream defined,
>>                 so I will helpfully do something else that
>>                 you probably have meant.
>>         }
>>
>> this patch will break that codepath you did not look.
>
> How can that ever happen in a non end-user case?  That failure
> requires a string containing "@{u}" to be constructed and passed as an
> argument.  Why would we ever programmatically construct "@{u}" to find
> the upstream?
>
> To put it another way: unless an end-user facing application finds an
> "@{u}" while parsing argv and passes it on to interpret-branch-name,
> isn't it impossible for an "@{u}" to end up in the argument?

So did you or did you not audit the codepath?
