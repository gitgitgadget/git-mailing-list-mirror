From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 23:14:20 +0200
Message-ID: <85zm0igdhv.fsf@lola.goethe.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	<46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	<Pine.LNX.4.64.0708221713540.20400@racer.site>
	<86mywjcwv7.fsf@lola.quinscape.zz> <20070823202647.GA3516@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOK0e-0001nL-IX
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 23:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761220AbXHWVOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760908AbXHWVOa
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 17:14:30 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:46738 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761090AbXHWVO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 17:14:29 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 4CED824B018;
	Thu, 23 Aug 2007 23:14:26 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 31CA713F1CE;
	Thu, 23 Aug 2007 23:14:26 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-002-248.pools.arcor-ip.net [84.61.2.248])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 118E91A32E2;
	Thu, 23 Aug 2007 23:14:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 205091C36605; Thu, 23 Aug 2007 23:14:20 +0200 (CEST)
In-Reply-To: <20070823202647.GA3516@steel.home> (Alex Riesen's message of "Thu\, 23 Aug 2007 22\:26\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4037/Thu Aug 23 21:08:22 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56533>

Alex Riesen <raa.lkml@gmail.com> writes:

> David Kastrup, Wed, Aug 22, 2007 19:17:16 +0200:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > And not making the scripts builtins helps Windows users how,
>> > exactly?
>> 
>> Red herring.  The proposal was not to do nothing, but rather give git
>> a dedicated scripting language internal to it.  Two suggestions of
>> mine with different advantages were git-busybox and Lua.
>
> Different "disadvantages". How do you do pipes and safe
> inter-program argument passing in Lua? Portably?

Argument quoting would have to depend on the system.  If you implement
that, you should be able to use os.popen and os.system.  However, the
general Lua approach would be to write wrappers around C routines
dealing with the basic git data structures, giving you things like an
iterator over the index and similar.  One would usually not call
executables, but rather functions from a git-specific library.

Instead of stringing this stuff together with pipes, one would string
it together using coroutines (Lua "threads" are strictly synchronous,
about as fast as normal function calls, and a yield/resume rendezvous
passes a value together with control).

So pipes would not be a natural building block, anyway.

> What do you propose to do about gitbox becoming a dependency for
> others, who inevitably start using it (why not? It promised to be
> portable enough for Git itself!)

I don't understand what you mean here.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
