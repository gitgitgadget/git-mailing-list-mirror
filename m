From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v9 08/11] trailer: add tests for "git interpret-trailers"
Date: Tue, 01 Apr 2014 15:51:54 -0700
Message-ID: <xmqqha6cy86t.fsf@gitster.dls.corp.google.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.56221.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 11:13:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdef-0004JW-NL
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbaDAWv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 18:51:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbaDAWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 18:51:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 031AC79AA8;
	Tue,  1 Apr 2014 18:51:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iXBcQr/EGmjzM3wBvD4kxrBdy6g=; b=bSNle3
	tRPfoLvId51GgDZe8YgCBfAlvDa6XO2wLrZBuo0aMc0PZWxpj5d0XZIsLlsA4J0f
	sfL4KSLY9cNND3eqKuE6CnagACvYkwUw8WHT43vnslJUWjz6KhQRjBADUgmDOcp7
	xMO9S6Cqf7EmHQML0tHvO3jxh/8nPGis4Mfbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hpcaF1TA4WMx16xci3Xzr4N7PFf+fCer
	3f0DiRRmS0OA8ObpwI36or8E2qWH4a2QsPqyupTPYB+V1fT9ErAno9VxU0vO6E9N
	0nRiBKnpLQzj8snugF3Dk8Sw0FLc0Pk5z76Ti13tIWzU1NahuVYohKD+nk0cKSk/
	JeybNmXBPGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E242179AA7;
	Tue,  1 Apr 2014 18:51:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC6F779A9E;
	Tue,  1 Apr 2014 18:51:55 -0400 (EDT)
In-Reply-To: Junio C. Hamano's message of "Tue\, 01 Apr 2014 14\:55\:21 -0700"
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3980BA38-B9F0-11E3-820B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245667>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> +test_expect_success '--trim-empty without config' '
>> +	cat >expected <<-\EOF &&
>> +		ack: Peff
>> +		Acked-by: Johan
>> +	EOF
>> +	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
>> +	test_cmp expected actual
>> +'
>
> Let's avoid these overlong and unreadable lines by doing something
> like this (just one hunk shown for illustration):
>
>  		ack: Peff
>  		Acked-by: Johan
>  	EOF
> -	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
> +	git interpret-trailers --trim-empty "ack = Peff" \
> +		"Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
>  	test_cmp expected actual
>  '
>  

I'll squash in the line-chopping fix to this, and also fill a
missing whitespace in 3/11 before pushing it out to 'pu'.  Hopefully
the result can be later merged to 'next' without further rerolls.

Thanks.
