From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 21:55:13 +0200
Organization: At home
Message-ID: <ecfnf0$4bg$1@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org> <7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org> <7vodudno88.fsf@assigned-by-dhcp.cox.net> <86fyfohb4v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 22 21:56:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFcM0-0007d3-4R
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 21:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWHVTz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWHVTz7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 15:55:59 -0400
Received: from main.gmane.org ([80.91.229.2]:6857 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750758AbWHVTz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 15:55:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFcLb-0007VR-RW
	for git@vger.kernel.org; Tue, 22 Aug 2006 21:55:39 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 21:55:39 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 21:55:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25868>

Randal L. Schwartz wrote:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio>        my @result = (); 
> Junio>         for (my $i = 0; $i < @mapping; $i += 2) {
> Junio>                my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
> Junio>                if (defined $params{$name}) {
> Junio>                        push @result, "$symbol=$params{$name}";
> Junio>                }
> Junio>        }
> Junio>         return "$my_uri?" . esc_param(join(';', @result));
> Junio> }
> 
> If you already depend on the LWP package, then the "URI" module
> does precisely what you're reinventing.
> 
> my $uri = URI->new("http://host/base/path")
> $uri->query_form(\%params);
> my $result = $uri->as_string;
> 
> And I'd rely on Gisle Aas's experience about constructing these things
> far more than the thread I've just witnessed here. :)

First, I'd rather not introduce new dependency to git (and I think Junio
would agree). Second, more important, we do _parameters processing_,
it means renaming parameters (e.g. 'file_name' in params is 'p' in CGI URI),
in the future perhaps passing project via PATH_INFO not in query string,
and sorting the CGI parameters.

So it wouldn't be as easy as writing 
        $uri->query_form(\%params); 
        return $uri->as_string;
or as 
        return "$my_uri?" . esc_param(join(";", "$_=$params{$_}") keys %params)'.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
