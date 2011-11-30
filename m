From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Auto update submodules after merge and reset
Date: Wed, 30 Nov 2011 09:31:14 +0100
Message-ID: <4ED5E9D2.4060503@web.de>
References: <4ED57EED.4040705@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Krasnyansky <maxk@qualcomm.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 09:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVfgt-0004Lt-F9
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 09:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab1K3Iiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 03:38:50 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:34582 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147Ab1K3Iiu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 03:38:50 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Nov 2011 03:38:49 EST
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id C37D267ABC7D
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 09:31:45 +0100 (CET)
Received: from [192.168.178.25] ([80.187.97.97]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Mg7Zl-1R8FPV17wr-00NSUl; Wed, 30 Nov 2011 09:31:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4ED57EED.4040705@qualcomm.com>
X-Provags-ID: V02:K0:xxfghAKdDHjEO3Emrzjp0WTx1yOklUMyAV7ngakHdSj
 ro88dEvBuJ8O6/HqSB7Gj4gY51PIKmv2jG3MK63SEPLuHK8Ez7
 QYQEoZu2HOuaayL2/jYZjDMFHfF/M+wT4nHO1ayI2O/pM+/SMH
 3GR7nDEETzj0a4SJB6ANqARNvGFxcRy0L4ZbTwYIfspe76tZ2U
 vBPb/4jD7JikXzU3ueioA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186114>

Am 30.11.2011 01:55, schrieb Max Krasnyansky:
> Does anyone have a pointer to a thread/discussion that explains why git submodules are not auto
> updated when the superproject is updated (merge, reset, etc) by default?

This is because in current git a submodules work tree gets only updated
when running "git submodule update". A default auto update wouldn't be
backwards compatible (and some users really like it the way it is now).
I'm working on a patch series to teach Git to optionally update the
submodules work trees on checkout, reset merge and so on, but I'm not
there yet.

> Assuming a simple and default setup where submodule update policy is set to "checkout".
> It seems that the default and sane behavior should be to update (checkout) corresponding submodule
> commit to track the superproject.

I agree, but we should decide about a sane default when the feature is
there. In the first version it will be off by default, so people can make
up their minds about breaking backwards compatibility.

> I can't seem to find convincing explanation why it's not the case :). Having to manually update
> submodules after pull or reset has been error prone and confusing for the devs I work with.

Yes, we even had some mis-merges because of that.

> I'm thinking about adding a config option that would enable automatic submodule update but wanted
> to see if there is some fundamental reason why it would not be accepted.

I think adding something like an "submodule.autoupdate" config makes lots
of sense, but IMO it should affect all work tree updating porcelain commands,
not just merge.
