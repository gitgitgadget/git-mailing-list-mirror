From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Only use GIT_CONFIG in "git config", not other programs
Date: Tue, 15 Jul 2008 19:56:01 +0200
Message-ID: <bd6139dc0807151056q61a9379l84761fe021d4541c@mail.gmail.com>
References: <alpine.LNX.1.00.0806300328380.19665@iabervon.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 19:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIolx-0005l8-8T
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 19:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbYGOR4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 13:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbYGOR4H
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 13:56:07 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:6332 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbYGOR4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 13:56:06 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1665977yxm.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eKkF+ecj4mKPbtXtSQKrkx/U6KGxckyoKd4tejNYZCk=;
        b=nwqFe9cWJgA1m4sO+1EzzD03XCgyYh56aOb1GsJBOJDftwHyrJCc/HvKpqT8EX6wf7
         eBg28Fwv+yLogm2JoHDQ+RvXbQxhxBZpyJbB79Uf2uv0mCmVS4+I+ejPDCvo1azKesdu
         8bwgxR7LIG22qFMKjErZURKWLKbp4ZZ48nk2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=vZCESDBIq4beQQIBsyA3CauOShtZ/HZ9pWcYwc2JhZqfG9vQpiWICUWulEIoRGV8bU
         +UJl3Daj4yvUJoOnPkkxqNRLzhItBRljpEHt9sS+CSbOiBUsCG1K2KgvSv7HLXUu7pJm
         9paM2EBjz2EXhAK3Skriej0fVo55ZXLtCSWxY=
Received: by 10.142.213.9 with SMTP id l9mr4776823wfg.208.1216144561968;
        Tue, 15 Jul 2008 10:56:01 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 10:56:01 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0806300328380.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88584>

On Mon, Jun 30, 2008 at 9:37 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> @@ -611,31 +613,28 @@ int git_config(config_fn_t fn, void *data)
>  {
>        int ret = 0;
>        char *repo_config = NULL;
> -       const char *home = NULL, *filename;
> +       const char *home = NULL;
>
>        /* $GIT_CONFIG makes git read _only_ the given config file,
>         * $GIT_CONFIG_LOCAL will make it process it in addition to the
>         * global config file, the same way it would the per-repository
>         * config file otherwise. */

I noticed today while looking at config.c (because of the 'git config
oddity' thread) that this reference to GIT_CONFIG_LOCAL was not
removed? On latest next:
$ grep GIT_CONFIG_LOCAL *
config.c:	 * $GIT_CONFIG_LOCAL will make it process it in addition to the
git-svn:		my $file = $ENV{GIT_CONFIG} || $ENV{GIT_CONFIG_LOCAL} ||
git-svn.perl:		my $file = $ENV{GIT_CONFIG} || $ENV{GIT_CONFIG_LOCAL} ||

I doubt that this stray comment will hurt anyone, but it's probably
nicer not to let cruft like this accumulate, I think?

-- 
Cheers,

Sverre Rabbelier
