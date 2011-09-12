From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Mon, 12 Sep 2011 16:06:10 -0700
Message-ID: <7vboup4azh.fsf@alter.siamese.dyndns.org>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
 <20110912224934.GA28994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:06:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fa2-0006p2-54
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab1ILXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:06:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334Ab1ILXGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:06:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99954A33;
	Mon, 12 Sep 2011 19:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EfCi+z+lVrZTkRwwOzFU5HP5/GE=; b=EWX7Hr
	JmvzzNjkz/cCsgDz2zwLkFbBqmreWMSzcK4s4MxPP7bEzO3ESq+63tOzTvHG3a3a
	rjX68CHn8GEad0/EgzaFFRNiRmWjzCDDEZgbQI29g193WWEYOBnC/913JSKWyRMJ
	4RFKJqcC5iVOPSlhAJjidcZTmxT2m6L1R6XnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jMItcvdiAKf/F8Cd2/GR5kPmrsFHTG1o
	mYG6jl/PTtBDW5MdhmpGeXvI1wXfaUfK897r+A2itwtUZeD6/PQA1sd74BW3yKIm
	4Fjtlan1TQrj4U6Cq7Q+hkzSz5Fc4i6bVeo6U6Vbc91NUsjrRXQz2JsqULaPEp5R
	iemlYBkAOqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5834A32;
	Mon, 12 Sep 2011 19:06:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 439554A31; Mon, 12 Sep 2011
 19:06:12 -0400 (EDT)
In-Reply-To: <20110912224934.GA28994@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Sep 2011 18:49:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEF0124E-DD93-11E0-B404-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181244>

Jeff King <peff@peff.net> writes:

> Also also. I was a little turned off by the fact that every fetch is
> going to do the equivalent of "git log --raw -m $new --not $old",
> whether you have submodules or not.

Notice I called your patch solving "the other half"?
See http://thread.gmane.org/gmane.comp.version-control.git/181101
