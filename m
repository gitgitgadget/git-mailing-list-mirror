From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Replace literal STRLEN_ #defines in refs.h with compiler evaluated expressions
Date: Sat, 29 Sep 2007 09:58:41 -0700
Message-ID: <7vd4w1l872.fsf@gitster.siamese.dyndns.org>
References: <200709291400.13880.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 18:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibfea-0006S2-Ae
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbXI2Q6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756117AbXI2Q6t
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:58:49 -0400
Received: from rune.pobox.com ([208.210.124.79]:36490 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098AbXI2Q6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 12:58:49 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 19D4413E3CA;
	Sat, 29 Sep 2007 12:59:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B83013E3B7;
	Sat, 29 Sep 2007 12:59:05 -0400 (EDT)
In-Reply-To: <200709291400.13880.andyparkins@gmail.com> (Andy Parkins's
	message of "Sat, 29 Sep 2007 13:00:13 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59479>

Andy Parkins <andyparkins@gmail.com> writes:

> Bill Lear pointed out that the following:
>
>  #define PATH_REMOTES             "remotes/"
>  #define STRLEN_PATH_REMOTES      8
>
> Could be replaced by the less error-prone
>
>  #define PATH_REMOTES "remotes/"
>  #define LIT_STRLEN(S) ((sizeof(S) / sizeof(S[0])) -1)
>  #define STRLEN_PATH_REMOTES LIT_STRLEN(PATH_REMOTES)
>
> which is what this patch does.

I do not think the above is wrong per se, but doesn't a good
compiler optimize

	#define PATH_REMOTES	"remotes/"
	#define STRLEN_PATH_REMOTES strlen(PATH_REMOTES)

	... and much later in some *.c file that includes the
	... above and <string.h>

        foo = strlen(PATH_REMOTES)

anyway?
