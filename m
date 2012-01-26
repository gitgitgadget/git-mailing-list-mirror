From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 12:42:28 -0800
Message-ID: <7vmx9a2o23.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <4F2119E6.8010109@viscovery.net>
 <20120126165456.GA5278@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 21:42:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqW9U-0007ur-Ik
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 21:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2AZUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 15:42:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab2AZUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 15:42:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18D946129;
	Thu, 26 Jan 2012 15:42:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UXailsc/SzrdhaQ9k8vsnXIh9Hk=; b=dVzQXa
	nGWj1zxKHyuFN2S3+HbL31q9BObJqwoNC/1SfN1cRBiUI+c3RiyDpEJP59UaxTc3
	v/RzMgSf2ut5JV/RkyCxi4ZApbxboDiB/8vLK5g+c+9ZMxj1uOcRtiEhObOdoiDO
	uRgNurh9DuL5rhs9ccgObKeoSqzfu6uBk3d2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fIK+DlC2G2Ld+0cMdHCOp8olx/gliztx
	xd4S97Sj2q52xj52m4Jh8ogfAfJtyQb92GIIRJ/QDAZLP4gJJb8VituyyfRW9bcB
	f7D0qwmdn52niFknpcHEEeOcgFrPddR13sXhlVMzzqI9bNwfmySaHwsqkWbuPGiz
	jcN5Hs7AYCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB6B6124;
	Thu, 26 Jan 2012 15:42:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 959386123; Thu, 26 Jan 2012
 15:42:29 -0500 (EST)
In-Reply-To: <20120126165456.GA5278@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jan 2012 11:54:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 439BD602-485E-11E1-B514-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189163>

Jeff King <peff@peff.net> writes:

> And no, I didn't do any cycle detection. We could either do:
>
>   1. Record some canonical name for each source we look at (probably
>      realpath() for files, and the sha1 for refs), and don't descend
>      into already-seen sources.
>
>   2. Simply provide a maximum depth, and don't include beyond it.
>
> The latter is much simpler to implement, but I think the former is a
> little nicer for the user.

Another thing I wondered after reading this patch was that it will be a
rather common "mistake" to include the same file twice, one in ~/.gitconfig
and then another in project specific .git/config, or more likely, people
start using useful ones in ~their/.gitconfig, and then the site administrator
by popular demand adding the same include in /etc/gitconfig to retroactively
cause the same file included twice for them.

Your first alternative solution should solve this case nicely as well, I
would think.
