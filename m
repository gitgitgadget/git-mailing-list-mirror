From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] send-email: expand paths in sendemail.{to,cc}cmd config
Date: Mon, 23 Nov 2015 19:04:46 -0500
Message-ID: <CAPig+cRY3W4VMgqnRuQFeMk7oueKsA=ZhMAk15LLyZg0KfVvCA@mail.gmail.com>
References: <cover.1447797487.git.john@keeping.me.uk>
	<db0b817c4be57635248a48a529a32719ad232f02.1447797487.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Nov 24 01:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a116I-0003YN-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 01:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbbKXAEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 19:04:48 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33820 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbKXAEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 19:04:47 -0500
Received: by vkbs1 with SMTP id s1so614744vkb.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Z8IDo/CmjWxCK6vIab1LBXWU7Zrrp2rMd/8QLPMDE6g=;
        b=Okm/UOIfyJg2TDBnj58gHw2/OxCQj7EKBqaC8QvDplfdgITEzeayn6RHFoftD9ARIh
         xuB9pth/TPwnqlBMn4Yq4PZUirwAjSK3VvHZ4G0GM6TFgVol8ecjhfXrJPn6yqiJ+e1c
         7gZdHnwbdY2T9RVmJIHEcr4Zvsq+ovVB9/L8rOeGxapHAa23SrbkrQaiNWi6zPpHACi+
         P8CA/JKj3lYPKvSqaZBeswgJKO4rLhvdSy/PXnPJh6d5HXOf1Gc2T5SH8Zbt6oLIhKvl
         tygvSIwbB2Ux3lK2JB8mc2x/41JoVqsomk0K09sYkkr1l6Mqg7YSie3/WeOLDtc+3MGp
         R/Hw==
X-Received: by 10.31.134.3 with SMTP id i3mr22736506vkd.14.1448323486403; Mon,
 23 Nov 2015 16:04:46 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 23 Nov 2015 16:04:46 -0800 (PST)
In-Reply-To: <db0b817c4be57635248a48a529a32719ad232f02.1447797487.git.john@keeping.me.uk>
X-Google-Sender-Auth: YP0K5LmCEIjzFgmh3EgHVZMRRhs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281603>

On Tue, Nov 17, 2015 at 5:01 PM, John Keeping <john@keeping.me.uk> wrote:
> These configuration variables specify the paths to commands so we should
> support tilde-expansion for files inside a user's home directory.

Hmm, I don't see anything in the documentation which says that these
are paths to commands, and the code itself treats them purely as
commands to be invoked, not as paths to commands. What is the
behavior, for instance, with --tocmd='foobar -x zopp' or even
--tocmd='foobar -x ~/zopp'?

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 719c715..8e4c0e1 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -242,9 +242,7 @@ my %config_settings = (
>      "smtpdomain" => \$smtp_domain,
>      "smtpauth" => \$smtp_auth,
>      "to" => \@initial_to,
> -    "tocmd" => \$to_cmd,
>      "cc" => \@initial_cc,
> -    "cccmd" => \$cc_cmd,
>      "aliasfiletype" => \$aliasfiletype,
>      "bcc" => \@bcclist,
>      "suppresscc" => \@suppress_cc,
> @@ -259,6 +257,8 @@ my %config_settings = (
>  my %config_path_settings = (
>      "aliasesfile" => \@alias_files,
>      "smtpsslcertpath" => \$smtp_ssl_cert_path,
> +    "tocmd" => \$to_cmd,
> +    "cccmd" => \$cc_cmd,
>  );
