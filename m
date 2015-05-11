From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: improve output when bad commit is found
Date: Mon, 11 May 2015 14:12:51 -0700
Message-ID: <xmqq4mni3jjg.fsf@gitster.dls.corp.google.com>
References: <1431377939-13887-1-git-send-email-tbsaunde@tbsaunde.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Mon May 11 23:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrv0U-0000lx-ET
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 23:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbbEKVMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 17:12:54 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35802 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbEKVMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 17:12:53 -0400
Received: by igbyr2 with SMTP id yr2so83361281igb.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=k27QEh5mOdH4WkguJMBszqnje1wBC7/YqgwKaqYjpJg=;
        b=inK0e/37I/fY+qbOEcmRZeMfkXVBCSS4kxQ0nov3673FOLwNGJfDHanjxUBHT407g2
         4ZhzzGUuoE82Rm4GxOvArA9au23K3DLgDvxCcqmUwiT7rn27mDoXiNWH/V8UUcjIbxUA
         PDhClNor9JddGnj34JFrvlTPLMImZFVIN7O7HRmvoFkyLszpbMr4IgFFMuYWGdg0seHl
         FyKCEDlqMbcV8QNd9RcacxvfP2P5CY2cCD8O9WHExIt8YB0fpoB1hCsYLav7+i7z3+cT
         B/Vm8+A/V7Z3ACrcE5JMdHbZgawgO98iMKkmiffaDJVCFyBI1sDBAgundmtINIZrsWpa
         P+Uw==
X-Received: by 10.50.142.67 with SMTP id ru3mr15799885igb.40.1431378773078;
        Mon, 11 May 2015 14:12:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id h128sm10493625ioh.38.2015.05.11.14.12.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 14:12:52 -0700 (PDT)
In-Reply-To: <1431377939-13887-1-git-send-email-tbsaunde@tbsaunde.org> (Trevor
	Saunders's message of "Mon, 11 May 2015 16:58:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268825>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

> When the first bad commit has been found git bisect prints something
> like this

>
> <40 char sha1> is the first bad commit
> Commit <40 char sha1>
> ...
>
> <raw diff output>
>
> The raw diff output is not really useful, and its kind of silly to print

End "something like this" with a colon, and indent the example
display, i.e.

        ... prints something like this:

            <40-hex object name> is the first bad commit
            Commit <40-hex object name>

        The raw diff output is ...

> the sha1 twice.  Instead lets print something like
>
> the first bad commit is
> Commit <sha1>
> ...

Likewise.

> This also fixes an odd inconsistancy where if the first bad commit is a
> trivial merge git bisect will only print the first line.
> ---

Sign-off?

> -		printf("%s is the first bad commit\n", bisect_rev_hex);
> +		puts("the first bad commit is");

s/the/The/, I would think.

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 06b4868..bf50d20 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -26,6 +26,14 @@ add_line_into_file()
>      git commit --quiet -m "$MSG" $_file
>  }
>  
> +check_bisect_msg()
> +{

Find this paragraph in Documentation/CodingGuidelines:

 - We prefer a space between the function name and the parentheses,
   and no space inside the parentheses. The opening "{" should also
   be on the same line.

> +	file=$1
> +	hash=$2
> +	grep "the first bad commit is" $file || return $?
> +	grep $hash $file || return $?

Is it OK to have these strings anywhere in the $file?

Thanks.
