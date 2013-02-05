From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP/RFH/RFD/PATCH] grep: allow to use textconv filters
Date: Tue, 05 Feb 2013 09:48:05 +0100
Message-ID: <5110C745.9050306@drmicha.warpmail.net>
References: <2c0641ea4df6a872a4466efe0c0124f304f44c3e.1359991521.git.git@drmicha.warpmail.net> <7vtxps2eb2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:48:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2eCc-0003IQ-GD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 09:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab3BEIsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 03:48:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35521 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754073Ab3BEIsF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 03:48:05 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 34E4A2092C;
	Tue,  5 Feb 2013 03:48:04 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 05 Feb 2013 03:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Gcvg6RBfwZC7yZNFEEHW6c
	UrYkk=; b=A1L5Rqglhvs2tjMVbAO/GMj1NIxdc9/GfjNZj/ZSikkzWH6xNMJhuo
	gTzv554i54O0zlMmH4VtUyCYf3dDpOWBXwsTckqIZis4R+mR10q35OkO6ezuOdmZ
	AAtOnxRQyZMGrWDZj7jjaU6vU+xSa7te1r1X0iTMyDeJSVSIJ0gVQ=
X-Sasl-enc: 4mr/sWFBBPmzSRU4PiLKP9QYfaZ8Bqslpk0rZm37t2od 1360054083
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8DBF18E08C5;
	Tue,  5 Feb 2013 03:48:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vtxps2eb2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215467>

Junio C Hamano venit, vidit, dixit 04.02.2013 18:12:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Recently and not so recently, we made sure that log/grep type operations
>> use textconv filters when a userfacing diff would do the same:
>>
>> ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
>> b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
>> 0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)
>>
>> "git grep" currently does not use textconv filters at all, that is
>> neither for displaying the match and context nor for the actual grepping.
>>
>> Introduce a binary mode "--textconv" (in addition to "--text" and "-I")
>> which makes git grep use any configured textconv filters for grepping
>> and output purposes.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>
>> Notes:
>>     I'm somehow stuck in textconv/filespec/... hell, so I'm sending this out
>>     in request for help. I'm sure there are people for whom it's a breeze to
>>     get this right.
> 
> Looks like the patch touches the right places in the codepaths that
> need to be updated from a quick read.

I should have added that this coredumps when used on blobs and that
textconv isn't invoked in any case (because it crashes on blobs, and I
haven't implemented tetxconv on worktree files yet).

I'm somehow struggling to use just the right bits from the more diff
centric helpers like fill_textconv or fill_one (which is static so far).

>>     The difficulty is in getting the different cases (blob/sha1 vs.
>>     worktree) right, and in making the changes minimally invasive.
> 
> I think grep_source abstraction was intended to be a way for that,
> and if what it gives you is not sufficient for your needs, extending
> it should not be seen as "invasive" at all.

It seems to me that we textconvified the diff versions of these
abstractions, but not the grep_source abstractions. Doing it at the
source appears to be the right thing.

Michael
