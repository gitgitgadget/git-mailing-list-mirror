From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Wed, 25 Sep 2013 12:44:03 -0700
Message-ID: <20130925194402.GA9464@google.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOv0P-00012u-MD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab3IYToJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:44:09 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58468 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3IYToH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:44:07 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so129174pde.9
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O3WedaCu7N6B0wFY6uwnAinzg483Y0r7CGKfrmQnzao=;
        b=x4NuVEb8N8W+wRQEG2wgXg3ViMH7G9+CYESVaQUhDYEtqe3jV6mSkOE3eML7ZkUlhR
         Keuazi5ezPqvo/LXSl1I7Ho+hk9SevHvBFX48gaU/3id7Kry4y2mmOBrnuqkiTbzlpG7
         VSnnJ92kg05SN857j1p/DVgUEvyvAYUXnjVdeKR/wEO8dSvEEF2qhULVuWn1GiX9jjH6
         7DvcFH1jLt8Nbx4ErD1MyqLysyWblcIx9mvfW4/QOPL843xT4ozSyKTOGhG5c8yKKhKo
         HEUoNYznDs3mmHEbblMcIRvP+5yz5WN43JMBYrfpeglpyuwPPUG31oLSQ0lLasGfox5n
         464Q==
X-Received: by 10.67.4.136 with SMTP id ce8mr1020095pad.158.1380138246780;
        Wed, 25 Sep 2013 12:44:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qf7sm55449489pac.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 12:44:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235372>

Hi,

Keshav Kini wrote:

> The man page for `git svn` describes a situation in which "'git svn'
> will not be able to rebuild" your .git/svn/**/.rev_map files, but no
> mention is made of in what circumstances `git svn` *will* be able to do
> so, or how to get `git svn` to do so.
>
> This patch adds some language to the description of the 'fetch' command
> to rectify this oversight, and also fixes an AsciiDoc escaping typo.
>
> Signed-off-by: Keshav Kini <keshav.kini@gmail.com>

Good idea.

[...]
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -103,9 +103,12 @@ COMMANDS
>  
>  'fetch'::
>  	Fetch unfetched revisions from the Subversion remote we are
> -	tracking.  The name of the [svn-remote "..."] section in the
> -	.git/config file may be specified as an optional command-line
> -	argument.
> +	tracking.  If necessary, rebuild the .git/svn/\*\*/.rev_map.*
> +	files, given the requisite information exists in commit
> +	messages (see the svn.noMetadata config option for more
> +	information).  The name of the [svn-remote "..."] section in
> +	the .git/config file may be specified as an optional
> +	command-line argument.

Taking a step back, the reader might wonder *why* he would want
to run "git svn fetch" to rebuilt these .rev_map.* files, and what
they are for.

Perhaps there should be a separate REVISION MAP section describing
this in more detail.  Something as simple as

	FILES
	-----
	.git/svn/\*\*/.rev_map.\*::
		Mapping between Subversion revision numbers and Git
		commit names.  Can be rebuilt using the git-svn-id:
		lines at the end of every commit as long as the
		noMetadata option is not set (see the 'svn.noMetadata'
		section above for details).
	+
	'git svn fetch' and 'git svn rebase' automatically update
	the rev_map if it is missing or not up to date.  'git svn
	reset' automatically rewinds it.

Then this reference in 'fetch' could just say something like

	...
	argument.
	+
 This automatically updates the rev_map if needed (see
 '.git/svn/\*\*/.rev_map.\*' in the FILES section below for
 details).

> @@ -684,7 +687,7 @@ svn-remote.<name>.noMetadata::
>  +
>  This option can only be used for one-shot imports as 'git svn'
>  will not be able to fetch again without metadata. Additionally,
> -if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
> +if you lose your .git/svn/\*\*/.rev_map.* files, 'git svn' will not

I don't mind seeing this fix snuck into the same commit, but a
separate commit that could be applied more quickly would be even
better. ;-)

Thanks and hope that helps,
Jonathan
