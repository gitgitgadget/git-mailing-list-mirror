From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/4] commit.c: replace some literal strings with
 constants
Date: Wed, 16 Feb 2011 23:19:19 -0600
Message-ID: <20110217051919.GA7740@elie>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-4-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 06:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpwH9-0007Mq-23
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 06:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab1BQFTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 00:19:32 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61802 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1BQFT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 00:19:28 -0500
Received: by gyb11 with SMTP id 11so963988gyb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 21:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dP51HnexBMc2PTH2JD11dwoYB00ukDAWZqMLiCi/asQ=;
        b=I4VUQzkPZvne+gKX1p8xKqGc6HXi371V2zKIv3+44cDQP5QAAJzZ0f4L4i3+ntC8Rh
         cRm+E3gLWjvMvoVvRGLboLU4Kr2Zy9ewdbrC0VQwx3m/eDgC9ncK6G97ZeQDDboMgJEj
         y0w3PIPoAa2moKl73nTMBs7DgsMvylGD9VC34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EX3nlHMliPqljChsYaE7dhNNTKDdqdCImMhgI8CJGCKgIA3gLNZYJofEMTcPppECCZ
         GnNWdT6IweDDF1XIgOlrSfA+B20iWiH4JgEL6yDXenWV3zBmLnkBtayqnJTVhCbeRrEg
         v/ph3yBTWV14DNqNPqr/BrQc283j8EdgrHu+Q=
Received: by 10.150.145.9 with SMTP id s9mr1849066ybd.125.1297919967911;
        Wed, 16 Feb 2011 21:19:27 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id u31sm386985yba.9.2011.02.16.21.19.26
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 21:19:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297916325-89688-4-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167041>

Jay Soffian wrote:

> I converted these per
> http://article.gmane.org/gmane.comp.version-control.git/167015
>
> Maybe this should be the last patch in the series; it's questionable to
> me whether it's even worth doing.

What have I wrought?  I think this makes the code much less readable.

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -626,13 +632,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		format_commit_message(commit, "fixup! %s\n\n",
>  				      &sb, &ctx);
>  		hook_arg1 = "message";
> -	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
> -		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
> -			die_errno("could not read MERGE_MSG");
> +	} else if (!stat(git_path(merge_msg), &statbuf)) {
> +		if (strbuf_read_file(&sb, git_path(merge_msg), 0) < 0)
> +			die_errno("could not read %s", merge_msg);

So now a person needs to look earlier in the file to see that
merge_msg means "MERGE_MSG" rather than being something that
can vary.

Yes, commit_editmsg has the same problem.  If I get to choose[*] then
cache.h would contain something like

	#define MERGE_HEAD_FILE "MERGE_HEAD"
	#define PREPARED_COMMIT_MESSAGE_FILE "MERGE_MSG"
	#define <description of SQUASH_MSG goes here> "SQUASH_MSG"

and commit.c or cache.h would contain something like

	#define EDITABLE_COMMIT_MESSAGE_FILE "COMMIT_EDITMSG"

and those symbolic names would be used throughout builtin code to
name those files.  So we would get

 (1) documentation of what filenames are special to git, collected
     in one place
 (2) protection against typos

without losing

 (3) names that look like constants

Jonathan

[*] and I shouldn't!  What I like should matter much less than what is
right.
