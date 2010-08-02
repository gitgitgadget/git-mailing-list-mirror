From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep
 foo
Date: Mon, 02 Aug 2010 14:28:31 -0700
Message-ID: <7vsk2wk8lc.fsf@alter.siamese.dyndns.org>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
 <1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vvd7tlzfu.fsf@alter.siamese.dyndns.org> <vpqtyncdeuc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:28:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2Yx-0007LP-3N
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab0HBV2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 17:28:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab0HBV2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CA243CAE33;
	Mon,  2 Aug 2010 17:28:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s0JcfgppfLvfpVhu5XDmdw5XYa0=; b=KUrYW6
	z82REUJiVt9UhpCRG8nWBRI2vQFs81BunSWRe8ndGVPrtxYOMHVod6Y4ZvT2psZS
	S9ZGx6AjzGrjeR/Nt3sJhrORwLJra1Ychi+8tNYv0vgPmap7TsAGwGR20XQ5a953
	uAt/VF48UH44y14pYttGBgS+Mqo1O5Z225LV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/M2jjRf16mNy9HHxymI74DdJRiKD8mx
	NX5SidMWkn4NF61J+MDcpI0vHO8xOl9FlvHHlli45RInl6dlAFLlEgjpQVkXzmam
	aHsVSZZvKYcJgkdLrQBwkWdxBuRn1kqy4cYrz+iYogvRzSvBBRsG6fC/UsOQLkfJ
	ir9c4zGr9vU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A721FCAE2F;
	Mon,  2 Aug 2010 17:28:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB2DDCAE2E; Mon,  2 Aug
 2010 17:28:32 -0400 (EDT)
In-Reply-To: <vpqtyncdeuc.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 02 Aug 2010 20\:55\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E86663B0-9E7C-11DF-864B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152464>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The patch overall looks good, and this comments illustrates the issue
>> rather well.  When the user wants to use "--longopt val" syntax, s/he
>> needs to know that "--longopt" will always take a value.  Arguably
>> majority of options that can take value will, but like "--stat X,Y" this
>> leaves things inconsistent.  Without "--longopt value" patch there won't
>> be such an inconsistency, but I think this patch series is lessor of two
>> evils.
>
> ... especially when parse-option already does this:
>
> git commit --message foo   => works
> git gc --prune 'last week' => doesn't
>
> Just like most GNU tools:
>
> grep --regexp foo => works
> grep --color auto => doesn't

Hmm.

Are you hinting that we should keep "you can say '-Ofoo' and '-O foo'"
bits but we should drop "you can also say '--opt=foo' and '--opt foo' as
long as --opt always takes an argument"?

I actually think that may make sense.

>> Don't you by the way regret the naming of the parsing function by now?
>> There is nothing "diff" about it anymore.
>
> Right. I'll rename them to "parse_long_opt".

Thanks.
