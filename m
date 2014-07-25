From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: `ab | (cd cd && git apply -)' fails with v2.0.0
Date: Fri, 25 Jul 2014 08:49:06 +0200
Message-ID: <53D1FDE2.8030309@drmicha.warpmail.net>
References: <20140724142945.iERQ798d%sdaoden@yandex.com>	<53D116B9.3050809@drmicha.warpmail.net> <xmqqegxaad3r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steffen Nurpmeso <sdaoden@yandex.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 08:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAZK3-00085Q-Dr
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 08:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759639AbaGYGtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 02:49:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37634 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757587AbaGYGtO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 02:49:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway1.nyi.internal (Postfix) with ESMTP id 60302215AC
	for <git@vger.kernel.org>; Fri, 25 Jul 2014 02:49:07 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 25 Jul 2014 02:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/dxTN+mnsPuWeNsFysvwHu
	Egi4Q=; b=euURcKW1Qoapb7vj56zEj78aS69dOcW7AuwZrndOszuJrqFb5ktPBy
	8HBUVmHqfaQb8eycwelCzhQEQRWsbxqR1ppoZf5gmr3YjlyqggfCtpMaW4lYnVie
	qjClpyARWoHD0ADf4XU0O1r56fmkvp6zmbvNEys59mMJLc0wxg2IA=
X-Sasl-enc: Kz1Mu5LzEwgfmItZ8DxX7l8mWm3GFBQzlaMoKQAj2TxF 1406270947
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 03E78680224;
	Fri, 25 Jul 2014 02:49:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqegxaad3r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254198>

Junio C Hamano venit, vidit, dixit 24.07.2014 19:19:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Steffen Nurpmeso venit, vidit, dixit 24.07.2014 15:29:
>>> Hello (again, psssssst, after a long time),
>>>
>>> it happened yesterday that i needed to do
>>>
>>>   $ git diff HEAD:FILE COMMIT:SAME-FILE |
>>>   > (cd src && git apply -) 
>>> ...
>>
>> Ah little more context would help. Are you diffing files in the subdir
>> src, or a file at the root which happens to be present in the subdir src
>> as well?
> 
> As the <treeish>:<path> form is not meant to produce "git apply"
> applicable patch in the first place, I am not sure what the OP is
> trying to achieve in the first place.  Not just "how many leading
> levels to strip?" but "which file is being modified?" does not
> appear in a usable form.  For example, here is what you would see:
> 
>     $ git diff HEAD:GIT-VERSION-GEN maint:GIT-VERSION-GEN
>     diff --git a/HEAD:GIT-VERSION-GEN b/maint:GIT-VERSION-GEN
>     index 40adbf7..0d1a86c 100755
>     --- a/HEAD:GIT-VERSION-GEN
>     +++ b/maint:GIT-VERSION-GEN
>     @@ -1,7 +1,7 @@
>     ...
> 
> and neither "HEAD:GIT-VERSION-GEN" nor "maint:GIT-VERSION-GEN" is
> the file being modified ("GIT-VERSION-GEN" is).

I thought "git apply" knows how to strip the rev part.

> I would understand if the upstream of the pipe were
> 
>     $ git diff HEAD maint -- GIT-VERSION-GEN | ...
> 
> though.
> 
> Needless to say, if the place "cd" goes is not a worktree controlled
> by git, then "git apply" would not know where the top-level of the
> target tree is, so even though the input with the corrected command
> on the upstream side of the pipe tells it which file is being
> modified, it needs to be told with the proper -p<n> parameter how
> many leading levels to strip.

I think it's a common mistake to think of "git apply" as some sort of
magic extension of "patch" which can do anything that "patch" does and
more, and can be fed anything that "git diff" produces", figuring out by
itself what to do with it :)

Michael
