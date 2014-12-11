From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] update-ref: fix "verify" command with missing
 <oldvalue>
Date: Wed, 10 Dec 2014 16:21:53 -0800
Message-ID: <20141211002153.GB14446@google.com>
References: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
 <1418255272-5875-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brad King <brad.king@kitware.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:28:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyrcF-0006R6-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 01:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbaLKA2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 19:28:19 -0500
Received: from mail-qc0-f201.google.com ([209.85.216.201]:42753 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822AbaLKA2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 19:28:18 -0500
Received: by mail-qc0-f201.google.com with SMTP id m20so247489qcx.4
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v0smxVJL+07lXCG9paIgtFUsEmPe58J8v9G5ooESkQ4=;
        b=FYn99Xs6dq02YgmRL3+kBJicePEdLTZdilpt6ReSMAG7oZmVhevvSa5XjDIudtBPHT
         nHRwJOlMWl6Lpl3VexWTLTYe424W7qORtO0b/VhxOb8KrdSv7C9Y2WJnq21sFVD/mqTe
         ttq9W0iLycbJ5u/h+97zKko/HsXtgAUglO3we/JOdNByVplOiGJ/YGw2Oxg1MSv/s7Fq
         SPxQvKo2pH01O7X7AYc1S3530xtSx4dufEd5ylQ8UHiMuhxeoSCIY52KjMKhm1NkjBUK
         Oxqa+YTsm+ij2M3wrFFx/v2cZGeAXo3JGiw2Tw3jqDGScz4hGkl0Sa13kLPCKWC2KfdU
         EHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v0smxVJL+07lXCG9paIgtFUsEmPe58J8v9G5ooESkQ4=;
        b=dT2iuvmLO9Hwz2d9VO0ZSqM7NRAP3HShbslYDLdIpgkJu8bFVpaINFQ91X/M1XNFN1
         pyywOE8aUHkzHctM+Ffb3WNXOdHACBcOSNPG1oNmQLKb2y153hqOMycy3SztM2KEQIUR
         WO+BrGUhy21/kWIrw7D5SaaDM3rlr/08ufYwcJxf+Yl3MA9pkMIFXjQDlKsAq4Stryzp
         DGOxW7DUd6nJ8UlWYR+4ff63pDvO633YbX4Eoj6DF5KDyn45+aiQm8A0C7WtfIaYY5SZ
         bp8+jb/aa4nl1lRZaQtM0S1CW1xHBQ1e1cJ6yMNUbvAha1MygQ2AUdDlbmB1G/SaIIAB
         EV8Q==
X-Gm-Message-State: ALoCoQm1vvytwww6jUh3nArfk0wZ/aMvdrJ7Ce1KsYot8bpKsgiz/zFrhEjqYVYhYITAAIYQFkqc
X-Received: by 10.224.88.4 with SMTP id y4mr5476549qal.6.1418257315016;
        Wed, 10 Dec 2014 16:21:55 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id jw4si1196455qcb.3.2014.12.10.16.21.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 16:21:55 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id snazIVuM.1; Wed, 10 Dec 2014 16:21:54 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id C91B0140BD8; Wed, 10 Dec 2014 16:21:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418255272-5875-3-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261266>

On Thu, Dec 11, 2014 at 12:47:52AM +0100, Michael Haggerty wrote:
> If "git update-ref --stdin" was given a "verify" command with no
> "<newvalue>" at all (not even zeros), the code was mistakenly setting
> have_old=0 (and leaving old_sha1 uninitialized). But this is
> incorrect: this command is supposed to verify that the reference
> doesn't exist. So in this case we really need old_sha1 to be set to
> null_sha1 and have_old to be set to 1.
> 
> Moreover, since have_old was being set to zero, *no* check of the old
> value was being done, so the new value of the reference was being set
> unconditionally to the value in new_sha1. new_sha1, in turn, was set
> to null_sha1 in the expectation that that was the old value and it
> shouldn't be changed. But because the precondition was not being
> checked, the result was that the reference was being deleted
> unconditionally.
> 
> So, if <oldvalue> is missing, set have_old unconditionally and set
> old_sha1 to null_sha1.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

This is reviewed by me as well.
Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/update-ref.c  | 14 +++++---------
>  t/t1400-update-ref.sh |  4 ++--
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 6c9be05..1993529 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -282,26 +282,22 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
>  	char *refname;
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
> -	int have_old;
>  
>  	refname = parse_refname(input, &next);
>  	if (!refname)
>  		die("verify: missing <ref>");
>  
>  	if (parse_next_sha1(input, &next, old_sha1, "verify", refname,
> -			    PARSE_SHA1_OLD)) {
> -		hashclr(new_sha1);
> -		have_old = 0;
> -	} else {
> -		hashcpy(new_sha1, old_sha1);
> -		have_old = 1;
> -	}
> +			    PARSE_SHA1_OLD))
> +		hashclr(old_sha1);
> +
> +	hashcpy(new_sha1, old_sha1);
>  
>  	if (*next != line_termination)
>  		die("verify %s: extra input: %s", refname, next);
>  
>  	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -				   update_flags, have_old, msg, &err))
> +				   update_flags, 1, msg, &err))
>  		die("%s", err.buf);
>  
>  	update_flags = 0;
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 6a3cdd1..6805b9e 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -655,7 +655,7 @@ test_expect_success 'stdin verify fails for mistaken null value' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'stdin verify fails for mistaken empty value' '
> +test_expect_success 'stdin verify fails for mistaken empty value' '
>  	M=$(git rev-parse $m) &&
>  	test_when_finished "git update-ref $m $M" &&
>  	git rev-parse $m >expect &&
> @@ -1020,7 +1020,7 @@ test_expect_success 'stdin -z verify fails for mistaken null value' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'stdin -z verify fails for mistaken empty value' '
> +test_expect_success 'stdin -z verify fails for mistaken empty value' '
>  	M=$(git rev-parse $m) &&
>  	test_when_finished "git update-ref $m $M" &&
>  	git rev-parse $m >expect &&
> -- 
> 2.1.3
> 
