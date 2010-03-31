From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Carrying over attributes when moving files
Date: Tue, 30 Mar 2010 21:05:36 -0700
Message-ID: <7vzl1pp23z.fsf@alter.siamese.dyndns.org>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
 <20100328014208.GA23015@progeny.tock>
 <19376.50971.397375.810974@winooski.ccs.neu.edu>
 <19376.53419.640007.930897@winooski.ccs.neu.edu>
 <20100329231501.GA28194@progeny.tock>
 <19377.33747.838003.360864@winooski.ccs.neu.edu>
 <20100330213049.GB11192@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 06:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwpBj-0001DG-6A
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 06:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab0CaEFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 00:05:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab0CaEFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 00:05:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F4E3A6E9B;
	Wed, 31 Mar 2010 00:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sMYEql9vVI/zCCt8WbBTX28RrkY=; b=DxO5xS
	F3l8iXU8UTFcAQKQerfqBg4W6gZHJvNUyl9n29xGhq9kkpusZ88p97zoZJyJzmmz
	hGnZkda5qLS5m6yHyIoVPlPFXNUClA6MtvQQZimSF07L7Q4/yL1SsAqN4+VjD6sv
	JGUQVwj/tf+tXuRYyvhU279HKvzSh+OTWi8DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tm6XQLVN65mFWXR/ZiGwG7L4MyapWjB1
	OvanVnASIWG8NljoJxeLja78qlTuLMNt66I56XmLGK5a+QytLTYzIfLqd7K5GyfP
	L/Vm3/tL3mBicgjhOhvrytl8qr7bguMl+ATgT9tY6hWKuguYM764lLPfYxqk+q2Q
	EZ9fUcCZ5T4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C5EBA6E98;
	Wed, 31 Mar 2010 00:05:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 668C1A6E95; Wed, 31 Mar
 2010 00:05:38 -0400 (EDT)
In-Reply-To: <20100330213049.GB11192@progeny.tock> (Jonathan Nieder's message
 of "Tue\, 30 Mar 2010 16\:30\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC7F9F60-3C7A-11DF-8E89-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143645>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Consider the following directory hierarchy.
>
> 	old-files/
> 		.gitattributes
> 		some-file.html
> 		other-file.html
> 	new-files/
> 		unrelated-file.html
>
> .gitattributes specifies that old HTML files use a CRLF line ending.
>
> 	*.html crlf
>
> What would you expect the following commands to do?
>
> 	git mv old-files/some-file.html new-files/
> 	git commit

I know what you are getting at, but I think it cuts both ways.

I can well imagine that the build structure where "make && make install"
will go to old-files and new-files directories and install the contents
overlayed in the same destination, and .gitattributes may be being used as
a way to "fix" some aspect of "oldness" in old-files/ files until the
sources are fixed.  So an equally valid work sequence might be:

 	git mv old-files/some-file.html new-files/
	edit new-files/some-file.html
        git add new-files/some-file.html
 	git commit

in which case adding a new "some-file.html crlf" entry to .gitattributes
in new-files/ directory would be just _wrong_.

So I am not opposed to a mechanism to _let_ users makes a copy of an entry
that covers (or used to cover) one path to apply to another path that was
not covered by it, but doing it unconditionally would not be such a good
idea.
