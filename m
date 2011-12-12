From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand
 option
Date: Mon, 12 Dec 2011 23:29:49 +0100
Message-ID: <4EE6805D.7020708@web.de>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com> <1313791728-11328-3-git-send-email-iveqy@iveqy.com> <7vmxemls8z.fsf@alter.siamese.dyndns.org> <20111017190749.GA3126@sandbox-rc> <7vr52bjljd.fsf@alter.siamese.dyndns.org> <4E9DE883.9050105@web.de> <CABURp0okOmsk4JV9Ku5pHJb5vT-kr_fmweNNBKZ_OoRyfZan=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:30:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaENk-0005ym-UX
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1LLW35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 17:29:57 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:38882 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1LLW34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:29:56 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id EF5FB6F4D62C
	for <git@vger.kernel.org>; Mon, 12 Dec 2011 23:29:54 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MJCAc-1RbtLG3iUk-002qW4; Mon, 12 Dec 2011 23:29:54
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABURp0okOmsk4JV9Ku5pHJb5vT-kr_fmweNNBKZ_OoRyfZan=Q@mail.gmail.com>
X-Provags-ID: V02:K0:geZTm8gstywcFHzK4lOkVW6ATefMHZ/5h+TLecloqKG
 DvE+Nt+SqLKQuSbdcEmDV0fL3qxiGQAUa9Wt3pnilSsK3pYlq+
 hCBrV2KxDWZ/xnzQBSNVwBfhxZg2nXZGsoWnNqLV5pk4ff28gU
 7p2PEp8Yxy1mXVwzsJotXDxCi3jbWG0t99AyEUsFJmH4NS5NkG
 4N5xOYpjeuLTkaonNP85w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186965>

Am 12.12.2011 22:16, schrieb Phil Hord:
> On Tue, Oct 18, 2011 at 4:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 18.10.2011 00:33, schrieb Junio C Hamano:
>>> We could even declare that the gitlink for such a
>>> submodule should record 0{40} SHA-1 in the superproject, but I do not
>>> think that is necessary.
>>
>> Me neither, e.g. the SHA-1 which was the submodules HEAD when it was added
>> should do nicely. And that would avoid referencing a non-existing commit
>> in case you later want to turn a floating submodule into an exact one.
> 
> 
> I'm sorry I missed this comment before.
> 
> I hope we can allow storing the actual gitlink in the superproject for
> each commit even when we're using floating submodules.

I think you misread my statement, I was just talking about the initial
commit containing the newly added submodule, not any subsequent ones.
Floating makes differences between the original SHA-1 and the current
tip of the branch invisible, so there is nothing to commit.

>  I thought-experimented with this a bit last year and came to the
> conclusion that I should be able to 'float' to tips (developer
> convenience) and also to store the SHA-1 of each gitlink through
> history (automated maybe; as-needed).

Which means that after "git submodule update" floated a submodule branch
further, you would have to commit that in the superproject.

> The problem with "float-only" is that it loses history so, for
> example, git-bisect doesn't work.

Yep. And different developers can have the same superproject commit
checked out but their submodules can be quite different.

> The problem with "float + gitlinks", of course, is that it looks like
> "not floating" to the developers (git-status is dirty unless
> overridden, etc.)

Yeah. But what if each "git submodule update" would update the tip of
the submodule branch and add that to the superproject? You could follow
a tip but still produce reproducible trees.
