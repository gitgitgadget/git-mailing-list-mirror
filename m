From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why does adding an existing repo as a submodule modify .git/config?
Date: Thu, 26 May 2011 23:35:17 +0200
Message-ID: <4DDEC795.3030304@web.de>
References: <irbq5a$h38$1@dough.gmane.org> <4DDAAAD2.1010708@web.de> <4DDB0786.5020006@gmail.com> <4DDB58D9.2090701@cdwilson.us> <4DDC562C.2000204@gmail.com> <BANLkTingA2oRY4i6OnYSz8PGdTRDqXVdFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Christopher Wilson <cwilson@cdwilson.us>
X-From: git-owner@vger.kernel.org Thu May 26 23:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiDE-0003bU-LB
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab1EZVfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:35:19 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42692 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab1EZVfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:35:19 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 124A418F8B14B;
	Thu, 26 May 2011 23:35:18 +0200 (CEST)
Received: from [93.240.114.65] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QPiD7-0005iP-00; Thu, 26 May 2011 23:35:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <BANLkTingA2oRY4i6OnYSz8PGdTRDqXVdFw@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/VBYpdZGV9Zw8p8/wAcacnkCbZ8MLGGcJJ8Mrt
	AUPJtVkg6ndlMrZDbh6e1zQie6eDV4f4tx9ZcCO7oKKGKTy/Kl
	/iHc8c+MZSvR1y+N5tJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174576>

Am 25.05.2011 05:11, schrieb Christopher Wilson:
> On Tue, May 24, 2011 at 6:06 PM, Mark Levedahl <mlevedahl@gmail.com> wrote:
> 
>> However, while you could then change submodule-add to not register the
>> submodule, you would now have the condition of having a submodule that is
>> checked out in the current tree but *not* registered in .git/config.
> 
> Isn't this exactly what "git submodule add" currently does for
> submodules that are NOT added in place?

That is the inconsistency this thread is about. Thanks Christopher for
bringing that up and to Mark for explaining the rationale for updating
the url in .git/config. I really agree with what Mark said there and also
concur with Christopher that a "git submodule add" should always update
the url in .git/config, no matter if it is an already existing repo being
added or a freshly cloned one.

But unfortunately there is more to it than just adding a
	git config submodule."$path".url "$realrepo"
to the module_clone branch in cmd_add() because that makes tests break
where "git submodule init" doesn't copy the "update" settings into
.git/config anymore as it already finds an url configured there and
thinks there is nothing to do. I'm looking into fixing that right now,
so stay tuned ...
