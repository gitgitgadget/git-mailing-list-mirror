From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH next] t7407: use 'cut' utility rather than bash's
 substring expansion notation
Date: Thu, 20 Aug 2009 00:34:10 -0700
Message-ID: <7vskfnq6q5.fsf@alter.siamese.dyndns.org>
References: <QHfHFS_5JGiL-O8GMDfdfscFUdxV1xVObzr6e5LPleagDRd7bCg8I9YUwL9xkbgM64vyf_EVLLg@cipher.nrlssc.navy.mil> <200908200856.30359.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>,
	Brandon Casey <drafnel@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 20 09:34:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me2AR-0000cP-36
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 09:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZHTHeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 03:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbZHTHeV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 03:34:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbZHTHeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 03:34:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 502971157C;
	Thu, 20 Aug 2009 03:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2uK7TBeWPSa7wTSuA5At9s9phY=; b=U6UUGz
	tqLFK2hDhxQFl63zz5rqO6AT/l5C/scYUkY1ihzOUtMYakUrcRDtMSqHGRA9j4un
	X2zzIQQFFitZm4cSh+SbPR/wAYBqF/qRBhxF4n1J/abc1kAtsfMeYdUYRUdRtJ75
	EDZV52W2DSXijNKgBXWNwKxFLtBjtrFq5hDaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LPDqf0m1nTAKYYBcfpZoBrTEf6oPgTBX
	m54gZqXmfpvppKUV5Nc1w+NG/uD1DpySz8YAnxevZdHotUJcvti/ZRSOWVzi9ZYt
	eaqt+5S8XOlZwAdp1cL8D5tTAYx2mg3M3+2GOxnG3KNpu9ao4X4Julnurm4nDF+H
	MLJoTzKPJXA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 182C91157B;
	Thu, 20 Aug 2009 03:34:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34A8A1157A; Thu, 20 Aug
 2009 03:34:12 -0400 (EDT)
In-Reply-To: <200908200856.30359.johan@herland.net> (Johan Herland's message
 of "Thu\, 20 Aug 2009 08\:56\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDD1677A-8D5B-11DE-BA44-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126611>

Johan Herland <johan@herland.net> writes:

>> - $sub1sha1 sub1 (${sub1sha1:0:7})
>> - $sub2sha1 sub2 (${sub1sha1:0:7})
>> + $sub1sha1 sub1 ($(echo $sub1sha1 | cut -c 1-7))
>> + $sub2sha1 sub2 ($(echo $sub1sha1 | cut -c 1-7))
>
> Typo (both in the original, and the patch), should be:
> 	$sub2sha1 sub2 ($(echo $sub2sha1 | cut -c 1-7))
>
>>   $sub3sha1 sub3 (heads/master)
>>  EOF
>
> Otherwise:
>
> Acked-by: Johan Herland <johan@herland.net>

Hmm, what does the command use to shorten these object names?  It may be
safer and more correct to use "rev-parse --short" in case these object
names were ambigous in their first 7 hexdigits.
