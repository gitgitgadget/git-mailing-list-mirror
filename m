From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 19:15:47 +0100
Message-ID: <200812181915.48556.jnareb@gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com> <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com> <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 19:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDNQx-0003EC-HW
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 19:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYLRSP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbYLRSP4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 13:15:56 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:61354 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYLRSPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 13:15:55 -0500
Received: by ey-out-2122.google.com with SMTP id 22so30662eye.37
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 10:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OUhDfkJ/bmYS1Somh2lh/Wp7Up2i2QX0CGxpVb7BpOs=;
        b=dLOFRzPh2k7xqzuxw+DpsLhx+r+lCwZ85DF8AalgmKA8iYK2XjzDQH2/JqYEG/r3LM
         EDbP0yXKFvfiDRvuYWHCvruJ+e77ozKPHZyCV1P+UbjOISSi5wABId25aqd9vVZLHdRt
         710rjzXFNjeFTP1NMF9HWlhbXrcQYgN4lxdX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DayWoD9J5HU5st4ZFTMhjpGedeJ8M7hpghnrmGKi4S9Q6buFCv2ZzBiaac6kEXIBgL
         rBhUf5/GVEnLcDEt33iuPy1RKREsXnl21KIjePH1OU4tItq4TKLzAK2zstDoUv1LVAr8
         gCyYlzXx7wGC1rkm1KOE0+7ww6GpFeOmMkRv8=
Received: by 10.210.59.3 with SMTP id h3mr2622207eba.87.1229624153317;
        Thu, 18 Dec 2008 10:15:53 -0800 (PST)
Received: from ?192.168.1.11? (abwk173.neoplus.adsl.tpnet.pl [83.8.234.173])
        by mx.google.com with ESMTPS id 24sm269453eyx.55.2008.12.18.10.15.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Dec 2008 10:15:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103479>

On Thu, 18 Dec 2008, Junio C Hamano wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
> 
> >  sub git_commitdiff {
> >  	my $format = shift || 'html';
> > +	my %params = @_;
> > ...  
> > +			if ($params{-single}) {
> > +				push @commit_spec, '-1';
> > +			} else {
> > +				if ($patch_max > 0) {
> > ...
> > +			}
> > @@ -5625,6 +5635,10 @@ sub git_commitdiff_plain {
> >  
> >  # format-patch-style patches
> >  sub git_patch {
> > +	git_commitdiff('patch', -single=> 1);
> > +}
> 
> Hmm, if you are changing the interface this way, wouldn't it make more
> sense to also do this?
> 
> 	git_commitdiff(--format => 'patch', --single => 1);
> 	git_commitdiff(--format => 'html');

Just a though, but does it really take much sense to have "patch" and
"patches" views handled in git_commitdiff? I can understand in the
first version, where it was more about better 'commitdiff_plain', but
I wonder about now, where patch(es) view is something between git show
and log_plain format... Wouldn't it be simpler to use separate 
subroutine, for example git_format_patch or something?

-- 
Jakub Narebski
Poland
