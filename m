From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: colour upstream branches
Date: Sun, 14 Apr 2013 18:52:25 -0700
Message-ID: <7vd2tw4l2e.fsf@alter.siamese.dyndns.org>
References: <1365982707-25455-1-git-send-email-felipe.contreras@gmail.com>
 <20130415004746.GA6477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYax-0001kq-6R
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab3DOBw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:52:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab3DOBw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:52:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F258E4CF;
	Mon, 15 Apr 2013 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s6g6lJLo6fuVKsbi+qlVi9EpaT4=; b=SEsvBm
	KZy8AJIpPPYcY+OjfMyZSwb9D0yeYFbUDydiLnBptb6pT9mOeWMzu/TvZuTLQHMk
	rMahDvimoTdnRA35ovwTkhfRXMVwnysSZ9OwAO8YK0fPGHfyb0am7FAa8Llk/Ik/
	Xn8iPl0UktetlTm2FTp5XLztmLqum0lu2Yhhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvTvF4gmcMxtsbkm/md+GB+NLzlexSTd
	9K/2fvSRa5XXzxRy1UbwpaoIJl4uNoT5L7DsTND8cWazS5OfLaFPVBye8pRnNIaT
	wWEIWa9WwBnMkPoJUrYTTHOFQtsd6xTKpAsRXJ5qmGzw0u7uMZ0JXiTEFLIMoEwl
	UDgxz9i1Xj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42B8BE4CE;
	Mon, 15 Apr 2013 01:52:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFB30E4CB; Mon, 15 Apr 2013
 01:52:26 +0000 (UTC)
In-Reply-To: <20130415004746.GA6477@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 14 Apr 2013 20:47:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC1A684-A56F-11E2-A41F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221181>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 14, 2013 at 06:38:27PM -0500, Felipe Contreras wrote:
>
>> +		if (want_color(branch_use_color))
>> +			snprintf(fancy, sizeof(fancy), "%s%s%s",
>> +					branch_get_color(BRANCH_COLOR_UPSTREAM),
>> +					ref, branch_get_color(BRANCH_COLOR_RESET));
>> +		else
>> +			strncpy(fancy, ref, sizeof(fancy));
>
>   $ man strncpy | grep -C1 Warning
>   The strncpy() function is similar, except that at most n bytes of src are
>   copied.  Warning: If there is no null byte among the first n bytes of src,
>   the string placed in dest will not be null-terminated.

Is there a reason to avoid strbuf_addf() here?  We are talking about
output for human consumption and not performance critical code, no?
