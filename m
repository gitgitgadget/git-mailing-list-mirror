From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] git: expand user path in --git-dir
Date: Mon, 24 Sep 2012 16:57:59 +0200
Message-ID: <506074F7.2000500@drmicha.warpmail.net>
References: <5060588D.3080202@drmicha.warpmail.net> <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net> <20120924145208.GB10349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGA72-0001w4-T4
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab2IXO6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:58:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45110 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756171Ab2IXO6B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 10:58:01 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 537BF20842;
	Mon, 24 Sep 2012 10:58:01 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 24 Sep 2012 10:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=BOOmzxY1FnVC0zCWnE5isp
	27QBQ=; b=AK6u7Z7EPaNlOPfNl+hjPqas4qVDR/RSkio8Fx0ny8e4/s5drXMhEF
	kWmgIL+jLCs7FHk5D0qV7KpJ4DQOsZ0w+n/CgpPTVfLQzssMUzORXOyddJzzqW7j
	mqDJZcSl9HWVKEj0A90AmWVMFEw3oFXiQpxjSpD4LrUkHSYvPR2Jw=
X-Sasl-enc: 4608js6/1kdgTxDqEb1GN3NnRLrSIZ/znsWpIySkUKGh 1348498680
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A0A7F4827AB;
	Mon, 24 Sep 2012 10:58:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120924145208.GB10349@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206282>

Jeff King venit, vidit, dixit 24.09.2012 16:52:
> On Mon, Sep 24, 2012 at 02:57:20PM +0200, Michael J Gruber wrote:
> 
>> Currently, all paths in the config file are subject to tilde expansion
>> for user paths while the argument to --git-dir is not expanded, and
>> neither are paths in the environment such as GIT_DIR. From the user
>> perspective, though, the two commands
>>
>> GIT_DIR=~user/foo git command
>> git --git-dir=~user/foo command
>>
>> currently behave differently because in the first case the shell would
>> perform tilde expansion, but not in the second. Also, one may argue that
>> specifying '--git-dir=' is like specifying a config variable (which
>> cannot exist for this purpose).
>>
>> Thus, make arguments to '--git-dir' undergo tilde expansion.
>> ---
>> So, here's a simple patch implementing tilde expansion for --git-dir. It passes
>> all tests. It's done doing the expansion on the setting side.
>>
>> Alternatively, one might do it on the getting side, i.e. when reading GIT_DIR,
>> so that paths passed directly through the environment undergo tilde expansion
>> as well. We don't do this for any environment variable yet, so I didn't go
>> that far.
> 
> Keep in mind that every layer of expansion you add is a layer of quoting
> somebody else must do in order to pass through certain paths.  I will
> admit that putting a "~" into a path is relatively uncommon, but this
> patch is a regression for anybody who does so with --git-dir (they will
> now need to quote the "~" against not just their shell, but against
> git). Expanding environment variables like GIT_DIR means that we would
> also need to quote things we put into GIT_DIR.

...as far as "~" is concerned, yes. We don't do a full expansion like
the shell does (or doesn't).

Probably "--git-dir" is hidden well enough to be for the initiated only.
As for the other path options, we can always blame bash. It's got its
name for a reason ;)

Michael
