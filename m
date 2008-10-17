From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-checkout-index.
Date: Fri, 17 Oct 2008 16:58:23 -0700
Message-ID: <7v63nqg4f4.fsf@gitster.siamese.dyndns.org>
References: <1224111343-17433-1-git-send-email-vmiklos@frugalware.org>
 <20081016082340.GB15266@artemis.corp>
 <20081016132810.GG536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:59:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzEW-0003L0-Cy
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbYJQX6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbYJQX6c
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:58:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbYJQX6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:58:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C97658B6A1;
	Fri, 17 Oct 2008 19:58:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B59C8B691; Fri, 17 Oct 2008 19:58:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FC63688-9CA7-11DD-BE37-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98505>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +static int option_parse_z(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	line_termination = unset;
> +	return 0;
> +}
> ...
> +		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> +			"paths are separated with NUL character",
> +			PARSE_OPT_NOARG, option_parse_z },

This adds a new feature to say --no-z from the command line, doesn't it?
And I suspect the feature is broken ;-).

> +		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
> +			"read list of paths from the standard input"),
> ...
> +	argc = parse_options(argc, argv, builtin_checkout_index_options,
> +			builtin_checkout_index_usage, 0);
> +	state.force = force;
> +	state.quiet = quiet;
> +	state.not_new = not_new;
> +	if (argc && read_from_stdin)
> +		die("--stdin must be at the end");

Is this comment still correct?  Do the original and your version act the
same way when the user says "checkout --stdin -f", for example?  I suspect
the original refused it and yours take it (and do much more sensible
thing), which would be an improvement, but then the error message should
be reworded perhaps?
