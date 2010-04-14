From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make description of "core.autocrlf" less ambiguous
Date: Wed, 14 Apr 2010 06:55:04 -0700
Message-ID: <7vk4saqguf.fsf@alter.siamese.dyndns.org>
References: <1271201003-3413-1-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 15:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2348-0004OI-QK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab0DNNzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:55:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0DNNzf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:55:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E894BAAC95;
	Wed, 14 Apr 2010 09:55:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6K/CSQZUjI+n35RmI7ZWgC1YD2E=; b=bPxmoNJuCqmhNf32RYwuYlU
	bFiUxvR6kcFHVoxFga34eSRnGW/0G7aZxMX3Ub5JfA1qcr9FUZ9WMLg7ESXgTMyX
	YzcVdXthhh94ryE2w38xc7tzoDeT3qP2e9WO3ATn7Wp+ZhZbrRLy4l3UQWzVsEtf
	btKeb3AJWXlMaFk7h9Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=E+DFLhenjjDbnOKhewxlAI2/WctXORuvLOINvAtllLmQX2DdT
	Ox89QvnXJh/fmRQZ10jRy6ZuGIIoOEK4dE3uOsMFqo0rQP+4fhQqFb7CGnLvnfdZ
	FfehATuPpTi/MQy5xrF0lahlGIF4CUCoMt3MYaDDVZ7lYU6QV0wfH3w3t0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B4B2AAC89;
	Wed, 14 Apr 2010 09:55:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC416AAC87; Wed, 14 Apr
 2010 09:55:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 594047E2-47CD-11DF-8135-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144875>

Will Palmer <wmpalmer@gmail.com> writes:

> While I did some simple checks to ensure that my basic assumptions about
> how the commands I use daily seem to interact with core.autocrlf, I'll
> easily admit that I don't actually know all the places autocrlf is
> referenced, so I could be completely wrong about what generalizations
> can actually be made in the documentation.

Thanks.

The description uses "reading from the filesystem" vs "writing to the
filesystem" but as you may have noticed, there are cases that we do not
interact with "the filesystem".  Reading (e.g. "hash-object --stdin") from
the standard input may read (e.g. "hash-object --stdin <file") from the
filesystem, but we we may be reading from a "cmd | hash-object --stdin"
pipe.  Similarly, when we write to the standard output, "git to outside
world" direction does not necessarily write to the filesystem.  If you
really want to be anal, these should probably be reworded to "converting
the data from the outside world to the internal canonical representation"
vs "converting the data git has for consumption by the outside world".

The "anal" description, however, is way too verbose, while it might be
technically more correct.  I think the current description would be a
reasonable compromise, as "the filesystem" is the most typical case of
"the outside world"; other than the "the standard input may come from the
pipe" exception, I do not think there is much practical difference (but if
there are more, we might need to sacrifice the readability and go with the
"anal" one).

Very low level plumbing commands deliberately omit the conversion in order
to show the raw data (e.g. cat-file), so it is not correct to reword it to
"when output" as in your version.
