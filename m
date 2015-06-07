From: Ariel Faigon <github.2009@yendor.com>
Subject: PATCH [git/contrib] Avoid failing to create
 ${__git_tcsh_completion_script} when 'set noclobber' is in effect  (af7333c)
Date: Sun, 7 Jun 2015 12:54:51 -0700
Message-ID: <20150607195451.GA23551@yendor.com>
References: <arielf/git/commit/af7333c176401601d67ea67cb961332ee4ef3574@github.com>
 <arielf/git/commit/af7333c176401601d67ea67cb961332ee4ef3574/11557888@github.com>
Reply-To: github.2009@yendor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 21:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1geo-00011g-IW
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 21:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbFGTyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 15:54:54 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:45471 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbFGTyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 15:54:53 -0400
Received: from homiemail-a38.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
	by hapkido.dreamhost.com (Postfix) with ESMTP id B6CE98DD07
	for <git@vger.kernel.org>; Sun,  7 Jun 2015 12:54:52 -0700 (PDT)
Received: from homiemail-a38.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTP id 5B16D10AFC2
	for <git@vger.kernel.org>; Sun,  7 Jun 2015 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yendor.com; h=date:from:to
	:subject:message-id:reply-to:references:mime-version
	:content-type:in-reply-to; s=yendor.com; bh=wr/O1AjN9MddFjCEmUo+
	BvJfMqU=; b=NUvN6IFmMqo5k9vvVxoGn+YHcrpUoBhYJGIDXXbvVtrlM8+eBCwz
	UGKzjZkKN3ISfx4qVUzWoqe5XfBx2WRgonIyDARGXYhJ58UxdE6AhOJudfi9i0In
	+U8ksmU4SKt0rrhFYIkRPUjXEQEpI+h15sOJPVYxYivuFfDThvFTUog=
Received: from go (c-67-188-70-105.hsd1.ca.comcast.net [67.188.70.105])
	(Authenticated sender: catch-all@yendor.com)
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTPA id 4913A10AFA5
	for <git@vger.kernel.org>; Sun,  7 Jun 2015 12:54:52 -0700 (PDT)
Received: by go (Postfix, from userid 1000)
	id E023A1BF7F1C; Sun,  7 Jun 2015 12:54:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <arielf/git/commit/af7333c176401601d67ea67cb961332ee4ef3574/11557888@github.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270979>


Junio,

This is my 1st time doing this, sorry.
I hope this satisfies the git Sign Off procedure.

Problem Description:

tcsh users who happen to have 'set noclobber' elsewhere in their ~/.tcshrc or ~/.cshrc startup files get a 'File exist' error, and the tcsh completion file doesn't get generated/updated.  Adding a `!` in the redirect works correctly for both clobber and noclobber users.

Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

 Signed-off-by: Ariel Faigon <github.2009@yendor.com>

 git patch follows.

---
 contrib/completion/git-completion.tcsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 6104a42..4a790d8 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -41,7 +41,7 @@ if ( ! -e ${__git_tcsh_completion_original_script} ) then
 	exit
 endif
 
-cat << EOF > ${__git_tcsh_completion_script}
+cat << EOF >! ${__git_tcsh_completion_script}
 #!bash
 #
 # This script is GENERATED and will be overwritten automatically.
