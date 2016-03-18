From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Fri, 18 Mar 2016 01:58:15 -0400
Message-ID: <CAPig+cRp3ghX8VUvR8Tfb6rsnbOM4eQiQ8Hw1hs4=BvXORREYA@mail.gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
	<1458219254-16343-1-git-send-email-pclouds@gmail.com>
	<xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Dm3_w6TT6FP-my9fsRJ8F+StK8dBPid9zxQv4OzoZfcw@mail.gmail.com>
	<xmqqbn6cs5sa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Durham Goode <durham@fb.com>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:00:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnS1-00035p-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbcCRF6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:58:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34689 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbcCRF6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:58:16 -0400
Received: by mail-vk0-f68.google.com with SMTP id e6so8733757vkh.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=FE0ojNrHVYx/wOic0PJ4wIpNNW4mvcyzsLf7yY1fbD4=;
        b=LWIMgWrQuLTSaplxDTT1hZ3RmtJFKzBUCRJwAIIwYZXw6U4d5Kf6vavUU62mSaGmue
         qoi2rr0vttgfGAgsSiiO1BIv85LtwpPNanI2RW7c+FjLDViAeBmIracKzhtx7KSXS2QJ
         /JzqtSz/5eECNqsF8249DRQSGbwn0sncdv/Ugc0VfwhcE+poPZlM8P1JR0+/Q5G1RBRo
         uGuWwu5MUJk54l9h8FwoLI1162CYcaas26/+t+vH2volBQWsNNjmK0t5dy3rrim80uBS
         iSPoFV2P3l2A+jSRlCZjvPHJkhcPSUo3GbIeVZzVFB7j9l+LiC/NgdZtVFUW9VYO5ZFK
         mZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FE0ojNrHVYx/wOic0PJ4wIpNNW4mvcyzsLf7yY1fbD4=;
        b=AUTlSyXiFvDHVRa/skL8W06hnbra5uChHm33EbaH9KBIHXkBYLtATYkZY7hWlcnGE5
         ne6I9cWvZ4bBJEw5/YpMwNAo7EmWxdyMfTmTgX66vG4pOEaZdAzTf6cw3AnMwqo0t/0O
         DdHnO9S1btfTj1Cu/LVgI3og6TALeHaoJt3SY7XXPugWiBPLVdbg0gX4UekvlXTSN4D8
         Pfhk+3b9mzQM8QFXd/OuoXS8KCAEyhAZm0QYrvfjdKudVkyTc6noSGuREKP1V7DiV8G4
         zJXIrfWGfcUkQfPwa5hwUlvza32VjFIqXjHa8WbbaYBQDtllZp/ryNEJ1T2PaDCMU6ij
         m+mw==
X-Gm-Message-State: AD7BkJKwCWllNOr/KVnu2Qux5cCcUYVF1R7hfX/BFe4yufBE+QKPRw8voHIZQtQTfh2Tdq+erGe76T+JC8xLmw==
X-Received: by 10.31.146.5 with SMTP id u5mr9217206vkd.19.1458280695508; Thu,
 17 Mar 2016 22:58:15 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 22:58:15 -0700 (PDT)
In-Reply-To: <xmqqbn6cs5sa.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: RGePShjOYKtkebP0fuo4-Pjz3Us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289197>

On Fri, Mar 18, 2016 at 1:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
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
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -1726,6 +1728,44 @@ sub validate_patch {
> +sub handle_backup {
> +       my ($last, $lastlen, $file, $known_suffix) = @_;

Is $lastlen a micro-optimization or does it have some other purpose
I'm overlooking?

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

Is this 'default' correct or am I reading the code incorrectly?

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
