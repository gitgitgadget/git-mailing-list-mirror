From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 07/15] t4019 (diff-wserror): add lots of missing &&
Date: Wed, 29 Sep 2010 12:01:38 -0700
Message-ID: <7v4od8nzl9.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 21:02:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P11vL-0006kA-UC
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 21:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab0I2TBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 15:01:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0I2TBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 15:01:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A769DA27F;
	Wed, 29 Sep 2010 15:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/JwB8+iN0Q5HCN8rPiCgweBRwA=; b=k+n1rT
	JdPm05eF9qF5if9HosT5VW1gahUdl+Uajllfalark6GmBO2qqtK3ICxUF4U1JNkL
	zrl2KZ/8ps4fWKECjbJbIxUWyr+47Ur2+4F1ZUejrpCSE1i8tjGGSb1USYwxQQqh
	3nUdRstgJGpZqjz7iby1lPf+bcEqUs0kk4pdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JAeuWS/3M3LxOocVG4klrV0xT8YckR1j
	Hb75cAX5caV3t1EPA1zqiMsFNyqf11bNWVoF93Ftq54Iqq1squgCJpyGYscIIcvJ
	b+seNP+hXI12MoEiOgXBgCzSX+fawvWif646LDDDVS6RBQnoGS9tF9FXsnMg0puM
	b1tel2VK8PE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAAF9DA27D;
	Wed, 29 Sep 2010 15:01:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DCDFDA27C; Wed, 29 Sep
 2010 15:01:40 -0400 (EDT)
In-Reply-To: <1285542879-16381-8-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\, 26 Sep 2010 17\:14\:31 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 000B9DC6-CBFC-11DF-886A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157589>

Elijah Newren <newren@gmail.com> writes:

> Also add a test_might_fail in front of the final git_config --unset
> core.whitespace as that value may have already been unset previously.

In general, if a previous one that is designed to set a variable failed
for whatever reason, the next one that does --unset without might-fail
will be broken.  So...

> @@ -65,9 +65,9 @@ test_expect_success 'without -trail' '
>  
>  test_expect_success 'without -trail (attribute)' '
>  
> -	git config --unset core.whitespace
> -	echo "F whitespace=-trail" >.gitattributes
> -	prepare_output
> +	git config --unset core.whitespace &&

... I think you need might-fail in front of this one, and ...

> +	echo "F whitespace=-trail" >.gitattributes &&
> +	prepare_output &&
>  
>  	grep Eight normal >/dev/null &&
>  	grep HT error >/dev/null &&
> @@ -79,9 +79,9 @@ test_expect_success 'without -trail (attribute)' '
>  
>  test_expect_success 'without -space' '
>  
> -	rm -f .gitattributes
> -	git config core.whitespace -space
> -	prepare_output
> +	rm -f .gitattributes &&
> +	git config core.whitespace -space &&
> +	prepare_output &&
>  
>  	grep Eight normal >/dev/null &&
>  	grep HT normal >/dev/null &&
> @@ -93,9 +93,9 @@ test_expect_success 'without -space' '
>  
>  test_expect_success 'without -space (attribute)' '
>  
> -	git config --unset core.whitespace
> -	echo "F whitespace=-space" >.gitattributes
> -	prepare_output
> +	git config --unset core.whitespace &&

... this one, ...

> +	echo "F whitespace=-space" >.gitattributes &&
> +	prepare_output &&
>  
>  	grep Eight normal >/dev/null &&
>  	grep HT normal >/dev/null &&
> @@ -107,9 +107,9 @@ test_expect_success 'without -space (attribute)' '
>  
>  test_expect_success 'with indent-non-tab only' '
>  
> -	rm -f .gitattributes
> -	git config core.whitespace indent,-trailing,-space
> -	prepare_output
> +	rm -f .gitattributes &&
> +	git config core.whitespace indent,-trailing,-space &&

... this one, ...

> +	prepare_output &&
>  
>  	grep Eight error >/dev/null &&
>  	grep HT normal >/dev/null &&
> @@ -121,9 +121,9 @@ test_expect_success 'with indent-non-tab only' '
>  
>  test_expect_success 'with indent-non-tab only (attribute)' '
>  
> -	git config --unset core.whitespace
> -	echo "F whitespace=indent,-trailing,-space" >.gitattributes
> -	prepare_output
> +	git config --unset core.whitespace &&

... this one, ...

> +	echo "F whitespace=indent,-trailing,-space" >.gitattributes &&
> +	prepare_output &&
>  
>  	grep Eight error >/dev/null &&
>  	grep HT normal >/dev/null &&
> @@ -135,9 +135,9 @@ test_expect_success 'with indent-non-tab only (attribute)' '
>  
>  test_expect_success 'with cr-at-eol' '
>  
> -	rm -f .gitattributes
> -	git config core.whitespace cr-at-eol
> -	prepare_output
> +	rm -f .gitattributes &&
> +	git config core.whitespace cr-at-eol &&
> +	prepare_output &&
>  
>  	grep Eight normal >/dev/null &&
>  	grep HT error >/dev/null &&
> @@ -149,9 +149,9 @@ test_expect_success 'with cr-at-eol' '
>  
>  test_expect_success 'with cr-at-eol (attribute)' '
>  
> -	git config --unset core.whitespace
> -	echo "F whitespace=trailing,cr-at-eol" >.gitattributes
> -	prepare_output
> +	git config --unset core.whitespace &&


... and this one, too.

> +	echo "F whitespace=trailing,cr-at-eol" >.gitattributes &&
> +	prepare_output &&
>  
>  	grep Eight normal >/dev/null &&
>  	grep HT error >/dev/null &&
> @@ -179,11 +179,11 @@ test_expect_success 'trailing empty lines (2)' '
>  '
>  
>  test_expect_success 'do not color trailing cr in context' '
> -	git config --unset core.whitespace
> +	test_might_fail git config --unset core.whitespace &&
>  	rm -f .gitattributes &&
>  	echo AAAQ | tr Q "\015" >G &&
>  	git add G &&
> -	echo BBBQ | tr Q "\015" >>G
> +	echo BBBQ | tr Q "\015" >>G &&
>  	git diff --color G | tr "\015" Q >output &&
>  	grep "BBB.*${blue_grep}Q" output &&
>  	grep "AAA.*\[mQ" output
> -- 
> 1.7.3.95.g14291
