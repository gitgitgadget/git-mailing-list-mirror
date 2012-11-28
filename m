From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 4/4] git-svn: Note about tags.
Date: Wed, 28 Nov 2012 15:58:02 +0100
Message-ID: <50B6267A.204@drmicha.warpmail.net>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name> <c72bc0d2a4f2681d27247c6f7510c4ada8e83aec.1353691892.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdj5g-0004hR-0F
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 15:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab2K1O6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 09:58:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49227 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755472Ab2K1O6C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2012 09:58:02 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9BEBF21027;
	Wed, 28 Nov 2012 09:58:02 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 28 Nov 2012 09:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=E2a1FnWAEbt6sUxkxuwDh1
	oMJws=; b=lGsJcger6QlBWUYgbiiDnR67/YbAOyFE0nuC06v6OoHguhpKtAjjJn
	nUUAf6OKdSLiVmlYU4tMrtBmlddnp5sgTCB/Tx4TOTAbabV0yg940BnyjRT8CbbD
	JqebvoXlRT15vZFZZSGQzHaJF0oimcCm714HN3DF4dRXJm1x6clBY=
X-Sasl-enc: X164oZV5Q2xTjE8XyBnAtE7XWgY8+2FJRJ0pqnMhXFJx 1354114682
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F36384827C5;
	Wed, 28 Nov 2012 09:58:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <c72bc0d2a4f2681d27247c6f7510c4ada8e83aec.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210736>

Sebastian Leske venit, vidit, dixit 23.11.2012 08:29:
> Document that 'git svn' will import SVN tags as branches.
> 
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 92780ef..6212b24 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -938,6 +938,12 @@ the possible corner cases (git doesn't do it, either).  Committing
>  renamed and copied files is fully supported if they're similar enough
>  for git to detect them.
>  
> +In SVN, it is possible (though discouraged) to commit changes to a tag
> +(because a tag is just a directory copy, thus technically the same as a
> +branch). When cloning an SVN repository, 'git svn' cannot know if such a
> +commit to a tag will happen in the future. Thus it acts conservatively
> +and imports all SVN tags as branches, prefixing the tag name with 'tags/'.
> +

If git-svn turned SVN tags in git lightweight tags it would be just as
conservative, because they can be rewritten also... It's just a ref.
Note that the above assumes standard refspecs.

But, importing SVN tags as branches conveys their character much more
precisely. If r8 is being tagged then svn creates r9, which may or may
not be treesame to r8; different projects do different things in this step.

Even if they are treesame, r9 still carries a separate commit message.
This is probably the most typical case, and converting the r9 commit
into a git tag object would be appropriate (but is left to the user of
git-svn).

A lightweight tag pointing to an "off-branch" commit (r9) would be a
strange thing, so git-svn creates a new branch instead, pointing at r9,
branching off r8.

>  CONFIGURATION
>  -------------
>  
> 
