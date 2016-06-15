From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] verify-tag: allow to verify signed blob objects
Date: Wed, 15 Jun 2016 12:24:32 -0700
Message-ID: <xmqqziqm5k7j.fsf@gitster.mtv.corp.google.com>
References: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
	<xmqq8ty670v2.fsf@gitster.mtv.corp.google.com>
	<9b700254-23b1-286c-70e6-68d484e9c4e8@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 21:24:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDGQb-0007l4-6C
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 21:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbcFOTYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 15:24:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752631AbcFOTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 15:24:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E37FC21C5A;
	Wed, 15 Jun 2016 15:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dzt3G7tmSsea82yLAFnrG3lDuJY=; b=Y1HEmU
	2K2z1tzF8loK9wAb6fefvU+hNCiRT1CTxBH2B3S6yMI6RfDqt5aUqel4AJcUO0V6
	0DJvLdajK9kYtfh/YSE76kbNfM4NnAe0eAUVNX7Wy3S6wgCBFDc6ij73nevZVemD
	8wSAixPlwQMQzYiKQA7y+OqJU/RLfXfHvCT/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cTm4+NRXIUm0VvMGFCY8fbLeC3TW1gEZ
	2ahb4Z8d5Sxpc//REC7mEkvWrrnBBup+aC1YkGYKKg4aBiizMkZvcIXakDhpWcGW
	l09UKfT3mUa/9VOy9uN7Hk91SOBULMDHgS1q1jFWdleLe+7xNtQ0OijAK7gaMfYt
	dTCvvTWzme8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB63B21C59;
	Wed, 15 Jun 2016 15:24:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52DEA21C58;
	Wed, 15 Jun 2016 15:24:34 -0400 (EDT)
In-Reply-To: <9b700254-23b1-286c-70e6-68d484e9c4e8@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Wed, 15 Jun 2016 21:07:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAB11BE2-332E-11E6-9C84-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297393>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Or even
>> 
>> 	if ((flags & GPG_VERIFY_BLOB) && (type != OBJ_BLOB))
>>                	"you told me to check blob but didn't give me one";
>> 	} else if (type != OBJ_TAG)
>> 		"you didn't give me a tag";
>> 
>
> I just tried to stay as close to the original as possible, but I don't
> care either way. Your latter version is more strict and would require a
> slight documentation change, but would be fine, too.

Actually, the message you reused is not reusable for this new mode.
I guess starting from more strict (which makes sense, as you do not
want to silently say "Yeah, the blob verifies OK" when the user
tells you "I want you to verify this blob, and here it is" and hands
you a tag.  If that were an acceptable behaviour, you do not even
need VERIFY_BLOB as an option, do you?

So I do not care too strongly about this feature, if it were to be
added, I think you would need to separate error messages and type
verification should not be lax, I would think.
