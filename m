From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] completion: add completer for status
Date: Fri, 28 Jun 2013 18:50:02 +0530
Message-ID: <CALkWK0=pyzcx-rB9gjRecoD1MFkHrSdYwLurD8y805O3FwT4Cg@mail.gmail.com>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
 <20130628102936.GA16562@goldbirke> <20130628105601.GB16562@goldbirke> <20130628112631.GC16562@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 28 15:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsYbY-0005vU-JX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 15:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab3F1NUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 09:20:44 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:40747 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab3F1NUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jun 2013 09:20:44 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so4187473ied.0
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EATM1yaQ5M1Bv/Yusc6VS8W5ErHjd+7RuS9IEt+e16s=;
        b=0JVRB9cBSDBsycyP3rKaWMrcQtT22G0bmE5VjQTYsrLXqYAy4Wj9UKnOEK08lhU0Ls
         DlqzzSOD2/o01MqOvi/6l+/ZWVVBmJluFxiJryPklMZdvYdpsq3aWXmc/PGcgjM4MPhv
         YxXTGFFu8No2/xjN2G/q0724C2dpEOTAwhXrZQlbx+NOgb+kDx6eHITBigrop39SAt26
         s0JT0vihM4Wa4RtDCiHImHUO48cX5hC7v5i42SFGnmm5hbyWX7kSdmSDDQu35x+5BrBg
         QaIRT+0y/IR3Jc8Du89be0RH8UG8vFzeI1W/hi1xYlP2k6lVeJcwMAguxp5JiD7sryjW
         hZGw==
X-Received: by 10.50.72.73 with SMTP id b9mr3628654igv.50.1372425643717; Fri,
 28 Jun 2013 06:20:43 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 28 Jun 2013 06:20:02 -0700 (PDT)
In-Reply-To: <20130628112631.GC16562@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229195>

SZEDER G=C3=A1bor wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 912fb988..b68024c6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1697,6 +1697,8 @@ _git_stage ()
>
>  _git_status ()
>  {
> +       __git_has_doubledash && return
> +

This line makes absolutely no sense to me.  When the case statement
fails to match anything (which it will, when a double-dash is
present), we'll use the __git_complete_index_file which is superior to
returning and falling back to the dumb zsh file listing, no?  As a
result, without that line,

  $ git status -- foo<TAB>

will complete fine when foo* isn't necessarily a file in the
filesystem, but something that our ls-files returns, no?

>         case "$cur" in
>         --untracked-files=3D*)
>                 __gitcomp "no normal all" "" "${cur##--untracked-file=
s=3D}"
> @@ -1718,7 +1720,7 @@ _git_status ()
>                 return
>                 ;;
>         esac
> -       __git_complete_index_file
> +       __git_complete_index_file "--with-tree=3DHEAD --cached --dele=
ted"

Might as well go all the way with  "--cached --deleted --unmerged
--others" no?  What is the point of --with-tree=3DHEAD?

Thanks.
