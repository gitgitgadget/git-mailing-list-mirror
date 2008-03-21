From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add hash parameter in feed URL when a hash is specified in the current request
Date: Fri, 21 Mar 2008 11:53:48 -0700 (PDT)
Message-ID: <m3skyjvrgr.fsf@localhost.localdomain>
References: <ae63f8b50803211138y6355fd11pa64cda50a1f53011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcmOJ-0006fj-Eb
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbYCUSxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755850AbYCUSxy
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:53:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:23129 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbYCUSxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 14:53:53 -0400
Received: by nf-out-0910.google.com with SMTP id g13so669274nfb.21
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=vblPI6WRQZUCtJe8+C9ij7juZkl9IYZ6W0vYprIJ4Fw=;
        b=hxjEwfOKheutyohkXLoKM5Fm2P965kWEe1h8Ukr5zVCDcjggBdEU+yQEbMoQ6cZy+n1CpYXsLunUAPnte+JHjjXwO8B6xbbiJi2Ejf4ripYLtTEjCDxxX4li6Mv5zqXnoC29JFc2+fK/boo+iT4M3+gpHd04Ffk1cKnb4VzsWEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=EYSHmcqjLjt+Is2J3dx9BEVES+q2kktZ0sycS8YgO5Rh4MvXufSCVp+AvuB75G/88rY2TKg+On5HU/ELZ/bNsLhsyuH4oD4wuYmUnL3J/IMadf6hqqyAshpFEr0Sv5yj5Fr5aG1O9sAze0gcfRdhcE+PBj0rQBbiMlyD/EYCauQ=
Received: by 10.78.157.15 with SMTP id f15mr9918433hue.2.1206125630051;
        Fri, 21 Mar 2008 11:53:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.99])
        by mx.google.com with ESMTPS id k10sm5996948nfh.17.2008.03.21.11.53.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Mar 2008 11:53:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2LIrg0b011628;
	Fri, 21 Mar 2008 19:53:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2LIrexK011625;
	Fri, 21 Mar 2008 19:53:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ae63f8b50803211138y6355fd11pa64cda50a1f53011@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77758>

"Jean-Baptiste Quenot" <jbq@caraldi.com> writes:

> Hi list,
> 
> I was annoyed with the RSS feed link at the bottom of gitweb because I
> couldn't find a way to have a specific feed for every branch.  With
> this patch, the generated links include the hash parameter so that
> feeds are context-dependant.
> 
> Hope it helps!
> 
> ---
>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ec73cb1..7d013bd 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -615,6 +615,7 @@ sub href(%) {
>         my %mapping = @mapping;
> 
>         $params{'project'} = $project unless exists $params{'project'};
> +       $params{'hash'} = $hash unless exists $params{'hash'};
> 
>         if ($params{-replay}) {
>                 while (my ($name, $symbol) = each %mapping) {

It is *a* solution, but I don't think it is a *correct* solution for
this problem.  This adds 'hash' parameter to *every* link if parent
view had hash parameter passed or just defined $hash variable for
convenience.  

The project parameter is added implicitely unless turned off 
('project => undef) because almost all links need this parameter;
IMHO this is not the case for hash parameter.

Besides this solution doesn't address the naming of feed links.


I was planning to add context-dependent feed links, both in page
header (<link .../> elements in HTML <head>) and at the bottom of the
page.  Unfortunately to do this *rigth* took me more time than I
though.  (Additionally I got no responses to the post asking about
thoughs on how should this be done:)
  "[RFC] gitweb: Use feed link according to current view"
  Message-Id: <200802111900.12325.jnareb@gmail.com>
I was derailed for a bit, but I can try to do this... but after the
Easter.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
