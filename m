From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 10:55:13 -0700
Message-ID: <7vipen191a.fsf@alter.siamese.dyndns.org>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 19:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh2eA-0002UN-TG
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 19:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab2FSRzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 13:55:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab2FSRzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 13:55:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4F17662;
	Tue, 19 Jun 2012 13:55:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9aWF9dN4xEhFREmKH8Vr2ys2H2M=; b=gPIq3g
	7wo6oQhlu5GgAOuUCv+3nQRq0qNnxX9e2WS6K7Io/g9LVc/4sr4aouYT+lEvbRFU
	wzeoWYyCIJv+6wvRGWH0J5OPN5g/e64wvsSG4KwG9jzthZlq4J4SV7ZheCmUSM+O
	fzy/NyYISRyvckNBn8Z+3Ahi5bgrqca0tzqYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J3qbqnfegz8/hEbl1VikInL7U/DdjrBH
	1UlZQsEswr+3g55XX9YXBqe89pOr4+D5L/Z/SkOmCyDhZUQDsBvKQOtovJoyr9/7
	5fvYzbs3BuJcRZZkYXnWSjwUc2C2nhuZSJu7HnYbJP1QIm/5Hu6zBqIFd01nllP1
	d3iG0WK5pEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C21DC7661;
	Tue, 19 Jun 2012 13:55:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 285DA7660; Tue, 19 Jun 2012
 13:55:15 -0400 (EDT)
In-Reply-To: <4FE08797.50509@xiplink.com> (Marc Branchaud's message of "Tue,
 19 Jun 2012 10:07:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC82A318-BA37-11E1-B835-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200216>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-06-18 06:12 PM, Junio C Hamano wrote:
> ...
>> That reliance of "origin" is what made me think that "not guessing
>> and blindly assuming" a wrong thing to do.
>
> I think git can do better than erroring out, though.
>
>> It is OK that your build usesdetached HEAD, but if that is the case
>> shoudln't it be the one deciding which specific remote it wants to
>> take the updated sources from, and telling Git to do so?
>
> Sure, but I feel it did that already when it cloned.  It seems reasonable for
> the submodules to default to using the remote specified when the super-repo
> was cloned.

I do not have a strong opinion either way, other than that I would
prefer predictable behaviour over "works most of the time provided
if the user does X, otherwise does this random thing".  And coming
from that standpoint, erroring out when there needs a guess involved
is certainly more predictable---it is a cop-out option for me in
areas of the system I do not have strong preferences.

If you can work with submodule people (it is good that you Cc'ed
Jens) to come up with a solution to make everything always use
'origin' when unconfigured in a consistent way, without breaking
existing users who rely on the current behaviour, that would be
good.  Or a solution with a predictable behaviour you come up with
may end up being something more involved than "just use 'origin'
when you do not know". As long as the end result can be easily
explained to end users, I wouldn't have any objection.

Thanks.
