From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] Documentation: cherry-pick does not set ORIG_HEAD
Date: Sat, 19 Feb 2011 21:13:10 +0100
Message-ID: <4D602456.3020200@gmail.com>
References: <AANLkTingcnvm6rLnWdweAKdeOWAVjh+F+6BMWzfJxhKi@mail.gmail.com> <20110218012435.GA16893@elie> <4D5EE6BB.9070507@gmail.com> <20110218231748.GA17836@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 21:13:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqtBE-0001cq-Js
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 21:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab1BSUNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 15:13:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54278 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab1BSUNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 15:13:19 -0500
Received: by fxm17 with SMTP id 17so313130fxm.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=A/qWz3LlsHr/MA+qV9izjpJDQ0OCC1/m48Y9p1xA3jI=;
        b=uFA7I18ko+BKLEzq+/MkX072kulV9VHC2auWvCfN6rqK7BtaPZ6+TItug5Ad1v+ykd
         N+oVTapVN7sVWP5FLjiXRas35VMcOfsQtC6VU7/jkiBWMVUCcZxHQGZnfNI+nqJNQrLo
         Y2qeEilKJ5kp6+f7459qoUCRbdBHGpTrIhKR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wnKTBm+piEHELlZp0hQ/VUfsSzIdy7iN4YmjjyFqr1gm4TcOqoQLHKyPUHl38lg7wP
         2sklUYXBzajJ5xiu+owjdnnDV01k5ybkRoBswo5K89tiq+fMlClCkPrpEHYB4T62vqS2
         MOgTm76TyApiO3gBIF71LlbHM8pGo5Nc1PVic=
Received: by 10.223.72.197 with SMTP id n5mr970303faj.8.1298146398151;
        Sat, 19 Feb 2011 12:13:18 -0800 (PST)
Received: from [192.168.1.101] (ala228.neoplus.adsl.tpnet.pl [83.26.30.228])
        by mx.google.com with ESMTPS id n3sm1695357fax.31.2011.02.19.12.13.16
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 12:13:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110218231748.GA17836@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167381>

W dniu 19.02.2011 00:17, Jonathan Nieder pisze:
>>> "git reset --merge" will remove local changes marked with "git add",
>>> under the assumption that they were part of the conflict resolution
>>> and thus should be cleared away.
>>
>> Didn't know that (one probably shouldn't merge with uncommitted/local
>> changes anyway). git-reset.txt mentions it, but there's no explicit
>> warning.
> 
> Care to write a patch?

I tried but gave up :( 


>> Is it possible to recognize that you have something more than what
>> was cause by the merge/cherry-pick?
> 
> I suppose it depends what you mean.  I see at least two distinct
> problems to solve:
> 
>  A. "undo" facility to recover from an ugly cherry-pick

That's what I meant. There's a 'git merge --abort', the same should be
available for cherry-pick.

If I understand correctly, this requires changes to cherry-pick to 
set ORIG_HEAD?


> This one is what reset --merge is for.  The idea is that after
> spending a little while trying to make something good out of a
> mess, you say, "oh, bother, let me get back to where I started".

Maybe 'git cherry-pick --abort' could do 'reset --merge' internally.
You would not have to remember "ok, for merge I can do --abort, 
but for cherry pick I must do reset --merge".


> So in this case it really does make sense to back out any changes
> you marked with "git add" after the cherry-pick, since they were
> part of the messy resolution process.  If there had been any
> changes registered before the cherry-pick, the cherry-pick would
> have just failed without making a mess.

Indeed, cherry-pick won't start if there are any stashed changes. 
I wasn't aware about this.

Which is a bit 	strange: why cherry-pick behaves differently than merge?
(merge allows staged changes when merging, cherry-pick doesn't).
Shouldn't they work the same, i.e. allow merge or cherry-pick if the
changes are not conflicting?


Anyway, cherry-pick refuses to work if you have staged changes, but still
doesn't mind local unstaged changes. Which makes possible following case:

   do some local hacking, do not stage yet
   cherry-pick commit with merge conflicts
   try to resolve them, adding local changes in meantime
   give up and try to abort with 'git reset --merge'

In result your local changes will be lost. I don't know how real such
situation is, but maybe git could/should prevent it?

For example by saying "you're trying to abort merge, but it will also
revert your local changes from before the merge".
 

> A patch in flight makes "git cherry-pick" print advice for this case
> when it encounters conflicts (thanks!).

Nice :)

 

-- 
Piotr Krukowiecki
