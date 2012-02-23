From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: add '*' modifier to add LF after non-empty
Date: Thu, 23 Feb 2012 11:53:24 -0800
Message-ID: <7v7gzd498r.fsf@alter.siamese.dyndns.org>
References: <1330002637-9347-1-git-send-email-pionchon.luc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luc Pionchon <pionchon.luc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 20:53:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ejO-000404-2u
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab2BWTx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 14:53:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab2BWTx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 14:53:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B03F79A6;
	Thu, 23 Feb 2012 14:53:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/lLYb8C4ghmhNk/q7jsQKSSUjX4=; b=tqs87C
	I6eNe3k9W6ddlhnlIH/GEgi7Mxm2P01Cpcxzs4rHqsxZQE5LAhygNug3CDhnwCdv
	+PVx+O1F1VDEFjNdwFw2AtrQTuIMI7Kh4dkq3gknIHYDw0SpEwVM+1vvxtCiYjFv
	tn4vE2lQyYL3M62fERtwAPPlt3Hb6n5Ei8mXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhwsURcjGfSQ5jAO8pdPTz0ZS4dZC6qG
	IIwlqDDesg/8ntGkl3/F2RI/IDlpbVkPcyNBdO/x8k8RXYLLSg0z12F6rN4OegZd
	27SgL1aDNjYwBrh5gQY32vT8DoYRy0NyBXj7dyKpYgQm1jKXbhvv5bbG0dV8bgO8
	i5xqLd3suVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E3B979A4;
	Thu, 23 Feb 2012 14:53:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5173798D; Thu, 23 Feb 2012
 14:53:25 -0500 (EST)
In-Reply-To: <1330002637-9347-1-git-send-email-pionchon.luc@gmail.com> (Luc
 Pionchon's message of "Thu, 23 Feb 2012 15:10:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CF39CD8-5E58-11E1-AE72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191389>

Luc Pionchon <pionchon.luc@gmail.com> writes:

> Add the '*' modifier, similar to the '+' modifier,
> to add a line-feed after a non-empty placeholder.

Hrm, I thought I designed the plus and minus fairly carefully so that
nobody needs to add this later.

Wouldn't it be sufficient to write

        Foo%n%-d

that says "We usually have LF after Foo, and write %d after that, but we
might not have anything interesting in %d at all, in which case we don't
add that %n"?

> +test_expect_success 'add LF after non-empty (1) (empty)' '
> +	git show -s --pretty=format:"%*d%s%nfoo%n" HEAD^^ >actual &&

Shouldn't this be equivalent to "%n%-d%s%nfoo%n", which in turn is covered
by one of the previous tests (del LF before empty)?
