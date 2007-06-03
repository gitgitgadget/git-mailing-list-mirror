From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Sun, 3 Jun 2007 12:28:58 +0200
Message-ID: <200706031228.58779.jnareb@gmail.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org> <Pine.LNX.4.64.0706030147520.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 03 20:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuuOQ-0006KT-RS
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbXFCSBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbXFCSBX
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:01:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:47854 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXFCSBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:01:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so572530ugf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 11:01:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dHFLkHvA8gfCzAGpL0ReYcOTScXGQB5NvxUSOy0g8Q4Xys0mxlF1NBIzAYeeTPi+PaRMg3H1OLl4vm8dbgRkagxGW78RzlfgNjrwUdhhNj0DDz2TlFXqVEHwuXoAMrnBEPtyGxaqH4XPI75zLRbLgacGxf6e5WHZ3C0f30fdc+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gTlhcG1XhzTEJ7riqj5YQ5xbSAPqkseVKf7CC0iJZC6R7Z3rNL8qK1spYXzEeSWt0Ib0CDVxV3EH2X1tV+Onviqd6XWSapVPzca8w+xrws54hURLQ0H684/Cu0KA4mBoM2jjwW3GDYlgiUL3HD9FSLu+p81svF84iA3eqRkZIr0=
Received: by 10.67.32.19 with SMTP id k19mr1640583ugj.1180893681533;
        Sun, 03 Jun 2007 11:01:21 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id k57sm914863uga.2007.06.03.11.01.17;
        Sun, 03 Jun 2007 11:01:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0706030147520.4046@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49016>

On Sun, 3 Jun 2007, Johannes Schindelin wrote:
> On Sun, 3 Jun 2007, Jakub Narebski wrote:
>> Johannes Schindelin wrote:
>> 
>>> This script is derived from Pasky's cg-admin-rewritehist.
>>> 
>>> In fact, it _is_ the same script, minimally adapted to work without cogito.
>>> It _should_ be able to perform the same tasks, even if only relying on
>>> core-git programs.
>>> 
>>> All the work is Pasky's, just the adaption is mine.
>> 
>> I was thinking about rewriting cg-adin-rewritehist as git-rewritehist
>> using Perl (IIRC it needs bash, not only POSIX shell), and make it
>> use git-fast-import.

By the way, why did you change name to git-filter-branch, instead of
leaving it [almost] as is, i.e. git-rewritehist. Or if you wanted to
emphasize that it rewrites only one branch at a time, git-rewrite-branch?

Note that history (branch) gets rewritten also in absence of filters,
if there are any grafts in place. But I might be mistaken.

> First, it does not need Perl.
> 
> Second, it does not even need bash.

If I remember correctly (but I can be wrong here) Pasky said that he had
to use arrays in cg-admin-rewritehist. Because introducing dependency on
bash would be bad, that was the cause of thought to rewrite it in Perl
(which we depend on anyway). 

See below.

> At least that is what I tried to make sure. I replaced the only instance 
> of a bashim I was aware, namely the arrayism of $unchanged. It can be a 
> string just as well, as we are only storing object names in it.

I'm sorry, I haven't reviewed your patch carefully enough, it seems like.
If you can translate cg-admin-rewritehist to POSIX shell, more power
to you.

                          -- " --

Few notes of lesser importance (meaning they can go into subsequent
commits).

1. Documentation: Cogito had documentation together with the command
   described, similarly to Perl POD, or LaTeX doc package + DocStrip,
   etc. It has IIRC rules in Makefile to extract documentation.

   In git we have documentation in separate files. The commands
   themselves have only usage, and sometimes long usage embedded.
   It would be nice of git-filter-branch / git-rewrite-branch also
   followed this convention.

2. Using fast-import.

   >> +# Note that since this operation is extensively I/O expensive, it might
   >> +# be a good idea to do it off-disk, e.g. on tmpfs. Reportedly the speedup
   >> +# is very noticeable.

   Would it be possible to use git-fast-import to reduce I/O in this
   command? Cogito didn't use it because it is quite new, but there
   is no reason to not to use it now, I think.

-- 
Jakub Narebski
Poland
