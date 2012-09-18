From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6] clone --single: limit the fetch refspec to fetched
 branch
Date: Tue, 18 Sep 2012 12:45:36 -0700
Message-ID: <7vfw6fm7xb.fsf@alter.siamese.dyndns.org>
References: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
 <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3jw-0006vd-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab2IRTpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:45:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498Ab2IRTpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:45:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EED19DF3;
	Tue, 18 Sep 2012 15:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6rW44QFKop3+BMXalzzQj+D9G2k=; b=PSKVIH
	rXBGsRnJrnfceHcNuW/15b2FewlCiIRFl/vH6o+ZWorrYF1Bz6oTqbo/0gOYvhug
	DSCZMAVSTD7FL62jo6V6sQaxrOr7u9erpan3yZ1UOWmNUUD/c3Vr74P4ltniw4eF
	ZU3QKfzZ06WWoqtTNXIUoKuZGHJIGCRe6GPv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQ+0SGC1fS+JYgWXdlls24CI2ik4AQ1T
	UoUDzM1Wj8AyOsQpTkZt3/MqinEFU7tn/9dFLFIYDsMqmJ4lO0Z0CQ22D2+863W6
	vBVDAIviSb49Mo7Gut0w+tozI1QqJxsDy1lCYByguIgwd994hNbuu3DqkY4wc/XQ
	JQspkQD2XfA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDAC9DF2;
	Tue, 18 Sep 2012 15:45:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94DC99DF0; Tue, 18 Sep 2012
 15:45:37 -0400 (EDT)
In-Reply-To: <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Tue, 18 Sep 2012 21:14:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B61E184-01C9-11E2-8572-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205857>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> + ...
> +	# explicit --single with tag
> +	git clone --single-branch --branch two . dir_tag &&
> +
> +	# advance both "master" and "side" branches
> +	git checkout side &&
> +	echo five >file &&
> +	git commit -a -m five &&
> +	git checkout master &&
> +	echo six >file &&
> +	git commit -a -m six

Don't we also want to cover your "delivery" tag scenario by updating
the tag "two" before letting the clones fetch in the following test?

> + ...
> +test_expect_success '--single-branch with explicit --branch tag' '
> +	(
> +		cd dir_tag && git fetch &&
> +		git for-each-ref refs/tags >../actual
> +	) &&
> +	git for-each-ref refs/tags >expect &&
> +	test_cmp expect actual
> +'
