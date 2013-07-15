From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Sun, 14 Jul 2013 20:22:43 -0700
Message-ID: <7vwqosfqws.fsf@alter.siamese.dyndns.org>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
	<1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
	<1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
	<20130714180916.GB1267@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 05:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyZND-0004Vn-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 05:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab3GODWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 23:22:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab3GODWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 23:22:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ABC12835A;
	Mon, 15 Jul 2013 03:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dERnlX14I56q9siFyHfWf86Tl0=; b=jskGDm
	jsMhlf9GnLZ8Mg2Q568eG2vRKuoY2MgJhkD7fmM/dMCvGd+kFk1K7tsAw2ddU7l9
	3xUq2AdxA2ALbVu7dMK8VcI77DaVHFW2jNFfKKD+afOt7KTguKECd7rpWUuTIYX4
	bpxL287bbZj5BCNMjbLRBL+OlBtlHR/QltCw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFBvsSBXpkjqZUC2PRdlnlsFjhai0IF0
	1FDDypfmPcK5LW6tDtZ2knVgRV24nAQgcKtCOSnnDuL4+qqLg34nB8pC/AGjfXBu
	u3W1J1u4KHcHeZCSf7b1RILFXBYFC8yDAzIG92fKuWeV5ju9CexHPERlYC4c6M6E
	sNUlPHMesV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E43D28359;
	Mon, 15 Jul 2013 03:22:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68F2328354;
	Mon, 15 Jul 2013 03:22:45 +0000 (UTC)
Importance: high
In-Reply-To: <20130714180916.GB1267@google.com> (Jonathan Nieder's message of
	"Sun, 14 Jul 2013 11:09:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1269422-ECFD-11E2-86A4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230406>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Based on 98770971aef8d1cbc78876d9023d10aa25df0526 in original patch
>> series from 2013-06-10.
>
> Please don't include this.  The audience for the commit message
> doesn't have that commit to compare to.
>
> If you want to preserve the original date, the way to do that is
> a "Date:" field at the top of the message body.
>
> 	Date: Fri, 28 Jun 2013 21:16:19 +0530

And you generally should not do that, either.

The first date of the publication of _this_ version is recorded on
the Date: header of this message, not the "original path series"
that this round which is _based on_ (meaning, "different from") that
old one.  We do not want to see the date of the old one, either.

>
> 	Spawning a new subprocess for ...
>
> [...]
>> --- a/templates/hooks--pre-commit.sample
>> +++ b/templates/hooks--pre-commit.sample
>> @@ -31,18 +31,19 @@ if [ "$allownonascii" != "true" ] &&
>>  	test $(git diff --cached --name-only --diff-filter=A -z $against |
>>  	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
>>  then
>> -	echo "Error: Attempt to add a non-ascii file name."
>> -	echo
>> -	echo "This can cause problems if you want to work"
>> -	echo "with people on other platforms."
>> -	echo
>> -	echo
>> -	echo "If you know what you are doing you can disable this"
>> -	echo "check using:"
>> -	echo
>> -	echo "  git config hooks.allownonascii true"
>> -	echo
>> +	cat <<-EOF
>> +Error: Attempt to add a non-ascii file name.
>
> Using
>
> 	cat <<\EOF
>
> would make reading easier since the reader then doesn't have to worry
> about whether the text being cat'ed is indented or uses variable
> substitutions.
>
>> -	echo "To be portable it is advisable to rename the file ..."
>> +To be portable it is advisable to rename the file.
>
> Yes, nice.
>
> With the above nits addressed, this change looks to be going in the
> right direction.  Thanks.
>
> Hope that helps,
> Jonathan
