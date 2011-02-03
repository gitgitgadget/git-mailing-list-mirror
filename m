From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH v2] git-commit --patch
Date: Wed,  2 Feb 2011 21:25:29 -0800
Message-ID: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Cc: conrad.irwin@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 06:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkrhV-0001mN-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab1BCFZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:25:41 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53209 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1BCFZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:25:40 -0500
Received: by yxt3 with SMTP id 3so331867yxt.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 21:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=zu1iGCpE/iamfPV6+iv+t8GJbGfOQIA6aVMGVs48Hlo=;
        b=we1vmnuOd3CWJ8AJRQ12V7cG03dSaNRBJ0YVVwNFvcOF+TWvN8rYREhtDQ2kARIa2M
         385geeCkmL+CIDAffEpr4WEQK14Lb2CtAzfZ7wTlLcl7/Ex5KMFZMFOto4GUK05ytezZ
         HWr3c6nQqmsxFOjRMnjikg6/jPOeZhRPE+rKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uAmowMhkpd3uLlEJTYk+LEzBDUShLTDPzWLJFeK/9w5eWKNWFUoD2t9AqItGybC8cx
         zXW6CuHhHESN2LeZ08IH4Tbcfhx3tMht1LVWqfo+KEllwQjzkInJTfxzbmVC368Zez4P
         T28k/+tctOTCnjZJj1ZzUVtj0buie5aQhz8hw=
Received: by 10.236.111.38 with SMTP id v26mr3816367yhg.39.1296710739833;
        Wed, 02 Feb 2011 21:25:39 -0800 (PST)
Received: from scarlatti.dunvegan.biz ([173.228.114.197])
        by mx.google.com with ESMTPS id g63sm295461yhd.15.2011.02.02.21.25.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 21:25:39 -0800 (PST)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1PkrhJ-0003Gr-I4; Wed, 02 Feb 2011 21:25:37 -0800
X-Mailer: git-send-email 1.7.4.1.g1c7a9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165951>

This patch-set adds support for git-commit --patch, and tidies up some of the
rough edges of git commit --interactive.

The motivation is to support my current workflow, which goes something like:

1. Hack out the basic structure of the feature that I'm working on, until I have
   something that looks like it will work.
2. Split this into several commits with a more logical flow (i.e. some that add
   support for the techniques I want to use for the actual feature, then the
   feature itself).
3. Start fleshing out the implementation, and bug-fixing, with lots of
   git-commit --fixup so that the changes end up in the right commit.
4. At the end of the day, a big rebase -i to make the history readable.

This is just about doable with git-add -p, or git-commit --interactive, but
it's very inefficient. I take the presence of git commit --fixup to imply that
other people are doing similar, if less extreme things, so assume that they
would like a git-commit -p too.

Conrad
