From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/9] streaming_write_entry: propagate streaming errors
Date: Tue, 26 Mar 2013 14:38:17 -0700
Message-ID: <7vy5d9suye.fsf@alter.siamese.dyndns.org>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202216.GF16019@sigill.intra.peff.net>
 <20130325213934.GE1414@google.com>
 <20130325214936.GA22419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:38:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbZw-0004OJ-DN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab3CZViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:38:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab3CZViT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:38:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B1DA259;
	Tue, 26 Mar 2013 17:38:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eXWwsU+cqAVW0NTHGNjZ5m+rIDg=; b=Jjt0u+
	jfdJUBGQVgRJ/30ZlLQ41PJ7HUw6ksxwUeoNynM4OImz/avZQmDJLrGJposNCd01
	HQzjkDp5Z6XZEOy2fSE4laBlEChq3y0u6LDUPpx4xhb7WyBkCqhNzuWHgzfoc4nj
	xASnDbDhJv70C+Nb2eDBTO1rScTaP3EputCpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YeL1BYgLJuJ4+6QByMWTKtwnU7Hw+AqS
	Lhr7EkXL4jGkZJpSuAiAdvKmD83JCNa7StTFT4Rg+Xo6MqPFJo0tSpujefuPYduO
	HAMFsIh97AnFpTbHEZpwGIHpxUWsLTJ1g2rkKzuz7d+oswFp09GPZoXI6b3KH125
	Vv02Q7jkjuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E8FA258;
	Tue, 26 Mar 2013 17:38:19 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A495A253; Tue, 26 Mar 2013
 17:38:18 -0400 (EDT)
In-Reply-To: <20130325214936.GA22419@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Mar 2013 17:49:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 794CE2A2-965D-11E2-BCD0-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219214>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] streaming_write_entry: propagate streaming errors
>
> When we are streaming an index blob to disk, we store the
> error from stream_blob_to_fd in the "result" variable, and
> then immediately overwrite that with the return value of
> "close". That means we catch errors on close (e.g., problems
> committing the file to disk), but miss anything which
> happened before then.
>
> We can fix this by using bitwise-OR to accumulate errors in
> our result variable.
>
> While we're here, we can also simplify the error handling
> with an early return, which makes it easier to see under
> which circumstances we need to clean up.
>
> Signed-off-by: Jeff King <peff@peff.net>

Very sensible.  Thanks.
