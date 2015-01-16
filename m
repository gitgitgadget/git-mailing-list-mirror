From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contacts: introduce --since and --min-percent
Date: Fri, 16 Jan 2015 16:11:51 -0500
Message-ID: <CAPig+cS5is73damiYgCmWp3QzmBX+E38f26oyn2nwG0FO2AStQ@mail.gmail.com>
References: <1421441933-54183-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 22:11:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCEBR-0000TO-7H
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 22:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbbAPVLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 16:11:52 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:53200 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbAPVLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 16:11:52 -0500
Received: by mail-yh0-f48.google.com with SMTP id i57so11210684yha.7
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Gb+PwkIQpa6d6BVm7cXzmtAhXAil8RLnp3OiGQ70BkM=;
        b=htieeXY5pxK2vCSz6joNp/NSgsEEFEaVUpxULCcY/XoXGDemNaM1uRisqdjkeKQfOs
         MD5it3RiA8hQN2XvsWf8YK5YJtM5o4hPNAt3MUcpwtXMAQ5tU0YBjlyWrk7A04L1B1b7
         q0YttHyMgTUzAX6LvdqkBCXJazQQGS5GW9RgXJsM8Pr9yW08N1i/G3hnx0f6H6c4bkDu
         b23X0eWM71GPyHOipe1GZD9V89NHwVYYJEmQZerii99aiM2mFJf/YGJObGRtR4dyyDmK
         6hrjj/h0kdgdZ5sz24Mlx1P1ImXenZaHDzG1Cnt+4bHjdewrA8uxxyL99XtrPd2SquF9
         AjQw==
X-Received: by 10.170.127.5 with SMTP id t5mr12536262ykb.2.1421442711372; Fri,
 16 Jan 2015 13:11:51 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 16 Jan 2015 13:11:51 -0800 (PST)
In-Reply-To: <1421441933-54183-1-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: CzP1JWnnrEoDb3kjIO_ApRePX7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262575>

On Fri, Jan 16, 2015 at 3:58 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> index dbe2abf..b06f2e1 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -8,12 +8,16 @@
>  use strict;
>  use warnings;
>  use IPC::Open2;
> +use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;

Most of the rest of the codebase uses qw(...) rather than qw/.../.

>  my $since = '5-years-ago';
>  my $min_percent = 10;
>  my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
>  my %seen;
>
> +my $rv = GetOptions('since=s' => \$since, 'min-percent=i' => \$min_percent);
> +exit 1 if (!$rv);

This would make more sense if moved down to the point where the script
arguments are processed (just before the 'if (!@ARGV)' line, for
instance).

These new options should be documented in git-contacts.txt. Also, the
"Limitations" section of the documentation says that these values are
currently hard-coded, so it deserves an update as well.

>  sub format_contact {
>         my ($name, $email) = @_;
>         return "$name <$email>";
> --
> 2.2.1
