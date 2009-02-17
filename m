From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/8] config: Reorganize get_color*.
Date: Tue, 17 Feb 2009 03:00:20 +0200
Message-ID: <94a0d4530902161700n734b1ee0p22672757b978b850@mail.gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 02:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZELW-0001Dk-8W
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 02:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZBQBAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 20:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbZBQBA2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 20:00:28 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42723 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbZBQBA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 20:00:26 -0500
Received: by bwz5 with SMTP id 5so3548219bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 17:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=29cb4gKxHi77iV2AzebuoU8wsyAi1uJ7pAMtyip4H28=;
        b=SqKJfkMVv4fh4uhIx/eg+hr/fYHkl/MfXAYXECYGrisy7arytJDvyZCtfCnlWIh7JR
         eGisp/3OTxgJgb/GdDH1bMyJfYK3bRxBkVLKmmvwj2IHhhyNZErIqfmjFoAs7XSuSXQP
         HMGuimnfNPTv9xjuxV7BGMq0HIgEuqhT+dY6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G8nZgUdiEG9G7mhkpqz/F86I+40Q6RoBTSuel8lnhAPX6idVJF4H78aYIHubwA13yj
         YnCB6sGt3sTvgaXgNBdn7MDKLcgR0YPFqzNmuEkcegy2Lj4ht1l1b71SYWMDIxY5cKS8
         +2htoNqSO1lxo1OcTb9vB+PmylBQxBYTw2qWM=
Received: by 10.223.104.140 with SMTP id p12mr1183182fao.7.1234832420986; Mon, 
	16 Feb 2009 17:00:20 -0800 (PST)
In-Reply-To: <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110286>

On Tue, Feb 17, 2009 at 2:54 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> In preparation for parseopt.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

<snip/>

> @@ -274,12 +237,11 @@ static int get_colorbool(int argc, const char **argv)
>                        get_colorbool_found = git_use_color_default;
>        }
>
> -       if (argc == 1) {
> -               return get_colorbool_found ? 0 : 1;
> -       } else {
> +       if (print) {
>                printf("%s\n", get_colorbool_found ? "true" : "false");
>                return 0;
> -       }
> +       } else
> +               return get_colorbool_found ? 0 : 1;
>  }

<snip/>

>                } else if (!strcmp(argv[1], "--get-colorbool")) {
> -                       return get_colorbool(argc-2, argv+2);
> +                       if (argc == 4)
> +                               stdout_is_tty = git_config_bool("command line", argv[3]);
> +                       else if (argc == 3)
> +                               stdout_is_tty = isatty(1);
> +                       else
> +                               usage(git_config_set_usage);
> +                       get_colorbool_slot = argv[2];
> +                       return get_colorbool(argc == 3);

Agh, crap, that should be argc != 3. Anyway, the next patch does it properly.

-- 
Felipe Contreras
