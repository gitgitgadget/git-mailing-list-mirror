From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 1/5] command-list: prepare machinery for upcoming
 "common groups" section
Date: Thu, 21 May 2015 09:48:49 -0400
Message-ID: <CAPig+cTV2pm5+76H_jh0WBJ-NeOOP=aMOAwg7kmdp_dqO1LV+w@mail.gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432213989-3932-2-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 15:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQqG-0005TS-9G
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbbEUNsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 09:48:53 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37202 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbEUNsu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 09:48:50 -0400
Received: by igbsb11 with SMTP id sb11so8859289igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=YsjTHMGTRZsE2BRHxCQDmd92TWSRrMs+xWjUYLRKJ7I=;
        b=vqFGuP+44+P1GD12z+V/mzS1cIT3QDp+g+neuEdhQ1nZtMMy1Ypp9d+RYZknMdT0L3
         eBEfWCFxmHr/QyuWDJa4FGsHHUXcTd484Q39jEBYM6mWi/2LszShuJQPvp7l2Sc897NF
         F10vC32XfgDinMZ9nILWQvdARsop0QU0VqJFK+hkfd+5iD+9sVfUqWbCc7qDNblJGwF4
         UbcRLngLCc+ottYaPg27eJlXCNDBiKo82WUeUF0MVwape278GlyEbwbfwre+9jhJ/gV4
         dHIOyEPd6krpT0knHv0O82blDXMdNOyn8xa+1ej5C43uS96jzm6dm7RLRsDZE+idkFZA
         QvXQ==
X-Received: by 10.107.31.134 with SMTP id f128mr3447029iof.19.1432216129872;
 Thu, 21 May 2015 06:48:49 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 06:48:49 -0700 (PDT)
In-Reply-To: <1432213989-3932-2-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: vue53slgeww7q2QZis3EmCk4jKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269592>

On Thu, May 21, 2015 at 9:13 AM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> The ultimate goal is for "git help" to classify common commands by
> group. Toward this end, a subsequent patch will add a new "common
> groups" section to command-list.txt preceding the actual command list=
=2E
> As preparation, teach existing command-list.txt parsing machinery, wh=
ich
> doesn't care about grouping, to skip over this upcoming "common group=
s"
> section.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.per=
l
> index 04f9977..5aa73cf 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -38,6 +38,10 @@ sub format_one {
>         }
>  }
>
> +while (<>) {
> +       last if /^### command list/;
> +}
> +
>  my %cmds =3D ();
>  for (sort <>) {
>         next if /^#/;
> diff --git a/Documentation/howto/new-command.txt b/Documentation/howt=
o/new-command.txt
> index d7de5a3..6d772bd 100644
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
>  that categorizes commands by type, so they can be listed in appropri=
ate
>  subsections in the documentation's summary command list.  Add an ent=
ry
>  for yours.  To understand the categories, look at git-commands.txt
> -in the main directory.
> +in the main directory.  If the new command is part of the typical Gi=
t
> +workflow and you believe it common enough to be mentioned in 'git he=
lp',
> +map this command to a common group in the column [common].

I think you meant to squash the documentation update into patch 2/5
where the "common groups" block is actually introduced. It doesn't
really belong in this patch which is about updating machinery in
preparation for the new block.

Also, it's now spelled "### common groups" rather than "[common]".

>  7. Give the maintainer one paragraph to include in the RelNotes file
>  to describe the new feature; a good place to do so is in the cover
> diff --git a/Makefile b/Makefile
> index 323c401..655740d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2455,7 +2455,7 @@ check-docs::
>                 esac ; \
>                 test -f "Documentation/$$v.txt" || \
>                 echo "no doc: $$v"; \
> -               sed -e '/^#/d' command-list.txt | \
> +               sed -e '1,/^### command list/d' -e '/^#/d' command-li=
st.txt | \
>                 grep -q "^$$v[  ]" || \
>                 case "$$v" in \
>                 git) ;; \
> @@ -2463,7 +2463,8 @@ check-docs::
>                 esac ; \
>         done; \
>         ( \
> -               sed -e '/^#/d' \
> +               sed -e '1,/^### command list/d' \
> +                   -e '/^#/d' \
>                     -e 's/[     ].*//' \
>                     -e 's/^/listed /' command-list.txt; \
>                 $(MAKE) -C Documentation print-man1 | \
> diff --git a/command-list.txt b/command-list.txt
> index 54d8d21..181a9c2 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,4 +1,4 @@
> -# List of known git commands.
> +### command list (do not change this line)
>  # command name                          category [deprecated] [commo=
n]
>  git-add                                 mainporcelain common
>  git-am                                  mainporcelain
> --
> 2.4.0.GIT
