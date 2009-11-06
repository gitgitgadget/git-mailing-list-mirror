From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3/RFC 4/5] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Fri, 6 Nov 2009 19:05:51 +0100
Message-ID: <200911061905.52285.jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com> <1251805160-5303-5-git-send-email-jnareb@gmail.com> <20091105203316.GD17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 06 19:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6TCQ-0006JT-7v
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 19:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758802AbZKFSGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 13:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758204AbZKFSGC
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 13:06:02 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:8758 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbZKFSGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 13:06:00 -0500
Received: by fg-out-1718.google.com with SMTP id e12so378477fga.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=E+yLXbVkK1HhhKNwGCarRbj0Fvvh+dyNpHT00G8nAJ4=;
        b=abGB0guI6DlAWnhFonQFD5bg4xENUhGIp5WZ//tIjMxyWKx+myCtzAkrzmYZpQuCCt
         JBiGNB03/4bU7vuZgLuzicn+vi5dmvJ05R28oiXKBZrlvR5PlWsVxU4Mbf4/ALOGp9mF
         Sahd3EZFARG5cYg+odG7L9s2nAwCPq+12McIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iGJTIsPvQi1H9sArCI8eIm+aaO6puwtovC7iZTMmMUBExCiXEfmHahUwKDrSWXYV7H
         lKLjA89N2TsCt8iL6iNk2sUQwbe8NPA28IslY29O6gvFNdufyh3+j/iOpE0BeHqi88xZ
         fKNZB9bUGtbLxOOr1yimwxf2zHzOnqVFXsw5I=
Received: by 10.87.40.9 with SMTP id s9mr6047649fgj.11.1257530763075;
        Fri, 06 Nov 2009 10:06:03 -0800 (PST)
Received: from ?192.168.1.13? (abwp108.neoplus.adsl.tpnet.pl [83.8.239.108])
        by mx.google.com with ESMTPS id e11sm1455420fga.17.2009.11.06.10.06.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 10:06:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20091105203316.GD17748@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132318>

On Thu, Nov 05, 2009, Petr Baudis wrote:
> On Tue, Sep 01, 2009 at 01:39:19PM +0200, Jakub Narebski wrote:
> > @@ -4806,6 +4820,10 @@ sub git_tag {
> >  
> >  sub git_blame_common {
> >  	my $format = shift || 'porcelain';
> > +	if ($format eq 'porcelain' && $cgi->param('js')) {
> > +		$format = 'incremental';
> > +		$action = 'blame_incremental'; # for page title etc
> > +	}
> >  
> >  	# permissions
> >  	gitweb_check_feature('blame')
> 
>   I'm a bit concerned here. I have somewhat backed out of incremental
> blame myself because I have found (in accord with Junio's old findings)
> that in most cases, incremental blame can be actually slower than normal
> blame because of slow browsers where it takes long to update the page in
> each step.
> 
>   I'm sorry if I missed this in one of your mails, but how fast is
> incremental blame in your implementation? If this still might be an
> issue, I think it should be configurable whether to use incremental
> blame, or perhaps use some quick heuristic wrt. file size (negative
> bias) and history length (positive bias) [not sure if that information
> is quickly available].

Unfortunately I can't benchmark the speed of incremental blame well
because of testing it on a single computer.

What I have found that incremental blame spares at least _server time_,
which means that the time to prepare starting view for incremental blame
(with the contents of file in blame format, unblamed) plus the time to
generate incremental blame data is usually about the same or faster
than the time to generate ordinary blame view.  Quite faster if file
have large number of blamed commits:
  $ git blame -p <file> | grep author-time | wc -l

But even if incremental blame turns out to be slower than incremental
blame it still has the advantage of being _incremental_.  You have at 
least some result soon.  Even more with current implementation which
includes progress report for incremental blame.


What needs to be addressed however is to remove totally unnecessary 
critical section / locking code, as JavaScript is single threaded.
We should take care however that JavaScript code of interactive blame
doesn't take all CPU, for example using technique presented in
  "Timed array processing in JavaScript" by Nicholas C. Zakas
  http://www.nczonline.net/blog/2009/08/11/timed-array-processing-in-javascript/


.....................................................................

If you want below there are very simple benchmark of blame and
incremental blame on a _single_ computer:
  AMD Athlon 1 GHz, 512MB RAM, Linux 2.6.14-11.1.aur.2, Apache 2.0.54
I don't remember however if it is for the most current code.

File               | 'blame'[1] | 'blame_incremental'[2]
================================================================	
blob.h             |     2.346s |  0.443s +  (2.244s /   2.921s)
GIT-VERSION-GEN    |     2.449s |  1.346s +  (3.157s /   3.876s)
README             |     2.713s |  0.508s +  (2.952s /   3.659s)
revision.c         |    19.964s |  4.872s + (11.306s /  32.124s)
gitweb/gitweb.perl |    83.912s | 12.069s + (52.922s / 223.133s)

$ git blame --porcelain   gitweb/gitweb.perl >/dev/null
  0m11.437s user + 0m0.740s sys, 66300minor pagefaults
$ git blame --incremental gitweb/gitweb.perl >/dev/null
  0m11.477s user + 0m0.816s sys, 68945minor pagefaults

Footnotes:
~~~~~~~~~~
[1] Total wall-clock time as returned by gitweb in the page footer.
[2] XXs + (XXs server blame_data / XXs client JavaScript).

-- 
Jakub Narebski
Poland
