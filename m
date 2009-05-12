From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Cherry woes
Date: Tue, 12 May 2009 13:57:32 -0400
Message-ID: <32541b130905121057s19f9dd42h566a017d47bfe865@mail.gmail.com>
References: <4A097659.4060507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 12 19:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wEq-0004U6-V0
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZELR5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 13:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbZELR5w
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:57:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:18584 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbZELR5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 13:57:51 -0400
Received: by yw-out-2324.google.com with SMTP id 5so68625ywb.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OamX1+wWNmrq8iZxsUxGgKU+Qu+p1O0g5Nmc8MDHx1U=;
        b=ISiX3hAqrha46epJSqNss/erQ6QTbf6De1f0/8YsV8nF1/ckD8MCgw3VfyFpwo85Nd
         1y3g65F3hP/Z7AOqL9nv9cGot7E0vv+nSkA7qWIEu4aMdJSXYDQQ9CEzewxzLbjF9tiL
         zPCuatAA91w+eEeM6rDwfmD+LARgVCObzOTKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W24WIiPPesz/avlrrC7pAPZQHe5hOQKSKPJ+Hy+ibKrefS7oEbcHClkNSvS+QC81or
         eg15Em5rDcfOMkgHxdn1dzuqG4gKXC6BFmnpwe8sj/qoQdHmzCS+bCabqjNvWHlMF2mR
         D3bOHFdbXZ1I5tbUhGLUMCvtdgo4c2K19nZ4Y=
Received: by 10.151.134.8 with SMTP id l8mr218327ybn.163.1242151072284; Tue, 
	12 May 2009 10:57:52 -0700 (PDT)
In-Reply-To: <4A097659.4060507@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118937>

On Tue, May 12, 2009 at 9:15 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Now, adjusting the doc is easy, but I still feel that cherry does not
> give the most useful info in the situation at hand. But how would I find
> a better lower boundary for the range ..upstream? merge-base of master
> and upstream is upstream so that doesn't cut it. So I'm wondering what
> the right approach is and whether anyone cares.

I think the problem is that there's no well-defined "furthest back"
place where a particular patch might already exist in upstream.
Perhaps it was placed in upstream three years ago.

My guess is git-cherry was designed for a primarily rebase-like
workflow.  In that case, you would *never* merge between the two
branches in question, so the fork-point (ie. merge-base) would be the
right thing to use, as git-cherry already seems to do.

Aha, and the git changelog seems to support this theory, as we can see
by the first mention of git-cherry in
93c36dcd0a4f6373e3a02a8505046801106ddb85:

    [PATCH] git-cherry: find commits not merged upstream.

    The git-cherry command helps the git-rebase script by finding
    commits that have not been merged upstream.  Commits already
    included in upstream are prefixed with '-' (meaning "drop from
    my local pull"), while commits missing from upstream are
    prefixed with '+' (meaning "add to the updated upstream").

So my conclusion: git cherry is not really compatible with git merge.
Its man page could probably use a clarification to this effect.

Have fun,

Avery
