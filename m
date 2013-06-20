From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 14:03:19 -0700
Message-ID: <7vfvwcqyug.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
	<7v38sdzx8o.fsf@alter.siamese.dyndns.org>
	<7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
	<CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com>
	<7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
	<E1FE663A82E6499AA9B598B4F60A5CE6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jun 20 23:03:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upm0t-0003BX-1E
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab3FTVDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:03:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940Ab3FTVDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:03:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2ED829DD9;
	Thu, 20 Jun 2013 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nzp4GETaiEMpGnPrKqXWyFORU0E=; b=JyEGfm
	PdaYi9NRbqltjs/szvbCc5nGwgd40ZJcTHG2wqhvG6AhNkL+A529CC2VxaRycti3
	B+0ArO7jMvTexr4suvWHsA7HgC+uZH6J82UGgrv2tLpEqFGlmLoc4GTolcwD97Du
	Qi+qTt0Q6oGALBRUWuAIRm5yTNUL7zD0qF6bY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Th7OGBU2DB0GYD3Mm2X6oQuy3KWPv/C3
	wOZ8xKO7C8GA0bgBmXHXOR+msStWg9pk1bOdMkgYaQsvlQnC6wcGsO/IDeDNW7+A
	vSX6drZyqmFclDFxqvZgF3tf9CgdGM5uYBk9YOASaCxpqgUpoRgV5poMJrE1Fb56
	Z9F1rUGmci0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB35029DD8;
	Thu, 20 Jun 2013 21:03:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0602529DD0;
	Thu, 20 Jun 2013 21:03:20 +0000 (UTC)
In-Reply-To: <E1FE663A82E6499AA9B598B4F60A5CE6@PhilipOakley> (Philip Oakley's
	message of "Thu, 20 Jun 2013 21:49:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D69AB93E-D9EC-11E2-BE2B-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228539>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Thursday, June 20, 2013 8:23 PM
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Junio C Hamano wrote:
>>>> Double negation confused my parser.  'push' and 'pull' should be
>>>> kept symmetrical in central workflows?
>>>
>>> They're not the same thing.  It is very much intentional and
>>> intended:
>>> the safety net is not to "ensure that the push and pull are
>>> symmetrical" (i.e. among other things, error out if
>>> branch.$branch.merge is unset), but rather "ensure that the push and
>>> pull are never asymmetrical".
>>
>> Hmmmm....
>>
>>    not to "ensure that the push and pull are symmetrical"
>>    rather "ensure that the push and pull are never asymmetrical".
>>
>> They still talk the same thing to me.  What am I missing?
>>
>> Am I being clueless, or is there something else going on?
>
> I think it is a case of the user having explicitly set push=Africa and
> pull=Europe which can't be a setting for simple symmetry.

Yeah but then that is not a discussion about central workflow.

I can understand "In a central workflow push and pull should be
symmetrical."  I can also, with a bit of double-negation brain
twisting, understand "In a central workflow, push and pull should
not be asymmetrical."

But when I suggest to avoid double-negation, I was told that these
two statements mean different things, and the original should not be
rewritten to avoid double-negation, which is where my brain stopped
and asked for help.
