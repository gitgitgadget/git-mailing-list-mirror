From: dhruva <dhruvakm@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 09:13:04 +0530
Message-ID: <e3f230850811091943k63e4a93n566402458a6947dd@mail.gmail.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	 <bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
	 <87hc6gjs7v.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, git@vger.kernel.org
To: "Michal Nazarewicz" <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 04:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzNhZ-00075V-2w
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 04:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYKJDnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 22:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbYKJDnJ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 22:43:09 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:15174 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbYKJDnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 22:43:07 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1306214tic.23
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 19:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jL0KfRmDbz7ba4RtGftC296Cn9AYwelD1hzYWx+B7ZU=;
        b=HsCSrkFL0LYkiF8BKe7Y8/3NGD2ClPHhsc1CtOLvgVCnmuETzsm7RikD6KLfvQNtbs
         81jewxc1f6fKbeL5EmW7loscNgtawKaVwtR5P1uZaaVdIG4iUg8GVfqf5SIU75o4sS3G
         glBYE0UuCrKrIjKfZL0/d4tI3jbRytrhIPA4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hwRs8+91t5d5dJMsXUNPvtZ5fIt1HHDiBwXnQmfIg4zkOkig1zxyg2pLuvk/mPTWJn
         1VxR1a2V9bgSGkhPHqbw4Qz65RvwLXcVnGFDTuzjQt/VWz1QBR+angNaIzjKEcLTgMcR
         8Vzkit85uHG90bAzXqJ7ki8hefo08Q0oeQfdU=
Received: by 10.110.15.9 with SMTP id 9mr7269138tio.48.1226288584928;
        Sun, 09 Nov 2008 19:43:04 -0800 (PST)
Received: by 10.110.93.2 with HTTP; Sun, 9 Nov 2008 19:43:04 -0800 (PST)
In-Reply-To: <87hc6gjs7v.fsf@erwin.mina86.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100487>

Hi,

On Mon, Nov 10, 2008 at 6:46 AM, Michal Nazarewicz <mina86@tlen.pl> wrote:
> "Sverre Rabbelier" <alturin@gmail.com> writes:
>
>> On Mon, Nov 10, 2008 at 01:22, Michal Nazarewicz <mina86@tlen.pl> wrote:
>>> Now, what I need is such feature in GIT.  Upon committing I would like
>>> some magic string (say "$Date$") to be replaced with some value
>>> identifying uniquely given version of a file (a date of the commit would
>>> be sufficient).
>>
>> Please have a look at the relevant entry in the faq [0].
>>
>> [0] http://git.or.cz/gitwiki/GitFaq#head-4a0afe71a2bb7734777a8b0b345e0308aefdbd40
>
> Thanks for the quick reply (and yes, I can't believe I couldn't find
> that myself...) but it still lacks one thing that I'd like to have.
> I would like the "$Id$" sequences to be updated automatically after
> a commit (ie. without the need to check out).  (Besides I would prefer
> $Date$ more but I can live with $Id$ I guess ;) ).

I have worked on this topic quite a bit to fix issues in git-p4. There
is no direct way to get this $Id$ expansion in git, however you can
use a simple pre-commit hook (alpha state, more a proof of concept
that happens to work for me)

#!/usr/bin/env bash

for file in `git diff-index --name-only --diff-filter=AM HEAD` ; do
        perl -pi -e 's/(\$[ \t]*Id)(.*)([ \t]*\$)/"\$Id: git
".time()." \$"/e' ${file}
        git add ${file} > /dev/null
done

-dhruva

-- 
Contents reflect my personal views only!
