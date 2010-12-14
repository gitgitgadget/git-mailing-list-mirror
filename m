From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Refactor parse_loc
Date: Tue, 14 Dec 2010 15:20:20 -0800
Message-ID: <7vr5dkq6vf.fsf@alter.siamese.dyndns.org>
References: <cover.1292291624.git.trast@student.ethz.ch>
 <ff9def9ac3f207b9f9be9c59ec3a313c9b3d4d84.1292291624.git.trast@student.ethz.ch> <7v8vzsrmhk.fsf@alter.siamese.dyndns.org> <201012150006.12462.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:20:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSeAg-00087m-6E
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760222Ab0LNXUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:20:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760172Ab0LNXUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:20:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54EEF2EA5;
	Tue, 14 Dec 2010 18:20:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=INKDvVvkUE7vSDC+h5KLWjMvQgQ=; b=A75obo
	E/ivIqkxP2FZvVCCfHXQOBqq16TOmhzHCyT7ITOP0TVP0vDhXRKXk7j4OR7W7F1v
	gdzTzw0jKmv7sK9oyNEOz6LK1AHH0lC7WzWQ0xgmPOvp8wnR1Iu+S5ifv1jUTLXq
	0/Q/hyXWRtaxKlEmdTp2kdGmJ7SwycuLwoPCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gu8KNCEaVCyU2B3igbKXFWY+3u4h3UA+
	oRpWa7KkxeL/llI9ynEPEuOJQb5fwPDdMhT+9KcJnEbhMECBh4ee87CflybqCckc
	8RQ7985j/axiJ4Zn66fLQowL5c+DnEAnTmonaDLGsu8GePAlTJ3hcDqCXpN2W4zA
	/r+28NH/kAg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C8CC2E9E;
	Tue, 14 Dec 2010 18:20:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D4C02E9C; Tue, 14 Dec 2010
 18:20:49 -0500 (EST)
In-Reply-To: <201012150006.12462.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 15 Dec 2010 00\:06\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCC20C70-07D8-11E0-9457-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163719>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> > +test_expect_success 'blame -L parses end' '
>> > +	git blame -L1,1 tres >out &&
>> > +	cat out &&
>> > +	test $(wc -l < out) -eq 1
>> > +'
>> 
>> What does this test exactly?  "end"?
>
> That's the test I was referring to in the commit message:
>
>   The new test is for a case that made me pause during debugging: the
>   'blame -L with invalid end' test was the only one that noticed an
>   outright failure to parse the end *at all*.  So make a more explicit
>   test for that.
>
> So I guess a more thorough test title would be
>
>   blame -L parses <end> part of its argument
>
> IOW, the test verifies that -L1,1 is not parsed the same as -L1, which
> would result in *two* lines of output.

Oh the comment definitely was misleading.  It made me think that "-L1,1" was
a typo of "-L1,$" which was the new feature in the patch.
