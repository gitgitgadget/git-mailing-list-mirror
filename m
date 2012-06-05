From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 05 Jun 2012 10:27:39 -0700
Message-ID: <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
References: <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
 <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	ecryptfs@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: ecryptfs-owner@vger.kernel.org Tue Jun 05 19:28:12 2012
Return-path: <ecryptfs-owner@vger.kernel.org>
Envelope-to: gcfe-ecryptfs@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <ecryptfs-owner@vger.kernel.org>)
	id 1SbxYB-0007aw-K6
	for gcfe-ecryptfs@plane.gmane.org; Tue, 05 Jun 2012 19:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab2FER2F (ORCPT <rfc822;gcfe-ecryptfs@m.gmane.org>);
	Tue, 5 Jun 2012 13:28:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975Ab2FER1o (ORCPT <rfc822;ecryptfs@vger.kernel.org>);
	Tue, 5 Jun 2012 13:27:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB069FBA;
	Tue,  5 Jun 2012 13:27:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q2gamYifLV24FA6HYH5G0YbqcNQ=; b=Qt+bjH
	979FRuDYgU214NxB69VkXxwb6WI6xOK3OzzfQkWnf/Xe9RJC9w37kz5AotgmPUGg
	fuK0Tp1CbwqjlTBWQzk5WOw6qr+NvcVcNo9Ow9rozHI9dRbrZrXbnonQDk4kWEtX
	97/7xuL4FkkJtsSbfMoiLdKKiBnFkiTS7EwYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uG58XbshriRBLAS2wZ0s2M3i3Zem57Zj
	46taRvIfMuUrReEld/EMrArnWOWzlv8/fqLNAiRZ/YaSp/KayiEof5KOC74AbB/r
	WtGyWeSnn+EIGGlXRzLgs5q0Gm30Aiep+v9fuWlXp3MphMTH3VL0ca2x6BsU8loT
	Ew/0/UJsvcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B939FB9;
	Tue,  5 Jun 2012 13:27:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1424C9FB7; Tue,  5 Jun 2012
 13:27:41 -0400 (EDT)
In-Reply-To: <20120605164439.GA2694@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 12:44:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0D392A4-AF33-11E1-BF3E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: ecryptfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <ecryptfs.vger.kernel.org>
X-Mailing-List: ecryptfs@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199269>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 05, 2012 at 09:31:54AM -0700, Junio C Hamano wrote:
>
>> >>   setfacl -m m:rwx .
>> >>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
>> >>   umask 077
>> >>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
>> >>   getfacl a b
>> [...]
>> >
>> > Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
>> > clear that if a default ACL is present, it should be used, and umask
>> > consulted only if it is not (so the umask should not be making a
>> > difference in this case).
>> >
>> > The reproduction recipe above shows the minimum required to trigger it;
>> > adding a more realistic default ACL (with actual entries for users) does
>> > not seem to make a difference.
>> 
>> Thanks; so combining the above with your earlier patch to 1304 we
>> would have a good detection for SETFACL prerequisite?
>
> Yes, I think we can detect it reliably. I'd like to hear back from
> ecryptfs folks before making a final patch, though. It may be that there
> is some subtle reason for their behavior, and I want to make sure before
> we write it off as just buggy.

Sensible; thanks.
