From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Tue, 12 May 2009 16:16:02 -0700
Message-ID: <7vws8l7w0d.fsf@alter.siamese.dyndns.org>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	<200905121557.18542.Hugo.Mildenberger@namir.de>
	<81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	<200905121900.00625.Hugo.Mildenberger@namir.de>
	<81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	<20090512172452.GA32594@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M41Co-0000y1-05
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 01:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbZELXQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 19:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZELXQE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 19:16:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37194 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbZELXQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 19:16:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512231603.OUWU17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 May 2009 19:16:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id qnG21b0054aMwMQ03nG21T; Tue, 12 May 2009 19:16:02 -0400
X-Authority-Analysis: v=1.0 c=1 a=BJd_Gdj20ywA:10 a=nM9qI384qiQA:10
 a=pGLkceISAAAA:8 a=gq71ZiVMnDdDPZ2e1KQA:9 a=7Zfi09xfILKxtA-gtgPA_t_GgXwA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090512172452.GA32594@blimp.localdomain> (Alex Riesen's message of "Tue\, 12 May 2009 19\:24\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118970>

Alex Riesen <raa.lkml@gmail.com> writes:

> +		for (i = 0; i < url_len; ++i)
> +			if ('\n' == url[i])
> +				fputs("\\n", fp);
> +			else
> +				fputc(url[i], fp);
> +		fputc('\n', fp);

This ad-hoc quoting feels _very_ wrong.  Who is on the reading side and
how does it unquote?  If it uses quote.c infrastructure, we should be
quoting using the function from the same library shouldn't we?

If it is just informational use only, then it might make more sense to
drop this ugly "quoted \n" silently.  I dunno.
