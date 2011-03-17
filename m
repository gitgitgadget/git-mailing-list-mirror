From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] run-command: prettify -D_FORTIFY_SOURCE workaround
Date: Thu, 17 Mar 2011 15:34:26 -0700
Message-ID: <7vipvh1iml.fsf@alter.siamese.dyndns.org>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
 <20110316035135.GA30348@elie> <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
 <20110316073239.GJ5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Wookey <michaelwookey@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 23:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0LmH-0001pk-2u
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 23:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab1CQWel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 18:34:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1CQWej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 18:34:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D6224136;
	Thu, 17 Mar 2011 18:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fttBXI+0fYECzAnJ/LiEgzx3b3Y=; b=X/MUgr
	4ZTylz0XczACXlCazqup0dcX/fS9Mr7A5CPTEwaESoxlbwYTy1Xa3/+yu8732KQt
	uBoxmzRIvNTK4JkDf6CcEuHTU4ioXo3pbTFEreD988K4jWv+yioTSsi2pBg9KrwP
	2ArEuGBfxlNSiKijO1x+lQ5iBo31D6bLNkkfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RYltitLblg08H36HorTb0qa9Bx1Pzihy
	kNGn+f+C2iHyugBH2PRm9ZuiCr8Wk6L3Qc7RS8X8Hx+u7sO+pJuT8jB/DFQyaup2
	2jfwPOTgJztpDpMgCruvYfXkDAAeJzB7ZZfDoLVT9nKDrOgTGlfm4hmO1aGvF1+S
	uKMZWbXUyEg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D6954135;
	Thu, 17 Mar 2011 18:36:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E437F4132; Thu, 17 Mar 2011
 18:36:02 -0400 (EDT)
In-Reply-To: <20110316073239.GJ5988@elie> (Jonathan Nieder's message of "Wed,
 16 Mar 2011 02:32:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F39E7F48-50E6-11E0-BCA0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169285>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  static NORETURN void die_child(const char *err, va_list params)
>  {
> ...
> -	unused = write(child_err, "fatal: ", 7);
> -	unused = write(child_err, msg, len);
> -	unused = write(child_err, "\n", 1);
> +	if (write(child_err, "fatal: ", 7) ||
> +	    write(child_err, msg, len) ||
> +	    write(child_err, "\n", 1))
> +		; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */

Strictly speaking, this changes behaviour by stopping at the first failure
from write(2), but I don't think we care.

Thanks.
