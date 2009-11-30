From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] build dashless "bin-wrappers" directory similar
 to installed bindir
Date: Sun, 29 Nov 2009 22:28:46 -0800
Message-ID: <7vmy241q75.fsf@alter.siamese.dyndns.org>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 07:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzkt-0002ur-SX
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZK3G2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbZK3G2w
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:28:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbZK3G2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 01:28:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C86781080;
	Mon, 30 Nov 2009 01:28:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2cfIFPDNG4IGO9oT4wJYHYOjtno=; b=Mw6Nnv
	2xmiwnTkOhv562CbYrNsMet9g53mvFqoHbpUpwsnNvZAE2eFfYT2vHoUIajSJ4gg
	e6+U2qF+Q/DsRxyGtJwAV728XkqE7JduH0sbt9s6eNsaozcy9j3NloquNBxts9hI
	U7G4ugLBrMyuX3x+U3o9ONqUGfhF+R6MELUzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9Y87P0nT5biXwMT1XNjOrwG443GHMuO
	XyxmWrJoa78mV/yu6WzrDwQBkWLFKtCRWEPXt8VBUqNHhhKhyr8yu+cM8PpPiO+E
	n4iW8aIsYQ45inBlWYgBtgoKrME3QALz39Gb006A9iU/yoLv8bQr+NGpp26ZLoXD
	TlP+mam1+T8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A415C107F;
	Mon, 30 Nov 2009 01:28:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A9AF107C; Mon, 30 Nov
 2009 01:28:48 -0500 (EST)
In-Reply-To: <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
 (Matthew Ogilvie's message of "Sun\, 29 Nov 2009 23\:19\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A166A174-DD79-11DE-B42B-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134056>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> new file mode 100644
> index 0000000..ee2bc98
> --- /dev/null
> +++ b/wrap-for-bin.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +# wrap-for-bin.sh: Template for git executable wrapper scripts
> +# to run test suite against sandbox, but with only bindir-installed
> +# executables in PATH.  The Makefile copies this into various
> +# files in bin-wrappers, substituting
> +# __GIT_EXEC_PATH__ and __PROG__.
> +
> +GIT_EXEC_PATH="__GIT_EXEC_PATH__"
> +GIT_TEMPLATE_DIR="__GIT_EXEC_PATH__/templates/blt"
> +GITPERLLIB="__GIT_EXEC_PATH__/perl/blib/lib"
> +PATH="__GIT_EXEC_PATH__/bin-wrappers:$PATH"
> +export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB PATH
> +
> +exec "${GIT_EXEC_PATH}/__PROG__" "$@"

Two issues, one minor and one not so minor but not grave:

 - Everywhere else we seem to use "@@UPPERCASE_NAME@@" not
   double-underscore as placeholders like the above.

 - @@PROG@@ is under our control and it is easy for us to guarantee that
   it won't have any funny letters, but GIT_EXEC_PATH is not.  Is it safe
   to do a simple-minded "sed" replacement, or does it need the usual sq
   trick employed in the other replacement in our Makefile?
