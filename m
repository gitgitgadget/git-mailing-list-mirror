From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Mon, 10 Sep 2012 15:10:42 -0700
Message-ID: <7vhar5leal.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gs3sdjx.fsf@alter.siamese.dyndns.org>
 <20120909130532.GA27754@sigill.intra.peff.net>
 <7vhar7qd07.fsf@alter.siamese.dyndns.org> <504E62DF.5030408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 00:10:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBCBy-0001wd-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 00:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab2IJWKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 18:10:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab2IJWKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 18:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE50F89C9;
	Mon, 10 Sep 2012 18:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GC6JuGS8WhenoGQGFZy6HiJvCIE=; b=pDBAeI
	ATMUWVTf/QvW36bAiLv9IS3irRi9PB5M5nWGU/xJOgOaFzHwOMRF6b7FJVIyUdLw
	m1e2hPk6gt0E/357zf7BBeYVomz6LM6esO461Yb35GCrYy7i/5dhF4D1C4/DHFdX
	W7D69w6kXMlK1h/VFdVLQ3gldOOUYAiOuRF0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TfWLn5ogYYzQnQjBPRo1dLcfL/oRo59E
	56L4ibwmxVW++Tirg+fRXL7Osgm4FbSeynHqHdlPlKipyJ2ras7T6fx8h6PS/EYJ
	4f0oaYNq9Xf/IQbQDmrzK2bxXhCdOT4DHseLgFVGdYgIT15UHInEJMf1blkhi8ul
	5OU+KeHTK18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA2089C6;
	Mon, 10 Sep 2012 18:10:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A89A89C4; Mon, 10 Sep 2012
 18:10:43 -0400 (EDT)
In-Reply-To: <504E62DF.5030408@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 10 Sep 2012 23:59:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D845578-FB94-11E1-A856-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205203>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> OK.  As long as the sort order matches the order string-list
>> internally uses for its bisection search, it won't be a problem,
>> then.
>
> The sorting is crucial but there is no bisection involved.  The sorted
> linked-list of references available from the remote and the sorted
> string_list of requested references are iterated through in parallel.

What I meant was that the order used by string-list is pretty much
internal to string-list implementation for its "quickly locate where
to insert" bisection.  It happens to be the byte value order, I
think, but the point is whatever order it is, that has to match the
order we keep references in the other data source you walk in
parallel to match (i.e. the linked list of references).
