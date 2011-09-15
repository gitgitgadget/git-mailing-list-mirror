From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] add lame win32 credential-helper
Date: Thu, 15 Sep 2011 23:48:30 +0200
Message-ID: <CABPQNSZjGzyxJKWRDDWxRj_SLdC1Y_9TxnAMOA+b-Pw3+X-E7w@mail.gmail.com>
References: <1316118324-6164-1-git-send-email-kusmabite@gmail.com> <20110915214026.GA18623@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, jaysoffian@gmail.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 23:49:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Jo5-00055G-S0
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935189Ab1IOVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:49:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63863 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935181Ab1IOVtK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:49:10 -0400
Received: by pzk32 with SMTP id 32so4971070pzk.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jQvVIiW1weAgLTTWTnidCghZiVL99+28TCBUtKG6HgY=;
        b=fn/FLpMrv+WoZvkp1p2dIf2RbCEgiaX8+Oy5H6bMUTgHB9CCyZQePIjKsKXmpIKvKb
         Q6JG3DacHA9n8OpbKHPKotjT8kQgzieLaQ/tmOaPTl672rhddc+8QhMdHgr6EPA5d0PZ
         RHO9JNhrFTSjnhaqokzL8eVveu4vZ1tHzpJME=
Received: by 10.68.12.103 with SMTP id x7mr2463810pbb.188.1316123350125; Thu,
 15 Sep 2011 14:49:10 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 15 Sep 2011 14:48:30 -0700 (PDT)
In-Reply-To: <20110915214026.GA18623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181521>

On Thu, Sep 15, 2011 at 11:40 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 15, 2011 at 10:25:24PM +0200, Erik Faye-Lund wrote:
>
>> Not that it's useful yet, since the core-git code for the
>> credential-helper support doesn't compile on Windows. So
>> it's not fully tested, I've only read the interface
>> documentation and experimented with it from the command
>> line.
>
> Which parts of the credential-helper code don't compile? I wouldn't be
> surprised if the cache helper doesn't work (because it uses unix domain
> sockets for communication).

That's exactly it:

unix-socket.c:12: warning: 'struct sockaddr_un' declared inside parameter list
unix-socket.c:12: warning: its scope is only this definition or declaration, whi
ch is probably not what you want
unix-socket.c: In function 'unix_sockaddr_init':
unix-socket.c:15: error: dereferencing pointer to incomplete type
unix-socket.c:17: error: dereferencing pointer to incomplete type
unix-socket.c:18: error: dereferencing pointer to incomplete type
unix-socket.c:19: error: dereferencing pointer to incomplete type
unix-socket.c: In function 'unix_stream_connect':
unix-socket.c:25: error: storage size of 'sa' isn't known
unix-socket.c: In function 'unix_stream_listen':
unix-socket.c:39: error: storage size of 'sa' isn't known
make: *** [unix-socket.o] Error 1
make: *** Waiting for unfinished jobs....

> If it's too hard to adapt it to whatever IPC
> mechanism would be appropriate on Windows, we can just leave it out on
> that platform.
>
> But the core code in git itself should be pretty straight forward.

I didn't mean that it was impossible to port, just that it didn't compile
as-is. I haven't looked into fixing up the code so it compiles on Windows
again myself. And I'm not really planning to; I have little git-time these
days, and little knowledge of how unix-sockets works...
