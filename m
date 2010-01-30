From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 15:10:55 +0100
Message-ID: <4B643DEF.8010809@web.de>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com> 	<4B642696.2070501@web.de> <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 15:11:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbE2T-0007L7-5e
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 15:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab0A3OK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 09:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564Ab0A3OK6
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 09:10:58 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48747 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0A3OK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 09:10:57 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8D5C9145DC75A;
	Sat, 30 Jan 2010 15:10:56 +0100 (CET)
Received: from [80.128.91.77] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NbE2K-0006x1-00; Sat, 30 Jan 2010 15:10:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18wp7N50hlHm0IrZc0k2u0vHzXcvk8B9RwqfFTb
	rp2lYc+8+M7hWWc93kO/TzZGu2AbhWalTSkA3iEw69A48ZqPJv
	dExE8Y9H0IpRXxN0/wWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138475>

Am 30.01.2010 14:23, schrieb Jonathan del Strother:
> On 30 January 2010 12:31, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> I assume you have one or more submodules, maybe even with untracked
>> or yet uncommitted modified files in your tree? If so, what does git
>> status say in the superproject and in the submodule(s)?
> 
> Yep, I have 10 submodules.  However, they're all completely clean with
> no tracked or untracked changes shown in git status.  Anything else I
> can investigate?

The change in behavior my patch introduced is that "git status" is
called inside each submodule. So i would expect getting the same
errors when using this command:
   git submodule foreach git status -s

It should just show
   Entering '<submodule 1>'
   Entering '<submodule 2>'
   Entering '<submodule 3>'
   Entering '<submodule 4>'
   Entering '<submodule 5>'
   Entering '<submodule 6>'
   Entering '<submodule 7>'
   Entering '<submodule 8>'
   Entering '<submodule 9>'
   Entering '<submodule 10>'
when the submodules are not dirty. What do you get?


The error message "error: unable to find <sha1>" is only generated in
sha1_loose_object_info() when map_sha1_file() fails. Its single caller
being sha1_object_info(), which is called by many git commands. Does
that ring a bell for somebody?
