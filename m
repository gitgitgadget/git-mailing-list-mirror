From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 17:40:23 +0200
Message-ID: <517BF167.7090300@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>	<517BB798.4070703@gmail.com>	<CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com> <CAMP44s3h43S=A7+QEWuv0iefxbXyKZsiJ2QMdc-XiouoO3yYng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 17:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW7En-00005J-6m
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 17:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab3D0Pk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 11:40:29 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:59232 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab3D0Pk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 11:40:28 -0400
Received: by mail-ee0-f52.google.com with SMTP id d41so2051764eek.39
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=3Bjr2JWlnh56Qd/p2WJFWuHreOe8Lb+S45sWnQNNY5Y=;
        b=iyclH+EyRkvqH1XKq23/Ai3c6KNBwXGriYtmkAbonGNd4FTFCuq1/DlwzJ4HqWak96
         hPahwDhL5Av0kTXpRsZcUlAw2eUtPI0kGoKtbHVgtCYaP+0zcX/L+8ph773lyP+bCnRs
         lk6kw5rpVPjPl0yt1g4cFNwsOB7HOIz2V9u8XwIr4AeLvBOHWckpb6n8U0373806ckCd
         c560KFf6HEEpxp2aVLFLRC0pRntczGKeBeMgL8ueX+3zBb71QTdrnYUKtRg8iwBw1/YU
         iKcXkOQDzhRt1Kl02bn2RH3VRBazmudul0VSY/DNr5dwU+rmO58ERlcHKDBbYs3V91uu
         IqaQ==
X-Received: by 10.14.182.72 with SMTP id n48mr101565825eem.3.1367077226982;
        Sat, 27 Apr 2013 08:40:26 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.212.83])
        by mx.google.com with ESMTPSA id b5sm22348708eew.16.2013.04.27.08.40.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 08:40:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <CAMP44s3h43S=A7+QEWuv0iefxbXyKZsiJ2QMdc-XiouoO3yYng@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222657>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 27/04/2013 15:07, Felipe Contreras ha scritto:
> [...]
> This should do the trick. No?
> 
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -262,16 +262,17 @@ __git_ls_files_helper ()
>  #    If provided, only files within the specified directory are listed.
>  #    Sub directories are never recursed.  Path must have a trailing
>  #    slash.
> +# 3. Compat mode; set to enable.
>  __git_index_files ()
>  {
> -       local dir="$(__gitdir)" root="${2-.}" file
> +       local dir="$(__gitdir)" root="${2-.}" file old="${3-}"
> 
>         if [ -d "$dir" ]; then
>                 __git_ls_files_helper "$root" "$1" |
>                 while read -r file; do
>                         case "$file" in
> -                       ?*/*) echo "${file%%/*}/" ;;
> -                       *) echo "$file " ;;
> +                       ?*/*) echo "${file%%/*}${old:+/}" ;;
> +                       *) echo "${file}${old:+ }" ;;
>                         esac
>                 done | sort | uniq
>         fi
> @@ -480,7 +481,7 @@ __git_complete_revlist_file ()
>  # The exception is --committable, which finds the files appropriate commit.
>  __git_complete_index_file ()
>  {
> -       local pfx="" cur_="$cur"
> +       local pfx="" cur_="$cur" old
> 
>         case "$cur_" in
>         ?*/*)
> @@ -490,7 +491,8 @@ __git_complete_index_file ()
>                 ;;
>         esac
> 
> -       __gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
> +       compopt -o filenames +o nospace 2> /dev/null || old=1
> +       __gitcomp_nl "$(__git_index_files "$1" "$pfx" "$old")" "$pfx" "$cur_" ""
>  }
> 
>  __git_complete_file ()
> 

I like the idea (but I have not tested it), however compopt is called
two times, for each completion.

Maybe we can test for `-o filenames` support when script is loaded,
where currently there is a Bash version check, and set a global variable?



Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF78WcACgkQscQJ24LbaUSjzgCfWq26RMqFLgGU9B8C0mb+Wogu
A5IAnjKpupGbdOZAKtYZkglYKSmbqtqK
=iTzW
-----END PGP SIGNATURE-----
