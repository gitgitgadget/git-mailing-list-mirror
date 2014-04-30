From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] rerere: fix for merge.conflictstyle
Date: Wed, 30 Apr 2014 01:49:18 -0500
Message-ID: <53609cee92532_4c3af672f0f4@nysa.notmuch>
References: <1398830909-24680-1-git-send-email-felipe.contreras@gmail.com>
 <20140430060835.GA21698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 09:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfOUr-0004i4-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 09:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbaD3G74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 02:59:56 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:50004 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaD3G7z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 02:59:55 -0400
Received: by mail-yh0-f42.google.com with SMTP id f73so1274869yha.29
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=x3uZH4ZGgtIVPrNB7YsVincgwD4dNWZmBEa1J09oB0M=;
        b=RLOpglssIiE7UqkOrMpAlYaP5vKiPt1JnqSM/E8eXafxh5I0F/Ei1KOuLL+lnDHQGV
         Zph16om4ZOFHJtrFHpYs01lZY+ZLp1n1HOAIAxK1vBER/dy9f+8M520Y5ijpEZh0S6dL
         jBTfklmwD1rXw1bZULkm1G3H1oLUdlSN4rTdwbgLKTN6A3ucOFEdSKUohqCs2Jy1Swu9
         sa/zkGwy0R12u553P6tDCxjCRxTAbrC51vU4a8hj5L2FYWQ1cz05ElAhbwUXJcArICVH
         I2rAsfxMdos4YeERZXN0ONx4yh0zgqOgGFbF+prUmh1kTwFR2up40tCuaFzdzAnZ8num
         Yy0Q==
X-Received: by 10.236.83.66 with SMTP id p42mr3167308yhe.122.1398841194939;
        Tue, 29 Apr 2014 23:59:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l4sm41339457yhj.24.2014.04.29.23.59.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 23:59:53 -0700 (PDT)
In-Reply-To: <20140430060835.GA21698@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247681>

Jeff King wrote:
> On Tue, Apr 29, 2014 at 11:08:29PM -0500, Felipe Contreras wrote:
> 
> > If we use a different conflict style `git rerere forget` is not able to
> > find the matching conflict SHA-1 because the diff generated is actually
> > different from what `git merge` generated.
> 
> Can you show an example or test case?

% git clone https://github.com/felipec/git
% git config merge.conflictstyle diff3
% git checkout master
% git merge --no-ff origin/fc/branch/nice-verbose
% git merge --no-ff origin/fc/publish
# fix conflicts as per -Xtheir strategy
% git commit
% git rerere forget builtin/branch.c
error: no remembered resolution for builtin/branch.c

> I could not reproduce the problem with a trivial case, and rerere
> specifically tries to handle the differences between "merge" and "diff3"
> styles by throwing away the base content between "|" and "=" lines.
> However, I wonder if it could still miss a match in some cases because
> the "merge" style uses XDL_MERGE_ZEALOUS, whereas diff3 bumps it
> down to XDL_MERGE_EAGER, which could lead to a slightly different
> preimage.

That's probably it.

-- 
Felipe Contreras
