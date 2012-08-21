From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: silence warning
Date: Tue, 21 Aug 2012 02:04:04 -0700
Message-ID: <CAJDDKr5W5YJoMEkX7_ax_pvwdibJ81LMzsM0Rnkn1=9=Nu25EA@mail.gmail.com>
References: <1345532358-11742-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 11:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3kO2-00005L-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 11:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab2HUJEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 05:04:09 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59643 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab2HUJEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 05:04:05 -0400
Received: by vbbff1 with SMTP id ff1so6268602vbb.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eJjFpmyV5GQk1SuXD1Cy7w1sN+H+wOtz+uWGCqw2BVI=;
        b=zNvNzTdOjyJVprcylJ3AxdnK74syJq78I9L8DYbVQ/oPjU9prN+8GD3/7R6wpm/N08
         FF1s8d+bWx4lR63Lk0ivtW70LsXlJ5ULRH1TmjwR+G930iGNfIJ+oaa7pNGRihSYKhSA
         V2TjfaixFoXlfAAsLr8O27JZo7g2x9GrqwXXrOZbBVVfMNtiouCmxL1jXH2dvXquTs2p
         JgWY2F6KJ5BdgeOwdrDhzJlUFaIYhzu/BVPXHv8y+zQ5HAqmHm+elKKt7ZV0LlJyqm5E
         zEVbYZMNm3k5UUbYd8GJzOd6Ba/jO2BV+0PA9968oxy/hdviN7CRAd/HVAIDVTWgQbmB
         b5eg==
Received: by 10.58.151.197 with SMTP id us5mr14018984veb.14.1345539844419;
 Tue, 21 Aug 2012 02:04:04 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Tue, 21 Aug 2012 02:04:04 -0700 (PDT)
In-Reply-To: <1345532358-11742-1-git-send-email-rosslagerwall@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203956>

On Mon, Aug 20, 2012 at 11:59 PM, Ross Lagerwall
<rosslagerwall@gmail.com> wrote:
> Silence a warning given when running git difftool --dir-diff and
> there are no changes.
> This is because command_oneline returns undef when the command has no
> output, not ''.
>
> Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>

Thanks

This patch is obviously correct, but it won't apply in git's "next" branch.
Can you please prepare a patch based on the version in next?


A small question on Perl style for the list... is it better say this?

   exit(0) unless $diffrtn;

or is it better to explicitly check for undef using defined($diffrtn)
like was done in this patch? I would assume that explicit is preferred.


> ---
>  git-difftool.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index ae1e052..1cfcbb3 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -117,7 +117,7 @@ sub setup_dir_diff
>         # by Git->repository->command*.
>         my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
>         my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
> -       exit(0) if (length($diffrtn) == 0);
> +       exit(0) unless defined($diffrtn);
>
>         # Setup temp directories
>         my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
> --
> 1.7.11.4
-- 
David
