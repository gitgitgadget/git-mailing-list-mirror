From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] revert: simplify communicating command-line arguments
Date: Fri, 9 Dec 2011 13:02:36 -0600
Message-ID: <20111209190236.GA20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-10-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5ib-0003OJ-Dm
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab1LITCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:02:45 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63961 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1LITCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:02:44 -0500
Received: by yenm11 with SMTP id m11so2335641yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a9QtNlRP8GJmdv9GAUysfQ8q7din28l/uUtkxPw/Otk=;
        b=EMGlP8Q2YvntgvL1YIbjdZ0z8xokCuU+PNyHML2HJbfLL2py1TPh6oPagjYT6s5Hlr
         OsbygLt0608W12jBCDCRsiBeu0y/Y8UiBMH9IinUEZsQdpI/3MYoK5uq07VUXf6RO0Q5
         j5aX/Pudyk8gVzmaqwXxu+VKTbETsig8rYc7w=
Received: by 10.236.154.42 with SMTP id g30mr14779316yhk.3.1323457363881;
        Fri, 09 Dec 2011 11:02:43 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i50sm16421855yhk.11.2011.12.09.11.02.42
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:02:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-10-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186665>

Hey,

Ramkumar Ramachandra wrote:

> From: Jonathan Nieder <jrnieder@gmail.com>
[...]
> Future callers as other commands are built in (am, rebase, sequencer)
> may find it easier to pass rev-list options to this machinery in
> already-parsed form.  So, teach cmd_cherry_pick and cmd_revert to
> parse the rev-list arguments in advance and pass the commit set to
> pick_revisions() as a "struct rev_info".
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This sign-off chain suggests that the life of the patch happened in
three stages:

 - first, you wrote the patch or some component of it and passed it to
   me.
 - then, I accepted it, tweaked it so much that I felt the need to claim
   authorship and save you from blame (hence the "From:" field), and
   passed it on to Junio.
 - finally, Junio applied it to some tree.

and that you are sending out a copy of the patch Junio applied for
additional comments.

But in fact, this started with a patch from me (I don't rememember
whether it was signed off, but that doesn't matter --- I happily
retroactively sign off on it) and now you are sending it to the list
and Junio for comments.  So I would think it should simply say

	Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
	Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

and Junio can add his sign-off below that when applying some version
to his tree.  Bonus points if you mention what tweaks you made when
you are not just passing it on.

[...]
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -414,4 +414,15 @@ test_expect_success 'mixed pick and revert instructions' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'empty commit set' '
> +	pristine_detach initial &&
> +	test_expect_code 128 git cherry-pick base..base
> +'
> +
> +test_expect_success 'commit set passed through --all' '
> +	pristine_detach initial &&
> +	test_expect_code 1 git cherry-pick --all &&
> +	git cherry-pick --continue
> +'

What does this test mean?  "git cherry-pick --all" should report a
spurious conflict, and then --continue will clean it up automagically
and all will be well?
