From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] add: allow configurations to be overriden by command
 line
Date: Thu, 18 Jun 2009 11:14:42 -0700
Message-ID: <4A3A8412.7070705@gmail.com>
References: <1245316674-32377-1-git-send-email-bebarino@gmail.com> <7vfxdxxzps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 20:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHM8T-00015p-7K
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 20:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbZFRSOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 14:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbZFRSOn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 14:14:43 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:57402 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZFRSOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 14:14:42 -0400
Received: by pzk15 with SMTP id 15so1003012pzk.4
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=0mdXaIt78unlOU2Krp3RRN9zbj0pOiSkaO3/y6m2BhM=;
        b=mMdJP4oyEomc+w6NiZuGFrih6WJsTxFWrE+kOXkPXtD8zWQXMTT8RlHy8jEMXMJYtL
         Z6TmdnzFYM0mggTVFoi3/jFAKWZC0nh2261GBY7C4Ve9drqTr0mod+LsuY0TJpDRXfnI
         SE2OTWlAivNKuq1eYHIeHJ4ANZlfNc10uauYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dej3BFKHrpsfhl5nUDHU+e4TRc90qPYOhmK0xcm170PmKn8qBHMqswbD6ezE/fqZCj
         97TUvZZRgPD3UfYMlSyUPTJwHiPlmmJzyB44bManczQTo5M12n0aOJf51i+GL4bgyZSJ
         pFRKMpw28IXkOevGZpXVfQGblKJOo1Hv6/Jlw=
Received: by 10.114.235.16 with SMTP id i16mr2477932wah.164.1245348884591;
        Thu, 18 Jun 2009 11:14:44 -0700 (PDT)
Received: from ?192.168.1.5? (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id j34sm4340198waf.64.2009.06.18.11.14.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 11:14:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vfxdxxzps.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121865>

Junio C Hamano wrote:
>
> Perhaps this deserves a test.  It is an ancient breakage nobody noticed so
> far

I didn't think it would be very useful, which is why I left it out. But
hey, at least it stops it from happening again. Squash it in if you want.

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6ce8256..91c1f7a 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -242,4 +242,13 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 	git add track-this
 '
 
+test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
+	git config add.ignore-errors 1 &&
+	git reset --hard &&
+	date >foo1 &&
+	test_must_fail git add --verbose --no-ignore-errors . &&
+	! ( git ls-files foo1 | grep foo1 ) &&
+	git config add.ignore-errors 0
+'
+
 test_done
