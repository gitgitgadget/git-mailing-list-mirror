From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 13:03:04 -0600
Message-ID: <20110119190304.GA30618@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
 <20110119124230.GD23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfdJY-00050e-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab1ASTDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:03:23 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35330 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1ASTDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:03:22 -0500
Received: by ewy5 with SMTP id 5so671142ewy.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Bc/aT28rogDsfIMwjx3ccz3uGozxbcCqwIzEqxAzjLc=;
        b=fGcupzDRWKes26yJSufeDhzWtdsntMRP0RTNyakMaxFc+zTpDczLVgH4Tj6REA9hOW
         8l4Heup3mkMytZ18eJEsnH2pt++bL9uLZnOhzQDbhgYo2SSw0KtN813hHjr/VHkdy9aC
         2ear4F23PyXCctPyVlCmiIUb60RStlRNPapZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CztpeJ4V5ytLnP/CMLIDTltnmkq2VlVsNRLfr4EUxlv7JNVy21gGa1G6BiLLTHMPOW
         BijvC3NsDytNbvCZdo6RardBLdTey+K6yQI06C1GQPixg0lyFcKoXxyTYbyPsr4kywxh
         l/6QNPgfAhCeLPryPo2ruFi/J5WBqNhxo/JbA=
Received: by 10.227.134.2 with SMTP id h2mr1303580wbt.22.1295463801466;
        Wed, 19 Jan 2011 11:03:21 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id q18sm5338577wbe.11.2011.01.19.11.03.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:03:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110119124230.GD23222@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165276>

Jonathan Nieder wrote:

> --- a/setup.c
> +++ b/setup.c
> @@ -509,8 +532,10 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>  	 * validation.
>  	 */
>  	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
> -	if (gitdirenv)
> +	if (gitdirenv) {
> +		trace_printf("trace: gitdirenv = %s\n", gitdirenv);
>  		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
> +	}
>  

The above hunk is a debugging remnant.  I suppose it was foolish to
send out the series so late.  Probably not such a big deal since the
problem Maaartin mentioned remains anyway (that is, the warning is
still confusing).

-- 8< --
Subject: fixup! setup: always honor GIT_WORK_TREE and core.worktree

Remove noisy debug code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git b/setup.c a/setup.c
index c0f5846..e08cdf2 100644
--- b/setup.c
+++ a/setup.c
@@ -532,10 +532,8 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 * validation.
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (gitdirenv) {
-		trace_printf("trace: gitdirenv = %s\n", gitdirenv);
+	if (gitdirenv)
 		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
-	}
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
