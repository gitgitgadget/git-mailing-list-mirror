From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v7 2/3] git-remote-fd
Date: Wed, 13 Oct 2010 16:33:45 -0700
Message-ID: <7vzkuhfz1i.fsf@alter.siamese.dyndns.org>
References: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286901583-30088-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Oct 14 01:37:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6AsW-0005e5-Il
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0JMXdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 19:33:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0JMXdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 19:33:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C186DE723;
	Wed, 13 Oct 2010 19:33:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AVUupHWIf3J1quVqPUpARy0x1jk=; b=NipyXetsmK9GpRiXCM8xBfg
	mVFnMsbyBwG5Y3+1l+3zIv7NBC7aHY6IJqPqpBZE+aPQ56TQtQhoXuDK/fnMdfSX
	XzVP74o4CwPGZzkCOv51WRszdGN+XJFcJ1ZEPF+iK2voCmB3a9hf3fM/JAiLjw34
	XwmvEkRR1+ikRKUX0V9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XhZ0kiRDoBLnSTxHTfSO0gxbLOT8VaSvo2PFxbZdVvgXfHJe2
	NeG64JrFMoDyCprW6akFMFvToOFHEZ7tbiQB9lLzcgLpGGp2/LOJuTRlLbzsAlm7
	JaUze+lp1h9R8Gbaa591I13pK+LVoRAa8jnEh/D62/tFDdt+Aq3FkfCoCA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA820DE722;
	Wed, 13 Oct 2010 19:33:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D74ADE721; Wed, 13 Oct
 2010 19:33:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54F5887A-D722-11DF-B2C5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159005>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
> new file mode 100644
> index 0000000..1c1a179
> --- /dev/null
> +++ b/Documentation/git-remote-fd.txt
> @@ -0,0 +1,59 @@
> +git-remote-fd(1)
> +=================

It appears to me that it has one equal sign too many.  Does this format
correctly?

> +ENVIRONMENT VARIABLES:
> +----------------------

I didn't follow the discussion closely but I recall somebody saying that
the final colon is out of place, and I think I agree.

> +EXAMPLES:
> +---------

Likewise.

> diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
> new file mode 100644
> index 0000000..7517f24
> --- /dev/null
> +++ b/builtin/remote-fd.c
> @@ -0,0 +1,79 @@
> +#include "git-compat-util.h"
> +#include "transport.h"
> +
> +/*
> + * URL syntax:
> + *	'fd::<inoutfd>[/<anything>]'		Read/write socket pair
> + *						<inoutfd>.
> + *	'fd::<infd>,<outfd>[/<anything>]'	Read pipe <infd> and write
> + *						pipe <outfd>.
> + *	[foo] indicates 'foo' is optional. <anything> is any string.
> + *
> + * The data output to <outfd>/<inoutfd> should be passed unmolested to
> + * git-receive-pack/git-upload-pack/git-upload-archive and output of
> + * git-receive-pack/git-upload-pack/git-upload-archive should be passed
> + * unmolested to <infd>/<inoutfd>.
> + *
> + */
> +
> +#define MAXCOMMAND 4096
> +
> +static void command_loop(int input_fd, int output_fd)
> +{
> +	char buffer[MAXCOMMAND];
> +
> +	while (1) {
> +		size_t i;
> +		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
> +			if (ferror(stdin))
> +				die("Input error");
> +			return;
> +		}
> +		/* Strip end of line characters. */
> +		i = strlen(buffer);
> +		while (isspace(buffer[i - 1]))
> +			buffer[--i] = 0;

Hopefully you won't get a line with all space, going beyond the beginning
of the buffer?

> +int cmd_remote_fd(int argc, const char **argv, const char *prefix)
> +{
> +	int input_fd = -1;
> +	int output_fd = -1;
> +	char *end;
> +
> +	if (argc < 3)
> +		die("URL missing");

Is it Ok to have excess arguments to be ignored?
