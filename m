From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Mon, 22 Apr 2013 08:25:41 -0700
Message-ID: <7vwqrupoy2.fsf@alter.siamese.dyndns.org>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
	<5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net>
	<20130420040643.GB24970@sigill.intra.peff.net>
	<51729A6D.3030501@drmicha.warpmail.net>
	<20130421033710.GA18890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:25:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIcm-0008WN-SJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab3DVPZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:25:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab3DVPZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:25:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B23D16AC3;
	Mon, 22 Apr 2013 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQQU+rYlM7tWRZ9OZXt9wkTBA10=; b=G4MKsM
	Nom3ZPehiiBl3uLM2WJjJs9gf21FnfOZTdmE96IrzxbDlAWGFFpxxSjVr3yZ8k0B
	ZmlzhngXHl7KimJK4xErZLmNO9yNZKhJ35wMNOtBB47BnP156xuc/COa6yGtGizw
	En2xXq0fewDBlVU+5p2eR6kiIbQfJPPXlGETQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EE0fc1BWP4v3MTxHZFrtDFQwUC/zCjE/
	1KZyJrrCX/d+aMAd3CHV8FqkLb3zAhe3ZXYc0ffVAnuVw/684GRwsdQXSjhdx9dc
	hQbfXTJnfkt35ksgQ+dyM6rt8xTERQo/9/1i4Ls/E5Mo1PbyKZdlryzgSy20dNhr
	RCni6VcUcY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 338A316AC2;
	Mon, 22 Apr 2013 15:25:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFF1E16AC0;
	Mon, 22 Apr 2013 15:25:42 +0000 (UTC)
In-Reply-To: <20130421033710.GA18890@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 20 Apr 2013 23:37:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5551B28-AB60-11E2-ACDE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222026>

Jeff King <peff@peff.net> writes:

> Just my two cents as a reviewer.
>
>> My reasoning is twofold:
>> 
>> - consistency between "git show commit" and "git show blob"
>
> I'm not sure I agree with this line of reasoning. "git show commit" is
> showing a diff, not the file contents; textconv has always been about
> munging the contents to produce a textual diff. It may be reasonable to
> extend its definition to "this is the preferred human view of this
> content, and that happens to be what you would want to produce a diff".
> But I do not think it is necessarily inconsistent not to apply it for
> the blob case.

True.  Applying textconv to otherwise unreadable blobs is often
useful, but I agree that it is unexpected if it is done by default,
especially given that many people have learned to do:

	git show HEAD~4:binary-gob >old-binary-gob

to recover old version of binary contents to a temporary file when
checking the sanity of or restoring the breakage in the new one.

It of course does _not_ forbid

	git show --textconv HEAD~4:binary-gob | less

but I doubt it is a good idea to turn it on by default this late in
the game.
