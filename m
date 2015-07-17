From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Fri, 17 Jul 2015 10:12:04 -0700
Message-ID: <xmqq1tg63dzv.fsf@gitster.dls.corp.google.com>
References: <1437142912-25380-1-git-send-email-zoe@bytenoise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Zoe=CC=88?= Blade <zoe@bytenoise.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:12:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG9BF-0005e0-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbbGQRMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 13:12:08 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35358 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbbGQRMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:12:07 -0400
Received: by pactm7 with SMTP id tm7so64256586pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ADCnCHJ/1KCK7nvzv5Q7f37ZHDYOpKz4DcgLBDfaPag=;
        b=Vv9Gfp0JwyA4N/bWGQ55vZCkaSsV+rNl8EDAdulXwEi6pbvfTwNzYQOFw1y5tjoO0L
         u8mbwYe6QSh0g4b+3Va9fKhACNAnJGoPJrvKtaSn3r3k/tuXhjb5IXIPlcMgq1bmB3ch
         vCk+oQnupPYDfHTNik2lSB0jrAaqScfBQxE5FOI7W4ra2lo44zO0+YXOIEMAJeac0+GE
         UNyOMR8IKRs0b2yKwCkYmK0elQbXClKCBLsYVhTG0RhDCO43u5nRHWa4+ePAPJP63GTH
         0f6UByPx2Qg4J9sE0TmEzyorQpWwKPUJVx3jSZVI3ktyFONeBR2vD7wDuzx5U2WK6mu8
         CRCw==
X-Received: by 10.66.160.1 with SMTP id xg1mr31505877pab.27.1437153126169;
        Fri, 17 Jul 2015 10:12:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id ml6sm11799710pdb.69.2015.07.17.10.12.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 10:12:05 -0700 (PDT)
In-Reply-To: <1437142912-25380-1-git-send-email-zoe@bytenoise.co.uk>
 (=?utf-8?Q?=22Zoe=CC=88?=
	Blade"'s message of "Fri, 17 Jul 2015 15:21:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274089>

Zoe=CC=88 Blade <zoe@bytenoise.co.uk> writes:

> Add support for Fountain, a plain text screenplay format.  Git
> facilitates not just programming specifically, but creative writing
> in general, so it makes sense to also support other plain text
> documents besides source code.
>
> In the structure of a screenplay specifically, scenes are roughly
> analogous to functions, in the sense that it makes your job easier
> if you can see which ones were changed in a given range of patches.
>
> More information about the Fountain format can be found on its
> official website, at http://fountain.io .
>
> Signed-off-by: Zoe=CC=88 Blade <zoe@bytenoise.co.uk>
> ---

The test looks a bit too brief (i.e. there is only one obvious
candidate to be picked as the funcname header in the input, so it is
very hard to break the expectation of the test even when the code or
pattern is modified incorrectly), but it would do for now.
Everything else looks trivially OK ;-)

Thanks, will queue.


>  Documentation/gitattributes.txt | 2 ++
>  t/t4018-diff-funcname.sh        | 1 +
>  t/t4018/fountain-scene          | 4 ++++
>  userdiff.c                      | 2 ++
>  4 files changed, 9 insertions(+)
>  create mode 100644 t/t4018/fountain-scene
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattri=
butes.txt
> index 81fe586..e3b1de8 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -527,6 +527,8 @@ patterns are available:
> =20
>  - `fortran` suitable for source code in the Fortran language.
> =20
> +- `fountain` suitable for Fountain documents.
> +
>  - `html` suitable for HTML/XHTML documents.
> =20
>  - `java` suitable for source code in the Java language.
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 1dbaa38..67373dc 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -31,6 +31,7 @@ diffpatterns=3D"
>  	cpp
>  	csharp
>  	fortran
> +	fountain
>  	html
>  	java
>  	matlab
> diff --git a/t/t4018/fountain-scene b/t/t4018/fountain-scene
> new file mode 100644
> index 0000000..6b3257d
> --- /dev/null
> +++ b/t/t4018/fountain-scene
> @@ -0,0 +1,4 @@
> +EXT. STREET RIGHT OUTSIDE - DAY
> +
> +CHARACTER
> +You didn't say the magic phrase, "ChangeMe".
> diff --git a/userdiff.c b/userdiff.c
> index 2ccbee5..5316b48 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -35,6 +35,8 @@ IPATTERN("fortran",
>  	  * they would have been matched above as a variable anyway. */
>  	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][=
a-zA-Z0-9_]*)?"
>  	 "|//|\\*\\*|::|[/<>=3D]=3D"),
> +PATTERNS("fountain", "^((INT|EST|EXT)?\\.[A-Z0-9' -]+)$",
> +	 "[^ \t-]+"),
>  PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>  	 "[^<>=3D \t]+"),
>  PATTERNS("java",
