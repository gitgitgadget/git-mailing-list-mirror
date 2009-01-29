From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [PATCH] git-cvsserver: handle CVS 'noop' command.
Date: Thu, 29 Jan 2009 15:39:23 -0800
Message-ID: <d4bc1a2a0901291539m636f0fc8s5d9280ce9b7d22b2@mail.gmail.com>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
	 <1233264914-7798-1-git-send-email-stefan.karpinski@gmail.com>
	 <7v7i4denpg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSgVD-0006Ay-8I
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbZA2Xj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbZA2Xj0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:39:26 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:10080 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbZA2XjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 18:39:25 -0500
Received: by wa-out-1112.google.com with SMTP id v33so84944wah.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 15:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bDABS9QIB8nkavgv36/3RezX2OhDMcUzfdNeMgyb6WQ=;
        b=iYjf8JD3OOtpALFGgQKkSpmFHMVn5GVexcrskBgPLPIIIvtkgPKvpPVzmBSS81z/HB
         fmbs6QrCKVpA2oKBwD/kvGUkQragHkLRRQ47fR2FosBG8GKytG+IMg3Q+tjgarewSZbo
         GKu6HV5Vs9qwm2TkbL0wC+GvsW9PwYooNEUdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BZ4FdBducKH6HpHuWEzCL5z1Xwgt+1Ks6a+R14fo4Txx4xo2nMfFHw2pqo76Ot+jJq
         3SmnNi5iJ7zAcpSJYhSu/Ao+jMVctFSdSs0q0a8QkliQsAI3Wyi1ZZqRdiD0UUx6R6SA
         Owwr7i7jXYe5H4Q0KcRuatqQQLC8Y6hz6nWqo=
Received: by 10.115.109.1 with SMTP id l1mr348859wam.143.1233272363944; Thu, 
	29 Jan 2009 15:39:23 -0800 (PST)
In-Reply-To: <7v7i4denpg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107754>

On Thu, Jan 29, 2009 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Imagine what you would do when you discover another request a random other
> client sends that you would want to ignore just like you did for 'noop'.
> Viewed in this light, your patch is a very short sighted one that has a
> big negative impact on maintainability.

Fair enough. I was trying to change the minimal amount that I could
and still fix the breakage. Your patch is much better. Not to mention
terser ;-)

> A true no-brainer that has no negative impact would have been something
> like the attached patch, that adds a method that does not do anything.
>
> Even then, between req_CATCHALL and req_EMPTY, I am not sure which one is
> expected by the clients, without consulting to the protocol documentation
> for cvs server/client communication.  In the attached patch, I am guessing
> from your patch that at least Tortoise does not expect any response to
> it.

I have consulted the CVS protocol documentation (found at
http://www.wandisco.com/techpubs/cvs-protocol.pdf), which states the
following about the "noop" command:

"Response expected: yes. This request is a null command in the sense
that it doesn't do anything, but
merely (as with any other requests expecting a response) sends back
any responses pertaining to
pending errors, pending Notified responses, etc."

So apparently a response *is* expected. I'm not really familiar enough
with CVS or git-cvsserver to determine what that means it should do,
but I suspect from perusing the code that req_EMPTY is the appropriate
action.

Moreover, I've moved on from using git-cvsserver myself, having
instead convinced my Windows-using compatriots to use msysgit instead.
So if you feel that this change is unwarranted, feel free to just drop
it.
