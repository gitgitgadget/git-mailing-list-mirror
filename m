From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] notes: dry-run and verbose options for prune
Date: Sun, 16 May 2010 15:53:30 +0200
Message-ID: <4BEFF8DA.502@drmicha.warpmail.net>
References: <ecbe317d2f12d83185f3c3242c0350051e3b4bfa.1273873273.git.git@drmicha.warpmail.net> <4BEF1D93.7070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 15:55:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODeJY-0005jR-N3
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 15:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab0EPNxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 09:53:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42796 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752179Ab0EPNxo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 09:53:44 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B8C3BF761E;
	Sun, 16 May 2010 09:53:41 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 16 May 2010 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iwpBTsBUUKKNAeMZh3r5vdKpL1M=; b=S584ED2D+NTRaBU1tvOQ+y3kdnvXmBfIg5K6yHCcSye+plaKd7yBiXfLfRmEd825UC+ARe3qZfaqb0BXfGMN5oDR6Lf0YzG9vzl3yTvXnZzm5IBrcoMDJhb/rcEVk2/xHxaMMjQzUJdDNOR6P+66P7MVSo2mLf38P3SXBPfHZys=
X-Sasl-enc: OyChIpkeAqex/5Kq1XtXnbDGkg0KKjTsqLO7KA4cHZNO 1274018005
Received: from localhost.localdomain (p548589F2.dip0.t-ipconnect.de [84.133.137.242])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BCA8E4AB621;
	Sun, 16 May 2010 09:53:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <4BEF1D93.7070305@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147191>

Stephen Boyd venit, vidit, dixit 16.05.2010 00:17:
> On 05/14/2010 02:42 PM, Michael J Gruber wrote:
>> @@ -792,7 +792,10 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
>>  static int prune(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct notes_tree *t;
>> +	int show_only, verbose;
>>  	struct option options[] = {
>> +		OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
>> +		OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
>>  		OPT_END()
>>  	};
>>   
> 
> Why not use the standard OPT__DRY_RUN and OPT__VERBOSE macros?

Because of the part you cut out: complete analogy with "git prune".

I don't mind using the OPT__ions, but suggest that unification as a
separate task (involving all occurences of -v and -n, not just this one).

> 
> ---->8----
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 0f32792..6e53c9a 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -122,10 +122,12 @@ OPTIONS
>         is taken to be in `refs/notes/` if it is not qualified.
>  
>  -n::
> +--dry-run::
>         Do not remove anything; just report the object names whose notes
>         would be removed.
>  
>  -v::
> +--verbose::
>         Report all object names whose notes are removed.
>  
>  
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 8c2ac51..0ae2561 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -794,8 +794,8 @@ static int prune(int argc, const char **argv, const char *pr
>         struct notes_tree *t;
>         int show_only, verbose;
>         struct option options[] = {
> -               OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
> -               OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
> +               OPT__DRY_RUN(&show_only),
> +               OPT__VERBOSE(&verbose),
>                 OPT_END()
>         };
>  
> 
> 
