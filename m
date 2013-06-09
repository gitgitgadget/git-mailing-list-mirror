From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 09 Jun 2013 12:20:36 -0700
Message-ID: <7vy5ajozuj.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllAY-0000Fp-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab3FITUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:20:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab3FITUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:20:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53F0265B6;
	Sun,  9 Jun 2013 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kcZ2B0UOOr62NczcIfM5w6cZ/c0=; b=VPcDoZ
	xKHI/HWdNpqmIhMak/3pGFsFcbyWcXWsJcVvcZP410mg4rRh6l61OI3i4aqflds1
	Maxw8r9cReQ0DQulGycl7UguweRvFPxOYRl+buaZWuMsBc/6lCgv+TNWZKlft75V
	QsNXKX4JuqXsAjO0Y1Zy5f+v4pgocGL2eYCzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jfRi3OCSqCRc1/NvTn0yAxnU3QDxWeXG
	L0JeKrVgD+ZKvTsyl+Im0REh5EgQFnrNJAux3lqlUiBzaU7Pc8DDslEo8UH2P2kq
	hMW6p5GHPV4/7viJ4RkEPzRXWDNUjMK2nGND0b1UkHTTjk+umkPWJb+LR4Ma+2sX
	sV4ZZPleJUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8770265B5;
	Sun,  9 Jun 2013 19:20:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D82B265B3;
	Sun,  9 Jun 2013 19:20:43 +0000 (UTC)
In-Reply-To: <CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 9 Jun 2013 13:35:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADC5A8F4-D139-11E2-8049-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227106>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Jun 9, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -606,6 +606,18 @@ test_cmp() {
>>         $GIT_TEST_CMP "$@"
>>  }
>>
>> +# Check if the file expected to be empty is indeed empty, and barfs
>> +# otherwise.
>> +
>> +test_output_must_be_empty () {
>
> Why such a big name? test_empty() does the trick.

Primarily in order to avoid that exact name "test_empty" that others
may want to use for a helper to check that the contents of a string
variable is empty.  test-file-must-be-empty is a bit shorter and
also good for that purpose; I do not think we want to go any shorter
than that.
