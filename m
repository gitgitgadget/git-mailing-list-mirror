From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Show submodules as modified when they contain a dirty
 work tree
Date: Thu, 14 Jan 2010 09:32:13 +0100
Message-ID: <4B4ED68D.1060402@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de> <7v6375lkpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVL7v-0003lx-6c
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423Ab0ANIcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750Ab0ANIcS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:32:18 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36631 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab0ANIcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:32:18 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9E3F613C0D98F;
	Thu, 14 Jan 2010 09:32:16 +0100 (CET)
Received: from [80.128.84.195] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NVL7o-0002mX-00; Thu, 14 Jan 2010 09:32:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v6375lkpj.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18BNiNf5E3WalODzGwo7lpAEtu3ctHdqX8X73vt
	w+ms8TjdPMHKrIIIcrGP1jHMnJAbX1+l4H6kkqfM7b2GmqxcW4
	KTba01qMxU99eza7eZAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136965>

Am 13.01.2010 23:10, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> I had to squash in '#include "submodule.h"' in diff-lib.c just after it
> includes "refs.h", though.

Sorry, i seem to repeatedly have missed the compiler warning :-(


> And a patch to add:
> 
>>> * It doesn't give detailed output when doing a "git diff* -p" with or
>>>   without the --submodule option. It should show something like
>>>
>>>     diff --git a/sub b/sub
>>>     index 5431f52..3f35670 160000
>>>     --- a/sub
>>>     +++ b/sub
>>>     @@ -1 +1 @@
>>>     -Subproject commit 5431f529197f3831cdfbba1354a819a79f948f6f
>>>     +Subproject commit 3f356705649b5d566d97ff843cf193359229a453-dirty
>>>
> 
> would look like the attached.

Thanks!


> I think a reasonable next step would be
> 
>  - Move the check for your condition (c) that we dropped from this round
>    to wt-status.c;
> 
>  - Add wt_status_print_dangling_submodules() to wt-status.c, and use the
>    above logic to produce a section "Submodules with Dangling HEAD" or
>    something.
> 
>  - Call it in wt_status_print(), immediately before we check s->verbose
>    and show the patch text under -v option.  "git status" now will warn
>    about the condition (c).
> 
>  - Add a similar wt_shortstatus_print_dangling_submodules() and call it at
>    the end of wt_shortstatus_print().
> 
>  - Update is_submodule_modified() in your patch thats reads the output
>    from "status --porcelain", to *ignore* information about dangling
>    submodules.  As we discussed, dangling submodules may be something the
>    user cares about, but that is not something "diff" should.

Great, i will send patches when i have something to show.
