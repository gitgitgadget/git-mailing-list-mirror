From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] merge: Make '--log' an integer option for number
 of shortlog entries
Date: Tue, 31 Aug 2010 13:21:20 -0500
Message-ID: <20100831182120.GR2315@burratino>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
 <1283226800-28980-1-git-send-email-artagnon@gmail.com>
 <20100831143236.GC2315@burratino>
 <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVUN-0008Ik-3H
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab0HaSXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:23:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48328 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab0HaSXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:23:13 -0400
Received: by wyb35 with SMTP id 35so8182236wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KCtdjO2asMzvh6XlcHk6fTeG/OX8UHLhSfdCstrM1RA=;
        b=i2FDmNkns7vlyNXa8r6K1tCyqtnfqUJwe8Dlobo7F0PNJ1JbjKu2Sg5tra7Omi0qZ/
         xTUjDrMxHFxHZyTz8ZPPUtzR4kOzgKPObE5xS9aTwdvZnTasnmRgolQpiZpXnw/SRJ4C
         4sTb5ZbJiaVx6XP9txmPAQCpuvyjFdvJzEaCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bbfC+A+kuBJnrldKc2KYMADAbyG7RM1MFDcZ806TboxDpn4LCJtAJP3R5PM8IZs0BT
         YroiFTBwLx75EI4WKdPDRKP7Z9W/ShOZ8kZgf6ipL7nJ4OJvNfvKn2KNGvKbsKp2K88F
         +B/R+Iit2WSk3DNa8xrwVuAhCUIEeXVF3L3sA=
Received: by 10.227.134.136 with SMTP id j8mr6428974wbt.206.1283278991667;
        Tue, 31 Aug 2010 11:23:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i14sm7893407wbe.12.2010.08.31.11.23.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 11:23:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154956>

Junio C Hamano wrote:

> Hmm, do we plan on that?  It sounds a little bit insane.

I sent an RFC patch with -1 as internal representation for "git grep
-Cinfinity".  Infinity was the length Yaroslav was most interested in
for merge.log (not sure why, really).

Regardless, it's true that that would probably not be a detail to
expose.

> How about doing this on top?
[...]
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -322,7 +322,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  	const char *message = NULL;
>  	struct option options[] = {
>  		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
> -		  "populate log with <n> entries from shortlog",
> +		  "populate log with at most <n> entries from shortlog",
>  		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
>  		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
>  		  "alias for --log (deprecated)",
> @@ -350,7 +350,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  	if (shortlog_len < 0)
> -		shortlog_len = DEFAULT_MERGE_LOG_LEN;
> +		die("Negative --log=%d???", shortlog_len);

Looks good to me (modulo punctuation :)).
