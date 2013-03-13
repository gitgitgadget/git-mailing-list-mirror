From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 01:24:07 -0700
Message-ID: <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
References: <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
	<CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
	<20130312190956.GC2317@serenity.lan>
	<CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
	<20130312194306.GE2317@serenity.lan>
	<7vfw0073pm.fsf@alter.siamese.dyndns.org>
	<20130312210630.GF2317@serenity.lan>
	<CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
	<7vehfk5kn2.fsf@alter.siamese.dyndns.org>
	<3222724986386016520@unknownmsgid>
	<20130313001758.GH2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 13 09:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFgzI-0003Of-OK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 09:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab3CMIYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 04:24:12 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50649 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab3CMIYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 04:24:09 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so2535055wib.16
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=7BRX+MzSPddTeICdLS6CFBRBNlNlkbtTbiTGHra4pVI=;
        b=Z8YaAd1FtEE+TGqEi6tgz2pHh6GErriSP3ITMsyOD4j5krDo7gY4aMtOjkGqKedwAf
         Idbzr/MAdPc26H1nF8HRbRVdJIPQCmFff0WWymMeOmBlC613SWT0IaDkb4/vBFhwds1d
         CjNGSW85fg3qfkAmTKuCFe5NmhOc5WXvJF6b5AsR10+XZhu6Kxb1lpvRoqO/cnqcM0sg
         ohvzITYOWuv17v16ED0IXiMcjD3fjLU9I4WBVOlRFhAtxA1M027JVmCTkVlgIwI/xomY
         dBs00NpxD8V5xuUizhXIm+m5NV4VoLxp3alaVhWh/cm0iQo3zwyGHfY3WL5dOPvROyP9
         w7Ow==
X-Received: by 10.180.8.4 with SMTP id n4mr24897145wia.13.1363163048102; Wed,
 13 Mar 2013 01:24:08 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Wed, 13 Mar 2013 01:24:07 -0700 (PDT)
In-Reply-To: <20130313001758.GH2317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218039>

On Tue, Mar 12, 2013 at 5:17 PM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Mar 12, 2013 at 04:48:16PM -0600, Matt McClure wrote:
>> On Mar 12, 2013, at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> > Matt McClure <matthewlmcclure@gmail.com> writes:
>> >
>> > * If you are comparing two trees, and especially if your RHS is not
>> >   HEAD, you will send everything to a temporary without
>> >   symlinks. Any edit made by the user will be lost.
>>
>> I think you're suggesting to use a symlink any time the content of any
>> given RHS revision is the same as the working tree.
>>
>> I imagine that might confuse me as a user. It would create
>> circumstances where some files are symlinked and others aren't for
>> reasons that won't be straightforward.
>>
>> I imagine solving that case, I might instead implement a copy back to
>> the working tree with conflict detection/resolution. Some earlier
>> iterations of the directory diff feature used copy back without
>> conflict detection and created situations where I clobbered my own
>> changes by finishing a directory diff after making edits concurrently.
>
> The code to copy back working tree files is already there, it just
> triggers using the same logic as the creation of symlinks in the first
> place and doesn't attempt any conflict detection.  I suspect that any
> more comprehensive solution will need to restrict the use of "git
> difftool -d" whenever the index contains unmerged entries or when there
> are both staged and unstaged changes, since the merge resolution will
> cause these states to be lost.
>
> The implementation of Junio's suggestion is relatively straightforward
> (this is untested, although t7800 passes, and can probably be improved
> by someone better versed in Perl).  Does this work for your original
> scenario?

This is a nice straightforward approach.

As Junio mentioned, a good next step would be this patch
in combination with making the truly temporary files
created by dir-diff readonly.

Will that need a win32 platform check?
Does anyone want to take this and whip it into a proper patch?

> -- >8 --
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 0a90de4..5f093ae 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -83,6 +83,21 @@ sub exit_cleanup
>         exit($status | ($status >> 8));
>  }
>
> +sub use_wt_file
> +{
> +       my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
> +       my $null_sha1 = '0' x 40;
> +
> +       if ($sha1 eq $null_sha1) {
> +               return 1;
> +       } elsif (not $symlinks) {
> +               return 0;
> +       }
> +
> +       my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> +       return $sha1 eq $wt_sha1;
> +}
> +
>  sub setup_dir_diff
>  {
>         my ($repo, $workdir, $symlinks) = @_;
> @@ -159,10 +174,10 @@ EOF
>                 }
>
>                 if ($rmode ne $null_mode) {
> -                       if ($rsha1 ne $null_sha1) {
> -                               $rindex .= "$rmode $rsha1\t$dst_path\0";
> -                       } else {
> +                       if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
>                                 push(@working_tree, $dst_path);
> +                       } else {
> +                               $rindex .= "$rmode $rsha1\t$dst_path\0";
>                         }
>                 }
>         }
> --
> 1.8.2.rc2.4.g7799588
>
-- 
David
