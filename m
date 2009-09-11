From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: check given hash before trying to create snapshot
Date: Fri, 11 Sep 2009 09:52:48 +0200
Message-ID: <200909110952.50536.jnareb@gmail.com>
References: <4AA96DAF.4070200@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Sep 11 09:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm0wU-0007ZE-8N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 09:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZIKHxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 03:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbZIKHxE
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 03:53:04 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:42911 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbZIKHxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 03:53:03 -0400
Received: by fxm17 with SMTP id 17so617158fxm.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kRu2JQadNuEuzRXRDTv4TJv9WHJ9l6EFgIyF+fQ3JbY=;
        b=NgGCfH0EVwnJHBtWr797MpYfoV4/m1H5CWzuObPl/bbtCQ6q32+yZe+uvQoZBY04hA
         SeRYUig1lM98jry6YcDd609vYsRmpw9kWH9QC68cz6fL570q/zqdmBeqPkZ7U58InxAI
         MtYwwDHhHdcsIYbZb16a3GIIczaf9bklqG8Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TsaPxn4Z9dLsO1kLX8QJRpWSUHTIyqa/Tp3o/4k+sbEOn/77+Xdsp7HbpYtM8wizIM
         ZKaiOkNrQ73YCMTD788FKKyvrQXms98220nxVa7HzNVL0m8cGtnX1awkiVVUCP1xJ/pB
         wI9229FpXNjdRnh5TmFJEDl90w4KJNGnn0tT4=
Received: by 10.86.227.1 with SMTP id z1mr2030477fgg.56.1252655586087;
        Fri, 11 Sep 2009 00:53:06 -0700 (PDT)
Received: from ?192.168.1.13? (abwa69.neoplus.adsl.tpnet.pl [83.8.224.69])
        by mx.google.com with ESMTPS id l12sm1108282fgb.19.2009.09.11.00.53.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 00:53:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4AA96DAF.4070200@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128182>

On Thu, 10 Sep 2009, Mark Rada wrote:

> This patch is dual purposed.
> 
> First, it makes things nicer in cases when you hand craft the snapshot
> URL but make a typo (e.g. netx instead of next); you will now get an
> error message instead of a broken tarball.

This is a very good idea.

> 
> Second, any given treeish will always be translated to the full length,
> unambiguous, hash id; this will be useful for things like creating
> unique names for snapshot caches.

But this is not a good idea, IMHO.

First, it introduces feature that nobody uses (at least yet); we can
introduce this feature when it is needed instead.

Second, I'd rather have better names for snapshots than using full SHA-1.
For snapshot of 'v1.5.0' of repository 'repo.git' I'd prefer for snapshot
to be named 'repo-v1.5.0', and for snapshot of 'next' branch of the same
project to be named for example 'repo-next-20090909', or perhaps
'repo-next-2009-09-10T09:16:18' or 'repo-next-20090909-g5f6b0ff',
or 'repo-v1.6.5-rc0-164-g5f6b0ff'.

I'm not sure what would be the best name of snapshot of given 
subdirectory...


In short: I'd rather not improve on bad design of using full SHA-1
in snapshot name.

> 
> This patch includes test for t9501 to demonstrate the changed
> functionality.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
>  gitweb/gitweb.perl                       |    5 +++--
>  t/t9501-gitweb-standalone-http-status.sh |   26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d650188..4ae960c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5197,8 +5197,9 @@ sub git_snapshot {
>  		die_error(403, "Unsupported snapshot format");
>  	}
>  
> -	if (!defined $hash) {
> -		$hash = &git_get_hash($project);
> +	my $snapshot = &git_get_hash($project, $hash);

Same comment as for PATCH 1/2: don't use '&' subroutine call if it
is not required.


> +	if (!$snapshot) {
> +		die_error(400, "Not a valid hash id: $hash");

Note that we don't use user input in _any_ of other error messages;
you would probably need to sanitize $hash.

By the way, wouldn't 404 (Not Found) be a better error code?

>  	}
>  
>  	my $name = $project;
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index d0ff21d..4f8f147 100644
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -75,4 +75,30 @@ test_expect_success \
>  test_debug 'cat gitweb.output'
>  
>  
> +test_expect_success \
> +	'snapshots: bad treeish id' \
> +	'gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
> +	grep "400 - Not a valid hash id:" gitweb.output'
> +test_debug 'cat gitweb.output'
> +
> +test_expect_success \
> +	'snapshots: good treeish id' \
> +	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output'
> +test_debug 'cat gitweb.output'

Why you don't check for "Status: 400" too?

> +
> +test_expect_success \
> +	'snapshots: good object id' \
> +	'ID=`git rev-parse --verify HEAD` &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output'
> +test_debug 'cat gitweb.output'
> +
> +test_expect_success \
> +	'snapshots: bad object id' \
> +	'gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
> +	grep "400 - Not a valid hash id:" gitweb.output'
> +test_debug 'cat gitweb.output'
> +
> +
>  test_done
> -- 
> 1.6.4.2
> 
> 

-- 
Jakub Narebski
Poland
