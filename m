From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] "git name-rev --weight"
Date: Thu, 30 Aug 2012 08:54:40 -0700
Message-ID: <7vk3wgtlxb.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <068F712399864538B59054590881E19C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "Greg KH" <gregkh@linuxfoundation.org>,
	Jeff King <peff@peff.net>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 17:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7751-0000FF-8c
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 17:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2H3Pyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 11:54:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab2H3Pyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 11:54:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F1357630;
	Thu, 30 Aug 2012 11:54:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IIk8ga1tHRaHtzsG+DSSFltdCuU=; b=q42nQx
	A3UIpq26oXNihMz7KqKmeCBreMt6VnBECmqB0EmDUZyMQGb/AWp++HwLu2ZW3nas
	IKJSQUiwN075YEDTf/TgvBLewDCO+J9QGGnR112csR4X/GD3nhHAUAQ8SUTgVlOQ
	pHL9DxHRxGvL/6JfdeiT79OW2vdnL5UZDhDlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hBvE90sq5ifLcTHLTkkTkNjdVuFq/KkR
	nZh9oqKnbqF/J0TmoxpDPsuNODE3iC31TnMJwQfbLZgH1oAD39t3rVp4JlW1PLpP
	Vt9AYcuLY0cPF4txpqXlcuWztp/TFPL0JK7/hU0awF8ADzkR2GUpWRStmzczaraW
	NuXtE+/JtKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC13762E;
	Thu, 30 Aug 2012 11:54:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E324B762C; Thu, 30 Aug 2012
 11:54:41 -0400 (EDT)
In-Reply-To: <068F712399864538B59054590881E19C@PhilipOakley> (Philip Oakley's
 message of "Thu, 30 Aug 2012 08:06:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02E7E58A-F2BB-11E1-94E7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204542>

"Philip Oakley" <philipoakley@iee.org> writes:

> Is "--weight" the right term to use for the user (cli) interface?
> Wouldn't '--oldest' (or similar) be a better statement of what is
> desired (absent clock skew).
>
> While 'weight' may be a good internal technical description it didn't
> convey to me what was being sought (maybe -- deepest'?).

I agree with you that weight represents what it internally does.  I
however think that "oldest" is not quite good, as it still leaves
the source of possible confusion.  It has at least 3 (or 4,
depending on how you count) possible meanings.

 - Is it the one with the oldest timestamp (and if so, do we use the
   committer date, or do we use the tagger date that may be much
   newer than the committer date)?

 - Is it the one with its longest path down to the root is the
   shortest (i.e. with smallest generation number)?

 - Is it the one with the smallest number of ancestor commits?

For the purpose of "oldest tag that contains this commit", I think
the last one would give the most intuitive answer, but depending on
your use case, you may want to enhance the command to support other
definition of "oldest"; it does not feel quite right to have this
particular definition (the last one) squat on the generic "--oldest"
name.

We could punt to tautology and call it "--contains", meaning that is
the logic used to implement "describe --contains" ;-) but that is
not satisfactory, either.

I dunno.
