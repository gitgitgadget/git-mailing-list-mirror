From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 10 Sep 2006 15:03:32 -0400
Message-ID: <20060910190332.17667.qmail@science.horizon.com>
References: <9e4733910609101100u515ae6e3seababd5780db715d@mail.gmail.com>
Cc: git@vger.kernel.org, paulus@samba.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 10 21:34:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMV4R-00066w-ES
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWIJTeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWIJTeS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:34:18 -0400
Received: from science.horizon.com ([192.35.100.1]:27704 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932539AbWIJTeR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:34:17 -0400
Received: (qmail 17669 invoked by uid 1000); 10 Sep 2006 15:03:32 -0400
To: jonsmirl@gmail.com, linux@horizon.com
In-Reply-To: <9e4733910609101100u515ae6e3seababd5780db715d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26813>

> Maybe we are looking at the wrong thing, it may be fast to fork a
> process, is it fast for the process to exit?

The lmbench benchmark figures I cited are for fork+exit.  The other is
fork+exec+exit.

> At the time this was measured parsecvs was executing millions of git
> command using system(command). 40% of the CPU was in the kernel, it
> stayed that way for hours.

Ah!  You are aware, aren't you, that system(string) invokes
/bin/sh to parse the string, right?  So you're starting bash
several million times.  ("man system" explains.)

A direct fork() (or even faster, vfork) and exec() is going to have a
lot less overhead, although it's more work to code.  See Stevens for
excellent examples.
