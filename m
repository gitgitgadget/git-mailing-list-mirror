From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Branch annotations [Re: Annotated branch =?UTF-8?B?4omIIGFubm90YQ==?=
 =?UTF-8?B?dGVkIHRhZz9d?=
Date: Wed, 28 Sep 2011 10:58:16 +0200
Message-ID: <4E82E1A8.5080305@drmicha.warpmail.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com> <4E7C49CF.60508@drmicha.warpmail.net> <20110923201824.GA27999@sigill.intra.peff.net> <4E7DEC4A.3050900@drmicha.warpmail.net> <20110927215843.GE5176@sigill.intra.peff.net> <4E82A13B.2080509@alum.mit.edu> <CAH5451nT2Z6mBPkK4B2EgJAoMpf32bcc=7UqhTDnsw4-_hJwJw@mail.gmail.com> <4E82D52B.9020709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 28 10:58:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8pyC-0002mn-Jz
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 10:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1I1I6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 04:58:20 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33115 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355Ab1I1I6T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 04:58:19 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DD65428F7A;
	Wed, 28 Sep 2011 04:58:18 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 28 Sep 2011 04:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Y2ZWahvsWYefVaJMYZrSUw
	/WdeM=; b=t/PjvUdvDrqK64iZ1lWSb0p87dQBtx/2KHrBUURAqhuv/mW55LfX7V
	mg+1wMkz61/msxz31JAQzLmrYA8cAi1hzwjH136/KCT0RFeoNsgMpTJJQyBWO0lF
	cnuHaHgJh9viRDkBsHOoNcSHKQpfgKxD8ihEHA86qrjZxVbEwF4So=
X-Sasl-enc: z2q2tXSeh5Dwj8ZPGNqOQKLmSKgJ/hHnAjNEc3ZQ/i0w 1317200298
Received: from localhost.localdomain (p5485957E.dip0.t-ipconnect.de [84.133.149.126])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D7FBF6401BD;
	Wed, 28 Sep 2011 04:58:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E82D52B.9020709@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182303>

I'm not tied to a particular implementation (not even mine), but we
should think through the concept before baking something in. That was my
impetus for throwing in a (half-baked) notes based solution before a
config based is baked^Wset in stone ;)

For me, commit annotations as currently implemented (notes) have the
following positives:

* easy ui (add/edit/copy)
* easy scripting (-F/-m)
* can be shared *if I want* (by pushing refspec; note that share=backup
as well as share=publish, depending on where I push to); ui could be
somewhat better
* multiple sources possible
* is versioned (ui could be better, e.g. git notes log)

For branch annotations, I would want to have all of the above. Depending
on the use case, I want to treat branch annotations as purely local (but
may still want to push them to backup) or share and publish them. I
might be interested in their history or not, etc. In addition, we would
want to have the obvious:
* git branch -m moves annotation
* git branch --list --younameit shows annotation
* etc.

If we agree that we want the above properties (and that is a big if)
then using notes seem very natural. [Having to rewrite an annotated tag
object at each branch head change appears unnatural.] They should
probably live in a separate default tree (one per remote for remote
branches), and the actual mechanics (virtual objects, real objects,
textconvcache like...) is not dictated by those requirements.

Note though that we might be interested in annotating more general names
than just refnames, e.g. paths, or names like "description". Since tags
should be immutable, adding notes to a tag seems not much different from
annotating the referenced commit, but it is different in concept and
could be treated differently (as tag notes would be in a separate tree
from the commit notes tree).

So, if we want to keep that path open (annotate more general names), a
mapping from names to notes becomes mandatory. Again, that does not
dictate a specific implementation.

Michael
