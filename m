From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for
 color.diff
Date: Wed, 27 Apr 2011 04:03:23 -0500
Message-ID: <20110427090323.GA14849@elie>
References: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
 <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elias Persson <delreich@takeit.se>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0en-0003zr-H5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab1D0JDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 05:03:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44195 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab1D0JDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 05:03:31 -0400
Received: by iwn34 with SMTP id 34so1193488iwn.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=asV6dwEmygLeQcYlykYnkp6/41HhwC3bEFdX3BtAXU0=;
        b=Rk8qXKwOP6WVUVmNvpcnRu6H7HIAO61arIxzz0E2trhNrLAJ/J+RRT83nKAAeA+q+n
         0nrmUxEhqk7ytjh3Igey0f2ueXVKvwHEKz4quQTm5WrmVnilscOxTvE2opJXdgT/OIan
         3RJnE7+mXNPzH0WBqWBhXIYXIO33rbhjLm8vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fedEn0Tls0497QQW8s/w3/QJnYYsxZtP19U7+0GosfWDFHJ8sXiNER2QF4L3ljRlhD
         Gyck4fgpwZSuf2hhvLqUySzyV0V2hMXtifxVpcIIWDwohZxEHDic53l/1+g4n3tUN2oe
         dsw9xSS8A86vZzi8yuN4m5zbQJQQ063V24H4Q=
Received: by 10.231.199.77 with SMTP id er13mr1465304ibb.52.1303895010386;
        Wed, 27 Apr 2011 02:03:30 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id f28sm257249ibh.16.2011.04.27.02.03.28
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 02:03:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172202>

Michael J Gruber wrote:

> Reading the diff-family and config man pages one may think that the
> color.diff and color.ui settings apply to all diff commands. Make it
> clearer that they do not apply to the plumbing variants
> diff-{files,index,tree}.

Sounds like a good idea.  Quick reactions:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -708,7 +708,7 @@ second is the background.  The position of the attribute, if any,
>  doesn't matter.
>  
>  color.diff::
> -	When set to `always`, always use colors in patch.
> +	When set to `always`, always use colors in patch for porcelain commands.
>  	When false (or `never`), never.  When set to `true` or `auto`, use
>  	colors only when the output is to the terminal. Defaults to false.

I am not sure I like promising that all porcelain commands will use
color; for example, "git commit -v" does not (though "commit -v
--dry-run" does).  Maybe:

	Whether to use ANSI escape sequences to add color to patches.
	If this is set to `always`, linkgit:git-diff[1],
	linkgit:git-log[1], and linkgit:git-show[1] will use color
	for all patches.  If it is set to `true` or `auto`, those
	commands will only use color when output is to the terminal.
	Defaults to false.
+
This does not affect linkgit:git-format-patch[1] or the
'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
command line with the `--color[=<when>]` option.

> @@ -796,7 +796,7 @@ color.status.<slot>::
>  	color.branch.<slot>.
>  
>  color.ui::
> -	When set to `always`, always use colors in all git commands which
> +	When set to `always`, always use colors in all porcelain commands which
>  	are capable of colored output. When false (or `never`), never. When

Nitpick: the grammatical subject of the dependent clause ("when set to
always") and the rest of the sentence ("always use colors") differ, so
the sentence sounds awkward.  Not your fault, but while we're here, it
might be nice to change that.

I think the intent is something like

	This variable determines the default for color.branch,
	color.diff, color.grep, color.interactive, color.showbranch,
	and color.status, and its scope will expand as other commands
	learn configuration to set a default for the --color option.
	Set it to "always" if you want all output not intended for
	machine consumption to use color, to "true" or "auto" if you
	want such output to use color when written to the terminal,
	or to "false" or "never" if you prefer git commands not to
	use color unless enabled explicitly with some other
	configuration or the --color option.

In other words, it's closer to "all appropriate commands" than "all
porcelain".  format-patch is porcelain.  Not sure what a concise way
to say that is, though.

Thanks, and hope that helps.
Jonathan
