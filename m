From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] difftool: Change prompt to display the number of
 files in the diff queue
Date: Tue, 17 Dec 2013 21:25:25 -0800
Message-ID: <20131218052523.GB90546@gmail.com>
References: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 06:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt9de-0007bn-U9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 06:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3LRFZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 00:25:37 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:57610 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab3LRFZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 00:25:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so5477795pab.39
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 21:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MHomKR6wAoSemtwCzVAH4TLMGXg9XjOGd6isn5phG9Y=;
        b=Ys4abd+cyAfdL0TVfoV8uDJXwhQqQ8LY44mId0MQjyOYtX5LVxFAMjM0bC6lY42yNu
         fiu8n14j7vsbCTeory8+GFBnOX1RQislXIlzUymeAK4vdsQG27O8dog0LvG/kBz4LkG4
         wG19mO+dj0HHEL9fWL59vIKyruM3NDC7n5G2MR94cv+zYIHW2ZHkPf25OOI4a+fwfDHM
         VRjJQh05emDqG43be5suPiY4L+RNTU5XvL9xeM7EIJ1HGn+FdWcTdVUY5jT8+h4zlvab
         dRRgeIZs+KaOLrsO9FNy48EbTNIV4yH6/qPyDt8A/nvkt7X12IJGuzyG7a+y154pKyw4
         KQ0g==
X-Received: by 10.68.172.196 with SMTP id be4mr31999233pbc.12.1387344334230;
        Tue, 17 Dec 2013 21:25:34 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id bp5sm38023936pbb.18.2013.12.17.21.25.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Dec 2013 21:25:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239422>

Thanks for the patch, and sorry for the late response.
I have just a couple of notes below...

On Fri, Dec 06, 2013 at 10:38:46AM +1100, Zoltan Klinger wrote:
> diff --git a/diff.c b/diff.c
> index e34bf97..a7d5a47 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2899,11 +2899,16 @@ static void run_external_diff(const char *pgm,
>  			      struct diff_filespec *one,
>  			      struct diff_filespec *two,
>  			      const char *xfrm_msg,
> -			      int complete_rewrite)
> +			      int complete_rewrite,
> +			      struct diff_options *o)

Very minor nit -- "o" is a very terse variable name.
Maybe "opts"?

>  {
>  	const char *spawn_arg[10];
>  	int retval;
>  	const char **arg = &spawn_arg[0];
> +	struct diff_queue_struct *q = &diff_queued_diff;
> +	const char *env[3] = { NULL };
> +	char env_counter[50];
> +	char env_total[50];

Hard-coded 50; what's the length of the maximum signed int?


> diff --git a/diff.h b/diff.h
> index e342325..42bd34c 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -164,6 +164,8 @@ struct diff_options {
>  	diff_prefix_fn_t output_prefix;
>  	int output_prefix_length;
>  	void *output_prefix_data;
> +
> +	int diff_path_counter;
>  };

Since these are already "diff_options" it seems redundant to call
the struct entry the "diff_path_counter" when "path_count"
should be specific enough.  Would it make sense to rename it?

These are tiny nitpicky style notes; it looks good otherwise.

Thanks,
-- 
David
