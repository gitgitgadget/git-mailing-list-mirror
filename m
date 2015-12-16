From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/11] ref-filter: skip deref specifier in match_atom_name()
Date: Wed, 16 Dec 2015 16:11:28 -0500
Message-ID: <CAPig+cROdhYVW2f9ciwsMeXHNvu3BQP5bp4-no93x26dxor5cA@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:11:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9JME-0007h1-5f
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbbLPVL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:11:29 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36383 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbbLPVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:11:29 -0500
Received: by mail-vk0-f53.google.com with SMTP id y187so34527392vka.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=52NGnWZjdmD6r/wTWhwyzJKVnCxSL1nzedDHmM1JJn8=;
        b=ati8to7fzDVrcqVALPo0j/eBAdTRRpkQP4eJjurmqe+HkmFiGQhm4H3ukUAjf5OeQB
         P4eYzVSBZN5pyH2bHvsa/JM1vfRPUI1YpSsOMNb5zBXmZkceuXY2UwijDvTN7kzHxQfO
         6U9tKtIuCvkw5eJGIacsitS1/CC7yU+a92+GH/iVuvvDnmVTEmLLAKAp1z6DnOd6Oy1N
         zMVI9hCY8ETib+sufWxRgDpDtcS7RowRUuYcujOiXgYtd12D79C3CcbjWE6baiXmhq+z
         msmgoSQ1eu4HMeAuGxVBrzeYhOttDJWDRvUPxON6eTZyEpNcNxT0YBSPVZCznCZAYidQ
         IXdg==
X-Received: by 10.31.47.130 with SMTP id v124mr36406400vkv.117.1450300288457;
 Wed, 16 Dec 2015 13:11:28 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 13:11:28 -0800 (PST)
In-Reply-To: <1450279802-29414-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: WI-e8xe8Ig9qrwUtS19YJbm1b8E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282590>

On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In upcoming patches we make calls to match_atom_name() with the '*'
> deref specifier still attached to the atom name. This causes
> undesirable errors, hence, if present skip over the '*' deref
> specifier in the atom name.

I'd drop the second sentence since it doesn't add much or any value.
Instead, you might want to explain that skipping '*' is done as a
convenience.

    Subsequent patches will call match_atom_name() with the '*' deref
    specifier still attached to the atom name so, as a convenience,
    skip over it on their behalf.

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -37,6 +37,10 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>  {
>         const char *body;
>
> +       /*  skip the deref specifier*/

Too many spaces before "skip".
Too few spaces after "specifier".

> +       if (name[0] == '*')
> +               name++;
> +
>         if (!skip_prefix(name, atom_name, &body))
>                 return 0; /* doesn't even begin with "atom_name" */
>         if (!body[0]) {
> --
> 2.6.4
