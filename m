From: "James North" <tocapicha@gmail.com>
Subject: Re: Encoding problems using git-svn
Date: Thu, 30 Oct 2008 16:14:18 +0100
Message-ID: <8b168cfb0810300814i53a264c2x997543e145d5e15a@mail.gmail.com>
References: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
	 <20081030074114.GA26926@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:15:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZFH-0005Cp-V3
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbYJ3POV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbYJ3POU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:14:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34843 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbYJ3POT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:14:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so530065fgg.17
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gneA25TbW7nWq3ZMOg9Y2beypmuLxx6lWp0Ptchojhc=;
        b=cTs9eO6EIQrV0PTV8UsWCHkh5mMNVYAE7U/tpYLFSkDgjoOL+SI/5/uthlhG0a1GRA
         vCtMbADqoz7SprkqzojOLDv/rNvRLnPldzN8gcabsWu7fGQEkG+XlOLTx1+rck1kZZcy
         LjRR9nlRrIeZSy4gN6K9mc+C3fXoQiSRZIufs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pkTceUt+g9X7svYQK8ZqrCBEObeRvLN8BsU5kWpZ0iV+zxtSpM3cTjYNAnzI5kEsJj
         wc+zoDu2WJ24mJ61gYwYqwEcj++LnaLPZfOzv75zb2yOJexLD16UtFI9QAFk0dcPFRY5
         SfmHwZEbQ5vRxMcGsh/Rg+o+9IrnCIad/S4MI=
Received: by 10.187.210.10 with SMTP id m10mr1022377faq.13.1225379658666;
        Thu, 30 Oct 2008 08:14:18 -0700 (PDT)
Received: by 10.187.203.14 with HTTP; Thu, 30 Oct 2008 08:14:18 -0700 (PDT)
In-Reply-To: <20081030074114.GA26926@yp-box.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99486>

Hi Eric,

Don't worry about not seeing the patch and thanks for the answer :)

Your patch works great.

Messages appear without problems on "svn log" and "git log", I haven't
found any gotcha that I know of.

The weird thing is that this problem was not found by anyone before, I
guessed there should be some people with a setup similar to mine.

Thanks again.

