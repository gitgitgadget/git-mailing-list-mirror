From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cygwin: push/pull takes very long time
Date: Fri, 3 Mar 2006 10:10:25 +0100
Message-ID: <81b0412b0603030110x73f080ao6a5798e339aa6355@mail.gmail.com>
References: <81b0412b0603020526w7db41994v54a96895c1a6e960@mail.gmail.com>
	 <81b0412b0603020909p179ed9bx4ed8fc2ddf77e868@mail.gmail.com>
	 <20060302215408.GC6183@steel.home>
	 <20060303002806.GB7497@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 03 10:10:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6J1-0001z5-38
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbWCCJK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWCCJK3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:10:29 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:24154 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752189AbWCCJK1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:10:27 -0500
Received: by nproxy.gmail.com with SMTP id c31so431628nfb
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 01:10:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C7PLN+GjfS+HjhllL9l3bBVwIP83Q/pgXYgZoGpck9OhPJMdaIvurKEJEURdsjrlAmVUmIFWMZdZA2tS5oc+Nw1fMUFfD8f+HDGtYaHrY25wZg5KJ74/C52eOggjnYg8WPTaSlCEpc7XtSRgLdHPCF9fZ9galwoQlm/y2c0echA=
Received: by 10.48.225.15 with SMTP id x15mr1065107nfg;
        Fri, 03 Mar 2006 01:10:25 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Fri, 3 Mar 2006 01:10:25 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060303002806.GB7497@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17139>

On 3/3/06, Christopher Faylor <me@cgf.cx> wrote:
> On Thu, Mar 02, 2006 at 10:54:08PM +0100, Alex Riesen wrote:
> >Alex Riesen, Thu, Mar 02, 2006 18:09:23 +0100:
> >>I'll cleanup the profiling code and send it as well soon (I had to
> >>instrument x*alloc).
> >
> >This is not exactly the same.  It counts free as well, even if that is
> >not really interesting - there are places were there is more frees than
> >allocs.  Probably something missed or a result coming from libc.
> >
> >Also it is _not_ the code I used for windows.  I had to have a global
> >variable for argv[0], which needs modification of all main()s, which
> >gets too easily out of sync.
>
> I wasn't following this discussion closely so maybe this is useless
> information, but for Cygwin you can either use the undocumented global
> __argv or you can use /proc/cmdline.  /proc/self/cmdline is going to be
> pretty slow, however.

Oh, thanks. The speed is of no problem here: it's in atexit callback.

> It looks like pure Windows console apps define _argv in stdlib.h also
> but I've never used this and don't know if it is what it looks like.

It works as usual argv. I used "char **__argv", got the message from linker:
Info: resolving ___argv by linking to __imp____argv (auto-import)
which I almost expected.
