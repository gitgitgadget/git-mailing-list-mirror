From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] tag: recognize rfc1991 signatures
Date: Mon, 08 Nov 2010 11:27:51 -0800
Message-ID: <7vlj53pqdk.fsf@alter.siamese.dyndns.org>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
 <4CAB90EC.1080302@drmicha.warpmail.net>
 <553a88c4ac00e681e605b81f3ce10342a881ac2f.1289041051.git.git@drmicha.warpmail.net> <AANLkTi=ZmBdJWKj1z0HE=tFoftzDSJaU5=Ji_1ywcA8+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Stephan Hugel <urschrei@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:28:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXO2-0003br-N5
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab0KHT2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:28:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab0KHT2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E160236ED;
	Mon,  8 Nov 2010 14:28:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FfVJh4ZfnO4AKNyCRfvc+vIWdjc=; b=ODkXvL
	5aV+l4VAFbGoyspkgj+Ctau/LEFek7crMOcQjv5L2dgU109PYhIiFf7lXZcwMYjn
	0DZVzVYCBHVfypmAh8k8pWwVK5r5Us09iLA3+9jucdYGJnfUl/nS0MOWDThL4r82
	b/TKFW8iXnzPhpwduH25KCCM3tvFlDpEF1LlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMsrsiMVKGgF3y49QZWjTvMA+qzK4F1z
	q3bcWzhTv6b4YYC7l7QeWQbyFHUH4835muHhycvNJC1GH5+w7PwdQX0dpXmIwYP9
	CgT/O9M4y+FUUGB7f7J5K3jSYMSAvmLc5gXjk89pSkMiPGystiqPNw28/qZ1wEUl
	HrwzwFHPl5Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A353C36E9;
	Mon,  8 Nov 2010 14:28:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46FD436E8; Mon,  8 Nov 2010
 14:27:56 -0500 (EST)
In-Reply-To: <AANLkTi=ZmBdJWKj1z0HE=tFoftzDSJaU5=Ji_1ywcA8+@mail.gmail.com>
 (Thiago Farina's message of "Sat\, 6 Nov 2010 15\:46\:51 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D1106A6-EB6E-11DF-9F14-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160972>

Thiago Farina <tfransosi@gmail.com> writes:

> On Sat, Nov 6, 2010 at 9:04 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> diff --git a/tag.c b/tag.c
>> index 5f9626c..18a5142 100644
>> --- a/tag.c
>> +++ b/tag.c
>> @@ -138,7 +138,8 @@ size_t parse_signature(const char *buf, unsigned long size)
>>  {
>>        char *eol;
>>        size_t len = 0;
>> -       while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
>> +       while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)
>> +                       && prefixcmp(buf + len, PGP_MESSAGE)) {
>
> nit: I think this && should be in the end of the previous line. (Not
> sure what is the preferred style though, comments?).

I personally prefer to lay out a multi-line expression so that you can see
the parse tree when you tilt your head the same way as when you view ;-),
i.e. what Michael wrote, but when I inherited the codebase, nobody wrote
multi-line expressions that way, so the standard coding style here has
become "&& at the end" due to the "mimic the surrounding code" rule.
