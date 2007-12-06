From: "Mark Drago" <markdrago@gmail.com>
Subject: Re: [PATCH] hg-to-git: handle an empty dir in hg by combining git commits
Date: Thu, 6 Dec 2007 07:50:39 -0500
Message-ID: <af675f7f0712060450g2e9d0496y93749c2209bd0f0c@mail.gmail.com>
References: <4751A0FB.6090705@gmail.com>
	 <7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
	 <7veje11v7f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: stelian@popies.net, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0GEx-0004oV-IG
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbXLFMuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581AbXLFMun
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:50:43 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:37870 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716AbXLFMul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:50:41 -0500
Received: by nz-out-0506.google.com with SMTP id s18so44593nze
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 04:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WY65OePB2uDZ0A2Jrm0g+/9ktKhASzsPhzaCq96sy1E=;
        b=ZZESVilW+zdJbNK6De0ilkMZ8j3w8OamE3nTDz7GO2mn5kGprKxjqOc4NWrB43z9/Rz7RLADSwb+ZsrCRdagtY7o/QFQv6pDllyAvWwAVlfBfFEaboLEnKlRzHCfc8N5uVMybT6czHGeGoE9XgX3reHrfYGyI1YnrKMS65p8Dss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jGt0+a4RWez+aVIt3ni1Fgu5wn6EgAp0QHF2v3+21IrTaVgbeV2LoIRIMWJt0/voSjkCw2dz4TZFnhxAbxeMX3Rs2MkXG61Z0jMfJuek3nlql9r6/xJiprpy0TqbwZno1M1dp6EK1YmvmoI01IB9UUBF25ije4JfHNmNZ7kXnxU=
Received: by 10.142.215.5 with SMTP id n5mr1537915wfg.1196945439838;
        Thu, 06 Dec 2007 04:50:39 -0800 (PST)
Received: by 10.142.234.19 with HTTP; Thu, 6 Dec 2007 04:50:39 -0800 (PST)
In-Reply-To: <7veje11v7f.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67282>

On Dec 5, 2007 2:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Mark Drago <markdrago@gmail.com> writes:
> >
> >> This patch will detect that there are no changes to commit (using git-status),
> >> and will not perform the commit, but will instead combine the log messages of
> >> that (non-)commit with the next commit.
> >
> > I think a better approach would be to implement --no-tree-change-is-ok
> > option to git-commit, strictly for use by foreign scm interface scripts
> > like yours.  It does not usually make sense to record a commit that has
> > the exact same tree as its sole parent commit and that is why git-commit
> > prevents you from making that mistake, but when data from foreign scm is
> > involved, it is a different story.  We are equipped to represent such a
> > (perhaps insane, perhaps by mistake, or perhaps done on purpose) change
> > and it is better to represent it bypassing the safety valve for native
> > use.
>
> So I did "git commit --allow-empty".  With that, perhaps the following
> will fix the issue?
>
> I won't be commiting this myself until I hear a positive Ack.

I gave this a test and it works perfectly well.  Commit away.

Thanks,
Mark.

> ---
>  contrib/hg-to-git/hg-to-git.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
> index 7a1c3e4..9befb92 100755
> --- a/contrib/hg-to-git/hg-to-git.py
> +++ b/contrib/hg-to-git/hg-to-git.py
> @@ -211,7 +211,7 @@ for cset in range(int(tip) + 1):
>      os.system('git-ls-files -x .hg --deleted | git-update-index --remove --stdin')
>
>      # commit
> -    os.system(getgitenv(user, date) + 'git-commit -a -F %s' % filecomment)
> +    os.system(getgitenv(user, date) + 'git commit --allow-empty -a -F %s' % filecomment)
>      os.unlink(filecomment)
>
>      # tag
>
