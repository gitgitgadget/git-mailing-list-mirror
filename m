From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] start_command: detect execvp failures early
Date: Thu, 14 Jan 2010 13:31:16 -0800
Message-ID: <7viqb49xwb.fsf@alter.siamese.dyndns.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <201001101404.22258.j6t@kdbg.org> <201001101411.22418.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:31:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVXHw-0002Yc-2L
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 22:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab0ANVb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 16:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270Ab0ANVb1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 16:31:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0ANVb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 16:31:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A799199D;
	Thu, 14 Jan 2010 16:31:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6HL9uOSYTCcmPojq8pqntNkzkwI=; b=tMXB0E
	e2dbk5NkuaRledG/nVfgC/RDTXitsAG4eWQ+md3O4gI9aV4l6ZeeEMkZR2yHONu1
	cFL0Pf3mqn+J8mBihGk/QvXXGqIwFCSyHErNuwOc7ZetQwpi8pm4qEU+uU2uQX0d
	GrtGUStzwQ1FlH6cd4xdbgnj6tnTTp4SQ0TFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QbX8E1/QZnolV/psDVxw/f678KjFSG0+
	EvXivT/FDdX8amyU20sh1BYKwJiehYCJJV2UwJLVGfy9iEcwLPwWdlsZVnkniTFk
	gDFESCQCTlo9Ii56GgDupgxrSgSvqgtXLMTUPXfmbfxrrhKVBaoJs+CGDJw3CCzU
	XmLo/eqgzHE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93CCB9199C;
	Thu, 14 Jan 2010 16:31:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9391C9199B; Thu, 14 Jan
 2010 16:31:17 -0500 (EST)
In-Reply-To: <201001101411.22418.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 10 Jan 2010 14\:11\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28A5A434-0154-11DF-BDF7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137027>

Johannes Sixt <j6t@kdbg.org> writes:

> Previously, failures during execvp could be detected only by
> finish_command. However, in some situations it is beneficial for the
> parent process to know earlier that the child process will not run.
>
> The idea to use a pipe to signal failures to the parent process and
> the test case were lifted from patches by Ilari Liusvaara.

I wonder if we can do this without pipe, perhaps using "vfork, exec, then
update a variable"....
