From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix export check in git_get_projects_list
Date: Mon, 29 Dec 2008 13:29:25 +0100
Message-ID: <200812291329.28701.jnareb@gmail.com>
References: <a899d7ef0812270139u7dd28ee1q45a8c05f7c95db2f@mail.gmail.com> <200812280312.02615.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <petr.baudis@novartis.com>
To: "Devin Doucette" <devin@doucette.cc>
X-From: git-owner@vger.kernel.org Mon Dec 29 13:31:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHHH8-0004M8-LH
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 13:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbYL2M3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 07:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbYL2M3w
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 07:29:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:45934 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYL2M3w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 07:29:52 -0500
Received: by nf-out-0910.google.com with SMTP id d3so584720nfc.21
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SRJj6yvH9I64JBry/RIr0NhuSoeqbobElkxkrr5SEGI=;
        b=T3sedIHmiR9rZE9IQgGHdR7XIhlKLSz83jKmPTBCxfJE8iuzwHiKBkFfIOZ/fg8fkE
         ToVUF9Jh75gepWvUnoS+ozPqRjRmURNC7gmAVOAqAXdTf9bY0Zpagk+XwWbhIE4PtyWL
         ZNw2O1F4J89wWHiJsqOoVJqgMp/K7qdhEzBFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ujhXucajVz+VZ7UZjIE0zAwEPT3hlO6teIVYFU5ZjEVL6dLviypALFLbGe6S2c11mF
         cgwmzjt883rO7luvdz1eHj/Rx5qlvgDKYg+x4w4553nk101rl+PqyJktky89n8QlPWTr
         8ZAtiJBJCwO1tks66pnkrJl/wVFSKT8NfwK7w=
Received: by 10.210.58.13 with SMTP id g13mr15916427eba.61.1230553788949;
        Mon, 29 Dec 2008 04:29:48 -0800 (PST)
Received: from ?192.168.1.11? (abvc228.neoplus.adsl.tpnet.pl [83.8.200.228])
        by mx.google.com with ESMTPS id 28sm63466eyg.44.2008.12.29.04.29.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 04:29:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200812280312.02615.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104098>

On Sun, 28 Dec 2008, Jakub Narebski wrote:
> On Sat, 27 Dec 2008, Devin Doucette wrote:

> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 8f574c7..99f71b4 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2147,8 +2147,9 @@ sub git_get_projects_list {
> > 
> >  				my $subdir = substr($File::Find::name, $pfxlen + 1);
> >  				# we check related file in $projectroot
> > -				if (check_export_ok("$projectroot/$filter/$subdir")) {
> > -					push @list, { path => ($filter ? "$filter/" : '') . $subdir };
> > +				my $path = ($filter ? "$filter/" : '') . $subdir;
> 
> Nice and clear, but wouldn't be better to use slightly more effective
> 
> +				my $path = $filter ? "$filter/$subdir" : $subdir;
> 
> Or even, taking care of the case when $filter eq '0'
> 
> +				my $path = defined $filter && $filter ne '' ? "$filter/$subdir" : $subdir;

Err, actually with "$filter ||= '';" earlier in git_get_projects_list
this is not necessary, and is not an improvement.
 
-- 
Jakub Narebski
Poland
