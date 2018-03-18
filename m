Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FEF1FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 00:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeCRAOE (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 20:14:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34250 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeCRAOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 20:14:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id a20so7630402wmd.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 17:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4iYGqDKewm5dFyBAcyNdF4TGqwI+cQNQwCvkUB0FGFM=;
        b=S8GO5Hs0E5WCv/BoAFijBP3Q4v3OxOxgod2H1C6HnC+5h7s39r40o0pop+vinF0i+r
         2BM5GqmqDSCI53+RV25VEFt9GUhFDzdYs3H9EbQ9lSZlwIpWnmpl03WrpuPOFlSixuc2
         yzba6nbEp+FlLKow7AroK9WweslOMyQ4zkAEe5dqBFtVq+03oOSk1D3te0n6vzYy/YxK
         5NxT/jUkYu19/0iaPZeMNwswgA8F9qwAXaR5rBYkZXNqvXXyhk0tMIsOyNp/BQulf3yH
         xp+ooW3uk1LfWwTaw2l9N44paGT9mdHPoXJdVvycHU47uqbjRvBikpWjlJrrKStOzBcr
         EU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4iYGqDKewm5dFyBAcyNdF4TGqwI+cQNQwCvkUB0FGFM=;
        b=pjPv3TbPoQE0vL6H9v6dVPHDQBi9BZkUwF08m00Ly3UMvfKSBxc4UiqjoiKdM+6DmB
         LeL34CtYC5avdBbQzIWkT/YHWs3yYXNNqsNaMcmG6VJ03R+PgTk9jYTgnZJIkSFBcx26
         gxqheM3hosCULpMn1YjjPRTcbU4fnTEG1LRBIO5MdQ1rkDg2L0phl8odXzC/5fiPuC5N
         wb0ZfQ1NMD9mFsarxzfVscCjWcs2aRrVA3j1ZpABIXaINmPVAHCNMhuKwP6WqEEkHcsE
         /7AQI1xAYzTbUyCjLGq40lgkkTkB79mi1+fLn31CGfUTTY3Y/1qBDaDpOCARmcQIyVRg
         ALWA==
X-Gm-Message-State: AElRT7FBfWZQGpqbO1ha6gryjYxfLfiBrJnHycO/O5xOZfagVsbrwmH0
        MnmJJnyD3InXCmnGZU6pkRE=
X-Google-Smtp-Source: AG47ELvT2+5VapdBgI1VRQaeIOWjWmUsyqXsU/OBHvB8qdWINvUSbuZRuITmOTYHQgmpDXEDZfLxJQ==
X-Received: by 10.28.161.4 with SMTP id k4mr4692788wme.103.1521332041620;
        Sat, 17 Mar 2018 17:14:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n64sm9025375wmd.11.2018.03.17.17.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 17:13:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     git@vger.kernel.org, manlio.perillo@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/2] completion: improve ls-files filter performance
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
Date:   Sat, 17 Mar 2018 17:13:59 -0700
In-Reply-To: <1521274624-1370-1-git-send-email-drizzd@gmx.net> (Clemens
        Buchacher's message of "Sat, 17 Mar 2018 09:17:03 +0100")
Message-ID: <xmqqo9jmxmt4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clemens Buchacher <drizzd@gmx.net> writes:

> From the output of ls-files, we remove all but the leftmost path
> component and then we eliminate duplicates. We do this in a while loop,
> which is a performance bottleneck when the number of iterations is large
> (e.g. for 60000 files in linux.git).
>
> $ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git
>
> real    0m11.876s
> user    0m4.685s
> sys     0m6.808s
>
> Using an equivalent sed script improves performance significantly:
>
> $ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git
>
> real    0m1.372s
> user    0m0.263s
> sys     0m0.167s
>
> The measurements were done with mingw64 bash, which is used by Git for
> Windows.
>
> Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
> ---
>  contrib/completion/git-completion.bash | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6da95b8..e3ddf27 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -384,12 +384,7 @@ __git_index_files ()
>  	local root="${2-.}" file
>  
>  	__git_ls_files_helper "$root" "$1" |
> -	while read -r file; do
> -		case "$file" in
> -		?*/*) echo "${file%%/*}" ;;
> -		*) echo "$file" ;;
> -		esac
> -	done | sort | uniq
> +	sed -e '/^\//! s#/.*##' | sort | uniq

Micronit: perhaps lose SP after '!'?

cf. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

"""A function can be preceded by a '!' character, in which case the
function shall be applied if the addresses do not select the pattern
space. Zero or more <blank> characters shall be accepted before the
'!' character. It is unspecified whether <blank> characters can
follow the '!' character, and conforming applications shall not
follow the '!' character with <blank> characters."""


>  }
>  
>  # Lists branches from the local repository.
