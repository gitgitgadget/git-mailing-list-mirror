From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mktag.c: tweak validation of tagger field and adjust
 test script
Date: Mon, 31 Mar 2008 22:39:35 -0700
Message-ID: <7vy77ygmlk.fsf@gitster.siamese.dyndns.org>
References: <47F10B75.8060901@nrlssc.navy.mil>
 <47F172E3.7010104@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Apr 01 07:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgZEh-0007hC-99
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 07:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbYDAFju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 01:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYDAFjt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 01:39:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbYDAFjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 01:39:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF0071274;
	Tue,  1 Apr 2008 01:39:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3B6321273; Tue,  1 Apr 2008 01:39:43 -0400 (EDT)
In-Reply-To: <47F172E3.7010104@nrlssc.navy.mil> (Brandon Casey's message of
 "Mon, 31 Mar 2008 18:25:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78633>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>  	/*
>  	 * Check for correct form for name and email
>  	 * i.e. " <" followed by "> " on _this_ line
> +	 * No angle brackets within the name or email address fields.
> +	 * No spaces within the email address field.
>  	 */
>  	tagger_line += 7;
>  	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
> +		strpbrk(tagger_line, "<>\n") != lb+1 ||
> +		strpbrk(lb+2, "><\n ") != rb)
> +		return error("char" PD_FMT ": malformed tagger field",
>  			tagger_line - buffer);

This is the first use of strpbrk() in git.git codebase.  Are BSD folks Ok
with it (I understand this came from SVID 1, just like strspn we already
use elsewhere)?
