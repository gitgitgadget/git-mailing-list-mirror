From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] send-email: detect and offer to skip backup files
Date: Tue, 12 Apr 2016 16:05:21 -0700
Message-ID: <CAGZ79kZ+_JW-5BWdXse++_KaATO+qDhNtTz_k5gX507sObZyzA@mail.gmail.com>
References: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:05:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7N8-0003t4-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934405AbcDLXFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:05:23 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35416 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933719AbcDLXFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:05:22 -0400
Received: by mail-io0-f175.google.com with SMTP id g185so48465742ioa.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=bc3008Xlrh3EPKZScPbzi+P5sDykNp2CwPVjXBBixG0=;
        b=Ckjpjj7Dux+E3erGYirxIkVlXwwNtWwuK9eWdWVBOmeQ1RBxN2WlGudQnFiDId6qaz
         VJyQx3Hzvq3jxeiWO3nuJYAMmZDRz6J7VJZVj8ZCxpwL0CEoxCkHrvFCgtQv5dfYU+mC
         eFeilooz0ILaGXQt2oVfTsp3mmKx4PFHvbxCbhGTJSH3TdkLGFppWSaimnYMp1Bmo+Ei
         8SJhcNcjlKNfBU3LQ7fxRgQIVYZZPQyG32p4uJZ/eYsMJB+CRywenF1YeUzXj781fzdr
         Nu2o22x4lEo+4xG97D/qeXJA2KoF6L6F+8U8AFITKfDf4Ef2BUKBzGsDI5I9gCP3g7Lt
         YXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bc3008Xlrh3EPKZScPbzi+P5sDykNp2CwPVjXBBixG0=;
        b=NCz/x/IA21Legklyw7ashBO1l8ZKDv6TcHYoZTYa2DjEiLdGr/hn5/n+nGFV6oLV5q
         YZI6Y6Bm+lQmxudveFkXg+6T4Yt32tPPTwDipmSIggQs6sx8XXbHuoASFgMKdV7UySnY
         lTsdhXp7eOWm3ly56jorPJuRahB9r/AScSU0Rhtnkbn8RHkPLtcGdAFeWY3B1xXa9KiA
         5hcMqOQ6xuzfVtEKHqrXaRbJMbRQfVC+ylrQlT6UtkmsHsswvBGdj5Ms3irSVoqaN++6
         q58UZokIn6i470c0N2qTdhmAgGDCVkkPArczmioNNxErJUwhTs17E8EkzamkcDDAs6L4
         0LJg==
X-Gm-Message-State: AOPr4FUJFCVmYiqlcfSow13gQ2Tfb/bkwjqkgAVbU96MtfQm3jG9tcD33Rhf2OM5MVnBhDMJrxVZL57KrR3j9ze8
X-Received: by 10.107.184.8 with SMTP id i8mr6758183iof.96.1460502321135; Tue,
 12 Apr 2016 16:05:21 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 12 Apr 2016 16:05:21 -0700 (PDT)
In-Reply-To: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291316>

On Tue, Apr 12, 2016 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Diligent people save output from format-patch to files, proofread
> and edit them and then finally send the result out.  If the
> resulting files are sent out with "git send-email 0*", this ends up
> sending backup files (e.g. 0001-X.patch.backup or 0001-X.patch~)
> left by their editors next to the final version.  Sending them with
> "git send-email 0*.patch" (if format-patch was run with the standard
> suffix) would avoid such an embarrassment, but not everybody is
> careful.
>
> After collecting files to be sent (and sorting them if read from a
> directory), notice when the file being sent out has the same name as
> the previous file, plus some suffix (e.g. 0001-X.patch was sent, and
> we are looking at 0001-X.patch.backup or 0001-X.patch~), and the
> suffix begins with a non-alnum (e.g. ".backup" or "~") and ask if
> the user really wants to send it out.  Once the user skips sending
> such a "backup" file, remember the suffix and stop asking the same
> question (e.g. after skipping 0001-X.patch~, skip 0002-Y.patch~
> without asking).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Just something I had lying around in my tree...

I think that is a valid use case. (Save the user from embarrassment).
Although I admit to being even more stupid than that.

Once I made the mistake to not remove a previous patch series I had,
such that there was:

  0000-coverletter.patch (newly worded)
  0001-bla-from-new-series
  0001-foo-from-old-series
  0002-...
  ...

`git send-email 0*` then sent out a totally bogus series for me.

As another user friendly helper we could warn/abort if the first <n> characters
are the same as the previous patch as well?

>
>  git-send-email.perl | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d356901..74ed01a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -621,6 +621,8 @@ sub is_format_patch_arg {
>         push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
>  }
>
> +@files = handle_backup_files(@files);
> +
>  if ($validate) {
>         foreach my $f (@files) {
>                 unless (-p $f) {
> @@ -1726,6 +1728,44 @@ sub validate_patch {
>         return;
>  }
>
> +sub handle_backup {
> +       my ($last, $lastlen, $file, $known_suffix) = @_;
> +       my ($suffix, $skip);
> +
> +       $skip = 0;
> +       if (defined $last &&
> +           ($lastlen < length($file)) &&
> +           (substr($file, 0, $lastlen) eq $last) &&
> +           ($suffix = substr($file, $lastlen)) !~ /^[a-z0-9]/i) {
> +               if (defined $known_suffix && $suffix eq $known_suffix) {
> +                       print "Skipping $file with backup suffix '$known_suffix'.\n";
> +                       $skip = 1;
> +               } else {
> +                       my $answer = ask("Do you really want to send $file? (y|N): ",
> +                                        valid_re => qr/^(?:y|n)/i,
> +                                        default => 'y');
> +                       $skip = ($answer ne 'y');
> +                       if ($skip) {
> +                               $known_suffix = $suffix;
> +                       }
> +               }
> +       }
> +       return ($skip, $known_suffix);
> +}
> +
> +sub handle_backup_files {
> +       my @file = @_;
> +       my ($last, $lastlen, $known_suffix, $skip, @result);
> +       for my $file (@file) {
> +               ($skip, $known_suffix) = handle_backup($last, $lastlen,
> +                                                      $file, $known_suffix);
> +               push @result, $file unless $skip;
> +               $last = $file;
> +               $lastlen = length($file);
> +       }
> +       return @result;
> +}
> +
>  sub file_has_nonascii {
>         my $fn = shift;
>         open(my $fh, '<', $fn)
> --
> 2.8.1-347-g322afaf
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
