From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Fix chop_str to allow for & characters in strings
Date: Tue, 02 Feb 2010 15:43:01 -0800 (PST)
Message-ID: <m3mxzr9pcz.fsf@localhost.localdomain>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net>
	<1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>
	<1265147814-13284-3-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSOo-00032Y-FM
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab0BBXnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:43:10 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:43087 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0BBXnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:43:07 -0500
Received: by ewy28 with SMTP id 28so606852ewy.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3/jVs5c+G8Kp1r6deRyHUYyzyF0dY2pwE3Pw73khJZ4=;
        b=RYJcG7Dp0V8MTK9eJrRh7vxTsP6p5TkCLlrywOxBXSJK7J2u5QDGYTUfWpj2AsaWUd
         cZIbGvYqrj2ajaJWpxBghReGvVNqQEHv903/ANrgyx7WfaVib59OncraKwRvAaciM+NF
         XIyrcjW1QoHl1uAD5u18PDCW6IifWTluCj1BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ssBsYlmO0rdDF9FBrNCOxHX7dQFxJhwshhp64nyWJoECJ+lmu1qsWBIB2KuzjS/NdM
         C4wnk8gXNRfozMFqPP/d2bBVwacqPcpuDZvfubUQyHv5/wjImCg1ZlOg63+PbEcVlqIS
         jR5YfH0aGKIWwNQHFiOfgxamK5zXOc7xzmJoM=
Received: by 10.213.41.203 with SMTP id p11mr2061785ebe.75.1265154183383;
        Tue, 02 Feb 2010 15:43:03 -0800 (PST)
Received: from localhost.localdomain (abvx213.neoplus.adsl.tpnet.pl [83.8.221.213])
        by mx.google.com with ESMTPS id 10sm14072149eyd.45.2010.02.02.15.43.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 15:43:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o12NgbcQ019139;
	Wed, 3 Feb 2010 00:42:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o12NgLUc019123;
	Wed, 3 Feb 2010 00:42:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1265147814-13284-3-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138784>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> I'm unsure why this was placed in their originally, and it seems to
> ultimately stem from code from before gitweb was merged into git core,
> but there's an instance where git chops a string incorrectly based on
> this.
> 
> Specifically:
> 
> 	API & protocol: support option to force written data immediately to disk
> 
> from http://git.kernel.org/?p=daemon/distsrv/chunkd.git;a=commit;h=3b02f749df2cb1288f345a689d85e7061f507e54
> 
> The short version of the title gets chopped to
> 
> 	API ...
> 
> where it should be
> 
> 	API & protocol: support option to force written data...
> 
> This reverts that specific problem.
> ---
>  gitweb/gitweb.perl |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 57771a0..4cc6d19 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1382,7 +1382,6 @@ sub chop_str {
>  		my $body = $1;
>  		my $tail = $2;
>  		if (length($tail) > 4) {
> -			$body =~ s/&[^;]*$//;
>  			$tail = "... ";
>  		}
>  		return "$body$tail";

I think it is a good change.  chop_str is meant to be used _before_
HTML escaping (esc_html or equivalent) is to be applied; removed line
looks like it was meant (badly) to always remove HTML entities
fully... but those entities are only added later.

So now what is left is to come up with proper commit message, and add

Signed-off-by: John 'Warthog9' Hawley" <warthog9@kernel.org>
Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
