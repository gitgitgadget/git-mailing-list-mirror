From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and remote branches
Date: Thu, 30 Aug 2007 00:01:38 +0200
Message-ID: <200708300001.39203.jnareb@gmail.com>
References: <favitd$3ff$1@sea.gmane.org> <cb7bb73a0708280253y7d31f347yb84a40982d59d9d2@mail.gmail.com> <cb7bb73a0708280453k4315e80ej170238a52e66dcb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 00:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQWP7-0000px-H4
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 00:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368AbXH2Wwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 18:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758315AbXH2Wwt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 18:52:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:30472 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757681AbXH2Wws (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 18:52:48 -0400
Received: by nf-out-0910.google.com with SMTP id g13so311698nfb
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 15:52:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=WUgq1/BnzqUkqVNYbPgMbjpjAog/BcjFER9jNeVn60SIgPvduHxdlz6jduc3OG7ShEs6BLNIo4uZafHbMo3AKpxZdvQFBPen9w1KZ36kWKEfQk9EchBHfmdAqVtWipwQtX5+8ZxR/SsODEs47RD+2ACrl41zV2P8oMMVY7eVjS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=QZB8Hlv3FioyR5bl1kxieFI8CpZruRbwCQhFVGPavy3jh4sYUeBGZx3miCtmLVTmv0FuJ8f4kbE5JGA72kEqLgoFjjvgSLElr+41wQTqo9G/9+Z3e7nsUTYvziPd5EyEnSSmEV98hEPfCeBdEC7U3ZcKni5MMR5L1SxjGk/GL9Y=
Received: by 10.86.76.16 with SMTP id y16mr872972fga.1188427966657;
        Wed, 29 Aug 2007 15:52:46 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id a37sm10059954fkc.2007.08.29.15.52.40
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Aug 2007 15:52:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0708280453k4315e80ej170238a52e66dcb6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56988>

On Tue, 28 August 2007, Giuseppe Bilotta wrote:
> On 8/28/07, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>>
>> I've given a better look at the code and I think I can whip up a patch
>> to implement the feature. I have no idea about how to create a new
>> option in gitweb though, so I'll have to leave it that to someone
>> else.
> 
> Ok, this is hopefully the last time I reply to myself. I'm inlining
> the quick'n'dirty patch I've whipped up, hoping that gmail doesn't
> destroy it too much..

For quick'n'dirty solution this might be enough. For proper patch to
be accepted I don't think so.

First, in the idea to show also remote branches (from refs/remotes),
I wanted to separate heads list from remotes list in the 'summary'
view, and add 'remotes' view or modify 'heads' view to accept some
parameter specyfying kind of refs.

Second, what was stopping me from implementing that was an idea to
separate remote branches into categories (like gitwbe-xmms2 categories
of projects) defined by the remote it belongs to. And this is not so
easy if we want to respect old .git/branches/ and .git/remotes/ remote
config in addition to new config based remote config.

> -- 
> Giuseppe "Oblomov" Bilotta
> 
> --- gitweb.cgi	2007-08-26 12:41:13.000000000 +0200
> +++ gitweb.cgi-my	2007-08-28 13:47:15.000000000 +0200

It is better to use git to manage source and to generate patches
(use git-format-patch, check Documentation/SubmittingPatches),
and use gitweb/gitweb.perl and not installed version.

[...]
> @@ -1677,8 +1677,9 @@ sub git_get_heads_list {
>  		my ($hash, $name, $title) = split(' ', $refinfo, 3);
>  		my ($committer, $epoch, $tz) =
>  			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
> -		$name =~ s!^refs/heads/!!;
> +		$name =~ s!^refs/(head|remote)s/!!;
> 
> +		$ref_item{'class'}  = $1;
>  		$ref_item{'name'}  = $name;
>  		$ref_item{'id'}    = $hash;
>  		$ref_item{'title'} = $title || '(no commit message)';

Nice, although very minor nit: I'd use

> +		$ref_item{'class'} = $1;


> @@ -3237,8 +3238,10 @@ sub git_heads_body {
>  		$alternate ^= 1;
>  		print "<td><i>$ref{'age'}</i></td>\n" .
>  		      ($curr ? "<td class=\"current_head\">" : "<td>") .
> +		      "<span class=\"refs\"><span class=\"$ref{'class'}\">" .
>  		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}),
>  		               -class => "list name"},esc_html($ref{'name'})) .
> +		      "</span></span>" .
>  		      "</td>\n" .
>  		      "<td class=\"link\">" .
>  		      $cgi->a({-href => href(action=>"shortlog",
> hash=>$ref{'name'})}, "shortlog") . " | " .
> 

I don't understand this double span. First, you can set multiple
classes for HTML element by separating them by space, e.g.

		"<span class=\"refs\ $ref{'class'}\">"

And you could have given appropriate class to <td> or <a> element

-- 
Jakub Narebski
Poland
