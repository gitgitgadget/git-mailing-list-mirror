From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/12] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 12 Feb 2013 11:13:42 -0800
Message-ID: <7v621xgxax.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-6-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:14:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5LIv-000854-JH
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293Ab3BLTNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:13:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165Ab3BLTNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:13:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A2C8CD66;
	Tue, 12 Feb 2013 14:13:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aUaDsz+VUH4XR8+rijcZ2JmWz1o=; b=OJiTyj
	2D7YAwkLqzasoxMEouc7MbvXJKtkl3cNrw9ChecIvB9NA7OUJLoDcYpTNSFzxyEI
	OnFE2qDiQMw9BIr+yGsO41xjYlBiOMo0DVR1O/KR84OI4PR/e/GtPAiq0gE4l/J6
	WmLYFThQ162mDckr1aqOPbiantSSqXX9YB4LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=acLb8ceT3yp8/+lKdeATA7btq6dvy7Jz
	xGTJk+HC5w2BL30KBnEL4gzC/VKUa5ocG6uPI65PfcjnHxcf3DfOC0Opw76o30Oz
	Xa/k85RL8ojfi3J88gXj+obVpZgiX1DWI0BeMs7AXKzOeqev9bk7pe5kiaBxsW4C
	es55+p0XKNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DF5BCD65;
	Tue, 12 Feb 2013 14:13:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 853D2CD64; Tue, 12 Feb 2013
 14:13:44 -0500 (EST)
In-Reply-To: <1360664260-11803-6-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Tue, 12 Feb 2013 02:17:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51D4E39A-7548-11E2-8150-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216175>

Brandon Casey <drafnel@gmail.com> writes:

> When 'cherry-pick -s' is used to append a signed-off-by line to a cherry
> picked commit, it does not currently detect the "(cherry picked from..."
> that may have been appended by a previous 'cherry-pick -x' as part of the
> s-o-b footer and it will insert a blank line before appending a new s-o-b.
>
> Let's detect "(cherry picked from...)" as part of the footer so that we
> will produce this:
> ...
> +static int is_cherry_picked_from_line(const char *buf, int len)
> +{
> +	/*
> +	 * We only care that it looks roughly like (cherry picked from ...)
> +	 */
> +	return len > strlen(cherry_picked_prefix) + 1 &&
> +		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
> +}

Does the first "is it longer than the prefix?" check matter?  If it
is not, prefixcmp() would not match anyway, no?
