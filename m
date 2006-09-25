From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [laroche@redhat.com: gitweb.cgi]
Date: Mon, 25 Sep 2006 18:32:22 +0200
Organization: At home
Message-ID: <ef90an$4ua$1@sea.gmane.org>
References: <20060925161934.GA18951@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 25 18:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRtOe-0003Be-Ro
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 18:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWIYQd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWIYQd2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 12:33:28 -0400
Received: from main.gmane.org ([80.91.229.2]:42413 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751248AbWIYQd1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 12:33:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRtON-000378-FN
	for git@vger.kernel.org; Mon, 25 Sep 2006 18:33:15 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 18:33:15 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 18:33:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27742>

Florian La Roche wrote:

> Hello git crew,
> 
> I'm not a big perl prorammer, but the following removes perl
> warnings about accessing undefined vars.
[...] 
> --- gitweb/gitweb.perl
> +++ gitweb/gitweb.perl
> @@ -427,7 +427,9 @@ sub esc_html {
>       my $str = shift;
>       $str = decode("utf8", $str, Encode::FB_DEFAULT);
>       $str = escapeHTML($str);
> -     $str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
> +     if (defined $str) {
> +             $str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
> +     }
>       return $str;
>  }
> 
It would be better to just use

        my $str = shift;
        return '' unless defined $str;

and neither your change in esc_html, nor the change below should be needed. 
By the way, commit without title? But it would be better if correct it, to
set $co{'title'} to an empty string, either in git_log or in parse_commit.
 
> @@ -2860,10 +2819,14 @@ sub git_log {
>               my $ref = format_ref_marker($refs, $commit);
>               my %co = parse_commit($commit);
>               next if !%co;
> +             my $esc_title = $co{'title'};
> +             if (defined $esc_title) {
> +                     $esc_title = esc_html($esc_title);
> +             }
>               my %ad = parse_date($co{'author_epoch'});
>               git_print_header_div('commit',
>                              "<span class=\"age\">$co{'age_string'}</span>" .
> -                            esc_html($co{'title'}) . $ref,
> +                            $esc_title . $ref,
>                              $commit);
>               print "<div class=\"title_text\">\n" .
>                     "<div class=\"log_link\">\n" .

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
