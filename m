From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Tue, 21 Oct 2014 10:08:35 +0200
Message-ID: <54461483.9010600@drmicha.warpmail.net>
References: <20141020115943.GA27144@gmail.com>	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>	<20141020222809.GB223410@vauxhall.crustytoothpaste.net> <CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 10:08:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgUUx-0006St-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 10:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbaJUIIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 04:08:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33199 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754493AbaJUIIh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2014 04:08:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by gateway2.nyi.internal (Postfix) with ESMTP id 32D5A20942
	for <git@vger.kernel.org>; Tue, 21 Oct 2014 04:08:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 21 Oct 2014 04:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=pObNH9Zhf+wkA6KKMb9HIL
	jw4+s=; b=XmNcUT+VBCQQDyHESaLkryyDkqwnEYAbMfP9xJps5Ecp5BCnS/IGU6
	zl222jpE2eFfm31kM/7crW2tyxlzxNzrs/EH3CVdPem8BsLAX1UjZeBHUcBmX7+N
	floYL4FvZ3l1V/ojS1EmljUOty5t+T3K8KNXbwTPxmBm+H4LyGNRU=
X-Sasl-enc: RXDfkuxDwMdCg+Kgk9NHpAfH+oCgoLpdTn2EowktRS7i 1413878916
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 50FFD680197;
	Tue, 21 Oct 2014 04:08:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb am 21.10.2014 um 01:17:
> On Mon, Oct 20, 2014 at 3:28 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> It doesn't appear that the stability of git archive --format=tar is
>> documented anywhere.  Given that, it doesn't seem reasonable to expect
>> that any tar implementation produces bit-for-bit compatible output
>> between versions.
> 
> The kernel has simple stability rules: if it breaks users, it gets
> fixed or reverted. That is a damn good rule.
> 
> I realize that some other projects are crap, and don't care about
> their users. I hope and believe that git is not in that sad group.
> 
> The whole "it's not documented" excuse is pure and utter bollocks.
> Users don't care. And stability of data should be *expected*, not need
> some random documentation entry to make it explicit.
> 
>                       Linus
> 

Linus, with all due respect, this is not the LKML, so please watch your
tone over here on the git list (and keep ranting on LKML however you want).

Brian made a very valid point about what his patch was trying to fix -
after all that is why it was applied. Konstantin made a very valid point
about why the existing behavior is useful for KUP. Interestingly, both
cared about the users of git, just different kinds users.

Git is probably one of the most conservative projects regarding
backwards compatibility and heeding users' expectations (sometimes to my
own dismay). That being said, we distinguish between justified
expectations and those without a solid base - which is why we have
porcelain vs. plumbing, for example, to make clear which part of the ui
is stable. (Yeah, I know you know, but you didn't argue as if you did.)

"data" in git is stable. "data exports" by git are as stable as the
output format is intrinsically or due to the (hopefully documented) way
git produces it.

Unfortunately, the git archive doc clearly says that the umask is
applied to all archive entries. And that clearly wasn't the case (for
extended metadata headers) before Brian's fix.

Brian: How old is the newest tar that get's the extended metadata
headers wrong? If those tars are a "real concern" then we should
probably do the extra pax_umask as suggested by Linus, but have the
default protect the "unknowing users" and give the "knowing users" that
config knob to twitch (sorry, Linus). Otherwise a revert is in order.

Michael
