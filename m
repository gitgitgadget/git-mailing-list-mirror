From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 16:49:11 +0200
Message-ID: <200905131649.13159.Hugo.Mildenberger@namir.de>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905131340.31509.Hugo.Mildenberger@namir.de> <81b0412b0905130510n61d59f54rf385a89bbb43a530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 16:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4FnA-0004CZ-NL
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 16:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760708AbZEMOuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 10:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760695AbZEMOub
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 10:50:31 -0400
Received: from mx02.qsc.de ([213.148.130.14]:51236 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760681AbZEMOua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 10:50:30 -0400
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx02.qsc.de (Postfix) with ESMTP id 35FA319B6215;
	Wed, 13 May 2009 16:50:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0905130510n61d59f54rf385a89bbb43a530@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119055>

Am Mittwoch, 13. Mai 2009 schrieb Alex Riesen:
> 2009/5/13 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
> > Am Mittwoch, 13. Mai 2009 schrieb Alex Riesen <raa.lkml@gmail.com>
> >>
> >> That'd mean to loose the information completely. Which is just as bad
> >> as putting the LF in the url in the first place.
> >
> > This stray linefeed is not information, but pure contamination. Thus it
> > would be much better to simply strip it off.
> 
> Not at the place where the patch changes it. In git clone, maybe (the many
> times mentioned guessing function). But then, we have to provide an option
> to leave the names alone, verbatim (which, I think, the non-quessing form
> already provides. No additional coding necessary).
> 
> > And besides from the fact that git apply rejects this patch (fatal: corrupt
> > patch at line 6),
> 
> This is your local problem. Maybe you copied the patch through clipboard
> and it kept the presentation in KMail, or KMail generally corrupts
> mails, I don't
> know. Just save the mail as is and do "git am -3" on it.

My apologies, the problem actually was copy & paste from kmail.

> > I think it would also not handle the equally wrong repository directory name on disk,
> 
> You think wrong. It does handle it perfectly.

I'm thinking right. The stray linefeed is still there:

ls -l 'bluetooth-testing.git
'/ -d
drwxr-xr-x 23 hm hm 4096 13. Mai 15:06 bluetooth-testing.git?/


> > which then possibly leads to subsequent make failures (as it actually happend in
> > the case I described earlier here.)
> 
> The make(1) works in such directories just fine. Fix yours (thinking about
> it now - you wont find a make which does not work in such directories).

You aren't saying which make you are using, but GNU make version 3.81 or 
the linux kernel make system still can't cope with a linefeed contaminated directory 
name:

hm@localhost /var/tmp/bluetooth-testing.git $ make
make[1]: /mnt/hda1/tmp/bluetooth-testing.git: No such file or directory
make[1]: *** No rule to make target `/mnt/hda1/tmp/bluetooth-testing.git'.  Stop.
make: *** No rule to make target `include/config/auto.conf', needed by `include/config/kernel.release'.  Stop.

> > Why not just return to your original idea, which proposed testing the
> > repository name against a regular expression describing a forbidden
> > set of characters (which is "\n", currently) and then terminate with a
> > clear message?
> 
> The idea was not abandoned nor followed upon. It's just I don't need that
> warning and would switch it off immediately anyway (if it was implemented).
> I just spent a minute thinking about it (that's where regexp idea came from).
> I'm not going to work on it (at least, not right now). I'm even sure you wont
> be working on it too, now when you have learned what the problem is and
> how to work around it. And that's while all you needed is to put a two-three
> lines in that guessing function...

I reported this problem here after I already knew the cause and how to avoid
the problem, because I thought it might be useful fix it generally, especially 
useful for those who run git within a brushwood of scripts, which I do not. 
If you personally would need this or not is not of so much interest here. But 
I was interested in discussing a clean way to implement it.
