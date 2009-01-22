From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-log: Follow file copies with 'git log --follow
 -C -C'
Date: Thu, 22 Jan 2009 09:28:59 -0800
Message-ID: <7v8wp36yhw.fsf@gitster.siamese.dyndns.org>
References: <1232642245-94405-1-git-send-email-arjen@yaph.org>
 <1232642245-94405-2-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3Nu-00064C-G5
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbZAVR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbZAVR3H
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:29:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbZAVR3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:29:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E2DD92C6E;
	Thu, 22 Jan 2009 12:29:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 424F592C6D; Thu,
 22 Jan 2009 12:29:00 -0500 (EST)
In-Reply-To: <1232642245-94405-2-git-send-email-arjen@yaph.org> (Arjen
 Laarhoven's message of "Thu, 22 Jan 2009 17:37:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A51F288-E8AA-11DD-B4A0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106777>

Arjen Laarhoven <arjen@yaph.org> writes:

> When the '--follow' option is used with '--find-copies-harder' ('-C -C')
> logs on individual files will work across file copies as well as
> renames.

Is there a reason to limit this to "harder" case?

> diff --git a/tree-diff.c b/tree-diff.c
> index 9f67af6..73652b2 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -333,6 +333,8 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
>  
>  	diff_setup(&diff_opts);
>  	DIFF_OPT_SET(&diff_opts, RECURSIVE);
> +	if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER))
> +		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
>  	diff_opts.detect_rename = DIFF_DETECT_RENAME;

Hmm, why isn't this DIFF_DETECT_COPY?

>  	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
>  	diff_opts.single_follow = opt->paths[0];
> -- 
> 1.6.1.354.gd9e51
