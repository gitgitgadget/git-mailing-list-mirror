From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] git-remote-hg : Enable use of,
 $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sat, 12 Apr 2014 15:01:52 -0500
Message-ID: <53499bb02c140_285f9032ec58@nysa.notmuch>
References: <53076DFC.1000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com
To: Daniel Liew <delcypher@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:12:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4HX-0003MG-A7
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbaDLUL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:11:59 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:32961 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbaDLULy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:11:54 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so7726972oag.28
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Hv3JcPir5fndNIzF5bbf59EcXM2yb0C3okOwwQBBYWs=;
        b=PKe3vj6eg5uqIovGgBhTWomoL4g+GPMhUKSjDrFi9zefMc/64dA6xVYtvaGZTLCQnD
         2YEnw2BuNTArm5AaiH7ilGlo0J3+uibpLHYVKhrEGUZIeALHHXRs0XKpEoYlQbH+hrtW
         jXoG3QWXjclN+jSXMHgn59/txE6xC3knyuI4O35BtSBgBNP0n9+VnjA+shXvN6hwcg4/
         +QS+EzimX23ZJicuxPVPGQAvZnZaIEKNfKSGIltbTAZJyZaew7yjordf7Rz+5tPwOtis
         pBppxizpxFe5TWIX/8tk2+AMulGQNJhYEh9SphbU7jwMQdHUrivBQxAzdOat8KLhUPli
         Dnfw==
X-Received: by 10.182.75.161 with SMTP id d1mr5960104obw.7.1397333514388;
        Sat, 12 Apr 2014 13:11:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm48808426oeb.11.2014.04.12.13.11.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:11:52 -0700 (PDT)
In-Reply-To: <53076DFC.1000602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246178>

Daniel Liew wrote:
> git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
> 
> Use the hgrc configuration file in the internal mercurial repository in
> addition to the other system wide hgrc files. This is done by using the
> 'ui' object from the 'repository' object which will have loaded the
> repository hgrc file if it exists.

What is the problem you are trying to solve? Is there a way to test that this
code is working correctly?

> Prior to this patch the mercurial repository's hgrc file was ignored
> which I consider to be a bug.

It might be, although the internal repository is not supposed to be used by the
user.

> Signed-off-by: Dan Liew <delcypher@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg
> b/contrib/remote-helpers/git-remote-hg
> index eb89ef6..451842a 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -421,7 +421,7 @@ def get_repo(url, alias):
> 
>          repo = hg.repository(myui, local_path)
>          try:
> -            peer = hg.peer(myui, {}, url)
> +            peer = hg.peer(repo._unfilteredrepo.ui, {}, url)

Why not repo.unfiltered.ui? Or just repo.ui.

Cheers.

-- 
Felipe Contreras
