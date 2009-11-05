From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Thu, 5 Nov 2009 16:48:58 +0300
Message-ID: <20091105134858.GG27126@dpotapov.dyndns.org>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257331059-26344-1-git-send-email-ahaczewski@gmail.com> <4AF175E8.7020400@viscovery.net> <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 14:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N62i6-0007xp-EA
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 14:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbZKENs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 08:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbZKENs6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 08:48:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:46962 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbZKENs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 08:48:57 -0500
Received: by fg-out-1718.google.com with SMTP id 16so44366fgg.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 05:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SFsfoszpnGO0G7wkHR/LT9U3ZNU5bUsVgmqoaUIHgkA=;
        b=mh+XPL2f9ul5R5tmfIAbtK5fTufvvTzAhbfJHAqJ72CBmGLzPd/3/K2TQhuC0gT/Lg
         /0jb/f6lXsTHiMpy2SjRHjDDvbGr99QV6PSOdbIB5WTJmq8HyYgnyOS7JK6KHXimVKze
         ffvRLnZzhoqEUzbjZViAogGZXjQ3x9wwnL1AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fYQrbOu25jrdP5EmQDCU8qO2WZXBxSxHI+L/PJmvhxKGRMUieRD28lM9ukuymLrJgg
         wYHQ4fDaX1m5WlRYsW0wDGSjUb3mdijDc6lP0M0NclHTgobEyqjJl3FZaoqfJMwxyTf2
         eHVV+JayeMv4kXAajJRGdnP5AizSNLd/JX6Lk=
Received: by 10.87.69.28 with SMTP id w28mr4874171fgk.46.1257428941318;
        Thu, 05 Nov 2009 05:49:01 -0800 (PST)
Received: from localhost (ppp91-76-18-216.pppoe.mtu-net.ru [91.76.18.216])
        by mx.google.com with ESMTPS id d8sm1805752fga.8.2009.11.05.05.48.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 05:48:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132228>

On Wed, Nov 04, 2009 at 02:47:09PM +0100, Andrzej K. Haczewski wrote:
> 2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
> 
> > - pthread_cond_signal is called while the mutex is held.
> 
> AFAIK that is a requirement for condition variable to be signaled
> while holding the same mutex that other threads cond_wait on. I just
> don't check that it is true, because Git is locking mutex.

There is no such requirement in POSIX:

   The pthread_cond_broadcast() or pthread_cond_signal() functions may
   be called by a thread whether or not it currently owns the mutex that
   threads calling pthread_cond_wait() or pthread_cond_timedwait() have
   associated with the condition variable during their waits; however,
   if predictable scheduling behavior is required, then that mutex shall
   be locked by the thread calling pthread_cond_broadcast() or
   pthread_cond_signal().

http://www.opengroup.org/onlinepubs/009695399/functions/pthread_cond_signal.html



Dmitry
