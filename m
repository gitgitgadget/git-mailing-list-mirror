From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: add arbitrary email headers
Date: Wed, 25 Mar 2009 12:11:02 -0700
Message-ID: <7v3ad11kqh.fsf@gitster.siamese.dyndns.org>
References: <1237996712-61859-1-git-send-email-michael@ndrix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYWx-0007sB-Ks
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbZCYTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbZCYTLK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:11:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZCYTLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 15:11:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8FD697A0;
	Wed, 25 Mar 2009 15:11:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 341A2979E; Wed,
 25 Mar 2009 15:11:04 -0400 (EDT)
In-Reply-To: <1237996712-61859-1-git-send-email-michael@ndrix.org> (Michael
 Hendricks's message of "Wed, 25 Mar 2009 09:58:32 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B13AA820-1970-11DE-8C2D-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114649>

Michael Hendricks <michael@ndrix.org> writes:

> format-patch supports the format.headers configuration for adding
> arbitrary email headers to the patches it outputs.  This patch adds
> support for a --header argument which makes the same feature available
> from the command line.  This is useful when the content of custom
> email headers must change from branch to branch.

How should this interact with the configuration variable?

Typically we allow command line options to override the matching config
variable, so that people can say "here are the settings I ordinarily use"
in the config file, and say "but I do not want the usual values to take
effect for this particular invocation; please use these _instead_" with
command line options.

Note that the above question is "how should this interact"; not "how does
this interact".  I can see you chose to make this cumulative in your patch
and the documentaiton.

I am asking if that is what the users want, overriding is preferred, or
perhaps another option to clear extra headers (say, "--no-extra-headers")
is necessary to allow both.

> diff --git a/builtin-log.c b/builtin-log.c
> index c7a5772..35701a7 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -918,6 +918,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			cover_letter = 1;
>  		else if (!strcmp(argv[i], "--no-binary"))
>  			no_binary_diff = 1;
> +		else if (!prefixcmp(argv[i], "--header="))
> +			add_header( argv[i] + 9 );

No extra SP immediately after ( and before ), please.
