From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Tue, 23 Aug 2011 22:18:11 +0200
Message-ID: <4E540B03.2030909@web.de>
References: <cover.1312923673.git.hvoigt@hvoigt.net> <7v8vqzreeo.fsf@alter.siamese.dyndns.org> <20110811195955.GA21185@book.hvoigt.net> <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc> <7v62lpuky8.fsf@alter.siamese.dyndns.org> <20110823194350.GA57187@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 22:18:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvxQj-0001BC-Tm
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 22:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab1HWUSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 16:18:30 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:53633 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab1HWUS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 16:18:26 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 226071A9093B5;
	Tue, 23 Aug 2011 22:18:14 +0200 (CEST)
Received: from [79.247.254.73] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QvxQM-0003bl-00; Tue, 23 Aug 2011 22:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <20110823194350.GA57187@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18GtVdUrsB1bkf+M9np+aLol4pVwXCaL93t0+J/
	ePJvLmnA8i42ou9MmVYSzKk3JH+vw95y4E2/LuFngovKIthfMU
	CaUa17qdht343fZTnmNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179967>

Am 23.08.2011 21:43, schrieb Heiko Voigt:
> On Mon, Aug 22, 2011 at 03:42:55PM -0700, Junio C Hamano wrote:
>>> It is somewhat worrying that some parts of the system may still be using
>>> that old criteria "do we have it in .git/config of the superproject?" to
>>> decide if the user is interested in the submodule. If so they need to be
>>> updated to take this new semantics "do we have it in .git/config without
>>> its submodule.$name.update set to none" into account. We would probably
>>> need to have a paragraph in the release notes to warn about the semantics
>>> change (which I tend to agree with you that it is a good one).
> 
> Sorry that I forgot to answer to this. I am not sure what you mean by
> "the semantics change". This patch does not change any existing
> behavior. I rather see this as an extra way to specify the default
> behavior of what happens on submodule update. If people do not use it
> there will be no expectations broken.

It might surprise people. E.g. when their old scripts don't work anymore as
they did before because a submodule won't be populated or updated in the work
tree even though it is present in .git/config. So I agree that this should be
documented in the release notes so people can check if their expectations are
still met.

> Another change I am thinking of (which would definitely need an entry in
> the release notes) is to change submodule foreach to iterate over all
> gitmodule entries in the index/HEAD/worktree (not sure yet) instead of
> "just entries that are in .git/config".

When changing the default I think we'll surprise a lot of users (imagine
someone running a "git submodule foreach pwd" when some submodules aren't
populated). But adding an option to "git submodule foreach" (and maybe others)
to get the list of submodules from the index or HEAD might make sense (while
I'm not sure parsing the work tree does, as you'll basically have to pick up
any .git you find. AFAICS a submodule is defined either by an entry in the
.gitmodules file, in .git/config or through a gitlink entry in a commit or the
index. So maybe the third alternative to index and HEAD is to use those found
in .gitmodules?).

Could you describe a use case for that?
