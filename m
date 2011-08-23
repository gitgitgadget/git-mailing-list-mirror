From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's the difference between `git show branch:file | diff -u
 - file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 22:07:43 +0200
Message-ID: <4E54088F.7050700@drmicha.warpmail.net>
References: <loom.20110823T091132-107@post.gmane.org> <4E537AF0.9070604@drmicha.warpmail.net> <1314096731.15017.2.camel@n900.home.ru> <4E53C89A.9000604@drmicha.warpmail.net> <7vk4a4rqvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 22:07:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvxGJ-00051v-5d
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681Ab1HWUHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 16:07:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37131 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102Ab1HWUHp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 16:07:45 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 56CB1209C6;
	Tue, 23 Aug 2011 16:07:45 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 23 Aug 2011 16:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=xiCKmP12AKO9Ri1tvUGs4h
	O7n0U=; b=kTb+Vmc5YjNfL+b/kGebsUO1JYlitEUN3LbEFao+IGI1DkLIuzKXxd
	+MaLrxlCFAE/ZTjwZpgOq3hwc4A2Av3iv8/5fuhvtxIU+ctC7uDPltjkA3tyDzXB
	dNzhy4/Fz6vn894DETzMZrTIkRjbT8o3OFrc7vwfJE0K/NEEFOs3A=
X-Sasl-enc: CB+vclU6JUt6xmYU3JLO9d6X2BSjv9pV6PO4tFtRQLcL 1314130065
Received: from localhost.localdomain (p54858E80.dip0.t-ipconnect.de [84.133.142.128])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9B267720197;
	Tue, 23 Aug 2011 16:07:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vk4a4rqvb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179966>

Junio C Hamano venit, vidit, dixit 23.08.2011 19:15:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Marat Radchenko venit, vidit, dixit 23.08.2011 12:52:
>>>> Is that a very large tree or a very slow file system?
>>> Tree is large (500k files), file system is irrelevant since all time is spend on CPU.
>>>
>>>> Do we enumerate all
>>>> differing files and only then limit diff output by path??
>>>
>>> Dunno, that's why I am asking why it is so slow.
>>
>> Well, we have to read the full tree before diffing.
> 
> Not necessarily, especially when pathspec is given like the original post,
> i.e. "git diff $tree_ish -- $path". We would need to open tree objects
> that lead to the leaf of the $path and a blob, but other objects won't be
> needed.

I meant: The way "git diff" is now, it does that.

> 
> The default diff backend tries to come up with minimal changes by spending
> extra cycles, so it is not so surprising if the file compared is large-ish
> and/or has very many similar lines in itself (in which case there are many
> potential matching line pairs between the preimage and the postimage to be
> examined to produce a minimal diff).

But the file in this case is not that large, and "git diff" spends 30s!

Michael
