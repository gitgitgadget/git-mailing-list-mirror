From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 4/6] Git.pm: allow pipes to be closed prior to calling
 command_close_bidi_pipe
Date: Tue, 12 Feb 2013 13:14:57 -0800
Message-ID: <7va9r9fd4e.fsf@alter.siamese.dyndns.org>
References: <cover.1360677646.git.mina86@mina86.com>
 <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com>
 <20130212205141.GC25330@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:15:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5NCI-0003DR-UN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab3BLVPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:15:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab3BLVPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:15:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A6AB6A1;
	Tue, 12 Feb 2013 16:14:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zQt0WrbDFWhQYUDBJgQbp8VB0CE=; b=pAQXoa
	Vyj454InvT7fwzuxANP7hGSsPZotB5OhmfAwfRsc783qX3lrW8mFCO1aJV74pys8
	iaE5R8sxfg5zw2tbX7q6J9tfvnLYVoTgC8VlMhhu+wk0JMVO66yfP2Lp6TcAb1H5
	kzTZnQfKh3NY6e2A66gb/nt49cFMSJersIwew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lk+7s2dQ2ojOBpiOh/Pzro6A5qvfw/Qi
	nau0T+4drfskotgRExfIjOgHGWUW10k0ztwOstDKbnOyCnplpazpKhvlMnEgRpF/
	PCyWiHdHpkm0rb6ukjSXrVZPDg0CtlRo5AHGiZm3s5lL978J4BKrXu6G4jw21VDY
	YvXmysDg6QM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E829EB6A0;
	Tue, 12 Feb 2013 16:14:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C2FEB69F; Tue, 12 Feb 2013
 16:14:59 -0500 (EST)
In-Reply-To: <20130212205141.GC25330@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 12 Feb 2013 15:51:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41EE1EB8-7559-11E2-A11F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216202>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 12, 2013 at 03:02:31PM +0100, Michal Nazarewicz wrote:
>
>>  sub command_close_bidi_pipe {
>>  	local $?;
>>  	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
>> -	_cmd_close($ctx, $in, $out);
>> +	_cmd_close($ctx, grep defined, $in, $out);
>
> Maybe it is just me, but I find the "grep EXPR" form a little subtle
> inside an argument list. Either:
>
>   _cmd_close($ctx, grep { defined } $in, $out);
>
> or
>
>   _cmd_close($ctx, grep(defined, $in, $out));
>
> is a little more obvious to me.

I would actually vote for the most explicit:

	_cmd_close($ctx, (grep { defined } ($in, $out)));
