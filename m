From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t5510: ensure we stay in the toplevel test dir
Date: Thu, 01 Mar 2012 13:57:04 -0800
Message-ID: <7vipiokmrz.fsf@alter.siamese.dyndns.org>
References: <cover.1330637923.git.trast@student.ethz.ch>
 <80204781996b200d08b73cf61fa50df468e4b51d.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3E02-0000Re-6q
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393Ab2CAV5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:57:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965317Ab2CAV5G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:57:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77AE37A1E;
	Thu,  1 Mar 2012 16:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b6vQiA8Q8T32qPlU1Q7oZZRwfsY=; b=XFdEpS
	vsYwNYlJ7ve72L0mCNP1bEc0y1Wf+hcOuZzs6OpvjUl5e6x1qzzMS5i6SoDZO2l1
	a7IZRWlZ4yCu12gCxx7xyFXOJvODfKijCBlBdGtCQHQr5E2/VCb5EQpmA5KWhGlT
	LEihC84feaRvMsAkKvBBaye07EhjRvOqNpAcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cw7MhQQWTuXHtUCG+aeS2Pv6wHR4ag6g
	d0ggCe3Ne2y5myHkGD2bC4QlkTBpwnaZZLrDzeVddoH1WGizbyOVqvjIlPacQ4FC
	mZuscxyS7e1M8WTOzT4+/lMXA3FcR1zoGSuiXVRnqkK3QFZh/hwb3ykqJk5Jwk8g
	1K+f69um3sQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 668657A1D;
	Thu,  1 Mar 2012 16:57:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6C707A1C; Thu,  1 Mar 2012
 16:57:05 -0500 (EST)
In-Reply-To: <80204781996b200d08b73cf61fa50df468e4b51d.1330637923.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 1 Mar 2012 22:40:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C2157EE-63E9-11E1-A79B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191979>

Thomas Rast <trast@student.ethz.ch> writes:

> The last test descended into a subdir without ever re-emerging, which
> is not so nice to the next test writer.

True.  Making the test suite more robust like this patch does is very much
appreciated.

Is there a reason why we shouldn't be sticking to the more usual

	mkdir dups &&
        (
        	cd dups &&
                do whatever in dups
	)

pattern?

> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  t/t5510-fetch.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 8827828..dd035bf 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -431,6 +431,7 @@ test_expect_success 'fetch --dry-run' '
>  test_expect_success "should be able to fetch with duplicate refspecs" '
>  	mkdir dups &&
>  	cd dups &&
> +	test_when_finished "cd .." &&
>  	git init &&
>  	git config branch.master.remote three &&
>  	git config remote.three.url ../three/.git &&
