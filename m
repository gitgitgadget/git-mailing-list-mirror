From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] cherry-pick: when pick fails, explain how to cancel
Date: Fri, 18 Feb 2011 22:38:03 +0100
Message-ID: <4D5EE6BB.9070507@gmail.com>
References: <AANLkTingcnvm6rLnWdweAKdeOWAVjh+F+6BMWzfJxhKi@mail.gmail.com> <20110218012435.GA16893@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 22:38:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqY1q-00041W-BQ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 22:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1BRViO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 16:38:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58417 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab1BRViN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 16:38:13 -0500
Received: by fxm20 with SMTP id 20so4257106fxm.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZSkEIEGxaH3k/EXrqER8ljfRV97Hjb16nGdlD4yL6UI=;
        b=aPViRc7dGSrbcvCxy/91q4vwlh601iUiEe1Zwzs1RKrtI0yCYx4eLsj10twO37o8KM
         o2kiqd1EU77z+aOZgX9CCwRchEuzv/ebKi4ESC/LkWEKMjo1AN7vgBgivsKUrErL0Xpd
         X1C7kPgj0E9BKLl93yUSVu4rRPGt//cJPuKpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VJN9AWAhB0FQTlP7GUmk6EJU9snm5seMWUkJJeyrjf0dIVQt2kA2Zzroh9yiGmUsSZ
         szuFHGNs3PbFLwrVi1qpDM46BYiIQ3az9wQXwszdS9AoPPcmVS3HySukYmoE3PLBJQ44
         WrEx/J+kUvqIhL0+QpPRiZ7QeWjADF75aib44=
Received: by 10.223.86.80 with SMTP id r16mr1615604fal.81.1298065091673;
        Fri, 18 Feb 2011 13:38:11 -0800 (PST)
Received: from [192.168.1.101] (akw69.neoplus.adsl.tpnet.pl [83.26.26.69])
        by mx.google.com with ESMTPS id 5sm82072fak.23.2011.02.18.13.38.09
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 13:38:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110218012435.GA16893@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167230>

W dniu 18.02.2011 02:24, Jonathan Nieder pisze:
> Piotr Krukowiecki wrote:
>> 1. add hint to cherry-pick how to abort merge, for example:
>>    hint: use 'git reset --merge ORIG_HEAD' to abort merge
> 
> Good idea.  "git cherry-pick" does not set ORIG_HEAD, so I
> put "git reset --merge HEAD" instead.

You're right. I was sure I have tested it, but when I try to 
use ORIG_HEAD now it does not work.

I took it from Documentation/git-cherry-pick.txt, which seem
to be wrong:

   $ git cherry-pick topic^             <1>
   $ git diff                           <2>
   $ git reset --merge ORIG_HEAD        <3>
   [...]
   <3> cancel the cherry-pick.  In other words, return to the
   pre-cherry-pick state, preserving any local modifications you had in
   the working tree.


>> 2. add hint to status how to abort merge, for example:
>>    #   (use 'git reset --merge ORIG_HEAD' to abort merge)
> 
> "git reset --merge" will remove local changes marked with "git add",
> under the assumption that they were part of the conflict resolution
> and thus should be cleared away.

Didn't know that (one probably shouldn't merge with uncommitted/local
changes anyway). git-reset.txt mentions it, but there's no explicit
warning.


> This leaves me afraid of the following scenario:
> 
> 	git pull
> 	# conflict?  agh!
> 
> 	# ... two days later ...
> 	... hack hack hack ...
> 	... add add add ...
> 	git commit;	# fails because of unmerged files
> 
> 	# whoops, forgot about that merge.
> 	# Let's do what it says to do:
> 	git reset --merge ORIG_HEAD
> 
> It seems safest to only recommend "reset --merge" immediately
> after a mergy operation.

Is it possible to recognize that you have something more than what
was cause by the merge/cherry-pick?


>> The ORIG_HEAD is specified in man page example.
> 
> I assume you mean on the git-reset page?  It might be nice to add
> more examples and to update the current ones with current best
> practice (e.g., using reset --keep more often).

Yes, it says:

   Running "git reset --hard ORIG_HEAD" will let you go back to where
   you were, but it will discard your local changes, which you do not
   want.  "git reset --merge" keeps your local changes.

 
>> git-cherry-pick uses word "cancel" in man page (in example) and
>> git-merge uses word "abort" for (as I understand) the same action.
> 
> Hmm, where is this example in the cherry-pick manpage?

It's in the Documentation/cherry-pick.txt (in current master). I assume 
man pages are generated from those text files. I have also cited it at 
the beginning of this mail.


-- 
Piotr Krukowiecki
