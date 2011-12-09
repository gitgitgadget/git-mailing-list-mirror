From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Fri, 09 Dec 2011 10:43:42 -0800
Message-ID: <7v8vmlfuw1.fsf@alter.siamese.dyndns.org>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@mgmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:43:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5QF-0004I1-KU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab1LISnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 13:43:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709Ab1LISnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 13:43:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A48827BA7;
	Fri,  9 Dec 2011 13:43:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vvVd1zQSqT5XJkZvRl31Aul46QQ=; b=GbLlEn
	z7daa1UkqxQxbOXe1y6uDkp7iaFD/4vYLrvP5GF5qcmgy+0vrAgsmjOtnZNj23zn
	BQSDIDmcx4xHeQSr4NJr8i8eYczPaKczOqUprfURI/9PVwl53GdQ8hVNLtJB8IEa
	pA/ZAzyWOM4QcD4UnGu5f8obOLBMFmm3bauSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c98LumNqsQn01z8Fla5Evbc2Zb/K5AXg
	02ers3HjW8SNM4Kd/3uTtmH4Aof0+UfLkRYa2EZf+UodVMiMDv4zwXVlRGk0RmRg
	zCdcMq+qcAn79reQtfWQ8xC4LGOulHnTOH5EKLo7LhBahgkNCwbQrZKYucKj5GyR
	HiQtOJU4Uqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B6067BA6;
	Fri,  9 Dec 2011 13:43:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3CDC7BA4; Fri,  9 Dec 2011
 13:43:43 -0500 (EST)
In-Reply-To: <1323430158-14885-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 9 Dec 2011 16:59:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8959E8C-2295-11E1-91BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186661>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In testing, a common paradigm involves checking the expected output
> with the actual output: test-lib provides a test_cmp to show the diff
> between the two outputs.  So, use this function in preference to
> calling a human over to compare command outputs by eye.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t1006-cat-file.sh |  119 ++++++++++++++++++++++++---------------------------
>  1 files changed, 56 insertions(+), 63 deletions(-)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d8b7f2f..5be3ce9 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -144,10 +119,13 @@ tag_size=$(strlen "$tag_content")
>  
>  run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_pretty_content" 1
>  
> -test_expect_success \
> -    "Reach a blob from a tag pointing to it" \
> -    "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
> +test_expect_success "Reach a blob from a tag pointing to it" '
> +    echo_without_newline "$hello_content" >expect &&
> +    git cat-file blob "$tag_sha1" >actual &&
> +    test_cmp expect actual
> +'
>  
> +test_done
>  for batch in batch batch-check
>  do
>      for opt in t s e p

What is that test_done about?
