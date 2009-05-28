From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Thu, 28 May 2009 20:00:53 +0400
Message-ID: <85647ef50905280900v274d87ag8d364ea7bd9a97ee@mail.gmail.com>
References: <20090527210410.GA14742@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dave Olszewski <cxreg@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu May 28 18:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9i2T-0002iP-CE
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 18:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbZE1QAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757656AbZE1QAx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 12:00:53 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:55494 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552AbZE1QAw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 12:00:52 -0400
Received: by bwz22 with SMTP id 22so5548378bwz.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZzvP7fzpbaj4exR70Y0xWHjRrcqE0CCofiu1HRa5XD8=;
        b=NG3pE6K7gzHVl1LKNwH81vyPA+RyTEzg26FFL3G2qlmAWs0W5x8xVYKu1IlN+MKIY4
         kbWNUR7sq2segt3clvjkFyoor1hmK66F0nDrjSZpayW24DrNRICsKk+krCLDic5yJxO2
         2w1so6m8d1o/bqKmPoBheAzjNtvEeUKmzVPRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JTZTDPpKODd+MnuxPBmGKdNqPEaJguJpNqDDvBCLtonw9EKtZ433FjDp0LNt11XdL0
         kftJFLgWAlOvpzprxTYKcnjhcO2nbaIhxdVkQO66YZJFltxhGYTfeVDSXMCM3Ta2JIVV
         /BkK55SeeAbhriJ36V1QAin65JL9X8UyL9WR0=
Received: by 10.204.113.198 with SMTP id b6mr1323536bkq.108.1243526453471; 
	Thu, 28 May 2009 09:00:53 -0700 (PDT)
In-Reply-To: <20090527210410.GA14742@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120194>

MERGE_HEAD file could also happen in case of --no-commit option. In
that case there might be no conflict and the message would look
confusing to the user. I suggest to change a message to "You are in
the middle of a uncommitted or conflicted merge." or something like
it.

Regards,
Constantine

On Thu, May 28, 2009 at 1:04 AM, Clemens Buchacher <drizzd@aon.at> wrot=
e:
> The following is an easy mistake to make for users coming from versio=
n
> control systems with an "update and commit"-style workflow.
>
> =A0 =A0 =A0 =A01. git merge
> =A0 =A0 =A0 =A02. resolve conflicts
> =A0 =A0 =A0 =A03. git pull, instead of commit
>
> This overrides MERGE_HEAD, starting a new merge with dirty index. IOW=
,
> probably not what the user intented. Instead, refuse to merge again i=
f a
> merge is in progress.
>
> Reported-by: Dave Olszewski <cxreg@pobox.com>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>
> =A0builtin-merge.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-merge.c b/builtin-merge.c
> index 0b58e5e..74a8c8f 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -836,7 +836,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
> =A0 =A0 =A0 =A0struct commit_list **remotes =3D &remoteheads;
>
> =A0 =A0 =A0 =A0setup_work_tree();
> - =A0 =A0 =A0 if (read_cache_unmerged())
> + =A0 =A0 =A0 if (read_cache_unmerged() || file_exists(git_path("MERG=
E_HEAD")))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("You are in the middle of a confli=
cted merge.");
>
> =A0 =A0 =A0 =A0/*
> --
> 1.6.3.1.147.g637c3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
