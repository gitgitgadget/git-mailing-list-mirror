From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] builtin/fetch: print hash of deleted tag when updating
Date: Mon, 27 Sep 2010 13:37:08 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749BFD33D90@xmail3.se.axis.com>
References: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com>
 <7vsk0wmbcd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 13:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0C1W-0005sv-M0
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 13:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0I0LhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 07:37:13 -0400
Received: from ra.se.axis.com ([195.60.68.13]:59203 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab0I0LhM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 07:37:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 53E5D11E5F;
	Mon, 27 Sep 2010 13:37:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SrTLidxLGt0Y; Mon, 27 Sep 2010 13:37:10 +0200 (CEST)
Received: from krynn.se.axis.com (krynn.se.axis.com [10.0.2.170])
	by ra.se.axis.com (Postfix) with ESMTPS id 553E211E5B;
	Mon, 27 Sep 2010 13:37:10 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8RBb9Su026098;
	Mon, 27 Sep 2010 13:37:09 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 27 Sep 2010 13:37:09 +0200
Thread-Topic: [PATCH] builtin/fetch: print hash of deleted tag when updating
Thread-Index: Actdw6l2MM553/6oQpiaPBGkrZKLwQAYexlg
In-Reply-To: <7vsk0wmbcd.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157324>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Junio C Hamano
> Sent: den 26 september 2010 23:42
> To: Knittl
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] builtin/fetch: print hash of deleted tag when
> updating
> 
> Knittl <knittl89@googlemail.com> writes:
> 
> > From b1c2b07aa1f5db25ebdf190aa12ccb66a17f131a Mon Sep 17 00:00:00 2001
> > From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> > Date: Sun, 26 Sep 2010 11:29:16 +0200
> > Subject: [PATCH] builtin/fetch: print hash of deleted tag when updating
> >
> > `git fetch --tags` will unconditionally update (and thus overwrite)
> > existing tags, which is especially annoying for annotated and signed
> > tags.
> 
> The first question is why s/he is running fetch with --tags if overwriting
> is unwelcome/annoying.

Maybe because the user is a git newbie who has just started to 
learn her first git commands and found --tags in the manual page, 
thinking "oh, nice, this will make sure I get all tags". Or because 
she added it to remote.<name>.tagopt without knowing that it would 
overwrite tags in this way.

> "--tags" is meant to be used when the auto-follow
> behaviour of normal fetch is not sufficient and the user actively wants to
> get the latest (potentially updated) ones;

If that (i.e., potentially updated) is the intention, it is not 
mentioned in the manual page for fetch. Further, reading "On 
Re-tagging" in the manual page for git tag, it says "Git does not 
(and it should not) change tags behind users back" (which I agree
with) but it seems contrary to what --tags does...

Shouldn't this behavior of --tags require --force to keep in line 
with what is described in git tag's manual page? If not, a big
warning sign is needed in the manual page description of --tags.

> would it be possible that you are solving a wrong problem?

Since git reflog does not support showing how a tag has changed, 
I think something like Daniel's patch is a good idea, as the 
alternative is to use git fsck and start digging...

//Peter
