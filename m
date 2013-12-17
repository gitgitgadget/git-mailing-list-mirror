From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 3/3] cmd_repack(): remove redundant local variable "nr_packs"
Date: Tue, 17 Dec 2013 14:46:53 +0100
Message-ID: <52B055CD.9040905@googlemail.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu> <1387287838-25779-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 14:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsuzE-0005j4-EE
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 14:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab3LQNq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 08:46:57 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50079 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3LQNq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 08:46:56 -0500
Received: by mail-bk0-f46.google.com with SMTP id u15so2793427bkz.5
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 05:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Cdchq+UCPv1OvgaCgpHlqFMvqPHJSwqZ8RiPRzk7QYE=;
        b=FXLpOwBIEo0Mjcp5hrYimwoeWmmS5LuVlS2jG7kgOGrDJbBbjq7BoT7N2mAU8EX6nP
         OMDCVHBaFLBzZBKsDvkmujXk12pFvyg9djDp6thrb43tbGbPsP8We0ZRPeuuJdyl4zhK
         PCliWzgFrWFMbwbd5qpe7hKxQUHAM39TCx0j5y4DijVTVHnRGiqdD271aaxzRc+KpPk2
         TC1xbYe9MmrhoSjB222xQF8QT0c1rCa17fZIzSSulL9+RFWVSr+foYzbcPItu98UeOSN
         SW018D3+5Dve4fZStGy7e5UuMVT2L0YInVITxMr/+09yLpsNxdZpddyzoq5tGUmAhrMe
         ctCw==
X-Received: by 10.204.3.74 with SMTP id 10mr115367bkm.173.1387288015224;
        Tue, 17 Dec 2013 05:46:55 -0800 (PST)
Received: from [131.234.241.45] (eduroamerw-241-45.uni-paderborn.de. [131.234.241.45])
        by mx.google.com with ESMTPSA id mf4sm13600978bkb.7.2013.12.17.05.46.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Dec 2013 05:46:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387287838-25779-4-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239385>

On 17.12.2013 14:43, Michael Haggerty wrote:
> Its value is the same as the number of entries in the "names"
> string_list, so just use "names.nr" in its place.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Acked-by: Stefan Beller <stefanbeller@googlemail.com>

> ---
> This is just a trivial simplification.  Take it or leave it.
> 
>  builtin/repack.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index a0ff5c7..91e2363 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -123,7 +123,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct string_list rollback = STRING_LIST_INIT_NODUP;
>  	struct string_list existing_packs = STRING_LIST_INIT_DUP;
>  	struct strbuf line = STRBUF_INIT;
> -	int nr_packs, ext, ret, failed;
> +	int ext, ret, failed;
>  	FILE *out;
>  
>  	/* variables to be filled by option parsing */
> @@ -233,13 +233,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (ret)
>  		return ret;
>  
> -	nr_packs = 0;
>  	out = xfdopen(cmd.out, "r");
>  	while (strbuf_getline(&line, out, '\n') != EOF) {
>  		if (line.len != 40)
>  			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
>  		string_list_append(&names, line.buf);
> -		nr_packs++;
>  	}
>  	fclose(out);
>  	ret = finish_command(&cmd);
> @@ -247,7 +245,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		return ret;
>  	argv_array_clear(&cmd_args);
>  
> -	if (!nr_packs && !quiet)
> +	if (!names.nr && !quiet)
>  		printf("Nothing new to pack.\n");
>  
>  	/*
> 
