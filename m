From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to create a diff in old file new file format (for code reviews)
Date: Tue, 14 Dec 2010 10:17:13 +0100
Message-ID: <4D073619.2010103@drmicha.warpmail.net>
References: <1292285257962-5832810.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: aerosmith <parvata@rocketmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 10:19:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSR2x-0003RH-OC
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab0LNJTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 04:19:42 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55295 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757007Ab0LNJTk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 04:19:40 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2A411C4E;
	Tue, 14 Dec 2010 04:19:40 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 14 Dec 2010 04:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Q5vY5BLKzG/yUSSMFVvFmhs2+3s=; b=oUfuDac2/69nBmT/RZX8vrsJiYlRaX6GYt+eCjPtz5hjlWDz/Mqm9zm5N4lj+4k5/eIMDFlacL68+MNtC5rGK/wqmVfsKamOEtM/uzfwp9UQfcTWrqGMS4/Akf4tDUVLy7UYSwYZ/p4Jk1MI65nxTwtWCBo26AmIzZSQ26W4klQ=
X-Sasl-enc: DoqGMVaPodTBk0RpdGMD3XNvXlogrFyBhOwvT4FHuuML 1292318379
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9FE78441379;
	Tue, 14 Dec 2010 04:19:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <1292285257962-5832810.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163636>

aerosmith venit, vidit, dixit 14.12.2010 01:07:
> 
> Hi,
> 
> I am trying to create a diff such that the original file (entire file) is
> saved something like file1.h.old and the new modified file as file1.h.new. I
> have read the various options for git-diff* tools but could not find one
> such utility. All I get is the removals and additions as a diff. Does anyone
> know how to create one with the help the available git utils? The only
> method that I can think of is to do everything manually. Any help w.r.t.
> this is really appreciated. Thanks in advance.

You could script around this e.g. with an external diff-helper. The
easiest way is to reuse difftool. For example,

git difftool -y -x echo <revexpression>

will give you pairs of names of temporary files for old/new, where
<revexpression> is what you would give to "git diff" to specify what to
diff.

With the patch I'm sending in a minute, the helper you specify with "-x"
can also access the basename easily, so that you could use "-x oldnew"
with a script "oldnew" containing

#!/bin/sh
cp "$1" "$BASE".old
cp "$2" "$BASE".new

Even without the patch, you could use

git difftool -y -x 'cp "$LOCAL" "$BASE".old; cp "$REMOTE" "$BASE.new";
#' <revexpression>

(all on one line) directly. But this requires insider knowledge and may
break some day.

Cheers,
Michael
