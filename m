From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] --dirstat-by-file: Make it faster and more correct
Date: Mon, 11 Apr 2011 11:14:57 -0700
Message-ID: <7vwrj0wt7i.fsf@alter.siamese.dyndns.org>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-1-git-send-email-johan@herland.net>
 <1302475732-741-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:15:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Ldt-0003Uq-IS
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab1DKSPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:15:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab1DKSPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 14:15:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B32C050F4;
	Mon, 11 Apr 2011 14:17:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eT4UGmZcz4OyBRA8f9SBW1glc/0=; b=c6Ol6E
	aevFZO1ydPSsGLUjnamYWs6+YXKxxG7eCooaCKqK4bKt7Rj4m3K2aimtJJRK3rq8
	A4n0cT3Kx8jCOOLUlf7iBgQHVnd+OF+4k2/8LRU4Zoh1vNe+MCUPu44KVAZhZxnC
	yOHbdWZ8GXHk8koKr4TIDFGlJ+6PyUXViy6CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=egArpVziGeqk4fyjFrrMHZmX4F3MpjoH
	oVU34qyCe7iKIkAouQz8+zwu8fvg3GKjuHtkKUtTv0kofkhqrQ4SesvfwALDRBPy
	w30FNzsf7XfV43Q8p7X70XqazKXjYUictmup/JKiJd7ZNIJT1gmi227fLHawrtE9
	t4UdwJuKWO4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E67450F1;
	Mon, 11 Apr 2011 14:17:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E3D450F0; Mon, 11 Apr 2011
 14:16:57 -0400 (EDT)
In-Reply-To: <1302475732-741-3-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 11 Apr 2011 00:48:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E55C124E-6467-11E0-8AA7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171343>

Johan Herland <johan@herland.net> writes:

> Currently, when using --dirstat-by-file, it first does the full --dirstat
> analysis (using diffcore_count_changes()), and then resets 'damage' to 1,
> if any damage was found by diffcore_count_changes().
>
> But --dirstat-by-file is not interested in the file damage per se. It only
> cares if the file changed at all. In that sense it only cares if the blob
> SHA1 for a file has changed. We therefore only need to compare the SHA1s
> of each file pair in the diff queue. As a result, we can skip the entire
> --dirstat analysis and simply set 'damage' to 1 for each entry where the
> SHA1 has changed.

Very sensible.  Thanks.
