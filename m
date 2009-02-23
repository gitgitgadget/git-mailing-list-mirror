From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Counter-intuitive results for git show and git checkout during 
	rebase with conflict.
Date: Mon, 23 Feb 2009 02:16:41 -0500
Message-ID: <76718490902222316m768d202fib4671d7782b47de@mail.gmail.com>
References: <544dda350902222004v742a7175od19ac417f75ddd1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbV4t-0006sK-IZ
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbZBWHQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbZBWHQm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:16:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:36919 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZBWHQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 02:16:41 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1822071rvb.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 23:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rHyaaco4Gw2JiDuUJNymzhaUKcJPem4mmkzaflQldv0=;
        b=Bsi726lOY5kZTOzNtR+g2cjKhcaqOXdxZHzTO/8HKsYwpPeKPdzEESRG0VDixUZXOd
         K6mivQBuqMSUPPNI/C1keFZ33AcW8i7gQyW3FyX6ed/nq46WpGUoNd3TsTP2ULdPeoGP
         eQ7Ln97maUXfsvd10oo6R+kxL9h2D089JvLA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BkU/LoRjYkfrdt0ZRSr+oO2vkQGTHLJ3/J4Qc5i7sHRW2xSBO7MAqD+BbraECdVzoG
         x4jHQYHpFqWY5O9kSLAwf+rbN4dWsNhxA+qk4HcvesOMI/2dIdEoHPZCInHaj9lEnvW3
         U4jrfBkQJcKMYeM/q34pQnrO8odWLbuTuUzFQ=
Received: by 10.141.71.14 with SMTP id y14mr1895537rvk.131.1235373401220; Sun, 
	22 Feb 2009 23:16:41 -0800 (PST)
In-Reply-To: <544dda350902222004v742a7175od19ac417f75ddd1a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111112>

On Sun, Feb 22, 2009 at 11:04 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> The scenario: We have two branches, local and master, we are now on
> branch local, and we would like to rebase local wrt master:
>
>        % git rebase master
>        conflictedfile: needs merge
>        cannot rebase: you have unstaged changes
>
> Obviously we have a conflict, here's the problem: these commands have
> counter-intuitive effect (as oppose to during a git merge with
> conflict):
>
>  git show :2:conflictedfile  # shows content from master version
>  git show :3:conflictedfile  # shows content from local version
>
>  git checkout --ours conflictedfile   # gets content from master version
>  git checkout --theirs conflictedfile # gets content from local version
>
> I know why they are counter-intuitive - :2:, :3:, --ours and --theirs
> are relative to the current <commit>, and during a conflict due to a
> rebase, the current <commit> is some commit that leads to master,
> which is not anywhere in the path that leads to local.
>
> So in summary:
>
> Fact 1:
>  During a conflict due to a rebase, HEAD is a commit that leads to
>  the other branch.
>
> Fact 2:
>  During a conflict due to a merge, HEAD is a commit that leads to the
>  current branch.
>
> (Please correct me if the two facts above are not true)
>
> Technically there's nothing wrong with the behavior of the commands,
> but wouldn't it be better if the arguments :2:conflictedfile and
> :3:conflictedfile to git show and the options --ours and --theirs to
> git checkout be made aware of the two facts above and do a more
> intuitive action?
>
> Or should this be left to a higher level tools to automatically detect
> the reason of the conflict and adjust the arguments appropriately so
> that the end results are intuitive for the user?

I took a crack at fixing this issue in the UI (well, just mergetool),
but that wasn't the right way to do it. See Junio's reply in this
thread:

http://thread.gmane.org/gmane.comp.version-control.git/74595

So, patches welcomed. :-)

j.
