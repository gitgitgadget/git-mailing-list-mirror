From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 09:31:54 -0700
Message-ID: <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
References: <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	ecryptfs@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbwfq-0003Nx-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab2FEQb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:31:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab2FEQb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:31:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BECA194AC;
	Tue,  5 Jun 2012 12:31:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KX+OSoDK9dB9MTFcY0d6EPPtKwU=; b=knyhYW
	9f4yHXNivmGQjm2ff3q09kz8fvQomjoPqZD/v6GZKiRPLj7f4CSLiVTnHAZomrOc
	oCBkIWxcQk8ZmyhJA392+QFVmymdL0/S1ybMQKF4gscQr3O4bGyq9U0H82nlH/If
	hh8EUDpAY38ESYdg54TrA7vQC8g5JCaWIuzIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H74x2t4JNFwLaFxEOaGkTXT9YmDK0+Am
	T8AwMxUw00mcDwbYOm9U6UJ9eHK2txRtvLgTnO6Z559SxKD/Q24SeG12zYmCD6Q+
	b3QO3BH8kltEFXfcWqXyq//VbO986Q9jL2TmiJGMxiYy0WVbvh5zfarE1RF8RfJI
	o2ASR/D6MB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5CA194AB;
	Tue,  5 Jun 2012 12:31:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C32994AA; Tue,  5 Jun 2012
 12:31:56 -0400 (EDT)
In-Reply-To: <20120605150550.GA19843@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 11:05:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F70F8DD0-AF2B-11E1-905C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199258>

Jeff King <peff@peff.net> writes:

> [+cc ecryptfs@vger, as I think this is an ecryptfs bug]
>
> On Tue, Jun 05, 2012 at 10:28:13AM -0400, Jeff King wrote:
>
>> OK, here's the _real_ issue. Git creates with mode 0444, which should
>> still allow read in the mask. But it's the restrictive umask at the top
>> of the test script that causes the problem. Try this:
>> 
>>   setfacl -m m:rwx .
>>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
>>   umask 077
>>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
>>   getfacl a b
>> 
>> On ext4, both files will have the read bit set in the mask. On ecryptfs,
>> "b" will have an empty mask. I think the wrong thing is that we should
>> not be respecting umask at all when default ACLs are in play, and
>> ecryptfs is getting that wrong. But I'm having trouble digging up an
>> authoritative source.
>
> Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
> clear that if a default ACL is present, it should be used, and umask
> consulted only if it is not (so the umask should not be making a
> difference in this case).
>
> The reproduction recipe above shows the minimum required to trigger it;
> adding a more realistic default ACL (with actual entries for users) does
> not seem to make a difference.

Thanks; so combining the above with your earlier patch to 1304 we
would have a good detection for SETFACL prerequisite?
 
