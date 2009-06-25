From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 1/8] gitweb: refactor author name insertion
Date: Fri, 26 Jun 2009 01:01:27 +0200
Message-ID: <200906260101.28054.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com> <200906260055.11347.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 01:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxwt-0008Iq-QX
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 01:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbZFYXBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZFYXBc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 19:01:32 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58677 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbZFYXBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 19:01:32 -0400
Received: by fxm9 with SMTP id 9so1783195fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RtAjIG8WtRIafiCWvyYfuMeFxKj+n1GrAP0wowzdxHs=;
        b=EbHFmaO08iiijz+sUBnGpHSgrhhwmGS0jDMCGHZAoSY+CKJyNpHpy9f/VMoQ6b1wBU
         DjF6zGFddpybVifUPhVb72A8UztVWfdY5spYpgaHg4guMujBoH3W4L+Bw344LcZFbUnA
         96B8p8+P1Ikd3EVoU1wNvApgb07SfcVH5w5WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ij6m3Kf11sbn5nlo14wrNodv/8AjWKocnCC9wgdz3jihCUep1MXn9GfoGxsvsla+y1
         /UHOl44U4/35N4boUSY00EZDXh78UvCwG+RxwlBqS80t23eyfSAn/Kp+jUGwNf4pzZ94
         F7yi3SBuk/08yXX4VxZPvDe7Yd8vr1P76SosQ=
Received: by 10.86.59.18 with SMTP id h18mr3112645fga.44.1245970894230;
        Thu, 25 Jun 2009 16:01:34 -0700 (PDT)
Received: from ?192.168.1.13? (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id d4sm56761fga.3.2009.06.25.16.01.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 16:01:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906260055.11347.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122257>

On Fri, 26 June 2009, Jakub Narebski wrote:
> On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> > @@ -5094,9 +5127,9 @@ sub git_log {
> >  		      " | " .
> >  		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
> >  		      "<br/>\n" .
> > -		      "</div>\n" .
> > -		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
> >  		      "</div>\n";
> > +		      git_print_authorship(\%co);
> > +		      print "<br/>\n</div>\n";
> >  
> >  		print "<div class=\"log_body\">\n";
> >  		git_print_log($co{'comment'}, -final_empty_line=> 1);
> 
> Here you replace inline <i> element with <div> _block_ element, 
> destroying layout.  Replacing default of 'div' by default of
> inline <span> element restores old layout.

Note: here we want <span>.

> > @@ -5579,7 +5595,7 @@ sub git_commitdiff {
> >  		git_header_html(undef, $expires);
> >  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
> >  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
> > -		git_print_authorship(\%co);
> > +		git_print_authorship(\%co, 'localtime' => 1);
> >  		print "<div class=\"page_body\">\n";
> >  		if (@{$co{'comment'}} > 1) {
> >  			print "<div class=\"log\">\n";

Note: here we want <div>.

Whether default would be 'span' or 'div', at least one of those has to
pass explicit 'tag' / '-tag' parameter.  I guess it would be easier to
pass 'tag' => 'span' in git_log().

-- 
Jakub Narebski
Poland
