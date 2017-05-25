Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860FE20209
	for <e@80x24.org>; Thu, 25 May 2017 04:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032380AbdEYEQ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 00:16:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33738 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031481AbdEYEQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 00:16:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so36489741pfe.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TTONC+KzW1/Qq1IKNCGLmRgJVRu/UzS3hKP1FnnfJxQ=;
        b=UuCxKVZrxQn+2WDYm9ivJptGsxAesJVEYshb17AkcebM1DLuRftnJYx5eNMqf/mPdj
         R+q6q+G2JEohtsxlMpW480nuHBw0iWOwhcYMkXcGXxciFQAmKExKThcd1jdPztYYY70Y
         hwF0vaWaYGhAy/BJt/BZBj+gfQmsaMFz3Rw4GT7p8oPBLrFHGPRgWye6LOsm4UrKSjds
         /UGKVX9UhDg0tLe5vvHyVIvVw8WJ0mlEO/I8Qbg2u/K0JTeACoftpHaqkLYXoYXBT+rm
         qps+laMjrThV9Utn0uZ+z6LXk7CoPRxxrOzy+XHCPitGqzVqWwoOCwT6EvauDs57xVYU
         emfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TTONC+KzW1/Qq1IKNCGLmRgJVRu/UzS3hKP1FnnfJxQ=;
        b=HNdeOrzJsJoTqKvsiqO+aHG049RLb8VVr6PAUx4CdB2iUxgiobLoAOl9nXq37Q/CID
         WaJ3JA3ltFyz+q4f3Ug2RrmiN1E/5WBCUA/n0JosdOyHX7H5I/XkFIBXAkq3uSRP4AB0
         +f16ws9NIPhA4F0QXRP1U6q9/BtNjLF3evjAs3UV3O9kdnmdYdW3sd6NoEydDKsazaC0
         LBQ9v6xI4G/eCF6lnoTdjEP/OeVqSEgRS+DzpD6ATGJEedmdFnJTzkph05O/nzYAgiJV
         oUFVqSBlYTsaS/evgX1VE/rOvUvDp65PSzfxkeTwFkmINSVx+QJdyZF7QWmITqjqT+Dl
         1FNg==
X-Gm-Message-State: AODbwcD24WtE9a9X35+nfi4X5d4TdKJScdVeyJrRTQLf42TlYiNeFHih
        bNKPLH9s8xCE+g==
X-Received: by 10.84.236.15 with SMTP id q15mr31129811plk.163.1495685774401;
        Wed, 24 May 2017 21:16:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id 80sm10499650pfx.80.2017.05.24.21.16.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 21:16:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 18/29] blame: move progess updates to a scoreboard callback
References: <20170524051537.29978-1-whydoubt@gmail.com>
        <20170524051537.29978-19-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 13:16:12 +0900
In-Reply-To: <20170524051537.29978-19-whydoubt@gmail.com> (Jeff Smith's
        message of "Wed, 24 May 2017 00:15:26 -0500")
Message-ID: <xmqq1srdfu5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Subject: Re: [PATCH 18/29] blame: move progess updates to a scoreboard callback

s/progess/progress/ (I can do this on my end).

> Allow the interface user to decide how to handle a progress update.
>
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  builtin/blame.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> -static void found_guilty_entry(struct blame_entry *ent,
> -			   struct progress_info *pi)
> +static void found_guilty_entry(struct blame_entry *ent, void *data)
>  {
> +	struct progress_info *pi = (struct progress_info *)data;
> +
>  	if (incremental) {
>  		struct blame_origin *suspect = ent->suspect;
>  

This hunk is interesting.  The function not only does the "progress"
eye candy, but it actually handles the "--incremental" option.
Anybody who wants to do something similar using the libified blame
needs to implement it in their found_guilty callback like this one
does, which is probably a good division of labor between the blame
lib and the front-end (which builtin/blame.c is one instance of).

> @@ -1754,11 +1758,6 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
>  {
>  	struct rev_info *revs = sb->revs;
>  	struct commit *commit = prio_queue_get(&sb->commits);
> -	struct progress_info pi = { NULL, 0 };
> -
> -	if (show_progress)
> -		pi.progress = start_progress_delay(_("Blaming lines"),
> -						   sb->num_lines, 50, 1);

And this piece (and matching "stop progress" at the end of the
function) is now the responsibility of the caller, which makes
sense.

>  
> +	sb.found_guilty_entry = &found_guilty_entry;
> +	sb.found_guilty_entry_data = &pi;
> +	if (show_progress)
> +		pi.progress = start_progress_delay(_("Blaming lines"),
> +						   sb.num_lines, 50, 1);
> +
>  	assign_blame(&sb, opt);
>  
> +	stop_progress(&pi.progress);
> +
>  	if (!incremental)
>  		setup_pager();


Very nicely done so far.
