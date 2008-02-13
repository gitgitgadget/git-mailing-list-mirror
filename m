From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-am strips newlines in some commit messages?
Date: Wed, 13 Feb 2008 01:15:02 -0800 (PST)
Message-ID: <m3skzxcj5c.fsf@localhost.localdomain>
References: <20080213083200.GP25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 10:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPDiW-0005ZS-6d
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 10:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759952AbYBMJPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 04:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759359AbYBMJPK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 04:15:10 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:4860 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825AbYBMJPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 04:15:06 -0500
Received: by fk-out-0910.google.com with SMTP id z23so5253503fkz.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=b1lmcKs2w5KYTwSki2DbCb4tXXfdE0v21ABl5V0R48o=;
        b=CODxiO3PGcDmJPXAqhaaweXo1JogQKMCPYIO4pZN3Jfv6/0NZSw973OOfd8lnRahWXJkvhK11HPb+oypR2MVc/v5rK90FRdNUMwWNOHDaIzJwtFAQMlKKFFZdswM6E7Sn7ZnJfo1iUWe0Sri+wHEPzxPkQ4K1/P1GHEBKIbxZ94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=WrPQCZPmqJs/fWRJCLRwjJtg0tgnQ+4N47ggH3tLK5U/MYekNBCSKC+ceNtLLwRF7/ogdxvwS4nFl1h97/yFnx6d5h2tVEsWDYqUq/tcMBYviTFPGtt+Byrn/vKSi5AG3Nxb4Q0QkmgmqqLeIBdC3klgJJFZUf+4onFW0XJUoko=
Received: by 10.82.106.14 with SMTP id e14mr2641008buc.37.1202894103130;
        Wed, 13 Feb 2008 01:15:03 -0800 (PST)
Received: from localhost.localdomain ( [83.8.208.20])
        by mx.google.com with ESMTPS id t2sm1394532gve.3.2008.02.13.01.15.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 01:15:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1D9EvoC002572;
	Wed, 13 Feb 2008 10:14:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1D9Eu93002569;
	Wed, 13 Feb 2008 10:14:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080213083200.GP25954@genesis.frugalware.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73761>

Miklos Vajna <vmiklos@frugalware.org> writes:

> it seems that in case the second line of a commit message is not empty,
> then git am strips newlines from the commit message. is this expected?

> vmiklos@gaia:~/git/t$ cat 0001-foo.patch |git am
> Applying - foo - bar - baz
> vmiklos@gaia:~/git/t$ head -n 6 0001-foo.patch
> From a928423a563201d95cf2e53c5050dbdfb415708e Mon Sep 17 00:00:00 2001
> From: Miklos Vajna <vmiklos@frugalware.org>
> Date: Wed, 13 Feb 2008 09:23:49 +0100
> Subject: [PATCH] - foo
>  - bar
>  - baz

git-am assumes that patch is in email form, and in email there is
single empty line separating email headers from email body. What makes
git-am mangle your commit message is the fact that email format allows
for header to span multiple lines: you have continuation lines to have
indented by whitespace. So git-am thinks that " - bar - baz" is
continuation of Summary: header.

> of maybe the solution would be that git format-patch inserts two
> newlines after the subject - even if the second line would not empty
> originally.

Decidely. This empty line would always be stripped.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
