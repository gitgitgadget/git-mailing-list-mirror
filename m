From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible 'git --dirstat=0' buglet in 1.7.0.4?
Date: Tue, 16 Nov 2010 10:05:06 -0800
Message-ID: <7v7hgdi1pp.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=wZ8MhU0NUw9as-kw8Lhr=TFBK2BY7MFRQvOct@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 19:05:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPuG-000180-TC
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 19:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218Ab0KPSFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 13:05:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0KPSFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 13:05:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E50B2070;
	Tue, 16 Nov 2010 13:05:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/9Xs0DAUZHeS7HBf7YBnAlSHpg=; b=Q4cyXd
	TLwwpWucud/NKMi6hxKkvKnkXI3pMoy1s5ak3a3LjNIohYwffKRCUmeskX2Wxdxn
	MnVhyKvWOdZ7HmRFyq8elGbpsKUs9T6iO1oDAa/4FgFA9yHUgntkEj0lPXzwov5Y
	/Un8GQrK4tPpuHZQcl9SoKUWFO8kKuJqCLYMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjEsxygXHjjV6sHF4L8dg/jz7shqMDPl
	ClfB1VojL1ATPN2OZjZS6dwZ+5hHYfO9mQn1iwK58dQxiKUPdKi20mQG6gZeJP+y
	3VWrKS4NaL83jWGdGk8i1gdGQh9A1uRLByFGdGet8F/V9gnvyLcyzaoDcwMg/7Y+
	FA8O3sgXZus=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B5DE206F;
	Tue, 16 Nov 2010 13:05:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4DAF6206D; Tue, 16 Nov 2010
 13:05:17 -0500 (EST)
In-Reply-To: <AANLkTi=wZ8MhU0NUw9as-kw8Lhr=TFBK2BY7MFRQvOct@mail.gmail.com>
 (Mike Coleman's message of "Fri\, 12 Nov 2010 08\:33\:56 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13C2E98E-F1AC-11DF-A006-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161572>

Mike Coleman <tutufan@gmail.com> writes:

> I noticed just now that the '--dirstat=0' flag still seems to filter
> out some diffs, even though I would expect the '0' to mean "don't
> filter anything".  If there's another flag that says "don't filter", I
> missed it.  Could this be a rounding or off-by-one error?

We seem to internally compute in per-mille (see gather_dirstat() in diff.c)
so if your changes are too small to be rounded off to zero there,...

I think you can remove the "if (permille)" there to make it not filter at
all when dir->percent is set to 0, but I didn't look carefully.
