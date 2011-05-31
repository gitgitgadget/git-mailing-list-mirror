From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Tests for some submodule corner cases.
Date: Tue, 31 May 2011 21:30:52 +0200
Message-ID: <4DE541EC.7010202@web.de>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue May 31 21:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRUeb-00062p-V7
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 21:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab1EaTa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 15:30:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40499 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1EaTa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 15:30:56 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 03FB418FFD43C;
	Tue, 31 May 2011 21:30:54 +0200 (CEST)
Received: from [93.240.123.160] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QRUeT-0005cb-00; Tue, 31 May 2011 21:30:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19nQRGFpWieldJOmSyGSeZjYOor8KFlEPxkllM5
	MRZB4tLy6774T8uxEyOimOaImTSHd91QH0mIcSbWJPinw+WnF7
	MPMiPoZ6Y/OTTPdkhWRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174825>

Am 30.05.2011 23:51, schrieb Marc Branchaud:
> Ran across some submodule behavior that seems wrong to me.  I don't have the
> chops to fix the issues, so I thought I'd just point them out with some unit
> tests.

Thanks for bringing these issues to our attention this way, having a way
to easily reproduce them is very much appreciated.

> Patch 1 tests the case where "submodule add" fails if the path to the
> submodule repo is relative (i.e. starts with "../").  This currently fails
> with "remote (origin) does not have a url defined in .git/config".  Maybe
> there's a reason to fail?  If so, a better error message would be appreciated.

I stumbled across this behavior now and then too, but according to the
commit it added (f31a522a2d) it is intended that adding a relative path
behaves differently than using an absolute path (it resolves relative to
the superproject's origin, not the filesystem, and to be able to do that
the superproject's .git/config has to have an url defined for it). But
you are right about the error message, it really isn't that helpful ...

> Patch 2 exposes an anomaly in "submodule status", which reports that a
> submodule is OK even though it has deleted files.  "git status" inside
> the submodule (and in the super-repo) both identify any deleted files, but
> "submodule status" doesn't prefix the submodule's HEAD SHA-ID with a "+".

That is documented behavior. "git submodule status" only cares about the
commit recorded in the superproject vs the HEAD in the submodule, work
tree modifications are never shown by it.

But try a "git status" in the superproject, that will give you the following
output:
#	modified:   init (modified content)
