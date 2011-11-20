From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a
 crash
Date: Sun, 20 Nov 2011 13:10:35 -0800
Message-ID: <7vipmeijp0.fsf@alter.siamese.dyndns.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
 <m2sjlkcgyl.fsf@igel.home> <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
 <m2obw7dg1e.fsf@igel.home> <7vpqgniid5.fsf@alter.siamese.dyndns.org>
 <4EC8C7FE.5050903@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 20 22:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSEf4-0000cI-Ip
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 22:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab1KTVKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 16:10:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab1KTVKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 16:10:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F1FD682E;
	Sun, 20 Nov 2011 16:10:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nce76KfnHUD8yL0kFWrIEfcMnhc=; b=il7G+D
	mZZI3w8DfyqcXbehXqhMvhkPLiOUNwBkmEeJKgQWkZ+o21GZ8FT3OZpwCw+NSzFO
	rAc6jq7vVgaDXDtDXAWM90Z3TnrTtf0Q9ktRAuqzfXntQ/J++G7Px+0TEqprTRGZ
	RONMHX3uM9SWUld4UgYYvqkLjSAV6+LbdK8pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vYr4k2crPWD7HgJgOmmX9UcjA6nOZGxe
	q/IPYPFfxJZPdxCqYSR4MLaUdWXKM+YphxBqknTjwZ0aoJa4bqPCvvH8TFnuq+Sf
	ZJHBVBwwVARgbkxG+B3qVkJ/qIRaGYcb/kQ2D0vhd0OQoQzwq+x8nPMUjVey+W3I
	u7eWZthW/g4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9470E682D;
	Sun, 20 Nov 2011 16:10:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 214FC682B; Sun, 20 Nov 2011
 16:10:37 -0500 (EST)
In-Reply-To: <4EC8C7FE.5050903@kdbg.org> (Johannes Sixt's message of "Sun, 20
 Nov 2011 10:27:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17C69246-13BC-11E1-B89E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185725>

Johannes Sixt <j6t@kdbg.org> writes:

> But in the description of fclose() there is also:
>
>   After the call to fclose(), any use of stream results in undefined
>   behavior.
>
> And we do call fclose(stdout) in cmd_format_patch.

Yeah; this means the "in case builtin implementation is too lazy to clean
up after themselves, run_builtin() will clean things up for them" approach
taken by 0f15731 (Check for IO errors after running a command, 2007-06-24)
fundamentally does not work, which is a bit sad.
