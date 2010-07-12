From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/13] add range clone functions
Date: Mon, 12 Jul 2010 14:52:07 -0700
Message-ID: <7v4og49xmg.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-7-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 23:52:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYQvE-0000gK-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab0GLVwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 17:52:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0GLVwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 17:52:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6BADC3319;
	Mon, 12 Jul 2010 17:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HPiInnicFQdJf7obNQL6tfC5hOE=; b=KJ6EFZVO/uMpdGjU7wZiP8Z
	HKS3fFlB/UYsrWcd0kVMRHG8nrQnxILJWcfyjO1u0nlKnH2Hm0zZCOwDm16L0l8G
	yhuH8A8ZD8HEwho64ZfYg1bA74ACI9pgBJnd3GcH5KRaXUf8RA529iwwh5s+CkiK
	KRvsiBS53mdZqLPjb4yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Y3zLaQo4eN99lxe+YT/hdKhM0+UlBzkVXcnNg//8kW1mvkr7b
	rQPDHIC0EWhvVZ5AE92B+tSQLSdpX7jfYgJondZs9UlBciPiFsDwsZdas76YLKK9
	TMZNyQ+tb4zSRPn6Amakk3geBj0bkUnuuWKr3m7UJefmkRu+udBbvxXOco=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 627F2C3316;
	Mon, 12 Jul 2010 17:52:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5E50C3315; Mon, 12 Jul
 2010 17:52:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B98F5D90-8DFF-11DF-BB27-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150847>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Both single range clone and deeply clone are supported.

Please explain what you mean by "deeply clone" (no, not just a language
nitpick that it should at least be "deep clone"), and document which one
needs to be used in what situations to help people who would want to
decide which of these functions to call.

What I am trying to get at is that you might want to have only one kind of
clone that is _semantically_ deep (i.e. the list is copied, but the
elements are shared with refcounting), but makes a copy of the element
that is being updated on demand (i.e.  have an API function to allow users
to modify, which internally does copy-on-write if it is still shared).  I
don't know that kind of arrangement makes sense; it depends on how the
cloned ranges are used but I haven't looked at the callers.
