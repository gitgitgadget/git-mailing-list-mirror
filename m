From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Thu, 30 Sep 2010 13:24:58 +0200
Message-ID: <4CA4738A.9040503@web.de>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <4CA3C569.4020309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 13:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HG8-00041K-Qg
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0I3LZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:25:01 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:48514 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab0I3LZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:25:00 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 12A0116AFBBE1;
	Thu, 30 Sep 2010 13:24:59 +0200 (CEST)
Received: from [93.240.103.152] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P1HFy-0007KA-00; Thu, 30 Sep 2010 13:24:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CA3C569.4020309@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+0dNR9dfZ0j+f5aY3XKMhTLZfISfSDKEfph0N+
	lEXHngEVPnNKyti1MOyg7im6knMd8gFqiWqi7xMRSHmAE4QavT
	u/nJ3bhMRqIffuKoug2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157639>

Am 30.09.2010 01:02, schrieb Chris Packham:
> I actually started with --recursive and switched to
> --recurse-submodules. One thing with this is the standard grep
> --recursive option which may cause some confusion if people expect git
> grep to behave like normal grep.

Guess how I came to use "--recurse-submodules" for recursive checkout
in the first place ;-) But the fact that clone already uses it weighs
stronger here I suppose ...


> One more thought on this that has been hanging around in my mind. I
> sometimes want to do something on all but one submodule, in this case
> with grep I'm fairly likely to want to skip a linux repository because I
> already know the thing I'm looking for is in userland. Maybe in the
> future we can make --recursive take an argument that allows us to
> specify/restrict which submodules get included in the command invocation.

Hmm, maybe adding an option to "git grep" to exclude a pathspec would
make more sense?


>> It seems you want to use strbuf_detach() here so that this argv[]
>> stays valid after the strbuf_release() at the end of this function.

> I'll look into strbuf_detatch. The tricky thing will be keeping track of
> what to free at the end of grep_submodule.

Right, but if you push the strbuf operations into one of the calling
functions you can achieve that more easily.


> Yeah this is the part I was struggling with a little. It would be easy
> to save argv before any option processing but I wondered if that would
> be frowned upon as an overhead for non-submodule usages.

Yup, but as you are only copying a pointer array the overhead is very
small. And if the code gets much easier that way (as I would expect)
that price is well paid.
