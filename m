From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Wed, 20 Aug 2008 23:58:14 +0700
Message-ID: <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
	 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 18:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVr1m-0004AA-MT
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 18:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYHTQ6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 12:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYHTQ6Q
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 12:58:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:27424 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYHTQ6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 12:58:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so540196rvb.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GowzZR9JVRBSuP4Al94gaqBbjissM/5YCASQmZe8M0c=;
        b=cqqe2qeAxbB2Yx4n2Q8/iQKhRbfJzHDJq4eY0pLMHAhvH2lS4+5YQ6/xEBnLO04Sb6
         xX/yrOjEoVJcd9YgAMiYkqnwZibtfKdKxU6ZfXw/g780xynI8xLhAwVnQgOwAFTR/6kz
         6AUgZ282i5NDdLFstY1mN0B7ExnTIlW7vCRHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=plhBk+SbRlXRftAyKPuFtBA0iSj44cXyz6snBVkyTv+YYTORPgnuS/9BGmvlZ5R1kd
         aivgAegzFPaeh8I604tFbwrUyeFLWPWl0phizVnwv2Hxb9+tDnuptOBnkSdfjAJ+gVrB
         mne7sEZ7b8UMzhSrNXQUK0IZQ7lvJALT7q36w=
Received: by 10.141.170.10 with SMTP id x10mr172004rvo.105.1219251494485;
        Wed, 20 Aug 2008 09:58:14 -0700 (PDT)
Received: by 10.141.98.6 with HTTP; Wed, 20 Aug 2008 09:58:14 -0700 (PDT)
In-Reply-To: <48AADDBB.1080203@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92995>

On 8/19/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>
> > +--show-strategies::
>  > +     Show all available strategies. For internal use only.
>  > +
>
>
> IMO, you don't need to declare this option as internal; offering it for
>  the public is fine...

On second thought, I don't think the patch's worth it. The code in
git-completion.bash is a hack and I replace it with another the hack.
It won't work for custom merges and git-completion.bash will need to
be synced manually anyway, so maybe this patch will do better:

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 158b912..2fed6ac 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -267,19 +267,8 @@ __git_remotes ()

 __git_merge_strategies ()
 {
-	if [ -n "$__git_merge_strategylist" ]; then
-		echo "$__git_merge_strategylist"
-		return
-	fi
-	sed -n "/^all_strategies='/{
-		s/^all_strategies='//
-		s/'//
-		p
-		q
-		}" "$(git --exec-path)/git-merge"
-}
-__git_merge_strategylist=
-__git_merge_strategylist="$(__git_merge_strategies 2>/dev/null)"
+	echo recursive octopus resolve ours subtree
+}

 __git_complete_file ()
 {

-- 
Duy
