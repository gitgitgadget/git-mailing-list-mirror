From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/13] transport-helper: use the new done feature to
 properly do imports
Date: Sun, 29 Aug 2010 17:02:39 -0500
Message-ID: <20100829220239.GG1890@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-6-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OppzV-0001Zd-A9
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab0H2WEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 18:04:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45318 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0H2WEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 18:04:24 -0400
Received: by gyd8 with SMTP id 8so1770200gyd.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H+ACuBMLoK10C7YU71p7bg8O3Ww/A0M2/bYYS6Q9qrU=;
        b=sU/x4vVSyd8dap3BjUGYtJ+67H+EiJk4/xhYtuWi7qhrTjvf0r3ADQ4JpqndyqEKT/
         YBJ6Qo6rZiAN6evZB6McsvZ3UV3OYZDnzjfp0XXFuBNgHTFp3N7OAm28aciQeLDBvMYl
         vwaM9RgQbDHy9IK84noB0DeiP9rPsvcQh3SQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Fy0FaLeQq8zN9i2JxPoljErSRrrOwG6TBRJRN4RI+Qz0+32EpP8Xsrk2/9x6N2Wd+P
         U9++Z9OBC/E9skCvj4gpQ4+NJEwBXDlZLo7fhm4IWwvM5Uh4QxyJlDm38vHLpaKXqci6
         rITMYB3/QLXHHBPs5AenOHKTpAx69bArVKMfE=
Received: by 10.150.199.15 with SMTP id w15mr420278ybf.180.1283119463591;
        Sun, 29 Aug 2010 15:04:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i4sm6759492ybd.3.2010.08.29.15.04.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 15:04:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-6-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154725>

Sverre Rabbelier wrote:

> Previously, the helper code would disconnect the helper before
> starting fast-import. This was needed because there was no way to signal
> that the helper was done other than to close stdout (which it would
> do after importing iff the helper noticed it had been disconnected).
[...]
>   I really like what this does for the sanity of the import

Yeah, agreed.

> Instead, request that the fast-export uses the 'done' command
[...]
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -124,6 +124,8 @@ def do_import(repo, args):
>      repo = update_local_repo(repo)
>      repo.exporter.export_repo(repo.gitdir)
>  
> +    print "done"

I am probably not reading carefully enough, but I do not see what
this has to do with fast-export.  Is the patch actually about
something like this?

	Use the 'done' command where possible for remote
	helpers.

	In other words, use fast-export --use-done-feature to
	add a 'done' command at the end of streams passed to
	remote helpers' "import" commands, and teach the
	remote helpers implementing "export" to use the 'done'
	command in turn when producing their streams.
