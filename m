From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: only display "next" links in logs if there is a next page
Date: Wed, 28 May 2008 02:01:53 -0700 (PDT)
Message-ID: <m33ao23iqv.fsf@localhost.localdomain>
References: <483C97E7.2020504@gmail.com>
	<1211930742-24978-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 11:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1HYs-0004zH-Uu
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 11:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYE1JCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 05:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbYE1JCD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 05:02:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52223 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbYE1JB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 05:01:58 -0400
Received: by ug-out-1314.google.com with SMTP id h2so76369ugf.16
        for <git@vger.kernel.org>; Wed, 28 May 2008 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=CmaAup+dN7xJFtLTXkhBeZ6HUBMF4/zP4V9I2cIG9l4=;
        b=if3DYiyDgR0sSN6n5D22kI8dTO+J7bHFK4Ype0VrJ5ssYIGemdW5wtDn2AE+HFjC21b9U6MkJhNZfRMUeqjXgki2VopzoV83KrJUiDhINNt6YEh5AEperBh8fVgPQT+v7Fem896uQvdiKg+Y3Ji1wZ788QUi6X4JcdzQgQRyo0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=XxRFIvXzSw0vW7UnQhic05gAwBC5KEZ1oIRcNNnghRir11tCWqTO3MtGsd41kxFw+BLZ4r6nHpDMII3MUKkv7Rj7qTfzcGJz2TcTdTAb2y/+EBnoQtkZw4xXQJseaFoPxx6Nh5V78rk9oCVHu+GZ3NtE1Qle5VPE90KJLQC9QcA=
Received: by 10.66.249.20 with SMTP id w20mr3376167ugh.67.1211965315972;
        Wed, 28 May 2008 02:01:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.245])
        by mx.google.com with ESMTPS id 34sm4043008ugh.8.2008.05.28.02.01.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 02:01:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4S91N3g032674;
	Wed, 28 May 2008 11:01:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4S91CV1032667;
	Wed, 28 May 2008 11:01:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1211930742-24978-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83080>

Lea Wiemann <lewiemann@gmail.com> writes:

> There was a bug in the implementation of the "next" links in
> format_paging_nav (for log and shortlog), which caused the next links
> to always be displayed, even if there is no next page.  This fixes it.

Thanks for correcting this.

>  sub format_paging_nav {
> -	my ($action, $hash, $head, $page, $nrevs) = @_;
> +	my ($action, $hash, $head, $page, $has_next_link) = @_;
>  	my $paging_nav;
>  
>  
> @@ -2774,7 +2774,7 @@ sub format_paging_nav {
>  		$paging_nav .= " &sdot; prev";
>  	}
>  
> -	if ($nrevs >= (100 * ($page+1)-1)) {
> +	if ($has_next_link) {
>  		$paging_nav .= " &sdot; " .
>  			$cgi->a({-href => href(-replay=>1, page=>$page+1),
>  			         -accesskey => "n", -title => "Alt-n"}, "next");

This makes logic much simpler.  Nice change.

> @@ -4665,7 +4665,7 @@ sub git_log {
>  
>  	my @commitlist = parse_commits($hash, 101, (100 * $page));

Here I have realized the source of this bug.  Some time ago
git-rev-list acquired '--skip=<number>' option to have _git_ skip
commits and not _gitweb_, which improves performance a bit.  It was
required to implement huge performance improvement, namely getting
details for all commits from a single command, otherwise the
performance improvement of calling one git command instead of
$page_size git commands would be much reduced by generating large
amount of data which would be skipped (wound't be used by gitweb).

Unfortunately this change wasn't reviewed carefully enough; old logic
to decide whether to add 'next' link compared (tried to compare)
number of commits receivied with number of commits requested (via
'--max-count=<number>' option).  I guess that having format_paging_nav
decide whether to add "next" link was a bad idea...

> -	my $paging_nav = format_paging_nav('log', $hash, $head, $page, (100 * ($page+1)));
> +	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
> 

I would agree with Junio here that @commitlist > 100 would be more
readable.

Logic goes as the following: we request ($page_size+1) revisions to
know if there are additional revisions, skipping ($page_size * $page)
revisions; gitweb adds 'next' link if it got more than $page_size
revisions.
 
>  	git_header_html();
>  	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
> @@ -5585,7 +5585,7 @@ sub git_shortlog {
>  
>  	my @commitlist = parse_commits($hash, 101, (100 * $page));
>  
> -	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
> +	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
>  	my $next_link = '';
>  	if ($#commitlist >= 100) {
>  		$next_link =

What about git_history()... oh, I see, it generates paging itself, and
soes not use format_paging_nav() subroutine.  But I think it does not
exhibit mentioned (and corrected) error.  BTW. I *guess* that with
href(-replay=>1, ...) gitweb could use format_paging_nav() also for
other pages...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
