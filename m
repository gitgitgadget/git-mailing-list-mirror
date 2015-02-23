From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] checkout: --to requires directory
Date: Mon, 23 Feb 2015 16:01:51 +0100
Message-ID: <54EB40DF.8090800@drmicha.warpmail.net>
References: <768eecca8711467b43fcc45403ce9ce91bb1550e.1424700971.git.git@drmicha.warpmail.net> <20150223144214.GA31624@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 16:02:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPuWG-0004Jp-5p
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 16:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbbBWPBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 10:01:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36736 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981AbbBWPBx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 10:01:53 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 5913F20B62
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 10:01:52 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 23 Feb 2015 10:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=wg9vev4IPkzU1m1HtaF3j6
	An7L8=; b=QH4b4h/Fdq4brHE3PykvMp4oIxdXapZNG9kR4TT2cONPFWorYoiu5I
	ddGGEyDwI3wng+DYHJSwgPXzxW4WewU1oal2eSimye0prMvhZISIyEvQ/aody/4G
	NMb2Nrj1hwYuJMnYrInr4TPI6r/q/XPzUkkdF0Y5i40eglhCPrWUU=
X-Sasl-enc: YNSEcrpmOLuAPh8zpZ5sseFiplU60WTZQr0P/dU+PNYd 1424703712
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5D6DAC002A5;
	Mon, 23 Feb 2015 10:01:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150223144214.GA31624@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264262>

Jeff King venit, vidit, dixit 23.02.2015 15:42:
> On Mon, Feb 23, 2015 at 03:16:59PM +0100, Michael J Gruber wrote:
> 
>> --to requires a directory, not a file. Say so in the usage string.
> 
> Sounds like a good goal, but...
> 
>> -		OPT_FILENAME(0, "to", &opts.new_worktree,
>> +		OPT_STRING(0, "to", &opts.new_worktree, N_("dir"),
>>  			   N_("check a branch out in a separate working directory")),
> 
> OPT_FILENAME also calls fix_filename(), which munges the filename so
> that relative paths given by the user will work, even though git has
> chdir'd to the root of the working tree.

Ooops, I wasn't aware of that. We do use OPT_STRING in quite a few
places for directories, though.

> So you need to handle that somewhere. I think it might be less painful
> to teach OPT_FILENAME to be more flexible in the usage message it
> prints.

We have at least path, template-dir dir which can benefit from that.

After Junio's call, I'm trying to look a bit at list-files and multiple
workdirs. I guess I should collect those bits.

BTW: multiple workdirs commit messages and doc talk about a hard link
named "link" in worktrees/<id>/, but I don't get any from "checkout --to".

Instead, and in addition to the expected "gitdir", I get a file
"gitfile" whose content is a relative path (*not* prefixed with "gitdir:
"), probably to the worktree .git gitfile (relative from the base
worktree). But "gitdir" "points to" the same, using (i.e. it contains)
an absolute path.

I can't quite make sense of this. Maybe the doc is behind? But still.
"gitdir" and "gitfile" pointing to the same file.

Michael
