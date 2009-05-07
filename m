From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 10:35:15 +0200
Message-ID: <4A029D43.4030604@viscovery.net>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 10:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1z4w-0002NW-FJ
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbZEGIfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbZEGIfS
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:35:18 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35539 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbZEGIfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:35:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M1z4V-0008Ei-GS; Thu, 07 May 2009 10:35:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 461F354D; Thu,  7 May 2009 10:35:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118443>

(sorry for the previous message; fingers were too fast)

Matthias Andree schrieb:
> +	VN=$(${GIT} describe --abbrev=4 HEAD 2>/dev/null) &&

> +		${GIT} update-index -q --refresh
> +		test -z "$(${GIT} diff-index --name-only HEAD --)" ||

Use "$GIT" in all those cases

>  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
> -	@$(SHELL_PATH) ./GIT-VERSION-GEN
> +	@{ GIT=./git$X ; type $$GIT >/dev/null 2>&1 ; } \

+	@{ GIT=./git$X ; type "$$GIT" >/dev/null 2>&1 ; } \

> +	    || { GIT=$(prefix)/bin/git$X ; type $$GIT >/dev/null 2>&1 ; }\

+	    || { GIT='$(prefix_SQ)/bin/git$X' ; type "$$GIT" >/dev/null 2>&1 ; }\

BTW, isn't `test -x "$GIT"` better in some way than `type "$GIT"`?

> +	    || GIT=git ; \
> +	    export GIT ; \
> +	    $(SHELL_PATH) ./GIT-VERSION-GEN

-- Hannes
