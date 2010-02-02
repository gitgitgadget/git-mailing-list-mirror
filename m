From: Junio C Hamano <gitster@pobox.com>
Subject: Re: working directory umask
Date: Mon, 01 Feb 2010 22:43:14 -0800
Message-ID: <7v8wbccf3x.fsf@alter.siamese.dyndns.org>
References: <hk8gq7$o76$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: D Herring <dherring@tentpost.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 07:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcCTv-0007b9-SP
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 07:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab0BBGnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 01:43:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab0BBGnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 01:43:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C405196EF7;
	Tue,  2 Feb 2010 01:43:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/KVBwKEBcYnLQi0PWew91aUf73o=; b=k1MjNE
	9wQozh6VrDIshkVc3PJ+gHIpH4wSikNcUlBwuusAoTmT4wklIZEfkMZsRJFEvjlG
	xMsBnxmGGrBbeL/JNs5p80JqqgeNWSr1tkvv+bo0xS3NLe3uF0Cyzq92nlaGM5Lq
	d75Z6BbKL2NP7ssGZbnhe1GBCEQCANBIdwTCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAs3nZSRRUaOsdizrYZVgs/8KitaGAp0
	diPpexcCT0fr7KvM5FIBenNZfe9LkCunmiZg5HeGEg1qWv5sBYgKZqFcVtfVhF6Y
	ZpRZQCTvtD1gg1x+h6Ncg+XfL2m4OFP2mdNpWN/few1VRnCR8k81SHrReBUbKox7
	GcZTOiKz4Hc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 985B896EF6;
	Tue,  2 Feb 2010 01:43:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 004B196EF5; Tue,  2 Feb
 2010 01:43:15 -0500 (EST)
In-Reply-To: <hk8gq7$o76$1@ger.gmane.org> (D. Herring's message of "Tue\, 02
 Feb 2010 01\:30\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F648516-0FC6-11DF-B822-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138687>

D Herring <dherring@tentpost.com> writes:

> One problem:  Even though the working directory is g+swx and git was
> initialized with --shared=group or --shared=0660, the checked out
> source files still don't have group write permissions...

It is working as designed. "shared" setting is about a shared central
repository that is typically a bare repository, and currently it is
implemented as such.

You could argue that the behaviour for the work tree files is undefined
and make the code act differently, though.

In any case, it would be better to document this, and it might even make
sense to issue a warning message when we detect the repository is used
with a work tree (including the use of GIT_DIR and GIT_WORK_TREE
environment variables to temporarily turn a bare repository with a work
tree).

Thanks for a report.
