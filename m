From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: BUG. Git config pager when --edit
Date: Mon, 07 Nov 2011 21:45:02 +0100
Message-ID: <op.v4lfxck60aolir@keputer.lokaal>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
 <CAH6sp9Ox+6p4RkjCZ0j3tXG9F4u7SPuwbSrOWmLSXic9DxSKiQ@mail.gmail.com>
 <20111107164250.GC27055@sigill.intra.peff.net>
 <7vpqh327ds.fsf@alter.siamese.dyndns.org>
 <20111107171800.GA3621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Alexey Shumkin" <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 21:45:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNW48-0001hA-1o
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 21:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab1KGUpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 15:45:07 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62819 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1KGUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 15:45:06 -0500
Received: by eye27 with SMTP id 27so3863750eye.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 12:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=DuaPGpl0DAJR9SiU4ZFSGJ1wKqeAtJHmAknLydWzlgs=;
        b=JDDOKIOgs6DJ5dRMg9ZolP7IsdPXLGFEyBfqNBCoC6NPS/AIfU0syH8o1Ubu4FKBrG
         aCTDMyjH8Q/jqpRQa9al4rx9zMPM2mIUY/9GCE9WX9qbk0gWk+nB6hD+U9jSN9Q9gaiP
         KSTFOcYIa4ERBy/kCLtgvihmr0LBBhNFNZo3k=
Received: by 10.213.32.147 with SMTP id c19mr1158513ebd.10.1320698704930;
        Mon, 07 Nov 2011 12:45:04 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm53243474eef.9.2011.11.07.12.45.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 12:45:04 -0800 (PST)
In-Reply-To: <20111107171800.GA3621@sigill.intra.peff.net>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185023>

On Mon, 07 Nov 2011 18:18:00 +0100, Jeff King <peff@peff.net> wrote:

>> I was actually hoping that you won't go that route, but the route to  
>> push
>> further to decide/spawn pager as late as possible. Clearly no sane  
>> person
>> would want to run --edit subcommand under pager and "pager.config =  
>> less"
>> should just be ignored in such a case.
>
> The problem with that is that it dumps the responsibility for running
> the pager to every subcommand. For builtins, we can have a flag that
> says "respect the pager.log config" or "foo will handle this itself;
> don't respect pager.tag".
>
> But what about externals? If "pager.stash" does nothing in git.c, and
> leaves it to "git-stash.sh" to start the pager if and when it's
> appropriate, then what about my personal "git-foo" that I drop into my
> PATH? Now I can't use "config.foo" without carrying code to do so in my
> external command.
>
> Maybe that's an OK tradeoff. But it's more of a pain for existing
> scripts, and it's not backwards compatible. What do you think?

For both cases there's something to say. In any new design I might dump  
the responsibility on the external, but I would prefer to keep the  
decision logic centralized. But as I understand, removing the  
responsibility from git.c is going to require a whole bunch of other  
changes to get the pager functional again in the scripts. So if there is a  
somewhat decent way to be sure about whether or not to use the pager (i.e.  
no editing) in git.c, why not keep it there? If, on the other hand, the  
code is going to turn out to be a big hack, I'd say move it out.

Frans
