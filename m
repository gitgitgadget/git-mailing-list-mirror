From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3 (alternate)] gitweb: Mark "atnight" author/committer times also for 'localtime'
Date: Fri, 18 Mar 2011 23:28:13 +0100
Message-ID: <201103182328.19141.jnareb@gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost> <201103181846.04979.jnareb@gmail.com> <7vmxksw3x8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:28:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0i9u-0007bm-24
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030Ab1CRW2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 18:28:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64844 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933022Ab1CRW2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 18:28:32 -0400
Received: by wwa36 with SMTP id 36so5415413wwa.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2ALwDntQCs6Vmcbkmw9cdNPY7fF8dknk7D19Ll1i7qw=;
        b=ri9io6axyC/RpmrxBonR7QuY9Y4aIhDCOoWhykuJC6+if+dIT17P3w5S4CgcER/f0Z
         kTugT7B/mqMonOJIb+x1KOOzghXWwHIhNA6RUrnM7BjZH9i2Lec5niPQdkzGCO5LmmSN
         OQ02XcjoxuOgEc9kx0Tj3LYwm9B/4KA5nBc58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QpRc5EBiGJKs1pzNYfw2F0qv/vuB+3ooTwy8ZwosjOgPb7m3i88NOKLMwi6WT7t57n
         /nNu2viyqQKMkAQzukbcS1P/H8VMrDP+D8PR5mlhQ5RMoewYOjsf/gF7CO7eHIN/O2lu
         GzTOmIlHOyD9Ux2YXL4oJV43whjCjgj54jC/s=
Received: by 10.216.69.7 with SMTP id m7mr1567415wed.73.1300487311554;
        Fri, 18 Mar 2011 15:28:31 -0700 (PDT)
Received: from [192.168.1.13] (abuz4.neoplus.adsl.tpnet.pl [83.8.197.4])
        by mx.google.com with ESMTPS id k76sm1747946wej.19.2011.03.18.15.28.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 15:28:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmxksw3x8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169373>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Kevin, how about something like this instead?  This preserves _intent_
> > for why there is local time beside GMT time when 'localtime' is disabled
> > better, I think.
> >
> > Junio and Kevin, I am not sure if authorship should remain with Kevin,
> > or should it revert to me; the solution is quite different.
> > About no-change to git_print_authorship: alternate solution would be
> > to remove support for -localtime option, like in original patches.
> 
> I don't think it is worth anything to keep dead code that anybody
> exercises to support -localtime option that nobody asks.

Right.  Especially that refactoring would significantly change this
code.

> I thought we were getting closer (especially if you consider my suggestion
> to the earlier round, but obviously I am biased), but this looks far worse
> than your previous clean-up of Kevin's patch.  What is the point of
> duplicating the atnight logic her?  Why not kill the useless helper
> function "print-local-time", and instead enhance "format-local-time" so
> that whatever this added code does is performed there when the caller asks?

You are right.  I concentrated on the fact that IMVHO Kevin's version of
this 3/3 solved wrong issue (the problem is not GMT + local, but atnight
which needs localtime), but forgot to stop to think how ugly and
duplicated the code is... or at least mark this patch as RFC, request
for comments on resulting look.
 
> Then the caller here would look more or less like:
> 
> 	print "<tr><td>$who</td>" .
>             "... author name, email, avatar ..." .
> 	      "<td></td><td>" .
>             format_timestamp(\%wd, gitweb_check_feature('localtime')) .
> 	      "</td></tr>\n";

Right.

> 
> and format_timestamp would be like
> 
> 	sub format_timestamp {
> 		my %date = %$_[0];
>       	my $use_localtime = $_[1];
> 		my $localtime, $ret, $nite;
> 
> 		$nite = ($date{'hour_local'} < 6);
> 
> 		if ($use_localtime) {
> 			$ret = $date{'rfc2822_local'};
>       		if ($nite) {
>                         	$ret = sprintf("<span class='atnight'>%s</span>", $ret);
> 			}
> 		} else {
> 			... what the current format_local_time does to set
> 	        	... including the spanning part
>               	$ret = "$date{'rfc2822'} ($localtime)";
> 		}
> 		return $ret;
> 	}

Well, if we go this route, and assuming that parse_date does only parsing
and we use separate subroutine for generating date in an rfc2822 format,
then we could mark only time with "atnight" also when 'localtime' feature
is enabled.
 
> Wouldn't it be much cleaner?  You can then clean up the other call site of
> print_local_time in git_print_authorship using the same helper function
> (presumably you would always pass 0 to $use_localtime there), no?

Right.  Well, I'd have to think a bit about API for format_timestamp,
but it looks like good direction.

-- 
Jakub Narebski
Poland
