From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 11:53:40 +0200
Message-ID: <4E2FE024.2030204@drmicha.warpmail.net>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com> <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <7v8vrmrxok.fsf@alter.siamese.dyndns.org> <4E2FCAC4.7020408@drmicha.warpmail.net> <CAOnWdojgxZNs4qyEG55URScqOGb6k5e6Mh_B3By6Lj6SpN9L9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Reuben Thomas <rrt@sc3d.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:53:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0oG-00079v-Ty
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab1G0Jxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 05:53:45 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54905 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828Ab1G0Jxn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 05:53:43 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0F7F320A77;
	Wed, 27 Jul 2011 05:53:43 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 27 Jul 2011 05:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3Ky1LWvOhi82Z6pdpEnevg
	h2M2s=; b=m68N3MAw4geVIe1/SAai9ok5UOQygAdHmCa0moYhF41a6cqMWfSUYX
	pbXOj/cjtrY6+DWNR23KhuOuQnG9/p77j0GiiIKX4h2mvpMOtsctF3tUKdy7U1c6
	tfce4RPw9Mqb2k1gKCA8L4JMBpt+1cEaTOChadrliVlyO8hDjQSQ4=
X-Sasl-enc: wXWqozwmGmPtzFpFLP7n6u6PT2FwJj5dovLLtRbc8rmp 1311760422
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5EB3B412476;
	Wed, 27 Jul 2011 05:53:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CAOnWdojgxZNs4qyEG55URScqOGb6k5e6Mh_B3By6Lj6SpN9L9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177957>

Reuben Thomas venit, vidit, dixit 27.07.2011 11:45:
> On 27 July 2011 09:22, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Junio C Hamano venit, vidit, dixit 25.07.2011 21:02:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>> Also what is the "same
>>> problem"?
>>
>> The one reported by the OP for commit:
>>
>> git rm ../a
>> git commit -m "blurb" ../a
>> error: pathspec '../a' did not match any file(s) known to git.
> 
> Actually, this is not what I reported. This explains why I couldn't
> quite understand the direction this thread took. Look again:
> 
> $ cat ~/reportbug-git
> $ git rm -f ../INSTALL
> rm 'INSTALL'
> $ git ci -m "INSTALL is now provided by gnulib." ../INSTALL
> error: pathspec 'ALL' did not match any file(s) known to git.
> $ cd ..
> $ git ci -m "INSTALL is now provided by gnulib." INSTALL
> [master 0895314] INSTALL is now provided by gnulib.
>  1 files changed, 0 insertions(+), 1 deletions(-)
>  delete mode 120000 INSTALL
> 
> The thing I didn't understand is that I tried to check in ../INSTALL,
> but git complained about pathspec 'ALL'.

Well, you didn't say so, did you?

Also, we don't know what subdir you were doing this in, but I bet it has
a 7-character name...

I can't reproduce that name truncation with a current git, btw. (So I
won't bother bisecting where we removed a spurious offset by "prefix".)

In any case, I still think git should allow partial commits with staged
deletions from within a subdir, which is what my patch is about.

Michael
