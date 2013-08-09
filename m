From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] builtin/config.c: compilation fix
Date: Thu, 8 Aug 2013 22:38:26 -0700
Message-ID: <866829AC-DD63-462B-B12F-BF868D0ED5C0@gmail.com>
References: <7vli4b79x3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 07:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7fPQ-00073i-1w
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 07:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934307Ab3HIFia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 01:38:30 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49166 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933343Ab3HIFia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 01:38:30 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so149728pdi.5
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=3XWXkvqrWuY28aUvgSbABfnD6ZFjO5Kow8JaiKKdKG0=;
        b=UdGzwcSV6HYWDxcwJGNpvCoW23tjm8GcPDG8gu26jJfkHgITkiV+7aNsNkq+RKsDEy
         +srFBFjRRaylUeKmH8UxtKeW/uFIOWfI5PYeU6puZvxArhysF5aVBiIREAXgIVs8rWwa
         P21Cql3sryREZqEtZ45co5/BVGa6IKZqX0qynb4IItDjgpYt+/WZXJ+mXE7BrccgXNst
         3VBaluH/MfdCUpU69I0QHgUrMng6e4SfOZ1WKvQMGECmz/WkgCxVS2P81uuPiTCriRWM
         WQz0OdouS6TZTaOUSiGnpfpDaJ5QZuJfCZE+pBjL1bw76nogu3kOlHbP2EwyhKIQ3cnx
         zkxw==
X-Received: by 10.68.195.136 with SMTP id ie8mr9494253pbc.120.1376026709694;
        Thu, 08 Aug 2013 22:38:29 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qp10sm20336050pab.13.2013.08.08.22.38.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 22:38:28 -0700 (PDT)
In-Reply-To: <7vli4b79x3.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231955>

On Aug 8, 2013, at 21:41, Junio C Hamano wrote:
> Do not feed a random string as the first parameter to die(); use "%s"
> as the format string instead.
>
> Do the same for test-urlmatch-normalization.c while saving a single
> pointer variable by turning a "const char *" constant string into
> "const char []".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> builtin/config.c              | 2 +-
> test-urlmatch-normalization.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index c046f54..ae199e9 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -404,7 +404,7 @@ static int get_urlmatch(const char *var, const  
> char *url)
> 	config.cb = &values;
>
> 	if (!url_normalize(url, &config.url))
> -		die(config.url.err);
> +		die("%s", config.url.err);
>
> 	config.section = dup_downcase(var);
> 	section_tail = strchr(config.section, '.');
> diff --git a/test-urlmatch-normalization.c b/test-urlmatch- 
> normalization.c
> index 2603899..78c8b3a 100644
> --- a/test-urlmatch-normalization.c
> +++ b/test-urlmatch-normalization.c
> @@ -3,7 +3,7 @@
>
> int main(int argc, char **argv)
> {
> -	const char *usage = "test-urlmatch-normalization [-p | -l] <url1>  
> | <url1> <url2>";
> +	const char usage[] = "test-urlmatch-normalization [-p | -l] <url1>  
> | <url1> <url2>";
> 	char *url1, *url2;
> 	int opt_p = 0, opt_l = 0;
>
> -- 
> 1.8.3.3-1049-g890a991
>

Looks good to me except that there seems to be a missing part of the  
patch.  Did you also mean to include:

diff --git a/test-urlmatch-normalization.c b/test-urlmatch- 
normalization.c
index 2603899b..39017c20 100644
--- a/test-urlmatch-normalization.c
+++ b/test-urlmatch-normalization.c
@@ -42,7 +42,7 @@ int main(int argc, char **argv)
  	}

  	if (opt_p || opt_l)
-		die(usage);
+		die("%s", usage);

  	url1 = url_normalize(argv[1], NULL);
  	url2 = url_normalize(argv[2], NULL);


That's not terribly important here since we know the string will never  
contain any '%' characters, but the comment on the patch led me to  
believe that test-urlmatch-normalization would also get the die()  
change.
