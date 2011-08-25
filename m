From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow multiple calls to submodule merge search for the
 same path
Date: Thu, 25 Aug 2011 16:28:23 -0700
Message-ID: <7vsjopgjfs.fsf@alter.siamese.dyndns.org>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <7v39gqo2fn.fsf@alter.siamese.dyndns.org> <20110825211144.GA67523@book.hvoigt.net> <7vwre1gjq1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 01:28:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwjLb-00045C-Kx
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 01:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1HYX20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 19:28:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab1HYX20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 19:28:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 328445CAF;
	Thu, 25 Aug 2011 19:28:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UFC/JlWJb8TKbNFzU+7PnioX85s=; b=D6W2Dp
	TbDuTlbKcTzL1u4DSdLltZNU4JzttRsd3wXb0KmURWKJujtwmEWlGKDvVabtzqtz
	NzncqiC6U52ieZgNYPpxolrKnY5vDLVHL/vUZoJxYj8pi3Isk6d9KOHpWVGULXNj
	JkSuEWUFdVkR3+AqHR1blqk8BzI2a3kmBt4Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nx2zYbR1IFagzpTIYWcPbNz6yiy9ITkv
	75o5CzGXFuE5fR72w3ijuBb1gvJcPfrp6Uk2qxYiqXhyk2BpT4SWSMeHrIH3T+cD
	i+I2IgOLTpPvi2pl6I6vp+2CiDtx/CxkRZWj56DkDMYcHXRs9u/+ITd1yYAy3UaZ
	ULySuYKNwHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A5ED5CA5;
	Thu, 25 Aug 2011 19:28:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B43965CA4; Thu, 25 Aug 2011
 19:28:24 -0400 (EDT)
In-Reply-To: <7vwre1gjq1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 25 Aug 2011 16:22:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDB5EC4C-CF71-11E0-9E94-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180137>

Junio C Hamano <gitster@pobox.com> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
>> index 8f6f2d6..603fb72 100755
>> --- a/t/t7405-submodule-merge.sh
>> +++ b/t/t7405-submodule-merge.sh
>> @@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
>>  '
>>  
>>  # merge should leave submodule unmerged in index
>> -test_expect_failure 'recursive merge with submodule' '
>> +test_expect_success 'recursive merge with submodule' '
>>  	(cd merge-recursive &&
>>  	 test_must_fail git merge top-bc &&
>>  	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
>
> What is this patch based on?

Ah, nevermind. I figured it out. Thanks.
