From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sat, 02 Jan 2010 11:45:29 -0800
Message-ID: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
 <7v637nzky0.fsf@alter.siamese.dyndns.org>
 <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do>
 <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR9wZ-0005xL-OJ
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 20:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab0ABTpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 14:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236Ab0ABTpj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 14:45:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab0ABTpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 14:45:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC554ACFF5;
	Sat,  2 Jan 2010 14:45:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRGCRgiImbgLB6MOuhCK27BCGw8=; b=RE+j/P
	2IAi9PLajcw3aWEC+1pizqJQy8FQSGI0CDvzSpW6NJEYYt8EbNtcBIj+noSCNsnw
	QMeu91ZaJXgfEyMh+6yVAJYHZecnay/HIYwadiaGfLqdxEf3+S8STehpxBYdd8Mr
	IdYxPvjYXaaXTzakcwXmq49Cz8uYiooX2WgtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ein9EW52NwJeOfWOh0PHiTe9FOwpjfzl
	04G4FW1uH44+9KvWri+uiNuCzudgpYXT7lHlskKJNX3tnMPTGxUyhP2CGtnxrJdd
	kr0fnlStyJaQWrnxTeCht8Skf5kt2mfx/NP1/Fs6oObMkUWbsnIxNmGBUooELZl8
	Ee3BY7V97EM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C40B3ACFF4;
	Sat,  2 Jan 2010 14:45:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A6DFEACFF3; Sat,  2 Jan 2010
 14:45:31 -0500 (EST)
In-Reply-To: <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun\, 3 Jan 2010 02\:15\:22 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64B6E9DC-F7D7-11DE-87F6-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136041>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>  > +support_external_grep() {
>>  > +     case "$(git grep -h 2>&1 >/dev/null|grep -e --ext-grep)" in
>>  > +     *"(default)"*)  return 0;;
>>  > +     *"(ignored by this build)"*) return 1;;
>>  > +     *) test_expect_success 'External grep check is broken' 'false';;
>>  > +     esac
>>  > +}
>>
>>
>> Heh, clever.
>>
>>         git grep -h 2>&1 | grep 'allow calling of grep.*default' >/dev/null
>>
>>  may be sufficient, though.
>
> Yes, until somebody changes help text in builtin-grep.c and all
> external grep tests become disable. I wanted to catch that case too.

Ok, that is a worthwhile thing to do.

Then please at least make the second grep "grep ext-grep", droping "-e --"
from it.  We assume some implementation of external grep to lack "-e"
(e.g. Solaris).
