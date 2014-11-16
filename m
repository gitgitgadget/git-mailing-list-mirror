From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Sun, 16 Nov 2014 10:40:42 -0800
Message-ID: <xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 19:41:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq4kt-0001LF-GI
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 19:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbaKPSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 13:40:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751617AbaKPSks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 13:40:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E2801A489;
	Sun, 16 Nov 2014 13:40:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cX1KKd6h8XE4WILRkwSS3zSYig4=; b=VPt3Oh
	Sc4q+1BL+QfdAV4VqtNt0d/882UmOcmhGINLVq3HFCtqyk17eUZK8PWQE1Bv1WnH
	p+lFtzpxXJIdfOjRecC1XU3nPLpQMjN5et28C0sugj3J+kJC3Ia0zzNytdjoo3C7
	gBH2+20IXcbPK7SstPoT3Vuv7zuvTUjZo1A3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lficzHjC2s8GgiSIZm6+LxBcUJ08HiKI
	BHqn5wwITVBowB56a3+KBPqmp95ItmfNvVZRpz//uBIVhnXtdS/6BIxFTpxUOJI8
	4afYoB+3qS1zb2Uu4I472l+I6KyOu/9dg7sXc6wRkQjUJ8/IhfUi8dOZ7xvwQGO0
	OB7bfyDFi84=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 686A01A488;
	Sun, 16 Nov 2014 13:40:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ACA21A483;
	Sun, 16 Nov 2014 13:40:47 -0500 (EST)
In-Reply-To: <1416012460-4459-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 14 Nov 2014 16:47:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 146DECFA-6DC0-11E4-8C84-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +post-format-patch
> +~~~~~~~~~~~~
> +
> +This hook is called after format-patch created a patch and it is 
> +invoked with the filename of the patch as the first parameter.

Such an interface would not work well with --stdout mode, would it?

And if this only works with output generated into the files, then

    $ git format-patch $range | xargs -n1 $your_post_processing_script

would do the same without any change to Git, I would imagine.

So I would have to say that I am fairly negative on this change in
the presented form.

An alternative design to implement this as a post-processing filter
to work for both "to individual files" and "to standard output
stream" output filter may be possible, but even in that case I am
not sure if it is worth the churn.

In general I'd look at post-anything hook that works locally with a
great suspicion, so that may partly be where my comment above is
coming from.  I dunno.