On Thu, Oct 30, 2008 at 8:41 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Hi James,
>
> I saw your other patch too late, I had already started working on my
> patch earlier today but got distracted by other things (being at
> GitTogether :) and lacked a stable Internet connection afterwards.
>
> Anyways, here's my version, it handles the case where the user specifies
> the --edit option to interactively edit the commit message before
> committing; and also reencodes the messages when fetching from SVN.
>
> Can you let me know if it works for you?
>
> Note: I'll be in transit tomorrow and may not have time to follow
> up on this until Saturday.
>
> From 84f003e0c39414ebf27a98de167643e95bed6abb Mon Sep 17 00:00:00 2001
> From: Eric Wong <normalperson@yhbt.net>
> Date: Wed, 29 Oct 2008 23:49:26 -0700
> Subject: [PATCH] git-svn: respect i18n.commitencoding config
>
> SVN itself always stores log messages in the repository as
> UTF-8.  git always stores/retrieves everything as raw binary
> data with no transformations whatsoever.
>
> To interact with SVN, we need to encode log messages as UTF-8
> before sending them to SVN, as SVN cannot do it for us.  When
> retrieving log messages from SVN, we also need to (attempt to)
> reencode the UTF-8 log message back to the user-specified commit
> encoding.
>
> Note, handling i18n.logoutputencoding for "git svn log" also
> needs to be done in a future change.
>
> Also, this change only deals with the encoding of commit
> messages and nothing else (path names, blob content, ...).
>
> In-Reply-To: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
> James North <tocapicha@gmail.com> wrote:
>> Hi,
>>
>> I'm using git-svn on a system with ISO-8859-1 encoding. The problem is
>> when I try to use "git svn dcommit" to send changes to a remote svn
>> (also ISO-8859-1).
>>
>> Seems like git-svn is sending commit messages with utf-8 (just a
>> guessing...) and they look bad on the remote svn log. E.g. "Ca?\241a
>> de cami?\243n"
>>
>> I have tried using i18n.commitencoding=ISO-8859-1 as suggested by the
>> warning when doing "git svn dcommit" but messages still are sent with
>> wrong encoding.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl                           |   24 ++++++++-
>  t/t9129-git-svn-i18n-commitencoding.sh |   80 ++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 3 deletions(-)
>  create mode 100755 t/t9129-git-svn-i18n-commitencoding.sh
>
> diff --git a/git-svn.perl b/git-svn.perl
> index f90ddac..f24559c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1136,9 +1136,19 @@ sub get_commit_entry {
>                system($editor, $commit_editmsg);
>        }
>        rename $commit_editmsg, $commit_msg or croak $!;
> -       open $log_fh, '<', $commit_msg or croak $!;
> -       { local $/; chomp($log_entry{log} = <$log_fh>); }
> -       close $log_fh or croak $!;
> +       {
> +               # SVN requires messages to be UTF-8 when entering the repo
> +               local $/;
> +               open $log_fh, '<', $commit_msg or croak $!;
> +               binmode $log_fh;
> +               chomp($log_entry{log} = <$log_fh>);
> +
> +               if (my $enc = Git::config('i18n.commitencoding')) {
> +                       require Encode;
> +                       Encode::from_to($log_entry{log}, $enc, 'UTF-8');
> +               }
> +               close $log_fh or croak $!;
> +       }
>        unlink $commit_msg;
>        \%log_entry;
>  }
> @@ -2273,6 +2283,14 @@ sub do_git_commit {
>        }
>        defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
>                                                                   or croak $!;
> +       binmode $msg_fh;
> +
> +       # we always get UTF-8 from SVN, but we may want our commits in
> +       # a different encoding.
> +       if (my $enc = Git::config('i18n.commitencoding')) {
> +               require Encode;
> +               Encode::from_to($log_entry->{log}, 'UTF-8', $enc);
> +       }
>        print $msg_fh $log_entry->{log} or croak $!;
>        restore_commit_header_env($old_env);
>        unless ($self->no_metadata) {
> diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
> new file mode 100755
> index 0000000..2848e46
> --- /dev/null
> +++ b/t/t9129-git-svn-i18n-commitencoding.sh
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Eric Wong
> +
> +test_description='git svn honors i18n.commitEncoding in config'
> +
> +. ./lib-git-svn.sh
> +
> +compare_git_head_with () {
> +       nr=`wc -l < "$1"`
> +       a=7
> +       b=$(($a + $nr - 1))
> +       git cat-file commit HEAD | sed -ne "$a,${b}p" >current &&
> +       test_cmp current "$1"
> +}
> +
> +compare_svn_head_with () {
> +       LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
> +               sed -e 1,3d -e "/^-\+\$/d" >current &&
> +       test_cmp current "$1"
> +}
> +
> +for H in ISO-8859-1 EUCJP ISO-2022-JP
> +do
> +       test_expect_success "$H setup" '
> +               mkdir $H &&
> +               svn import -m "$H test" $H "$svnrepo"/$H &&
> +               git svn clone "$svnrepo"/$H $H
> +       '
> +done
> +
> +for H in ISO-8859-1 EUCJP ISO-2022-JP
> +do
> +       test_expect_success "$H commit on git side" '
> +       (
> +               cd $H &&
> +               git config i18n.commitencoding $H &&
> +               git checkout -b t refs/remotes/git-svn &&
> +               echo $H >F &&
> +               git add F &&
> +               git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt &&
> +               E=$(git cat-file commit HEAD | sed -ne "s/^encoding //p") &&
> +               test "z$E" = "z$H"
> +               compare_git_head_with "$TEST_DIRECTORY"/t3900/$H.txt
> +       )
> +       '
> +done
> +
> +for H in ISO-8859-1 EUCJP ISO-2022-JP
> +do
> +       test_expect_success "$H dcommit to svn" '
> +       (
> +               cd $H &&
> +               git svn dcommit &&
> +               git cat-file commit HEAD | grep git-svn-id: &&
> +               E=$(git cat-file commit HEAD | sed -ne "s/^encoding //p") &&
> +               test "z$E" = "z$H" &&
> +               compare_git_head_with "$TEST_DIRECTORY"/t3900/$H.txt
> +       )
> +       '
> +done
> +
> +test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
> +(
> +       cd ISO-8859-1 &&
> +       compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
> +)
> +'
> +
> +for H in EUCJP ISO-2022-JP
> +do
> +       test_expect_success '$H should match UTF-8 in svn' '
> +       (
> +               cd $H &&
> +               compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
> +       )
> +       '
> +done
> +
> +test_done
> --
> Eric Wong
>
