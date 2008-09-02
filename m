From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Mon, 01 Sep 2008 23:57:46 -0700
Message-ID: <7vd4jnnifp.fsf@gitster.siamese.dyndns.org>
References: <20080901011259.GA31696@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaPs7-0000PU-KL
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbYIBG5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 02:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYIBG5x
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 02:57:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYIBG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 02:57:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B071F70C1C;
	Tue,  2 Sep 2008 02:57:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E505970C15; Tue,  2 Sep 2008 02:57:48 -0400 (EDT)
In-Reply-To: <20080901011259.GA31696@zakalwe.fi> (Heikki Orsila's message of
 "Mon, 1 Sep 2008 04:12:59 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75D5A3C0-78BC-11DD-903E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94653>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> @@ -2474,7 +2478,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		options->output_format |= DIFF_FORMAT_DIRSTAT;
>  	else if (!strcmp(arg, "--cumulative"))
>  		options->output_format |= DIFF_FORMAT_CUMULATIVE;
> -	else if (!strcmp(arg, "--check"))
> +	else if (opt_arg(arg, 'X', "filedirstat", &options->dirstat_percent)) {
> +		options->output_format |= DIFF_FORMAT_DIRSTAT;
> +		options->filedirstat = 1;

Why 'X'?  It would never match, confusing to the reader, and risks a
sudden change in behaviour when these statements are reordered or somebody
mechanically attempts to convert this to parse_options().
