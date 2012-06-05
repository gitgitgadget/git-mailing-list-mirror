From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git smart protocol via WebSockets - feedback wanted
Date: Tue, 5 Jun 2012 11:54:48 -0700
Message-ID: <CAJo=hJue20kwo-jo8x8dC7AUVs3oP=ZC9aCq_ncq3+MWr9VmgQ@mail.gmail.com>
References: <jqlim2$6vt$1@dough.gmane.org> <7vpq9dobjo.fsf@alter.siamese.dyndns.org>
 <jqljtk$h6d$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephan Peijnik <stephan@peijnik.at>
X-From: git-owner@vger.kernel.org Tue Jun 05 20:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbyuU-0005Lj-0E
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab2FESzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:55:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39460 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab2FESzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:55:09 -0400
Received: by pbbrp8 with SMTP id rp8so7834092pbb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kX1iYGVowwcD3ryf2II7vl1tXi+rCDXPOubN34/OL5s=;
        b=f17fQMEFu68N6DK1SNAv4UyzbW5NLML/IalhTf2Xbefctw+GfBc1rIjyomdcADPCY2
         0lb1RSa77K8Obrzy1H1Y1O1hZReDX+RtFIYz0lyDpHUvdRL52M/Htjf9vPD4QdLUHzaM
         WtLA2ORxc+0W0KBcBc/x/Jk6H2nQvE2CU/tj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=kX1iYGVowwcD3ryf2II7vl1tXi+rCDXPOubN34/OL5s=;
        b=CWMSAW/vesPdmDWP3suIVLpD7SemFhguXqR9jbFvqfxLtg3DCEJwmJcS305FCCyd4E
         2jJV8XuCxo52ucmJ0PQMhasJM65rMtU8vLSC5ohSFULQNW6QihgwNio9eTq/8PMLkmIu
         Qn4vH77/UiXx7Bw6Qc/KJRc6VrCCd+0noX9PY6hirP261pN3rQsBTuDmnxWECTQFIvFJ
         njiQI6JXdH1x9LVtW7oYvelirX92PT8tS7L3mO3QVVYo1+TyofBs/v/PD7KEMMZkTim9
         jcu45mzK0aWhanz0q3OFqDg77FBc2wVeB2c3FyIfFKkseY3L547R8uIJrwfXC0REGzY4
         Dpgw==
Received: by 10.68.223.138 with SMTP id qu10mr14354326pbc.50.1338922508444;
 Tue, 05 Jun 2012 11:55:08 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Tue, 5 Jun 2012 11:54:48 -0700 (PDT)
In-Reply-To: <jqljtk$h6d$1@dough.gmane.org>
X-Gm-Message-State: ALoCoQm+t8dmLipMljgdsdq94MSJPrzz4pP4u40i6rcxkiE34LJxkYC44uMGdl9vw4z/EgstqeOl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199280>

On Tue, Jun 5, 2012 at 11:41 AM, Stephan Peijnik <stephan@peijnik.at> wrote:
> On 06/05/2012 08:31 PM, Junio C Hamano wrote:
>>
>> How does this compare with the smart-http support that tunnels the
>> git protocol over http (with some butchering)?
>
>
> To be honest, I didn't know smart-http support yet. Is that the approach
> introduced with git 1.6.6?

Yes. So its been around for a while now. Like 2 years.

> If so, that approach uses multiple POST requests, meaning multiple TCP and
> HTTP connections need to be established, multiple requests processed, etc.

Its actually only one TCP connection... assuming the servers in
between the client and the Git endpoint correctly support HTTP
keep-alive semantics.

> The WebSocket approach uses a single HTTP connection which gets upgraded to
> a WebSocket. This WebSocket then allows the same communication to happen as
> with the ssh implementation.

How does this fair going through crappy proxy servers that perform
man-in-the-middle attacks on SSL connections? Just last week I was
trying to help someone whose local proxy server was MITM the SSL
session behind Git's back, and their IT department forgot to install
the proxy server's certificate into the system certificate directory.
They only installed it into the browser. That proxy also doesn't
correctly grok HTTP 1.1 keep-alive with chunked transfer encodings.
Let alone something as new as web sockets.

> So in comparison there is possibly a lot less overhead and, in theory, the
> performance should be comparable to running the smart protocol over ssh.
> Personally I'd say the WebSocket approach is cleaner than the HTTP-POST
> approach.

This may be true. But its also a lot more complex to implement. I
noticed you reused Python code to help make this work. Let me know
when there is a GPLv2 client library that implements sufficient
semantics for WebSockets that Git can bundle it out of the box. And
let me know when most corporate IT proxy servers correctly grok
WebSockets. I suspect it will be many more years given that they still
can't even grok chunked transfer encoding.
