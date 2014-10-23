From: =?UTF-8?Q?=C3=89ric_Alber?= <eric.alber@gmail.com>
Subject: Re: [BUG] Possible issue with word-diff option
Date: Thu, 23 Oct 2014 22:01:40 +0200
Message-ID: <CAGDZK6ET+jG15FTCdg5GuxbBZS5Lt_gvnH1TitAtnH6-4KBOtA@mail.gmail.com>
References: <CAGDZK6HVevTPXVcwhHvmwdv9LZKzcv-3j-tBNV60tvhMuMhKtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 22:01:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhOZu-0004Zc-6C
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 22:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbaJWUBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2014 16:01:42 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52194 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbaJWUBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2014 16:01:41 -0400
Received: by mail-wi0-f180.google.com with SMTP id em10so2987146wid.7
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=LtKZj5sg56m9lay7h+neSvcu+tPSR/EFG87jCbJh/CQ=;
        b=IPyHWea94aNdAQaUUdC4bVi5d60LrlQKUnULaOUqG9quRZQUSvrFctVBML0LNljj2o
         toF+FLWwFpzlcBujfY39EHcZYDciKkf4iOIQ/BAkc4dgf8D92oMcWlo1isaohzvWozSE
         IN1bERiSsxqkCFJtWophvJTj+TcYTnZek3HqCML96ppC2PjztcUWLd6AAHkwbUgNFYgs
         ru+gXz8kbtVtVqtiD7LI6gOb4iPNwXQTNZJmwgpvV9lYfyOP8pky0eIjQkmmnsnMaTbm
         VfmyP4gTefmkg8BTABwlIbmi1KkutDna60+yhYgSY2vLoMYjPcvniWHs2ijFKse2Xeo6
         vY1A==
X-Received: by 10.180.82.105 with SMTP id h9mr14902233wiy.62.1414094500403;
 Thu, 23 Oct 2014 13:01:40 -0700 (PDT)
Received: by 10.217.136.7 with HTTP; Thu, 23 Oct 2014 13:01:40 -0700 (PDT)
In-Reply-To: <CAGDZK6HVevTPXVcwhHvmwdv9LZKzcv-3j-tBNV60tvhMuMhKtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to mention the version :
I tested with Ubuntu's git 1.9.1 and a 2.1.0 version I built myself

2014-10-23 20:54 GMT+02:00 =C3=89ric Alber <eric.alber@gmail.com>:
> Hi,
>
> I'm currently developing a local web based GUI for git in the same
> fashion as mercurial's 'hg serve': git-webui
> (https://github.com/alberthier/git-webui)
> I tried to add word-diff highlighting in my diff visualization panels=
=2E
> I used the '--word-diff=3Dporcelain' option of 'git show' and 'git
> diff'.
>
> Unfortunately I ran into an issue so I want to make sure I understand
> properly the format
> Here is how I interpret this output:
> - A line of the diff no longer corresponds to a line in the source
> file. A line of the source file, is represented between two leading
> '~' markers
> - A line starting with a '+' or '-' is respectively an added or
> removed line fragment
> - A line starting with a ' ' (space) is an unchanged line fragment
>
> The problem is visible with the git-webui repository itself:
>
> git clone https://github.com/alberthier/git-webui
> git show --word-diff=3Dporcelain ed934a7            # This is the hea=
d
> of the 'word-diff' branch
> # search for the first occurrence of 'fragment'
>
> In the source code, several lines have been replaced with the
> following single line:
>
>          var fragment =3D line.substr(1);
>
> But in the diff, 'fragment' and 'line.substr(1);' don't apprear in th=
e
> same '~' block.
> I get:
>
> ~
>          var
> -pre
> +fragment
>   =3D
> -$('<pre class=3D"diff-view-line">').appendTo(view)[0];
> ~
> [ some removed lines....]
> ~
> -        }
> +line.substr(1);
> ~
>
> By reading this output, it looks like 'var fragment =3D ' and
> 'line.substr(1);' aren't on the same line.
> I would have expected:
>
> ~
>          var
> -pre
> +fragment
>   =3D
> -$('<pre class=3D"diff-view-line">').appendTo(view)[0];
> +line.substr(1);
> ~
> [ some removed lines....]
>
> Is there something I miss or is this a bug of git's word-diff algorit=
hm ?
>
> Regards,
>
> Eric
