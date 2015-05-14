From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 0/3]
Date: Thu, 14 May 2015 16:31:06 -0400
Organization: Twitter
Message-ID: <1431635466.17436.0.camel@ubuntu>
References: <1431541434-21884-1-git-send-email-dturner@twitter.com>
	 <xmqqvbfvj7ge.fsf@gitster.dls.corp.google.com>
	 <xmqqegmikj7z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:31:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yszml-0004cY-Mb
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933558AbbENUbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:31:11 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35768 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933019AbbENUbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:31:09 -0400
Received: by qgew3 with SMTP id w3so1456103qge.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=uYDKaltSyGb5Fn0ZOisz2+1VGpYx5Eu9x5Ww2Swlufc=;
        b=FoLRu4g/2zk/Ga2b/b2gR3bUGpjeO8kNyx0Qz8g3dz6/OHiiWUUyJ4RS9HwmopHFYH
         07Mr51kxSv1RdytMpd+t1wZVNLbS5FBKSLZZugQ5NTtUKQkUWCbbHUfGPus+T0fA0urz
         U4RjKTURh/zcgSIW05FdLcrDEkaP0qo8B5rHPE5Fyz6ThtJaHrR1ANI58VhmbvldWyXf
         +fHi/xkN+SYDm1iKwfEWQgOOom+a2EQpfewDbE0wmlFtPN8HqqB2x6alu78s6rzkScz/
         UtdnyIL4TquK1NHteNwSmWluQHQfsncvQD+ehflAs4jKtPH6BQd9T9W4cbD3G3JhqGHd
         m+pA==
X-Gm-Message-State: ALoCoQkrztZFE2f9ji9ijK4RKBFLVzATz+XpSWlSY30BM4KdOdPdSTb0SlJqNU9xjTiyrgRa4Zpl
X-Received: by 10.140.102.180 with SMTP id w49mr7775371qge.82.1431635468187;
        Thu, 14 May 2015 13:31:08 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id k85sm69468qkh.48.2015.05.14.13.31.06
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 13:31:07 -0700 (PDT)
In-Reply-To: <xmqqegmikj7z.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269085>

I sent v10 in response to your last mail before getting this; I will
replace it with a v11 which includes this instead.


On Thu, 2015-05-14 at 13:16 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Turner <dturner@twopensource.com> writes:
> >
> >> Oops, forgot to ammend commit before patch v8.  This patch *really*
> >> includes the switch and type casting fixes.
> >
> > Thanks. Will replace.
> 
> I've placed the attached change on top as a suggested fix-up.
> 
> The reasons for the first two hunks should be obvious.
> 
> The last hunk is because:
> 
>  * "--follow-symlinks" (currently) works only with "--batch{-check}",
>    so it flows more natural to show it after them.
> 
>  * "in-repo" is a wrong phrase, I think.  For a symbolic link
>    HEAD:dir/link, you cannot give "$(git rev-parse HEAD:dir):link"
>    to this machinery if its value is "../toplevel-file", even though
>    the target is "in-repo", and the reason why you can't is because
>    it is outside the tree "$(git rev-parse HEAD:dir)".
>    
>  * OPT_SET_INT() is very old fashioned ;-) kn/cat-file-literally
>    topic, which I expect would graduate to 'master' before this
>    series would, updates all the existing ones to OPT_BOOL(), and
>    following suit to match it would reduce the need to do an evil
>    merge later.
> 
>  builtin/cat-file.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 095554b..43338bb 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -243,7 +243,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
>  
>  	result = get_sha1_with_context(obj_name, flags, data->sha1, &ctx);
>  	if (result != FOUND) {
> -		switch(result) {
> +		switch (result) {
>  		case MISSING_OBJECT:
>  			printf("%s missing\n", obj_name);
>  			break;
> @@ -358,7 +358,7 @@ static int batch_objects(struct batch_options *opt)
>  
>  static const char * const cat_file_usage[] = {
>  	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> -	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
> +	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>"),
>  	NULL
>  };
>  
> @@ -402,15 +402,14 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>  		OPT_SET_INT(0, "textconv", &opt,
>  			    N_("for blob objects, run textconv on object's content"), 'c'),
> -		OPT_SET_INT(0, "follow-symlinks", &batch.follow_symlinks,
> -			N_("follow in-repo symlinks; report out-of-repo symlinks (requires --batch or --batch-check)"),
> -			    1),
>  		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
>  			N_("show info and content of objects fed from the standard input"),
>  			PARSE_OPT_OPTARG, batch_option_callback },
>  		{ OPTION_CALLBACK, 0, "batch-check", &batch, "format",
>  			N_("show info about objects fed from the standard input"),
>  			PARSE_OPT_OPTARG, batch_option_callback },
> +		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
> +			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
>  		OPT_END()
>  	};
>  
