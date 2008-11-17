From: Andreas Ericsson <ae@op5.se>
Subject: Re: publish since current state?
Date: Mon, 17 Nov 2008 12:44:14 +0100
Message-ID: <4921590E.6000709@op5.se>
References: <96ed5eac0811161242o4c800e37u7c96872a9a4351ef@mail.gmail.com>	 <49211B78.50204@op5.se> <23ae57c00811170252uba2cd22kb99a23134f026fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gennady Kushnir <genkush@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 12:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L22a2-0002MN-A7
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 12:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbYKQLoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 06:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYKQLoU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 06:44:20 -0500
Received: from mail.op5.se ([193.201.96.20]:57594 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbYKQLoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 06:44:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7C87C24B0018;
	Mon, 17 Nov 2008 12:39:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByApaoDRRjkk; Mon, 17 Nov 2008 12:39:02 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3E44F1B8005E;
	Mon, 17 Nov 2008 12:39:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <23ae57c00811170252uba2cd22kb99a23134f026fc6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101224>

Gennady Kushnir wrote:
> Thank your for your reply.
> But I could not find documentation for grafts... it is only mentioned
> in glossary.
> The only thing I found with google is 1-year-old a mail list post
> http://marc.info/?l=git&m=119636089519572&w=2
> could you point out some direct link to grafts documentation?
> 


>From that link can be gleaned the important stuff, actually.
--8<--8<--
Graft points are configured via the .git/info/grafts file.  It has one
record per line describing a commit and its fake parents by listing
object names separated by a space and terminated by a newline.

<commit sha1> <parent sha1> [<parent sha1>]*
--8<--8<--

> And also - what you mean by "copy the object database
> from the old repository into the new one" ?

I mean something like this:
cd old_repo && git repack -a -d && \
  cp .git/objects/pack/* ../new_repo/.git/objects/pack

cd ../new_repo && \
  echo "$first_sha1_of_new_repo $last_sha1_of_old_repo" \
  > .git/info/grafts

and you're done.

> I'm not aware of such operation. What command does it?
> And will not that copied database go online as dangling objects?
> 

No. The grafts file will connect the two histories so they
look like one. The public repo where people clone from should
not have the grafts-file, and you should run "git repack -a -d"
in that repository to prevent dumb commit walkers from getting
access to all your ancient history through a mega-pack.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
