From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rev-parse: add --sq-quote to shell quote arguments
Date: Fri, 24 Apr 2009 01:14:45 -0700
Message-ID: <7v8wlqii2y.fsf@gitster.siamese.dyndns.org>
References: <20090424062902.3705.44704.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 10:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxGaQ-00071A-EC
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 10:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbZDXIPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 04:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758660AbZDXIPD
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 04:15:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669AbZDXIOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 04:14:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EB2AF1102B;
	Fri, 24 Apr 2009 04:14:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 480301102A; Fri,
 24 Apr 2009 04:14:47 -0400 (EDT)
In-Reply-To: <20090424062902.3705.44704.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri, 24 Apr 2009 08:28:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBC49916-30A7-11DE-9110-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117420>

Christian Couder <chriscool@tuxfamily.org> writes:

> @@ -30,6 +30,9 @@ OPTIONS
>  	Only meaningful in `--parseopt` mode. Tells the option parser to echo
>  	out the first `--` met instead of skipping it.
>  
> +--sq-quote::
> +	Use 'git-rev-parse' in shell quoting mode (see SQ-QUOTE section below).
> +

Hmph, I wonder how this interacts with the existing --sq option to the
same command in the mental model of end users.

> +Example
> +~~~~~~~
> +
> +------------
> +$ git rev-parse --sq-quote "'''" '"""' "arg with space"
> + ''\'''\'''\''' '"""' 'arg with space'
> +------------

Yuck --- does asciidoc formats this correctly?

    ... goes and tries ...

Not very readable.  A better example might be to demonstrate something
like this:

	$ cat >your-git-script.sh <<\EOF
	#!/bin/sh
	# quote user-supplied arguments
	args=$(git rev-parse --sq-quote "$@")
        # and use it inside a handcrafted command line
        command="git frotz -n24 $args"
        eval "$command"
	EOF

	$ sh your-git-script.sh "a b'c"

i.e, put stress on how to use it, not on how it works internally.
