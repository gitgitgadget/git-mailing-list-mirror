From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add path-limiting to git-add--interactive
Date: Thu, 22 Nov 2007 01:13:47 -0800
Message-ID: <7vpry27id0.fsf@gitster.siamese.dyndns.org>
References: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
	<1195695384-41329-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv88W-0002Q2-Bz
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbXKVJN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbXKVJN5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:13:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52404 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXKVJN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:13:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EC1942F0;
	Thu, 22 Nov 2007 04:14:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E8C269773E;
	Thu, 22 Nov 2007 04:14:11 -0500 (EST)
In-Reply-To: <1195695384-41329-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Thu, 22 Nov 2007 02:36:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65761>

Wincent Colaiuta <win@wincent.com> writes:

> @@ -56,9 +56,14 @@ sub list_modified {
>  	my ($only) = @_;
>  	my (%data, @return);
>  	my ($add, $del, $adddel, $file);
> +	my @tracked = grep {
> +		defined run_cmd_pipe(qw(git ls-files
> +			                --exclude-standard --), $_)
> +	} @ARGV;
> +	return if $#tracked == -1 && $#ARGV != -1;

Eek.  why?

Did you mean to say:

    my @tracked = run_cmd_pipe(gw(git ls-files --exclude-standard --) @ARGV);

It would also make sense to use --error-unmatch and perhaps --with-tree=HEAD
like git-commit.sh does.
