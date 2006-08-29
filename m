From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Tue, 29 Aug 2006 10:23:39 +0200
Organization: At home
Message-ID: <ed0ths$okn$1@sea.gmane.org>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org> <11567998513000-git-send-email-jnareb@gmail.com> <7vveocpfa3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 29 10:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHyt6-0001XW-8w
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 10:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWH2IXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 04:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWH2IXp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 04:23:45 -0400
Received: from main.gmane.org ([80.91.229.2]:11923 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750831AbWH2IXo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 04:23:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GHysj-0001SR-6M
	for git@vger.kernel.org; Tue, 29 Aug 2006 10:23:38 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 10:23:37 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 10:23:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26192>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Add local time (hours and minutes) and local timezone to the output of
>> git_print_authorship command, used by git_commitdiff.
> 
> Looks nice, thanks.
> 
> Now I got envious seeing people are having SO MUCH FUN with
> gitweb, so here is mine...
> 
> Likes, dislikes, "your color selection sucks ;-)",... ?
> 
> -- >8 --

> +td.age-week   { color: #00f; background-color: #fff; }
> +td.age-month  { color: #00f; background-color: #eef; }
> +td.age-season { color: #00f; background-color: #ddf; }
> +td.age-year   { color: #00f; background-color: #ccf; }
> +td.age-old    { color: #00f; background-color: #bbf; }

Could you use full hex color length? Everywhere else in CSS we use 
6-char wide hex colours.

> +     my $now = time();
>       while (<$fd>) {
> -             /^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
> -             my $full_rev = $1;
> +             my ($full_rev, $author, $timestamp, $zone, $lineno, $data) =
> +                 /^([0-9a-fA-F]{40})\s\((.*?)\s+(\d+)\s
> +                 ([-+\d]{5})\s+(\d+)\)\s{1}(\s*.*)/x;

Nice compact style. But different from other parsing using regexp in gitweb.
And some of those other, e.g. parse_difftree_raw_line cannot use this style.
Doesn't matter much.

>               my $rev = substr($full_rev, 0, 8);
> -             my $lineno = $2;
> -             my $data = $3;
> +
> +             my $age = $now - $timestamp;
> +             my $ago = age_string($age);
> +             my $pop = "$author, $ago";
> +             my $agegroup =
> +                 (($age < 60*60*24*7) ? "age-week" :
> +                  ($age < 60*60*24*30) ? "age-month" :
> +                  ($age < 60*60*24*120) ? "age-season" :
> +                  ($age < 60*60*24*360) ? "age-year" : "age-old");

We have age_class subroutine which does something similar.
I'm not sure if one subroutine can be used for those two situations.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
