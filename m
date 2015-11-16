From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] completion: add support for completing email aliases
Date: Mon, 16 Nov 2015 18:33:10 -0500
Message-ID: <CAPig+cST4iGdv0B91C_sWs85OMyw5c77ivjZ50xkbF+_uTr1YA@mail.gmail.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	<1447618940-27446-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:33:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTGu-0002cD-F4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbKPXdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:33:12 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35482 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbKPXdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:33:11 -0500
Received: by vkas68 with SMTP id s68so172994vka.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 15:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NiEXQKU3Rgb2N0IhsIKqf/SJgSxIcNOMYyN/BQWfTRk=;
        b=O+wMWBKsKmgGEdXSij+DK2x3nnH5ybKAXls5RIfM4sgNGkIMhpiVs9N08gPRST3AOD
         dpZcVL06ryY4bC7hWxZyPaEn4FD52s9vZP5GqSzwHjKXBOiCAeH4l1iZN/ULnYY19suo
         kujJN5VMLXAv3HCjqv0MthgTI4YlYDQpYATCRRs5/QXakLee845/1LDVFNSQh+LxvJOT
         DlxL/5XayX1fRcFjJqh1rliVrxLPFFv4KZNVVvDDWjHmevhiVLaAERg97i6LpmBRoMXO
         dIZCNmRy+SLElpxUT/exuiBnOWQvZVOBWiWg4EjTowl+jvutZDLrhuUp+ZWNtUgxS3yZ
         /ftA==
X-Received: by 10.31.159.137 with SMTP id i131mr562299vke.151.1447716790856;
 Mon, 16 Nov 2015 15:33:10 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 15:33:10 -0800 (PST)
In-Reply-To: <1447618940-27446-2-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: J59ujTwMRvNnYHjkGFXZJkzw-xU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281365>

On Sun, Nov 15, 2015 at 3:22 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Using the new --list-aliases option from git-send-email, add completion
> for --to, --cc, and --bcc with the available configured aliases.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> @@ -1711,6 +1712,15 @@ __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
>
>  _git_send_email ()
>  {
> +       case "$prev" in
> +       --to|--cc|--bcc)

What about --from, which also undergoes alias expansion?

> +               __gitcomp "
> +               $(git --git-dir="$(__gitdir)" send-email --list-aliases 2>/dev/null)
> +               " "" ""
> +               return
> +               ;;
> +       esac
> +
>         case "$cur" in
>         --confirm=*)
>                 __gitcomp "
> @@ -1735,6 +1745,12 @@ _git_send_email ()
>                         " "" "${cur##--thread=}"
>                 return
>                 ;;
> +       --to=*|--cc=*|--bcc=*)
> +               __gitcomp "
> +               $(git --git-dir="$(__gitdir)" send-email --list-aliases 2>/dev/null)
> +               " "" "${cur#--*=}"
> +               return
> +               ;;
>         --*)
>                 __gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
>                         --compose --confirm= --dry-run --envelope-sender
> --
> 2.6.3.491.g3e3f6ce
