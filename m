From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 11:33:48 -0700
Message-ID: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 20:48:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbdKQ-00053Q-RT
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 20:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab1F1SfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 14:35:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376Ab1F1Sdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 14:33:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB77A5877;
	Tue, 28 Jun 2011 14:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rjGeSYmuVIH+ws8TPYn/mwmO40M=; b=QXYmpn
	Qft9imd6WBeBGlsP7pFI6rg+QkOwqlLaHlwNgmgsQCfqKbsFdnDZSRjseTg0fGMb
	cWAP+c+dwmXYdiCFAjZndlewfv8Fa3wyy16PoKIxdCJHCNzpxVU3+tNTiQg4hZ6o
	RPRvVMUGnWjt0s1j6AMiXjIIZYIpA/Jdj/I4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ITSqb/6bml+JNRliV8zsrATa8VEUa3/M
	8I33G01NpLJIyYVBFvsRs4y9K1EGcFuyRqHFugzoRUTU+tTic5VoM0TCJkvKEqh0
	Ovux+EVg5leEGJwGe708qwev9zdyvM2oLpAa4eGFceROLsEpZUhzDIOnJcHpY+JP
	vAKeKKfTToI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE99B5876;
	Tue, 28 Jun 2011 14:36:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 020525874; Tue, 28 Jun 2011
 14:36:02 -0400 (EDT)
In-Reply-To: <1309272009-23076-1-git-send-email-sdaoden@gmail.com> (Steffen
 Daode Nurpmeso's message of "Tue, 28 Jun 2011 16:40:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A10781E-A1B5-11E0-8A0E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176412>

Steffen Daode Nurpmeso <sdaoden@googlemail.com> writes:

> So far progress always uses \r to produce one-line output on stderr.
> This only produces useful and easy parsable output if stderr is opened
> on a file which does interpret CR as a real carriage return operation.
> This patch changes EOL to the plain newline \n control if isatty() is
> false instead.
>
> Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>

I kind of like this patch, in the sense that if there is a sane scenario
to emit progress to non-tty, we should do just LF not CRLF, but I would
like to know the real motivation behind this proposal.

I thought that we try to disable the progress pretty much everywhere when
we are not talking to a tty, so ugliness coming from many CRLF appearing
in the cron e-mail shouldn't be the issue.
