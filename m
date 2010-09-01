From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: warn users about updating existing tags on push
Date: Wed, 01 Sep 2010 08:18:55 -0700
Message-ID: <7veidd7aqo.fsf@alter.siamese.dyndns.org>
References: <20100828012101.GB2004@burratino>
 <1282983736-3233-1-git-send-email-cxreg@pobox.com>
 <AANLkTinn0Evi6tYMSt+FevJnFt1taQVzqhJKuiGKudOy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, jrnieder@gmail.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 17:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqp5u-000367-3k
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 17:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab0IAPTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 11:19:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634Ab0IAPTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 11:19:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DE2CD2E80;
	Wed,  1 Sep 2010 11:19:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qx7en99Btw00dxlh7DxFKtJlqw4=; b=HkiJzC
	W5+Y5CW5oDqoQkdyyEJgcwyDDiyqJoLfU1tNC5zQB9UZixFJY4o83DJFRfu3k4KH
	mIe96aKsnGdF3wMdQrPQrF3QrHjUWn03/ucOU2wPWX2iFnmbXXPSgQPDM+pZR7KI
	NWdjfJIPbK3JRhO37XDABkmZPc4rDqHXCTrnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/qy+ViofVVs5/pCqprka1G9XUeTYbk5
	LZxqCO4LTHg//Xl7Dor/w7sGlFQ+YtoEEvrW8qpz6GoQWztX0LlBodG78UgmjFM3
	TNVzbRtMEog+b8kAkG2gbbrprRa3uLEkmNFvgntucfzrfeRNSwwQDBJ5Ef8pRwHY
	WHUEx4fzlBY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4204BD2E7A;
	Wed,  1 Sep 2010 11:19:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 328ACD2E72; Wed,  1 Sep
 2010 11:18:57 -0400 (EDT)
In-Reply-To: <AANLkTinn0Evi6tYMSt+FevJnFt1taQVzqhJKuiGKudOy@mail.gmail.com>
 (Tay Ray Chuan's message of "Wed\, 1 Sep 2010 11\:51\:05 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4195F402-B5DC-11DF-9C1E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155051>

Tay Ray Chuan <rctay89@gmail.com> writes:

>> +push.denyMovingTags::
>> +       Whether or not a user will be allowed to push a tag that already
>> +       exists on the remote for a different object.  False by default.
>
> Hmm, it's a little weird to speak of "allowing" the user to do this
> and that. Perhaps
>
> 	Whether or not a push will be allowed to proceed if a tag...

I think that is a sensible suggestion.  Or even stronger "forbid updating
an existing tag; defaults to false".

>> +receive.denyMovingTags::
>> +       If set to true, git-receive-pack will deny an update to a tag which
>> +       already points to a different object.  Use this to prevent such an
>> +       update via a push, even if that push is forced.
>> +
>
> Perhaps
>
> 	If set to true, git-receive-pack will refuse to update to a tag to point the
> 	tag to a	different object.  Use this...

Sounds better.

>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index 658ff2f..1d53e04 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -112,7 +112,10 @@ nor in any Push line of the corresponding remotes file---see below).
>>        Usually, the command refuses to update a remote ref that is
>>        not an ancestor of the local ref used to overwrite it.
>>        This flag disables the check.  This can cause the
>> -       remote repository to lose commits; use it with care.
>> +       remote repository to lose commits; use it with care.  This
>> +       flag will also allow a previously pushed tag to be updated
>> +       to point to a new commit, which is refused if
>> +       push.denyMovingTags is set to true.
>
> Perhaps
>
> 	remote repository to lose commits; use it with care.
>
> 	Note that for tags that have already been pushed and have been updated
> 	locally, \--force will not update them if push.denyMovingTags is set to true.

I don't think the change to this section is necessary, _unless_ existing
mention of "remote ref" is changed to "remote branch" to exclude tags.  If
we wanted to say something, probably

    Note that the above applies both to branches and tags.

would be sufficient.  I don't think this is a place to enumerate
exceptions like this new configuration and all the other existing ones
(e.g. denynonfastforwards, denycurrentbranch, denydeletecurrent etc.)
