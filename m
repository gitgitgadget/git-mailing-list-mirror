From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 12:23:52 -0700
Message-ID: <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
	<CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
	<CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
	<CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
	<20130312190956.GC2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUo9-0002pG-F4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635Ab3CLTXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:23:54 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:34434 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab3CLTXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:23:53 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so222737wea.10
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Rg83DDUvBHPRwUMondVUsgfd3P7wR18mWLTcuLv2Pvk=;
        b=RDlb3ETw0PdCT/bbdvX0je1RoBXzemLWuOXGAMfsgnVmLNzHf/pZkn/s1Hfz24AFzC
         99F4mkVTGDhJ63QTj2GFIRiOLfiUWnUdNwIaRxyXo4I5IjAIRVqGpzoxkDA1BF61jUfw
         OL+yRY1KffRPRV9Mh44WSPn2JD6ulTVCBVfVxtMGVIsGo0sN1tvzvJQs+jJHTvGy4nWW
         bFOEhyLCd45VPL4NBu2wE6IuApTuAD949fpOlAkQDo2cF809VVcgpGU3rCwu/sduLYgG
         Xk9k0ViMOXk70mjZCX8SrFcFC+Ci98ynebZmVCRldHfnC6G5Wxv/IW69mufOHocbMLZa
         h8Lw==
X-Received: by 10.194.76.37 with SMTP id h5mr29567238wjw.21.1363116232622;
 Tue, 12 Mar 2013 12:23:52 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Tue, 12 Mar 2013 12:23:52 -0700 (PDT)
In-Reply-To: <20130312190956.GC2317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217983>

On Tue, Mar 12, 2013 at 12:09 PM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Mar 12, 2013 at 02:12:29PM -0400, Matt McClure wrote:
>> On Tue, Nov 27, 2012 at 7:41 AM, Matt McClure <matthewlmcclure@gmail.com> wrote:
>> Your thoughts on the change?
>
> Please include the patch in your message so that interested parties can
> comment on it here, especially since the compare view on GitHub seems to
> mangle the tabs.
>
> For others' reference the patch is:
>
> -- >8 --
> From: Matt McClure <matt.mcclure@mapmyfitness.com>
> Subject: [PATCH] difftool: Make directory diff symlink work tree
>
> difftool -d formerly knew how to symlink to the work tree when the work
> tree contains uncommitted changes. In practice, prior to this change, it
> would not symlink to the work tree in case there were no uncommitted
> changes, even when the user invoked difftool with the form:
>
>     git difftool -d [--options] <commit> [--] [<path>...]
>         This form is to view the changes you have in your working tree
>         relative to the named <commit>. You can use HEAD to compare it
>         with the latest commit, or a branch name to compare with the tip
>         of a different branch.
>
> Instead, prior to this change, difftool would use the file's HEAD blob
> sha1 to find its content rather than the work tree content. This change
> teaches `git diff --raw` to emit the null SHA1 for consumption by
> difftool -d, so that difftool -d will use a symlink rather than a copy
> of the file.
>
> Before:
>
>     $ git diff --raw HEAD^ -- diff-lib.c
>     :100644 100644 f35de0f... ead9399... M  diff-lib.c
>
> After:
>
>     $ ./git diff --raw HEAD^ -- diff-lib.c
>     :100644 100644 f35de0f... 0000000... M  diff-lib.c


Interesting approach.  While this does get the intended behavior
for difftool, I'm afraid this would be a grave regression for
existing "git diff --raw" users who cannot have such behavior.

I don't think we could do this without adding an additional flag
to trigger this change in behavior (e.g. --null-sha1-for-....?)
so that existing users are unaffected by the change.

It feels like forcing the null SHA-1 is heavy-handed, but I
haven't thought it through enough.

While this may be a quick way to get this behavior,
I wonder if there is a better way.

Does anybody else have any comments/suggestions on how to
better accomplish this?


> ---
>  diff-lib.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index f35de0f..ead9399 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -319,6 +319,10 @@ static int show_modified(struct rev_info *revs,
>                 return -1;
>         }
>
> +       if (!cached && hashcmp(old->sha1, new->sha1)) {
> +               sha1 = null_sha1;
> +       }
> +
>         if (revs->combine_merges && !cached &&
>             (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
>                 struct combine_diff_path *p;
> --
> 1.8.2.rc2.4.g7799588
>



-- 
David
