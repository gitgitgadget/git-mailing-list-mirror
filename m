From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Parsing diff --git lines
Date: Sun, 09 Mar 2008 00:25:06 -0800 (PST)
Message-ID: <m3r6ekfgnw.fsf@localhost.localdomain>
References: <F4D3B820-CCF4-4212-BF32-700EFD448143@mac.com>
	<alpine.LFD.1.00.0803081955110.5896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Fraser <smfr@mac.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 09:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYGqu-0008L0-0r
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 09:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYCIIZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 04:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYCIIZM
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 04:25:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:6968 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYCIIZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 04:25:09 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1430423fga.17
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=JMl9bPbYQC+oUd+ChPqJSTiUeaqoCELfU7YQsYP3JJI=;
        b=qQDjcWdA8eJsARexn5U7qgbkFkQNpSnIj70K5C0SzqL5cGHUx8WBLr//K2s9L/Cydbs/iq+yx6dvyl/ABRLmY30BucipTmOB8/25NI7Nwzg4/c6qgt44FiYCPcUA0FAZGV5AIvC5JBFLtlUuOU8yOZtZb5bmSH8xqjYY0COkBfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=atZJqS+auA6s8hYVgimQaGHCnZtEFrGWj9pDnB0og1hcZlCf9d73eiIc5ZpmyVut4+PqUyVrdEr5OrDAFNQ/Z87bLnhC53STteZSyjZh2PP0XDR1iP/MeWWhG3gxCr8pGCqJKHFORn9qePw6ZyWBMSsIVR+boz6wYKT4LedfFbA=
Received: by 10.82.174.20 with SMTP id w20mr9022420bue.14.1205051107837;
        Sun, 09 Mar 2008 00:25:07 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.176])
        by mx.google.com with ESMTPS id z40sm7388737ikz.4.2008.03.09.00.25.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 00:25:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m298PC1O006682;
	Sun, 9 Mar 2008 09:25:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m298P8IF006679;
	Sun, 9 Mar 2008 09:25:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.00.0803081955110.5896@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76637>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 8 Mar 2008, Simon Fraser wrote:
> > 
> > However, I don't see a reliable way to identify the two files
> > from a "diff --git" line. Here's a (deliberately pathological)
> > example:
> 
> See how "git-apply" does it.
> 
> The rule is:
> 
>  - if the filenames are different, you should ignore the filenames on the 
>    "diff --git" line, and trust the ones on the "renamed from/to" ones 
>    (which are unambiguous because they only have one filename per line)
> 
>  - if the filenames aren't different, then you can unambiguously know how 
>    to parse it by simply making sure they are the same.

By the way, the default pre-commit hook behaves a bit strangely on
files which contain spaces[*1*] in filename (due to GNU-diff-uism):

*
* You have some suspicious patch lines:
*
* In  b
* trailing whitespace (line 1)
 b:1:++ b/ b	

Foootnote:
==========
[*1*] If file has '"', '\' or control character in filename,
      it is quoted. 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
