From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve collection of information for format-patch
 --cover-letter
Date: Mon, 25 Feb 2008 16:07:21 -0800
Message-ID: <7v1w70h96u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251822240.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 01:08:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTnMf-0001pE-VK
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 01:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757690AbYBZAHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 19:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbYBZAHe
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 19:07:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbYBZAHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 19:07:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 658F32FFD;
	Mon, 25 Feb 2008 19:07:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EF19D2FFA; Mon, 25 Feb 2008 19:07:28 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802251822240.19024@iabervon.org> (Daniel
 Barkalow's message of "Mon, 25 Feb 2008 18:24:17 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75094>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... Note that the single boundary test is empirical, not 
> theoretical; even a -2 limiting condition will give a diffstat if there's 
> only one boundary commit in this particular case.

It is unclear what "a -2 limiting condition" means here...

> @@ -679,21 +682,19 @@ static void make_cover_letter(struct rev_info *rev,
>  
>  	strbuf_release(&sb);
>  
> +	shortlog_init(&log);
> +	for (i = 0; i < nr; i++)
> +		shortlog_add_commit(&log, list[i]);
> +
> +	shortlog_output(&log);
> +

Nice ;-)

> @@ -962,7 +957,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  
>  	if (prepare_revision_walk(&rev))
>  		die("revision walk setup failed");
> +	rev.boundary = 1;
>  	while ((commit = get_revision(&rev)) != NULL) {
> +		if (commit->object.flags & BOUNDARY) {
> +			fprintf(stderr, "Boundary %s\n", sha1_to_hex(commit->object.sha1));

Leftover debugging?
