From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/11] t6050-replace: test that objects are of the same type
Date: Wed, 04 Sep 2013 13:39:58 -0700
Message-ID: <xmqqa9jsmich.fsf@gitster.dls.corp.google.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.76131.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJs8-0004ZL-BG
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761477Ab3IDUkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761444Ab3IDUkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:40:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 736483FF44;
	Wed,  4 Sep 2013 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7cbPRpaFJzg1FvAtN9pbaEHagp0=; b=Z+Erpc
	rx+RN6oHKXgHizXolVFZgzKIr/ndC/w8aeuI9w4nJ5egSEwd18FvjNurt3/idw4E
	lN9jrvbtR/0ehZUXRxaK1X3oa4BSxI2GFiRLtiwx3IE4hBxHhmfjaPKZVMvyM3RJ
	ex3P769wRdqDOgvOPtp4uYXcV2QC1uyWP5IvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wbZ1/tw0wwAaFnaH4vZGWcyEJKMUF7o2
	bPxzORo2iPGpFZzuoLV4GGZzSU2ctNlKW09pcD0sCLaXdmEuBjPQKvz+CTKd3QRH
	UL7+sBrq3erevO71TZqWJo264Sai9X4rRTw7Y3PS43yXa48Rn348XNM4feooKeWC
	Z6c6yNaHD2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AB933FF37;
	Wed,  4 Sep 2013 20:40:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0D13FF29;
	Wed,  4 Sep 2013 20:40:00 +0000 (UTC)
In-Reply-To: <20130903071026.29838.76131.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 03 Sep 2013 09:10:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B5FB08C-15A2-11E3-A721-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233870>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6050-replace.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index decdc33..5c352c4 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -263,4 +263,17 @@ test_expect_success 'not just commits' '
>  	test_cmp file.replaced file
>  '
>  
> +test_expect_success 'replaced and replacement objects must be of the same type' '
> +	test_must_fail git replace mytag $HASH1 2>err &&
> +	grep "mytag. points to a replaced object of type .tag" err &&
> +	grep "$HASH1. points to a replacement object of type .commit" err &&

Hmm, would these messages ever get translated?  I think it is
sufficient to make sure that the proposed replacement fails for
these cases.

> +	test_must_fail git replace HEAD^{tree} HEAD~1 2>err &&
> +	grep "HEAD^{tree}. points to a replaced object of type .tree" err &&
> +	grep "HEAD~1. points to a replacement object of type .commit" err &&
> +	BLOB=$(git rev-parse :file) &&
> +	test_must_fail git replace HEAD^ $BLOB 2>err &&
> +	grep "HEAD^. points to a replaced object of type .commit" err &&
> +	grep "$BLOB. points to a replacement object of type .blob" err
> +'
> +
>  test_done
