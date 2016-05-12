From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Thu, 12 May 2016 08:59:17 -0700
Message-ID: <xmqqk2izgtd6.fsf@gitster.mtv.corp.google.com>
References: <20160511233546.13090-1-gitster@pobox.com>
	<20160511233546.13090-2-gitster@pobox.com>
	<20160512044730.GA5436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 17:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0t1N-0005Pr-10
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbcELP7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:59:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752222AbcELP7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:59:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D09251A24B;
	Thu, 12 May 2016 11:59:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DrjQM+SvA//iu50ugwTzEdjx+Mk=; b=ExSaS2
	KZtap0UCpf68FL1wnodmWLylNJMFQuUr38IJd1rxvEi4m3+fmjwkOS5h7Jy9ek3t
	CpOxzQGxcjnpZFUgsa2OuXFb7smqI2dkKdeZItDar1zeOrQrSAiIFw5YsE49h+75
	qEryKw5HFlmzAfhzT8Z/sMxQAhFaTTpgC5WeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aGt75EwFvkqi2A7fxDcNl/R2VTePCZQy
	glbCMmpS5TMjPOBAjkDvIlVSTMJnNmn8k7m5TJSK10T7288pgUDXGupkNMnlQGsT
	YlwgVbZi1s0VHzOg1PTjAq/6FTmwgWZ1ANBAzpCuNky1vGPElsbrfsod5K9mdyyG
	JEs306bsh4s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C85091A24A;
	Thu, 12 May 2016 11:59:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F4681A249;
	Thu, 12 May 2016 11:59:19 -0400 (EDT)
In-Reply-To: <20160512044730.GA5436@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 May 2016 00:47:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C5DF9D6-185A-11E6-8181-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294413>

Jeff King <peff@peff.net> writes:

> Presumably `fclose` doesn't ever overwrite errno in practice, but I
> guess it could in theory.

Yeah, these two patches share the same issue.
