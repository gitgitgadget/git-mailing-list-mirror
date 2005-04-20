From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 18:11:43 -0700
Organization: http://madrabbit.org/
Message-ID: <1113959503.29444.91.camel@orca.madrabbit.org>
References: <20050418210436.23935.qmail@science.horizon.com>
	 <1113869248.23938.94.camel@orca.madrabbit.org>
	 <42645969.2090609@qualitycode.com>
	 <1113874931.23938.111.camel@orca.madrabbit.org>
	 <4264677A.9090003@qualitycode.com>
	 <1113950442.29444.31.camel@orca.madrabbit.org>
	 <42658E38.1020406@qualitycode.com>
	 <1113951972.29444.42.camel@orca.madrabbit.org>
	 <426594F9.4090002@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Wed Apr 20 03:07:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO3gm-0004f1-NO
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 03:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDTBLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDTBLs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:11:48 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:16871 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261179AbVDTBLp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 21:11:45 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id 48B294C0AC5; Tue, 19 Apr 2005 18:11:44 -0700 (PDT)
To: Tupshin Harper <tupshin@tupshin.com>
In-Reply-To: <426594F9.4090002@tupshin.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks for your patience.

On Tue, 2005-04-19 at 16:32 -0700, Tupshin Harper wrote:
> >Give me a case where assuming it's a replace will do the wrong thing,
> >for C code, where it's a variable or function name.

> try this:
> initial patch creates hello.c
> #include <stdio.h>
> 
> int main(int argc, char *argv[])
> {
>   printf("Hello world!\n");
>   return 0;
> }
> 
> second patch:
> replace ./hello.c [A-Za-z_0-9] world universe

Aha! Okay, I now see at least part of issue: we're using different
definitions of 'token.' Yours is quite sensible, in that it matches the
darcs syntax. However, I'm claiming a token is defined by the file's
language, and that a replace patch on anything but a token as per those
language standards is a silly thing.

In your example, I'd claim you did an inter-token edit, as the natural
token there was "Hello world!\n".

With that, let me restate what I think is possible.

One should be able to discover renames (replaces) of user identifiers in
C code programmatically. Is that everything darcs replace does?
Obviously not. Is that what users would usually *want*? If I were using
it, that's what I'd want (especially including the limited scope of
replacement -- user identifiers such as variable or function names,
etc.). But then I'm not a lurker on the darcs user list, so I don't know
how usage of darcs replace plays out in actual practice.

So, it's a subset. Is it a useful subset? Yes, as it addresses what
happens during refactoring, which is when I'd usually see this getting
used. (Syntactically ignorant search and replace is so, y'know,
*1970s*.)

Any clearer?

Ray

