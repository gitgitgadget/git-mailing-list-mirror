From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Sun, 17 Feb 2008 19:45:26 -0800
Message-ID: <7v4pc7udux.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802171335520.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQwxR-00014w-C6
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 04:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbYBRDpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 22:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbYBRDpo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 22:45:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYBRDpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 22:45:43 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AE455FF;
	Sun, 17 Feb 2008 22:45:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 D62EB55FE; Sun, 17 Feb 2008 22:45:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74225>

Daniel Barkalow <barkalow@iabervon.org> writes:

> +	argv[0] = "shortlog";
> +	argv[1] = head_sha1;
> +	argv[2] = "--not";
> +	argv[3] = origin_sha1;
> +	argv[4] = NULL;
> +	fflush(stdout);
> +	run_command_v_opt(argv, RUN_GIT_CMD);

Please make it a habit to always append "--" disambiguator for
such command lines generated internally.  In this case you are
not usinging short and common name like "master" or "HEAD" but
40-letter-long hex string, so it is much less likely to get hit
by the "ambiguous rev vs file" rule, but even then it is still
possible that a work tree happens to have a file with the same
name.

> @@ -0,0 +1,101 @@
> +$ git format-patch --stdout --cover-letter -n initial..master^
> +From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
> +From: C O Mitter <committer@example.com>
> +Date: Mon, 26 Jun 2006 00:05:00 +0000
> +Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
> +
> +
> +*** BLURB HERE ***
> +
> +A U Thor (2):
> +      Second
> +      Third
> +

This probably falls within the "personal taste" category, but
I'd rather not to see two extra blank lines between Subject: and
BLURB HERE.
