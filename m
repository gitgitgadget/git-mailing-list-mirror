From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Wed, 29 Jun 2011 00:32:46 +0200
Message-ID: <4E0A568E.3040202@web.de>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com> <4E0A506B.6040407@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	gitster@pobox.com, hvoigt@hvoigt.net
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:32:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbgpx-0007Bn-Du
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1F1Wct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:32:49 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:60260 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1F1Wcr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:32:47 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 81865192E7257;
	Wed, 29 Jun 2011 00:32:46 +0200 (CEST)
Received: from [93.246.41.92] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qbgpq-0001Fz-00; Wed, 29 Jun 2011 00:32:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <4E0A506B.6040407@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19jbSiEbu2nmyG7hOkEKCcqi5VlXROt19NMAjqA
	qB/7wew83nIpOoAca+mS44oxkGdplHcopVgXqr6spaXK3hDjHJ
	Eiyhf2vwhKDs5O0kaKcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176426>

Am 29.06.2011 00:06, schrieb Marc Branchaud:
> First, I expect performance will be terrible in repositories with large
> and/or many submodules.  I'd go so far as to say that it's pretty much a
> show-stopper for our repository.

Large submodules won't be the problem here, but many submodules and/or
many commits might cause some performance degradations here. But please
notice that there is no communication with the upstream of the submodules,
we only check the refs present locally. Do you still think doing some
"git rev-list" invocations in your submodules will be a problem? Then
please say so.

> Second, there are many times where I'm working in a submodule on branch
> "TopicA" but not in branch "TopicB".  If I've made submodule changes in
> TopicA then try to push up TopicB, won't I have have to tell push to "-f"?
> But that turns off other checks that I'd rather keep.

Nope, this patch only checks the refs to be pushed, not any others. So it
will only check that all submodule commits on branch "TopicB" are pushed.

> I'd feel a lot better about this patch if the check was *off* by default and
> there was a config setting / command-line option to turn it on.

I have no objections against making that configurable, although I tend
towards making this check default "on". But please feel free to test this
feature and tell us if it really hinders you in your work or does cause
performance degradation, we'll really appreciate the feedback!

> I also agree with Junio that this kind of verification makes more sense in a
> hook on the server side.

Hmm, but isn't that assuming that the server knows (= hosts?) both the
submodule and the superproject?
