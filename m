From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Wed, 28 Jan 2015 22:34:03 -0800
Message-ID: <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 29 07:34:15 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGig9-0002Hm-E8
	for glk-linux-kernel-3@plane.gmane.org; Thu, 29 Jan 2015 07:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbbA2GeI (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Jan 2015 01:34:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbbA2GeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2015 01:34:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF7C62950E;
	Thu, 29 Jan 2015 01:34:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nSy55U9W3fg6J3jkpJtW0EYCyh4=; b=U8k1/p
	KIbTlqp5Z02+eyaysQwfHfqkmVyGvHFQtGLKWd23oNRY5KVdyX6GKDpwbffb5I+H
	Oji2lbY/vOVQd+P85yqTZTuysSnHFBEcypsk3bA/soiZptzzoZgBOIAG9BabI+Bg
	Il/sAHxDgbXtkLkaGsTyBRio4mOrtGpWCBl98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hIUWnQMJO5SKjB1g0PnE+j64Ghr7qZF6
	DzjWo5WNQrrUULZ37NZdMfxFmBHP5CUhld4I3JRkgqbzGhlvUlo4ofhTlK7Nq/RZ
	US6V17J5AfvimDAOrod5wAM7eeWfyKreY/YKCM1ydX51V1XGc+VBfctjHXikRTyN
	yP+4B/ENHpQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4E562950D;
	Thu, 29 Jan 2015 01:34:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 691512950B;
	Thu, 29 Jan 2015 01:34:04 -0500 (EST)
In-Reply-To: <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Jan 2015 22:05:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1C71494-A780-11E4-A367-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263143>

Junio C Hamano <gitster@pobox.com> writes:

> Subject: [PATCH] apply: refuse touching a file beyond symlink
>
> Because Git tracks symbolic links as symbolic links, a path that has
> a symbolic link in its leading part (e.g. path/to/dir being a
> symbolic link to somewhere else, be it inside or outside the working
> tree) can never appear in a patch that validly apply, unless the
> same patch first removes the symbolic link.

I should rephrase the above to make it more readable.

    ... its leading part (e.g. path/to/dir/file, where path/to/dir is a
    symbolic link to somewhere else, ...

is what I meant to say.
