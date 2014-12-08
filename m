From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/23] expire_reflog(): move dry_run to flags argument
Date: Mon, 8 Dec 2014 14:38:45 -0800
Message-ID: <20141208223845.GC25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:38:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy6x9-0005KZ-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbaLHWis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:38:48 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:51724 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbaLHWir (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:38:47 -0500
Received: by mail-qc0-f202.google.com with SMTP id i17so315711qcy.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c3b6aqmiQSwJzeiOmHAAXEc/s0BWqfgld2u09CuVblk=;
        b=UOMwBcXdOrIX47rCTLCNdkylzHyHNckUMkh7loAoNeiOE0VuUeekkbW/dqWxeGKsC+
         54BIqA8JSiKvYkX9uqVquvnUpxxd4qYwZ2gHVBuKgSev0kPbH2YG+jGYkwRhFCqJlJ4i
         OQ0Rx8kSB1iJn4cZwTU0DVu2xwzfB+COi6OLzneV2bCow4FGr5wX1hBF8y8Ao67Saert
         7/9PTOvZB3M87Ahz4PERf80fbC8gBbBrKMhQqRIvrwoBpviHEDX+nU2o0oDPj1PgLDm8
         Y+JRIaIwiWcwc6lunlXkFXfw/U0vsFgonzmARN7PLl0CMTW6mJRtGFPtiNHNpNoKSVru
         p/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=c3b6aqmiQSwJzeiOmHAAXEc/s0BWqfgld2u09CuVblk=;
        b=emYWE5W4y9TNPi246adpKJB4x0bhQ/7pU8QpMuCk4N37BjKojlkWSe7Zo/YizevIWg
         1l2dThENsB2xHBpsPJ7NwS2DhAqGQvl0CSdMqBmpI8oC2kSn7S3NX0RtaF9FXFYhlrGd
         9wQcHFK43mNP/R9n56+rN2Eshnyin53NZ+CYhEKSzQJIpA4un/O7fN5n93UPunJlbUUN
         w9XkPjT02CM34o9f4yfmYCJ41FvOfUsG5qH2r1WdsAdRjKbtd8z9ruqA0aWgcdin008H
         AKVcBGJy1BBl7gqey1le/b9jytnEa7NdlUW90DVvJncb7CtkbcSRTGHA/jJFqmhRk89W
         b03Q==
X-Gm-Message-State: ALoCoQmetum+G70USAgNjLTP3Blq50fa74j6ahto8OaUgc1WP+IoYq8jvvJV2mo/VQKIjTcg0Hzl
X-Received: by 10.236.31.33 with SMTP id l21mr31315538yha.20.1418078326645;
        Mon, 08 Dec 2014 14:38:46 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t24si1694121yht.2.2014.12.08.14.38.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:38:46 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id cJV0mESO.1; Mon, 08 Dec 2014 14:38:46 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id AD75D140BBD; Mon,  8 Dec 2014 14:38:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-12-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261088>

On Fri, Dec 05, 2014 at 12:08:23AM +0100, Michael Haggerty wrote:
> The policy objects don't care about "--dry-run". So move it to
> expire_reflog()'s flags parameter.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: <sbeller@google.com>

> ---
>  builtin/reflog.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 319f0d2..a490193 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -22,7 +22,6 @@ static unsigned long default_reflog_expire_unreachable;
>  
>  struct cmd_reflog_expire_cb {
>  	struct rev_info revs;
> -	int dry_run;
>  	int stalefix;
>  	int rewrite;
>  	int updateref;
> @@ -415,6 +414,10 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
>  
>  static struct lock_file reflog_lock;
>  
> +enum expire_reflog_flags {
> +	EXPIRE_REFLOGS_DRY_RUN = 1 << 0
> +};
> +
>  static int expire_reflog(const char *refname, const unsigned char *sha1,
>  			 unsigned int flags, void *cb_data)
>  {
> @@ -439,7 +442,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  	}
>  
>  	log_file = git_pathdup("logs/%s", refname);
> -	if (!cmd->dry_run) {
> +	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
>  			goto failure;
>  		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> @@ -453,7 +456,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
>  	reflog_expiry_cleanup(&cb);
>  
> -	if (cb.newlog) {
> +	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		if (close_lock_file(&reflog_lock)) {
>  			status |= error("Couldn't write %s: %s", log_file,
>  					strerror(errno));
> @@ -644,7 +647,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
> -			cb.dry_run = 1;
> +			flags |= EXPIRE_REFLOGS_DRY_RUN;
>  		else if (starts_with(arg, "--expire=")) {
>  			if (parse_expiry_date(arg + 9, &cb.expire_total))
>  				die(_("'%s' is not a valid timestamp"), arg);
> @@ -738,7 +741,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
> -			cb.dry_run = 1;
> +			flags |= EXPIRE_REFLOGS_DRY_RUN;
>  		else if (!strcmp(arg, "--rewrite"))
>  			cb.rewrite = 1;
>  		else if (!strcmp(arg, "--updateref"))
> -- 
> 2.1.3
> 
