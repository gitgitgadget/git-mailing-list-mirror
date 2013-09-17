From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contacts: allow execution from other directories
Date: Tue, 17 Sep 2013 12:44:02 -0400
Message-ID: <CAPig+cTgfE_Lo2B50fy6rYOmfmb2O9wOZZfasTwt_Lx0k2KOOw@mail.gmail.com>
References: <1379422246-12818-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLyNl-0006jn-O6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab3IQQoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:44:05 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:38459 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab3IQQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:44:04 -0400
Received: by mail-la0-f51.google.com with SMTP id lv10so4562315lab.38
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=r+VLtRuMwqnPcxhXC9AsDEyukBCAz5cfN/M1M42qpiE=;
        b=DbDVbTGpvTbR8mEuuXEEjZXyY72a9rOQq/9oBkKiWTucMaF5UIJ6pH4FOQmKMBouyz
         mPHuk5OCM3i5LY8CVVVqk7RsrECOnY7Rdm0d1c1HHsx5c1rIfUm2H5+YxHf2qhd0oPQ6
         pzg60jdAtYQqMi5+O1KasQn8HT1TR//wMEiVlSfzZ3IpeL173ICGSTT9qdCB2mUYtmg6
         YcYmJdOlTDiy+PkzQuJuJNOj+OCaNw0MJ2Du7MzvFWn7nh80rfXZBWebjQA6tczOpIx2
         eJ0UraYLv33/+1RC7u41B4KmKyACv+1GOVT3u3MWPWet2qGam4b94g5JPdWwNSx3fIHP
         hSTA==
X-Received: by 10.112.210.136 with SMTP id mu8mr11411715lbc.25.1379436242641;
 Tue, 17 Sep 2013 09:44:02 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 17 Sep 2013 09:44:02 -0700 (PDT)
In-Reply-To: <1379422246-12818-1-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: -jGyBNOK7JXFXH64MlRFqG0E7Xs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234888>

On Tue, Sep 17, 2013 at 8:50 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently git-contacts only works if it is executed from the top level
> of the git repository.  Enable the execution in sub directories of that
> repository.

Thanks. This was on my to-do list but fell off my radar when I
accidentally deleted the to-do list (which, oddly, was not under
version control).

I have a patch in my local tree accomplishing the same thing, but in a
less expensive manner. I'll post it a bit later today for review.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> I have no experience in perl, so there may be nicer implementations.  It works when tested manually.
>
>  contrib/contacts/git-contacts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> index fb6429b..32f03fc 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -61,6 +61,9 @@ sub import_commits {
>  sub get_blame {
>         my ($commits, $source, $from, $ranges) = @_;
>         return unless @$ranges;
> +       my $git_dir = `git rev-parse --show-toplevel`;
> +       chomp($git_dir);
> +       $source = $git_dir . '/' . $source;
>         open my $f, '-|',
>                 qw(git blame --porcelain -C),
>                 map({"-L$_->[0],+$_->[1]"} @$ranges),
> --
> 1.8.4.535.g7b94f8e.dirty
>
