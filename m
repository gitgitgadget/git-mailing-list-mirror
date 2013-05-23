From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: fix handling of special characters
Date: Thu, 23 May 2013 12:56:08 -0700
Message-ID: <7vfvxdeahz.fsf@alter.siamese.dyndns.org>
References: <20130523135418.GA20741@redhat.com>
	<7vk3mpeaok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 21:56:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfbcW-0000nf-IO
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601Ab3EWT4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758521Ab3EWT4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:56:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB9F121A45;
	Thu, 23 May 2013 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z4KJJrb8m2EhM7pyTUDJyYepxZI=; b=hHgaG5
	CUpCqu/JJNj2yQtwfXlS+dD7bCV2j0VMieJRX1IMRMfe2hthzQg+ngFJQClVRS6Y
	iP40ApEKD9b+a1xFhmvhCk/VNFpWOUO9dA+vRqDlZhjEAtvAT1cOucsunJ7+zqcc
	B97o13g4EEh+q0CFucJ5vs3bk7MluCgmol0ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bGtM3iRP4tmKB9o6SOYFgaWcpkFZS/f8
	wiCF6TnPX0TEupXW8OrMo9OW+B5sdJ0Jyb37wv3kwAl9COI+zBDDgeXMxzKdaypM
	rtooQvsg53c/Bb/+ZimQFnHnd6puoZPd3fRCPEhswecIvedPhJM2P1D9WHDYWJMD
	rY7XR8GWBTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F8F121A44;
	Thu, 23 May 2013 19:56:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 253FC21A43;
	Thu, 23 May 2013 19:56:10 +0000 (UTC)
In-Reply-To: <7vk3mpeaok.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 23 May 2013 12:52:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0708E32-C3E2-11E2-B825-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225289>

Junio C Hamano <gitster@pobox.com> writes:

>> +	my $sanitized_sender = sanitize_address($sender);
>> +	if (defined $author and $author ne $sanitized_sender) {
>>  		$message = "From: $author\n\n$message";
>>  		if (defined $author_encoding) {
>>  			if ($has_content_type) {
>
> ...
> Also, isn't the $sender the same during the whole outer loop that
> iterates over @files?  Do we need to apply sanitize_address() on it
> over and over for each and every logical line in the @header?

Ahh, I think $sender is constant, but this is not for each @header
line, but done per @file, so it is a much lessor offence than what I
originally thought.  The other one does do that inside the loop but
if we have a single copy of $sanitized_sender at the very beginning
that will become a non-issue.

> This comment also applies to the other patch but they probably
> should become a single patch anyway, I guess?
