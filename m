From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 2/5] t4205: revert back single quotes
Date: Fri, 05 Jul 2013 00:07:09 -0700
Message-ID: <7v61wpa3j6.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<b7ac1f5c14ab4571f06030ab02a33b1489ab4dcd.1372939482.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 09:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv06y-0002au-0g
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 09:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075Ab3GEHHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 03:07:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3GEHHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 03:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DABA12999B;
	Fri,  5 Jul 2013 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=RwEPsVNhehTKZMLwor7n35vGymg=; b=Ybt3DPLPXpvw5nnqKi7G
	JqDceiMcCSyzLwYY6ZHEE5oTgFleZf+zSTR/v5jmvDJuEykc6BIuf4IqS5F2FPhB
	aWbi3okTodZWC3ud8tPWF67NXTkAWLY0xIgpzwpuzWWXwWrZ2mr+UjWR1VGq3tTs
	b1w5vlUAI7jRDx4SPiq52x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cT3RwwxxxigivG28ZaKzUNDNF6K35shC7iY3/HNqxLkNss
	DLN9++Xcspws12mQzZgsxemto7qdO4hXnbdtRevDPPkMggDFLfvFZAiRhoNC3MCj
	b+wuJDx5luXXhJIJdhhk6go1dvAB83ftYJRdsJhyGpJ5s6DiZ3prFXqYFlMFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD5A29999;
	Fri,  5 Jul 2013 07:07:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 546C429998;
	Fri,  5 Jul 2013 07:07:11 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8354F9E6-E541-11E2-AB73-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229631>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> In previuos commit de6029a2d7734a93a9e27b9c4471862a47dd8123 single
> quotes were replaced with double quotes to make "$(commit_msg)"
> expression in heredoc to work. The same effect can be achieved by using
> "EOF" as a heredoc delimiter instead of "\EOF".

OK.

> -test_expect_success 'left alignment formatting' "
> -	git log --pretty='format:%<(40)%s' >actual &&
> +test_expect_success 'left alignment formatting' '
> +	git log --pretty="format:%<(40)%s" >actual &&
>  	# complete the incomplete line at the end
>  	echo >>actual &&
> -	qz_to_tab_space <<\EOF >expected &&
> +	qz_to_tab_space <<EOF >expected &&
>  message two                            Z
>  message one                            Z
>  add bar                                Z
>  $(commit_msg)                    Z
>  EOF
>  	test_cmp expected actual
> -"
> +'

A subtle difference is that a call to commit_msg is made when the
test is actually run, not when the test script is prepared to be
passed (as a parameter) to test_expect_success helper.  I think the
result of applying this patch, i.e. running $(commit_msg) inside the
test, is easier to read and understand.
