From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Thu, 11 Oct 2012 10:09:09 -0700
Message-ID: <7vvceh6imi.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org>
 <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
 <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
 <7vlifd7zz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMGC-0001TA-NM
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964Ab2JKRJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:09:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758936Ab2JKRJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 13:09:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 732CE9A5F;
	Thu, 11 Oct 2012 13:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=63AljP+hu5m3o+ng8piN+kwjTzc=; b=Qsw+vO
	JsEEHMNXQHudQec+Q4Z/+avfuraTKUWkXEwEOIjS5A358iQ3G3VQ1mqoUPVsIX9f
	25PmZCrkXIskxxpomUfAi906WPtziJ7tVYgd5mb+NwV0Yj265Embwli3CPtyAH7d
	Bk016piS1i2l+9hw27IGMhXh66kfmCLX+Bbio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5aYKr2HYoZXTxAgp/M2ggcWrBFGRyJL
	Huo00g/0IoQlm5bZdShIQYbHOmy+5o0kuG0Q7bo6poiKeH364WS1HGtdJKnTH992
	QUa6NPy6xXMQNpE61bM3zgeAh3JWCtiwn7OMR+zIJznO4a9VdNZrNbXkom/Gl2NB
	nyIDxE7SWYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F0F89A5E;
	Thu, 11 Oct 2012 13:09:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEFD69A5D; Thu, 11 Oct 2012
 13:09:10 -0400 (EDT)
In-Reply-To: <7vlifd7zz3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 11 Oct 2012 09:09:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FF006AA-13C6-11E2-8BC2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207489>

Junio C Hamano <gitster@pobox.com> writes:

>>> This probably is due to this part of the output:
>>>
>>>     ok 72 - wildmatch 1 1 [ab] [\[:]ab]
>>>     ok 73 - wildmatch 1 1 ?a?b \??\?b
>>>     ok 74 - wildmatch 1 1 abc ^G^Hok 75 - wildmatch 0 0 foo
>>>     ok 76 - wildmatch 1 0 foo/bar/baz/to **/t[o]
>>>     ok 77 - wildmatch 1 1 a1B [[:alpha:]][[:digit:]][[:upper:]]
>> ...
>
> I suspect that this is the immediate culprit:
>
>     match 1 1 'abc' '\a\b\c'
>
> The symptom looks like that somebody is interpreting \a as BEL, \b
> as backspace, etc. when showing the "ok ..." line, no?

Ahh, it must be this bits from t/test-lib.sh

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/t/test-lib.sh w/t/test-lib.sh
index 514282c..489bc80 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -230,7 +230,7 @@ else
 	say_color() {
 		test -z "$1" && test -n "$quiet" && return
 		shift
-		echo "$*"
+		printf "%s\n" "$*"
 	}
 fi
 
