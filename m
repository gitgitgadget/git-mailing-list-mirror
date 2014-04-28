From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 13:45:45 -0700
Message-ID: <xmqqlhupp4hx.fsf@gitster.dls.corp.google.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesR1-00051f-6I
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbaD1Upv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:45:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62986 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbaD1Upv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:45:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A365819BD;
	Mon, 28 Apr 2014 16:45:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=untrsr98dhvqde0HydVHl1qCoxw=; b=X7up3C
	dSPTl8NVSZTJQqgqwYxQ8zYd9Q18QgJUaMkm8jN5QgGOsAHNYGj5FOlLMzlqHFnk
	/Iwuma6tEpnReqDSaT+4bb9ZE2Izyp688uIHdY8YxOX9IC7qUxPdT54Mc+VS5k6U
	2QUh0mu4A/i+6LFXtbRpajvLWKpls1d8ChfL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b/tuu922fsjWuc28h1OiEI/LTGaMxmuF
	OVk70q3of56phQFsiPC0JjNQWTb9ROaLTKS3C7urbbZnPcCoANDqa1R6ut6IHSpt
	vuPTGcOMynsQWmcpkgzuXsA6Gx6lG+Y4iB0k8a+l2a8Y4Hi+P5slsgt41A8t4Qr2
	0DFJIyvUF7Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 210D6819BA;
	Mon, 28 Apr 2014 16:45:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98084819B7;
	Mon, 28 Apr 2014 16:45:47 -0400 (EDT)
In-Reply-To: <1398714653-1050-1-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Mon, 28 Apr 2014 12:50:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 139C5C9C-CF16-11E3-9087-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247443>

Dave Borowitz <dborowitz@google.com> writes:

> The original implementation of CURL_CONFIG support did not match the
> original behavior of using -lcurl when CURLDIR was not set. This broke
> implementations that were lacking curl-config but did have libcurl
> installed along system libraries, such as MSysGit. In other words, the
> assumption that curl-config is always installed was incorrect.
>
> Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
> to curl-config being missing), use the old behavior of falling back to
> -lcurl.
> ---

Sign-off?

I still think the implementation of "If CURL_CONFIG is unset" bit is
a bit redundant, though.

> +		CURL_CONFIG ?= curl-config
> +		ifeq "$(CURL_CONFIG)" ""
> +			CURL_LIBCURL =
> +		else
> +			CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
> +		endif

Other than that, the remainder of the change looks correct to me.

Thanks.  
