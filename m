From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: Re: [PATCH 1/2] git-svn: Fix merge detecting with rewrite-root
Date: Sat, 13 Mar 2010 08:54:24 +0200
Message-ID: <201003130854.24847.tuomas.suutari@gmail.com>
References: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com> <20100226094317.GA22579@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Mar 13 07:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqLF7-00051I-VH
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 07:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab0CMGyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 01:54:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:60910 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0CMGya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 01:54:30 -0500
Received: by fg-out-1718.google.com with SMTP id l26so668104fgb.1
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 22:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=XIcGcCbFrupewpqvvp6dmhmatM4wKak6K4ihYWZK7KI=;
        b=LxaMTsAUfAKPIDQaFg4G9OoMQV3hZQqJ76qJbb6h0n4TBxhGMFLk1yHbtlGbYxrm9Z
         pAmiBnbKHi15J5q8pgsVMKP6Scy+/th0Eijmv/EfyLZLu+mRUxWYzxvznNYbLpPmKIza
         SDNFBTIzD0kJMI3GpwBWFnE5N7f9nF1VcWPRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=qBzENDGWEuPGrsXrCDQbCFzAG4NsO1n03MS/x3qUWBxqp5RPSRHCOG71JK5AxuZI4g
         5yWT6gWtRpfpgqgg9halEI/VNLST1iyfBVfwAv147qRrE7kCR2qUHp9HwAxDk8oDiYs3
         jUq+tNKXgwbNOk7Fb3p2QO9eQR3xvfnN4E+uY=
Received: by 10.87.68.15 with SMTP id v15mr3794873fgk.64.1268463268987;
        Fri, 12 Mar 2010 22:54:28 -0800 (PST)
Received: from mikrohiiri.localnet (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id l12sm265591fgb.12.2010.03.12.22.54.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 22:54:27 -0800 (PST)
User-Agent: KMail/1.12.3 (Linux/2.6.31-gentoo-r6; KDE/4.3.3; i686; ; )
In-Reply-To: <20100226094317.GA22579@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142087>

Hi Sam,

Could you please provide your feedback on this?

Thanks!

On Fri 2010-02-26 11:43:17 Eric Wong wrote:
> Tuomas Suutari <tuomas.suutari@gmail.com> wrote:
> > Detecting of merges from svn:mergeinfo or svk merge tickets failed
> > with rewrite-root option. This fixes it.
> >
> > Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
> > ---
> > Hi again,
> >
> > now I found another problem while importing SVN repo with git-svn.
> >
> > To speed-up the import, I copied the SVN repo with rsync to localhost
> > and used file:// URL for the import, but because I want to be able to
> > track the history with svn+ssh:// later, I used the rewrite-root
> > option. That seemed to break the merge detecting.
> >
> > With this patch the merge detecting works also with rewrite-root
> > option, but since there are no comments why the $self->rewrite_root
> > was used in the first place, I have no idea, if this is the right
> > thing to do.
> 
> Hi Tuomas,
> 
> I'm not sure why rewrite_root is used here, either.  Ignoring it
> seems correct but I'll wait for Sam to chime in.
> 
> >  git-svn.perl |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 265852f..1cbddca 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -2993,7 +2993,7 @@ sub find_extra_svk_parents {
> >  	for my $ticket ( @tickets ) {
> >  		my ($uuid, $path, $rev) = split /:/, $ticket;
> >  		if ( $uuid eq $self->ra_uuid ) {
> > -			my $url = $self->rewrite_root || $self->{url};
> > +			my $url = $self->{url};
> >  			my $repos_root = $url;
> >  			my $branch_from = $path;
> >  			$branch_from =~ s{^/}{};
> > @@ -3201,7 +3201,7 @@ sub find_extra_svn_parents {
> >  	# are now marked as merge, we can add the tip as a parent.
> >  	my @merges = split "\n", $mergeinfo;
> >  	my @merge_tips;
> > -	my $url = $self->rewrite_root || $self->{url};
> > +	my $url = $self->{url};
> >  	my $uuid = $self->ra_uuid;
> >  	my %ranges;
> >  	for my $merge ( @merges ) {
> 
