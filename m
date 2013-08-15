From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] send-email uses contacts to propose recipients
Date: Thu, 15 Aug 2013 18:28:22 -0400
Message-ID: <CAPig+cSZFU4oBuJCSXC+0Mgjegh4MzWCsDqdRYPLtwazwhy--Q@mail.gmail.com>
References: <1376605069-525-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mst@kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	bebarino@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA61s-0000a3-93
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab3HOW2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:28:24 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:59946 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab3HOW2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:28:24 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so977450lab.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KQ0IDROG47Sytv0jKbSNwgiKMxmUnZg3gVY4Oeo1vvQ=;
        b=e2nAep8X2v+JzqY0xEJbsEvwGf23FniaV4/C/CM+6L/FypHAJ1nSoe9S12N5o3I8PD
         Hn1WnrMQK4rsBnuRlFzsiE//AexcfhRjKgKesvFu4oqweky3I9wN3GdlTGqTyNuvJ27s
         onjBUevVvVozMoA3ZzbSL770C5GzwCpsmpn7VoZ9iDBusosSTBCSARsfC5ANzGGQxno5
         i3YP1bCads4XDVbB8xvx4L3HtVOpiVA9vDzRpvH/9Ao7cNweTDV/ZxqlxxH6JPYvje18
         JIQY4aJDLnjDQwUA45qJZi2LnqYidE2nq24Rm1A41AJ/lJ5hcQzDZjrQFNMzLc3/ual9
         mBRA==
X-Received: by 10.112.9.195 with SMTP id c3mr3514976lbb.33.1376605702691; Thu,
 15 Aug 2013 15:28:22 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 15 Aug 2013 15:28:22 -0700 (PDT)
In-Reply-To: <1376605069-525-1-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: ePBGMlKprk4wwywwYqRS6HtX8Hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232380>

On Thu, Aug 15, 2013 at 6:17 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> I have got an idea regarding the send-email. If there are no recipients
> given, it could propose recipients using the new 'git contacts'
> This would help people new to projects to not forget people, who may have
> the most knowledge reviewing that specific patch.

You can already do this with git-send-email's --cc-cmd option or
sendmail.cccmd configuration variable.

> Unfortunately I cannot read/write perl, so I cannot solve it
> myself in the near future, but I'd put it on my todo list for later.
> ---
>  git-send-email.perl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2162478..a34723d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -757,6 +757,12 @@ $sender = sanitize_address($sender);
>
>  my $prompting = 0;
>  if (!@initial_to && !defined $to_cmd) {
> +       if (git contacts is available) {

git-contacts is very slow, so at the very least you would want to
prompt before invoking it.

> +               proposed senders = git contacts on the same range or set of patches
> +               print "Suggesting these receivers:\n"
> +               print proposed senders
> +       }
> +
>         my $to = ask("Who should the emails be sent to (if any)? ",
>                      default => "",
>                      valid_re => qr/\@.*\./, confirm_only => 1);
> --
> 1.8.4.rc3.1.gc1ebd90
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
