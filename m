From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodule add does not consider git svn
Date: Sun, 24 Jul 2011 21:44:39 +0200
Message-ID: <4E2C7627.8050104@web.de>
References: <CAJs9aZ9cMZd5PfOW7Zfza3un5JqKRM5eQdDpKPCWvLn-vkzktA@mail.gmail.com> <4E2B10B7.3010903@web.de> <CAJs9aZ8fAPzr6Lo1EUO+Lnr1pHm=dNr6P5oYgpXE1RqkmMX7hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rupert THURNER <rupert.thurner@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql4c6-0001jj-Dw
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab1GXTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 15:44:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35833 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab1GXTol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 15:44:41 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3E6C01944C204;
	Sun, 24 Jul 2011 21:44:40 +0200 (CEST)
Received: from [93.246.46.13] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Ql4bQ-0001n3-00; Sun, 24 Jul 2011 21:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAJs9aZ8fAPzr6Lo1EUO+Lnr1pHm=dNr6P5oYgpXE1RqkmMX7hA@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18fppwYMFrRI006pO6O0kRcULlVf6Z2weSN/wuh
	I1TEg0OEbl4GvGvUTDVcGTKNtxdIxXBY2XL9uJF35yMT82993B
	ljG8+r3AXA272Caf0RfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177775>

Am 24.07.2011 10:00, schrieb rupert THURNER:
> On Sat, Jul 23, 2011 at 20:19, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Try the following instead:
>>
>> git init test
>> cd test
>> git svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg/GeoIP/trunk GeoIP
>> git submodule add ./GeoIP      # Add existing git svn repo GeoIP in place
>> cd GeoIP
>> git svn rebase
>>
>> Of course when you push that submodule somewhere else using git I expect
>> that "git svn rebase" won't work when you clone that somewhere else, just
>> like it happened in your example.
> 
> how would the standard git case work, to continue with the example above:
>   git clone test test1
>   git clone test1 test2

I don't think you should clone "test" directly, but rather push that to
a bare repo or git server so others can clone from there. And as the
GeoIP submodule is its own git repo, it has to have someplace to be
pushed to too. That url must be configured in the .gitmodules file and
you have to call "git submodule sync" before you commit and push the "test"
superproject and push the GeoIP submodule so others can use "git submodule
init" and "git submodule update" in their "test" clone to get the submodule
too.

The "test" repo you set up with "git svn clone" could be where you integrate
changes coming from svn (git svn people please stop me if this is rubbish,
I'm just making assumptions here!) which are then pushed to the shared git
repo so your coworkers can fetch it from there.

> if then sombody changes test, and i want to get these changes into
> test2, without involving test1, and rebase what is there?

I'm not sure I understand what you mean here. But you can control what to
check out using different branches for different purposes.
