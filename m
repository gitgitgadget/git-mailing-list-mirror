From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 3/5] pseudorefs: create and use pseudoref update and
 delete functions
Date: Tue, 11 Aug 2015 18:53:43 -0400
Organization: Twitter
Message-ID: <1439333623.5283.37.camel@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
	 <1438322781-21181-3-git-send-email-dturner@twopensource.com>
	 <CAGZ79kZ-e-GU5FfKWDAUxQPUnyrmGjSvHGnjWn=pwpDAj37umQ@mail.gmail.com>
	 <1439318789.5283.23.camel@twopensource.com>
	 <xmqqh9o5o3r2.fsf@gitster.dls.corp.google.com>
	 <xmqqbnedo31z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPIQZ-0003k1-9J
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 00:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbbHKWxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 18:53:47 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35059 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933087AbbHKWxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 18:53:46 -0400
Received: by qkbm65 with SMTP id m65so22733qkb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 15:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=TPusMKufXwLZZwqC75ck+oxQLtKI3m+/QfO0mVlLii8=;
        b=UIUMJ3d94UxwYhpF7/LntEJ0ucA0KPVtNpXixLfmGD9jqG+2vDu/9Apb2LcFXKf/ZV
         RuFeLdeFo0OGTbdgA0LtdAm+K3K3OpVW5FUUZatULG2Bg3k3SWJMjgGPDhRtfExAhyxi
         e0ZQS7omyGbzrlI6OlR5K9dfg7wpuLz6Ll3ZEfRd+fzBPEDKWiNcc6ku28VIkuS7YcZw
         nU2v3/N0gag2hKHy2mAoEVhOAVQ+BZDrsvcbhEYlDodoQ6UTfNzsY7u5YMUS494FkvgC
         +GL57YBYPHyY0My6RqdupJMJ0q49SApqrTMOMoH8eI+Lqdk/UBzq1veED5zMEcw5voIF
         kO8g==
X-Gm-Message-State: ALoCoQm185l0+eOH3ndjM+SNTm7cwwwoB/kpjAEUysP2uRqkqvGX3VRUBuIII5o5rsr5RG/1Fge6
X-Received: by 10.55.16.209 with SMTP id 78mr52535243qkq.81.1439333625595;
        Tue, 11 Aug 2015 15:53:45 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 108sm2086300qgi.45.2015.08.11.15.53.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 15:53:44 -0700 (PDT)
In-Reply-To: <xmqqbnedo31z.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275741>

On Tue, 2015-08-11 at 15:47 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Turner <dturner@twopensource.com> writes:
> >
> >> On Fri, 2015-07-31 at 16:40 -0700, Stefan Beller wrote:
> >>> I am sorry for being late to the review, I looked into coverity today as Duy
> >>> bugged me to fix the memory allocation stuff[1]
> >>
> >> Thanks. Junio, can you pleas substitute the attached patch instead?
> >
> > No.  The topic is already in 'next', no?
> 
> Yes, the topic is already in 'next'.  A follow-up fix would be good.
> 
> The patch didn't apply cleanly on top of 74ec19d^ to replace 74ec19d
> anyway, so I was about to discard it, but after conflict resolution,
> the interdiff turns out just these two hunks.
> 
> -- >8 --
> Subject: pseudoref: check return values from read_ref()
> From: David Turner <dturner@twopensource.com>
> Date: Wed, 15 Jul 2015 18:05:28 -0400
> 
> These codepaths attempt to compare the "expected" current value with
> the actual current value, but did not check if we successfully read
> the current value before comparison.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * It is likely that we would end up comparing the expected value with
>    garbage when the read fails, and the most likely outcome is that
>    they do not match and we fail the transaction, which is all fine.
> 
>    So in that sense, this is not all that urgent, but it is nice to
>    fix it when we know the code is not kosher.
> 
>  refs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 522b19b..1db3654 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2868,7 +2868,9 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
>  
>  	if (old_sha1) {
>  		unsigned char actual_old_sha1[20];
> -		read_ref(pseudoref, actual_old_sha1);
> +
> +		if (read_ref(pseudoref, actual_old_sha1))
> +			die("could not read ref '%s'", pseudoref);
>  		if (hashcmp(actual_old_sha1, old_sha1)) {
>  			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
>  			rollback_lock_file(&lock);
> @@ -2904,7 +2906,8 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
>  					       LOCK_DIE_ON_ERROR);
>  		if (fd < 0)
>  			die_errno(_("Could not open '%s' for writing"), filename);
> -		read_ref(pseudoref, actual_old_sha1);
> +		if (read_ref(pseudoref, actual_old_sha1))
> +			die("could not read ref '%s'", pseudoref);
>  		if (hashcmp(actual_old_sha1, old_sha1)) {
>  			warning("Unexpected sha1 when deleting %s", pseudoref);
>  			rollback_lock_file(&lock);
> 

LGTM.
