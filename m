From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase pain on (the) pot
Date: Thu, 19 Mar 2015 12:43:56 -0700
Message-ID: <xmqqlhisixhf.fsf@gitster.dls.corp.google.com>
References: <550ADDD3.9070706@warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <drmicha@warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYgMP-0003P5-7p
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 20:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbbCSTn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 15:43:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750999AbbCSTn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 15:43:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3250C41E9E;
	Thu, 19 Mar 2015 15:43:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UNSTXB7vvHQuDoMXsMyAbOOJ1ek=; b=ccwxQk
	GJpF2OUePjlQJi+MVQBMwe8X5aMHK70aVttaSvsYnSA4KKoaY3RmvYGU+dDZcO+y
	YDN24jmilSg2Lay1coUCmFYBHwrFnKVBDyioScL7ZFQgp3eawOJssJ+Rbaolzhc7
	jooEKOl8mUrZOlZIRO0n2tsogSMidMcVOWxnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHZwbEEdthzinfGAHqkz5CtzNfqRthmP
	jLZ23iV87IL5i/D0BQrnznr9YBH15Wrt9XGgkRavleeBHPzsrdjF6jMKFUvy3h+d
	WnWmwTw6IQtavCFG2OTe95gd8k8HF3vvNgYy6pnqW8BKszcM2ikIFiqnHWVouMuw
	gwgMo/vXzgo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A55F41E9D;
	Thu, 19 Mar 2015 15:43:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EF9C41E9C;
	Thu, 19 Mar 2015 15:43:57 -0400 (EDT)
In-Reply-To: <550ADDD3.9070706@warpmail.net> (Michael J. Gruber's message of
	"Thu, 19 Mar 2015 15:31:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 487650D0-CE70-11E4-8EA9-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265820>

Michael J Gruber <drmicha@warpmail.net> writes:

> Do we have a merge driver or something for the l10n files?

I haven't heard of any, but given that these can be added back by
running xgettext and the result will have the up-to-date line
numbers, it wouldn't be wrong to define a script that roughly does:

    * find a run of lines that match "^#: .*$" and replace it with a
      single line with "#:" in original, ours and theirs.

    * feed these three files to 'merge' from RCS suite.

and use that as a merge driver.  The merged result would lose the
line number information, so if you really care, you could run "make
pot" at each step to update it but I do not think it matters as long
as you do so at the very end once, even as a follow-up "fix-up"
patch that says "we deliberately lost the line number information
during the series to avoid unnecessary merge conflicts, and this
commit puts it back".
