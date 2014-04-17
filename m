From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] Update SVN.pm
Date: Thu, 17 Apr 2014 07:24:38 +0200
Organization: <)><
Message-ID: <20140417052438.GA13907@camelia.ucw.cz>
References: <20140416141605.GA9692@camelia.ucw.cz> <xmqq61m9gka6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 07:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaeoX-0007r4-VK
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbaDQFYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 01:24:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38935 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbaDQFYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:24:40 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id EF9771C00A6
	for <git@vger.kernel.org>; Thu, 17 Apr 2014 07:24:38 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3H5OcOF013938
	for <git@vger.kernel.org>; Thu, 17 Apr 2014 07:24:38 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3H5OcWd013937
	for git@vger.kernel.org; Thu, 17 Apr 2014 07:24:38 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq61m9gka6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246401>

Hello,

On Wed, Apr 16, 2014 at 12:13:21PM -0700, Junio C Hamano wrote:
> Interesting.  What other strange forms can they record in their
> repositories, I have to wonder.  Can they do
>     2014-01-07T5:8:6.048176Z
> for example?

Roman Belinsky, the author of this fix, witnessed after large scale
conversion that the problem happens with the hour part only.
(SVN commits from the same origin did this with hours but not with
minutes.)  Recorded here:
https://github.com/msysgit/git/pull/126#discussion_r9661916

> I am wondering if it is simpler and less error prone
> to turn all these "we only accept two digits" into "\d+" not only
> for the hour part but also minute and second parts.

But Roman's proposed regexp nicely shows 1) what the standard is and
2) what is the deviation.

Have a nice day,
  Stepan Kasal

> > Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> > ---
> >  perl/Git/SVN.pm | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> > index a59564f..09cff13 100644
> > --- a/perl/Git/SVN.pm
> > +++ b/perl/Git/SVN.pm
> > @@ -1321,7 +1321,7 @@ sub get_untracked {
> >  sub parse_svn_date {
> >  	my $date = shift || return '+0000 1970-01-01 00:00:00';
> >  	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> > -	                                    (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
> > +	                                    (\d\d?)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
> >  	                                 croak "Unable to parse date: $date\n";
> >  	my $parsed_date;    # Set next.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
