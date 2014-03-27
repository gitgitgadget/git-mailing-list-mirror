From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] patch-id: make it stable against hunk reordering
Date: Thu, 27 Mar 2014 11:03:46 -0700
Message-ID: <xmqqfvm3ecxp.fsf@gitster.dls.corp.google.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
	<xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
	<20140327175746.GA3853@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTEeq-0005a6-07
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbaC0SDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:03:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200AbaC0SDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 14:03:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D29607509C;
	Thu, 27 Mar 2014 14:03:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45iC9DtQ/fXhhSRxa2q9zO34tZA=; b=rfUj5g
	yML/vBkrlxI2fcLRRze620b6Z55e5NQuWLxB0o2qGa4MJFPbbgA9L3x6jVe3dIT4
	4fgperuCtUp2mbHo1TA9l6K660bEAMBidYZK/UfbB1cl8KVSsMM6g6DqTEIHtlAn
	UsOr0hKjSLrHafb6tjfvG8CWkS1kf0n4HHUfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ED/6M6NCzCgy9wh61D95IbSlakVltk2z
	rNj3FAov5aUXLK72ns1PCaXS93L/GKkLLVqdLxbuz+akmvKdfNl9CXLa+qnvFFTk
	SM2tvW0WFBT8/TeNrp6MpOPkrU2ZsvgRZMoiYm8Nu8nNL9J1f5rktlZNhrQXUHEp
	eU8sIL59ec8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1EA7509A;
	Thu, 27 Mar 2014 14:03:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1552F75098;
	Thu, 27 Mar 2014 14:03:47 -0400 (EDT)
In-Reply-To: <20140327175746.GA3853@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 27 Mar 2014 19:57:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 251638DA-B5DA-11E3-A6B5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245302>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> I started to remove that code, but then I recalled why I did it like
> this.  There is a good reason.  Yes, you can't simply reorder hunks just
> like this.  But you can get the same effect by prefixing the header:

Yes, that is one of the things I personally have on the chopping
block.  Having to deal with more than occurrences of the same
pathname in the input made things in builtin/apply.c unnecessarily
complex and I do not see a real gain for being able to concatenate
two patches and feed it into a single "git apply" invocation.
