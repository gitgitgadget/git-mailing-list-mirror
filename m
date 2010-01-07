From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick problem - directory not touched by commit is 
 marked "added by us"
Date: Wed, 06 Jan 2010 19:35:49 -0800
Message-ID: <7vzl4qegdm.fsf@alter.siamese.dyndns.org>
References: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
 <1262727434.22597.8.camel@denix>
 <82cfa8031001060328r21aa8de3s5c2dd5dac005b679@mail.gmail.com>
 <7v4omyfv6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Hakim Cassimally <hakim.cassimally@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 04:36:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSjAN-0003f0-0n
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 04:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711Ab0AGDgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 22:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756708Ab0AGDf7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 22:35:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab0AGDf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 22:35:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F9C48E208;
	Wed,  6 Jan 2010 22:35:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wzjO4F7taCD0JZcGMOhGm7W3CYE=; b=mTV6TH
	0dlOctw4zSX7gA2moMQFeOn8GYUy6Di4HHRqZN1AGKbD95P/OkUBI3f8zQr9UvRN
	4HvePzoICrNQmo2tFFwdaT+M2VamtjH6WpD+8Zb53Hgli64JgHzucOdrXPZYbVJK
	jdQYUok88VIkkkV2oP3gAClEfoAnAWFlHJMu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BxsZXmy5voii2j8/Ahctd/xJe0+q1E4c
	eHHRJPFNnchewM6OM0Vkazqm0oyi6jkgOLy/XTvShViC0A80HKu2nw+r6L0ZNh8n
	6oLzRmiLRSrt+9s8TNHtHBpJJpGnGTtcX02tbmiDsUi2r48aaCTPpjsxPQCIvTXv
	S+Z1jGsng/0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B1A58E202;
	Wed,  6 Jan 2010 22:35:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CC148E201; Wed,  6 Jan
 2010 22:35:51 -0500 (EST)
In-Reply-To: <7v4omyfv6h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 06 Jan 2010 19\:30\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C327DB48-FB3D-11DE-B627-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136320>

Junio C Hamano <gitster@pobox.com> writes:

> What "cherry-pick" internally does is to run:
>
>     git merge-recursive 301a^ -- HEAD 301a
>
> That is, "We are at HEAD; consolidate the change since 301a^ to 301a into
> our state, and leave the result in the index and the work tree".  Then it
> commits the result.  One thing to try is to see if this gives the same
> kind of breakage.

There actually is another possibility; we used to run inside "cherry-pick"

    git merge-resolve 301a^ -- HEAD 301a

instead.  The request is the same but it uses a different algorithm, so if
one fails and one succeeds, that might give us a better clue to figure out
what is going on.
