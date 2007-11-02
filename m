From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed a gcc 4.0.1 complaint about an uninitialized variable
Date: Thu, 01 Nov 2007 22:37:47 -0700
Message-ID: <7v8x5h6wd0.fsf@gitster.siamese.dyndns.org>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
	<1193971102-61907-2-git-send-email-blaker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Blake Ramsdell <blaker@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 06:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InpEU-0007Le-FC
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 06:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXKBFh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 01:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbXKBFh7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 01:37:59 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:44906 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbXKBFh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 01:37:59 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D70112EF;
	Fri,  2 Nov 2007 01:38:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 346C08F558;
	Fri,  2 Nov 2007 01:38:16 -0400 (EDT)
In-Reply-To: <1193971102-61907-2-git-send-email-blaker@gmail.com> (Blake
	Ramsdell's message of "Thu, 1 Nov 2007 19:38:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63064>

Blake Ramsdell <blaker@gmail.com> writes:

> diff --git a/transport.c b/transport.c
> index 400af71..cac1870 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -107,7 +107,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
>  		return;
>  
>  	for (;;) {
> -		int cmp, len;
> +		int cmp = 0, len;

Yeah, if you follow the logic, it is clear that the variable is
never used while unset, but gcc is not careful enough to see it.

It is customary to use

	int cmp = cmp;

for something like this.  There are already other instances of
such phony initializations in the code elsewhere.
