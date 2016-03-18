From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Fri, 18 Mar 2016 12:51:35 +0700
Message-ID: <CACsJy8BHVJPHv-Tap8DYUYGn0NH9s2rXPfxV7FUiMyVGQMU4yQ@mail.gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com> <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
 <CACsJy8Dm3_w6TT6FP-my9fsRJ8F+StK8dBPid9zxQv4OzoZfcw@mail.gmail.com> <xmqqbn6cs5sa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Durham Goode <durham@fb.com>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:52:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnKn-0001pi-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbcCRFwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:52:09 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35761 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcCRFwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:52:07 -0400
Received: by mail-lb0-f171.google.com with SMTP id bc4so81924371lbc.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FzYp6XzxHhfoQu9vuQXPpzA2/lStCuu9RrMefYaZFcI=;
        b=F5J3YY5ZKW1E0+bljMh+wDg4j4lidZrLoQ2/f7zUsTIxA6uAd8Nbq80gI/KTxXxuvW
         hhXKHTMh7WU386uxqd5MYRxrJlInneJyiOcWEw2SN7QpxhqL+ZtAmrMmNy0Fa8uaF6nd
         dcl8NpnNA/2ML7BSN0b5h539Na4ktj5xqruvF7NliZ2GyWL+LzTWt+YuoafrOE/kaQnQ
         Gj5NcpHwUv4fwAIliEK9BHkodOhzgx2dwwtO60YjntD7BfVvgnC2TKoBtc512iHGgTDM
         f3SrAnj3pBvbQU4h6UQZNIL19LupumEoArRazpt1jY2hCIMjZBSMlrhzaNORBbtAkWUQ
         CoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FzYp6XzxHhfoQu9vuQXPpzA2/lStCuu9RrMefYaZFcI=;
        b=duCW4xo11z1afjP32bvsmzROLoKg+27VRwmsMjX5HyGn1cwVTCGPg4D42SvUM6aY8+
         yQ/s/FKOufXPzB9gcrG/ON/6XAgBQBLpwZndNj84VGdRVJw7DGo5266EpA7mYjpjPWFN
         5fk+wtVFmXHe0zwsc1uzxBbofvFbdM8O/qUZqAk6vUalPHbqHIPXRsOFPb/ISycmjZa5
         oEUHDcoFvXb5AYorNgO3U7K6v1dPA0pP5LO+ZGy2iXtRfOa9YwETrEebOznOrwOVmLLO
         6z+HmN0+zZLt3kUY59PU8xxBKU5xUY7eGMP4b+OGwqvrZSMuhOROBkzLX0iJQNMTvhPj
         aF2w==
X-Gm-Message-State: AD7BkJKOVlnhbSlpGK5UNZIz1l7T67iAyUiOGo+oEl9zZoQJoloofdsWHyGXBSpupGXxbK2If/CewGVJqlZbQQ==
X-Received: by 10.112.157.105 with SMTP id wl9mr5097076lbb.137.1458280324874;
 Thu, 17 Mar 2016 22:52:04 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 22:51:35 -0700 (PDT)
In-Reply-To: <xmqqbn6cs5sa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289196>

On Fri, Mar 18, 2016 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> send-email: detect and offer to skip backup files
>
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

The problem I see is it's hard to review the to-send list.
git-send-email does list it, but the the dashes in file names make
them really hard to split out words. Maybe highlighting can help, or
maybe we can show subject lines instead of file names.

Back to the patch, another case you can catch is when people have some
leftover patches in current dir, then 0*.patch may include unrelated
patches too. A check on patch numbering (contiguous and no duplicates)
might help.

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
-- 
Duy
