From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 09 Apr 2013 10:58:10 -0700
Message-ID: <7vip3vsi19.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcoI-0001bv-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715Ab3DIR6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:58:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759735Ab3DIR6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:58:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B69DC15724;
	Tue,  9 Apr 2013 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZFsLQxnY0QT+nFhs1Fy9G/btGfs=; b=lKEChq
	TR8EgBRWG3HeR5qDod2QDIkxyZdo7j0NxE1pkANcyJzQr6EIyu0ETAdYKAtD5djc
	fjaF67tXR59Ti9+ZEIXos8kHJCFztaC6bm6v0j/1eEBpWmnSAfI0Dr5yJ0o++CR5
	WHdc0ICA8IKRTmdk7wxQnG6cGHXBcXf6fdXzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FE9W37jHycx9fyXzgZsw6XUXs5q7nRwe
	pRSB63KO8d3gZuQdTtN6HXqQCLoCWGnM10UNwocMvzMqq4vSyZR3su66A9w2LaBE
	FSg1XbGR7CM8fuO/K9LlbvQ9eDmiijjXq8pjaYk8hUG21c+4e1lKyuyHdUmTHx6a
	5Iv4KYmpylg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB69115723;
	Tue,  9 Apr 2013 17:58:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAC6615720; Tue,  9 Apr
 2013 17:58:11 +0000 (UTC)
In-Reply-To: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 23:09:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B418D3E-A13F-11E2-9D51-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220603>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> host:foo/bar (take my "host" branch, push it to their "foo/bar"
>> branch) could be tricky, no?  It could be trying to go over the ssh
>> to "host" and access repository at $HOME/foo/bar.  The git_connect()
>> call may even succeed and you cannot use the failure as a hint to
>> disambiguate.
>>
>> Also the request may genuinely be to access foo/bar repository at
>> the host, but the network layer had trouble connecting temporarily
>> to the host.  After disambiguating incorrectly to push to the
>> origin, mapping our host branch to their foo/bar branch, that push
>> might even succeed.
>
> Oh, ouch.  I didn't think of that.  What do you suggest we do?  Go
> with Duy's simple '-' solution, or try some heuristics that may lead
> to confusing behavior in edge cases?

What is bad about saying "push origin ...the rest..."?

It is beyond me why people would want to invent unintuitive line
noise like '-' that others need to read the manual from cover to
cover to find and memorize for something small like this.
