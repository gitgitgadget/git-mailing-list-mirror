From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Thu, 19 Jan 2012 22:00:21 -0800
Message-ID: <7vobtyhq16.fsf@alter.siamese.dyndns.org>
References: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org>
 <1327029129-11424-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 07:00:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro7WZ-0007sQ-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 07:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab2ATGA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 01:00:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2ATGAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 01:00:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8DF97CB3;
	Fri, 20 Jan 2012 01:00:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYPBBFJgekflRGdDlcNbYRLpvkc=; b=qqyHHq
	rUoGwy2H9OPJ1frXmBjom87+zaFt8XLpuXxWyL9RbgiQwx9sJTS6LnwS00brllAe
	xgBxBw2cZ38jeH6uLJPMSjSHKpmTC+HnQb6s5IKBYdKxrnd6AR4TEr48zmeuITCW
	Lq4SGmRIKhICyM8H46ec0UiCVMHJAlV3phONw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XhlNpeonjIsdFDgleRXe/nDEmGqjPWc8
	sCkTVYyzIWq8uotxPhO2I1CQrt9qWY7h5toShvZ4NoJw251CmeUOywYpur6wJC6m
	K95jcS4CP1hkd1NQHPZXuWY+lB3XTdLlinE29rh0S2o8DB0ZjqbdrjIcXe+RFu5/
	GloHe1AnA1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0DD47CB2;
	Fri, 20 Jan 2012 01:00:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C7867CB1; Fri, 20 Jan 2012
 01:00:23 -0500 (EST)
In-Reply-To: <1327029129-11424-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Thu, 19 Jan 2012 19:12:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A98DD6E-432C-11E1-BAA6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188850>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
> index 9b85d42..4723930 100755
> --- a/t/t5541-http-push.sh
> +++ b/t/t5541-http-push.sh
> @@ -95,6 +95,31 @@ test_expect_success 'create and delete remote branch' '
>  	test_must_fail git show-ref --verify refs/remotes/origin/dev
>  '
>  
> +cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
> +#!/bin/sh
> +exit 1
> +EOF
> +chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> +
> +cat >exp <<EOF
> +remote: error: hook declined to update refs/heads/dev2        

Curious. Where do we get these eight trailing whitespaces?

The call to rp_error("hook declined to update %s", name) seems to be
giving the name properly.
