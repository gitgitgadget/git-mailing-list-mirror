From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Tue, 7 May 2013 13:17:18 -0400
Message-ID: <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org> <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 07 19:17:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZlWL-0001zi-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 19:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab3EGRRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 May 2013 13:17:40 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:48745 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3EGRRk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 13:17:40 -0400
Received: by mail-vc0-f180.google.com with SMTP id hv10so748334vcb.25
        for <git@vger.kernel.org>; Tue, 07 May 2013 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=xjkbQbinBJJ3/was/gOFYC/HhRTQ3ngiIAgRAkiuWaw=;
        b=KMHh1L9BnBEaKOvS2UAQybsD+rqQuUxlTCOgjykb2vHin/LzBd0/fP1+0ccwMVlTVP
         uk+SqtCV453bcImVoeBt3sMDsRih/Bx3ODBQGs6mPozFv33FDlUYLZSTH9MxlnrtTG8s
         uW47grD8PlwYcWsJHEp1Ypp+C+HJNeVpszTkOHskfcXxfJ5LgqpkplIiD4wXYM7oJSHX
         JnemP7Go+Nm2RJDNw735LCzlPOW+ysWyenN0qEn8jBdwAEIe2AFLdCwD1snADdjBnKvB
         ULRNqeKINpZEelR1/OhIMBKlM9XzEdLsETycVj5buH3NH+YgjrQ7a/9F904gH4YHDlrY
         xUtQ==
X-Received: by 10.220.168.202 with SMTP id v10mr1870041vcy.71.1367947059066;
 Tue, 07 May 2013 10:17:39 -0700 (PDT)
Received: by 10.220.248.79 with HTTP; Tue, 7 May 2013 10:17:18 -0700 (PDT)
In-Reply-To: <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223588>

I just did git rebase origin/master for the umpteenth time, which
reminded me this nice patch is still pending.

ping?



m

On Thu, Jun 14, 2012 at 2:34 PM, Zbigniew J=EAdrzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> From: Martin Langhoff <martin@laptop.org>
>
> git log -G'regex' is a very usable alternative to the classic
> pickaxe. Minimal patch to make it usable from gitk.
>
> [zj: reword message]
> Signed-off-by: Zbigniew J=EAdrzejewski-Szmek <zbyszek@in.waw.pl>
> ---
> Martin's off on holidays, so I'm sending v2 after rewording.
>
>  gitk-git/gitk | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 22270ce..24eaead 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2232,7 +2232,8 @@ proc makewindow {} {
>      set gm [makedroplist .tf.lbar.gdttype gdttype \
>                 [mc "containing:"] \
>                 [mc "touching paths:"] \
> -               [mc "adding/removing string:"]]
> +               [mc "adding/removing string:"] \
> +               [mc "with changes matching regex:"]]
>      trace add variable gdttype write gdttype_change
>      pack .tf.lbar.gdttype -side left -fill y
>
> @@ -4595,6 +4596,8 @@ proc do_file_hl {serial} {
>         set gdtargs [concat -- $relative_paths]
>      } elseif {$gdttype eq [mc "adding/removing string:"]} {
>         set gdtargs [list "-S$highlight_files"]
> +    } elseif {$gdttype eq [mc "with changes matching regex:"]} {
> +       set gdtargs [list "-G$highlight_files"]
>      } else {
>         # must be "containing:", i.e. we're searching commit info
>         return
> --
> 1.7.11.rc3.129.ga90bc7a.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
