From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Wed, 28 Mar 2012 21:02:14 -0700
Message-ID: <7v8vikrr5l.fsf@alter.siamese.dyndns.org>
References: <20120328042215.GB30251@sigill.intra.peff.net>
 <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, j.sixt@viscovery.net, jrnieder@gmail.com,
	git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Mar 29 06:02:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD6ZF-0002ij-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 06:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab2C2EC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 00:02:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab2C2ECS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 00:02:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CBCE77CC;
	Thu, 29 Mar 2012 00:02:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbKrEW86rKOUMVUQhhytRa6Mkuk=; b=IKQM6O
	l0DBT9QcXb7FwhOr6yQBEBYGgIe66/QppfaDhHAntFuoWTwKjmtnFCsjjZeuwBVa
	XVvr/qlZ+a/PKgswFB4+Pah5/MpgcuXZvV6b9XOwc86UIUhe44aKCphJCtp/gqPB
	etCuJ6i4UfrP+OBI1y98nPcnviQ1/Zy2L7Hv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NtapaYpntPA1J4ITnmNG3WxWV/0aIKHR
	4DAdFT4sJrNtendwkiv4waMFNCmfKcAwUwM7zLoC5x8ibY/Eg5dBRzOpbR1P2Epz
	rB/f6+Wdak8YcgUSwZ8aBxMDjYFqZkvHgYCJsb9m1ByWZPphbMZ5WHiTXBWOHUZB
	woFTVq+l2KE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B4477CB;
	Thu, 29 Mar 2012 00:02:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7368D77C9; Thu, 29 Mar 2012
 00:02:16 -0400 (EDT)
In-Reply-To: <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Wed, 28 Mar 2012 19:26:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F903CEA2-7953-11E1-A851-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194224>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Possible fixes for this issue are:
> ...
> 2. The git wrapper could prepend SANE_TOOL_PATH to PATH for
>    consistency with builtin commands.
>
> 3. The run_command.c:prepare_shell_command() could use the same
>    SHELL_PATH that is in the #! line of all all scripts.
> ...
> Option 2 is voided by the same example that turned up this issue.
> SANE_TOOL_PATH might also include 'insane' tools.
>
> Option 3 is the best choice at this time.

This line of reasoning makes me feel uneasy.

The approach may allow a directory that has "insane" tools in it to be on
the SANE_TOOL_PATH for *this* particular codepath, but at the same time,
it encourages people to build Git with such a broken SANE_TOOL_PATH.

Aren't you exposing your users to potential breakage in other parts of the
system, caused by broken tools on SANE_TOOL_PATH that is not shell, by
doing so?  Worse yet, there is no escape hatch similar to SHELL_PATH for
such tools.

Will queue on 'pu' for now, but I am not convinced.
