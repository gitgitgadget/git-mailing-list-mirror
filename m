From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 05/10] remote-hg: fix new branch creation
Date: Tue, 14 May 2013 15:19:35 -0500
Message-ID: <51929c576d949_13a8f89e18183b@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:24:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLlw-0007vr-O7
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab3ENUY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:24:28 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:59313 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895Ab3ENUY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:24:27 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so1225306oag.30
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=X59Yeda9+s36iyW/H33MKG3oCU6vuX2lbM4islRL6X4=;
        b=dQ70KpWNtU4Y+OTTTb3IV6zhR0e+1Ky96c5W2q/ip5yr9Knf/jrBasixIE/wPEAjaM
         KsKXc01r3NFSH5oyFooZk4hpkQO3Uv4sv7uXWvSB1q5afRYL1ERjiDeEetUP1toqAKdV
         3V90bu9IyIBBO4uoug/JgLNRZJrqf6GYxkrAR6O3yY61bO48AaRqTTeKVRap0TlG8D18
         14aZJvqAhgZJOArFXSOhXgyDXWeYCJCz1Hx25wnLuc6VOHUyE03wfz0iSMM0XPLlvJFU
         HyYGafJzFvW6uhrRT14JriGrOvoJHGnXi1uzQ0lq/tzcQhdzPLDhQFKdevg+Hz5BYdUz
         JpIA==
X-Received: by 10.182.214.103 with SMTP id nz7mr8035860obc.66.1368563067347;
        Tue, 14 May 2013 13:24:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm23208722obl.1.2013.05.14.13.24.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:24:26 -0700 (PDT)
In-Reply-To: <1368486720-2716-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224337>

This is the first fix, but it's obvious this is what we want: if a user creates
a new branch with git:

 % git checkout -b branches/devel

And then pushes this branch

 % git push origin branches/devel

(which is the way to push new mercurial branches)

We obviously want to create a branch, but the command would fail, and the fix
is simple: tell the push that we might create new branches.

This only matters when foce_push=False.

Can't possibly introduce regressions, unless you think of the ability to push
new branches as a regression.

Felipe Contreras wrote:
> When force_push is disabled, we need to turn the argument to True.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 4a5c72f..3cf9b4c 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -856,7 +856,7 @@ def do_export(parser):
>              continue
>  
>      if peer:
> -        parser.repo.push(peer, force=force_push)
> +        parser.repo.push(peer, force=force_push, newbranch=True)
>  
>      # handle bookmarks
>      for bmark, node in p_bmarks:
> -- 
> 1.8.3.rc1.579.g184e698



-- 
Felipe Contreras
