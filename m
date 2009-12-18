From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: fix patch format detection for Thunderbird "Save As"
 emails
Date: Thu, 17 Dec 2009 16:15:25 -0800
Message-ID: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
References: <1261094299-22930-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 01:15:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLQVR-0004EC-Hg
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 01:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbZLRAPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZLRAPg
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 19:15:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZLRAPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 19:15:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F043FA78A3;
	Thu, 17 Dec 2009 19:15:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HwS5FJQnOJDL+vnhdIqcro/ibx8=; b=aYo4UZ
	eOvYNIKZPmlhmSJlmKelNC6nx9XN2fQqNCJNSocrK0tn0A3D7dMEgcmEnIKxAAyH
	bZAd/YutslcBtyTFO0dttH7XLUO9YqxxozPRpR9bGVGRgEujobwxsKMHDGYjrPQL
	ZzfiE6lUfkvQGqz1ZQ2/HutwH4D5IHCXTBGIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tqq7inkYvZ4srqOJ9QSnKJFK4sf/WHqx
	+WW+AzzwcIdAZOxw6HrT2oM1oXUzMnYMVKSS40u2lYRXRkkct1MLR68Bd5JVMxKj
	r+7f0fey4/ZwBo+Qdx8d/oqzZlK6+8g6PGI1LyR9HerEyplo6ujeykC1BfiB2BI/
	3VVTbmOevgw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0195A78A2;
	Thu, 17 Dec 2009 19:15:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DCEC1A78A1; Thu, 17 Dec 2009
 19:15:27 -0500 (EST)
In-Reply-To: <1261094299-22930-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Thu\, 17 Dec 2009 15\:58\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 73B66E36-EB6A-11DE-B9C6-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135391>

Stephen Boyd <bebarino@gmail.com> writes:

> I'm not sure how portable \r in a sed invocation is.

Not very portable.

Adding

	tr -d '\015' <"$1" |

in front of the original "sed" invocation might be a better choice.

> but seems necessary because check_patch_format() is called before any
> splitting with mailsplit is done (where I assume the fix for the issue
> will be done).

I agree that the way non-native mbox format was bolted onto "am" is
somewhat unfortunate.
