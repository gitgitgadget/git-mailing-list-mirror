From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Wed, 04 Sep 2013 13:57:39 -0700
Message-ID: <xmqqli3cl2yk.fsf@gitster.dls.corp.google.com>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
	<1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
	<xmqqob89r8bc.fsf@gitster.dls.corp.google.com>
	<522791AE.8070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHK9A-0003vD-JM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759768Ab3IDU5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:57:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756913Ab3IDU5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:57:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C633C3FAD6;
	Wed,  4 Sep 2013 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VluS0EBBel+GU8k+HZ74w117DKU=; b=HJUqAB
	plTdhJON9XeVLHkIb0Dpfp1qgymbYvjmsdUjmwNIJJsUOnAQY4jT3v7JmV0Bu382
	IYbgAbzMQ+PY9TS5JCrAbY4BquW96bUzm5T5Mkk+oCZvhdZxZgqYOQU7pFD/wL71
	1txS7rUVRdEQoPFDYip1lSbg/DjyUmirgrG/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K7+9Xrp3Vdljt8vuWr07WF7EYDPFPNC5
	U6nGRYLq7vRXS2KfcCEoC7dKGfUEez34LekCpvA1bCHXk+JidO7+6ACwtE9d5QZ4
	0pE+r8tovdUt/M6GAqQXtYQ4cJCLp5QYaXEJKGVB7HiyDyrTbeAO0jWq0nI873Jf
	uDjLaM7lT/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 180AD3FACF;
	Wed,  4 Sep 2013 20:57:45 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BBAE3FABB;
	Wed,  4 Sep 2013 20:57:43 +0000 (UTC)
In-Reply-To: <522791AE.8070103@web.de> (Jens Lehmann's message of "Wed, 04 Sep
	2013 22:01:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4BF6970-15A4-11E3-A01F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233877>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 03.09.2013 21:53, schrieb Junio C Hamano:
>> Jens, I see 1/2 is the same as the previous one you already acked.
>
> Yep.
>
>> Does this update to 2/2 look good to you?  Sorry, but I lost track
>> of the discussion that led to this reroll, hence a ping.
>
> v3 fixes the bug Matthieu noticed, I only had some remarks to the
> new test Brian added. If you could replace his patch to t7401 with
> the following diff it's an ack from me on this one too.
>
> -------------------------8<---------------------------
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index ac2434c..81ae7c9 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -104,6 +104,24 @@ EOF
>  	test_cmp expected actual
>  "
>
> +test_expect_success 'no ignore=all setting has any effect' "
> +	git config -f .gitmodules submodule.sm1.path sm1 &&
> +	git config -f .gitmodules submodule.sm1.ignore all &&
> +	git config submodule.sm1.ignore all &&
> +	git config diff.ignoreSubmodules all &&
> +	git submodule summary >actual &&
> +	cat >expected <<-EOF &&
> +* sm1 $head1...$head2 (1):
> +  > Add foo3
> +
> +EOF
> +	test_cmp expected actual &&
> +	git config --unset diff.ignoreSubmodules &&
> +	git config --remove-section submodule.sm1 &&
> +	git config -f .gitmodules --remove-section submodule.sm1
> +"
> +
> +
>  commit_file sm1 &&
>  head3=$(
>  	cd sm1 &&

Thanks.

The above patch makes the <<-EOF situation that already exists in
this script worse. The only reason we would say -EOF not EOF is
because we would want to indent the here-document to align with the
rest of the command sequence, so we should either indent with HT, or
drop the dash.  I suspect the original did it that way fearing that
someday the indentation of the submodule difference list might start
using HT, but I do not think that is likely to happen, so my vote
goes to keeping '-' and indenting.

We need a clean-up patch after this series settles.
