From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 9 Jul 2012 23:03:21 +0100
Message-ID: <20120709220321.GE30213@beczulka>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
 <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
 <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoM3I-0003qm-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 00:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab2GIWD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 18:03:27 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:65524 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab2GIWD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 18:03:26 -0400
Received: by wibhm11 with SMTP id hm11so3834262wib.1
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 15:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=tW/Iai8kv5AyZrsN3GR9dJkSliPLfbchhC1zMswYmYo=;
        b=YapJG9phNNehd+LKIqsgpkFJYBNTGWFEZV2efZNSbHCZhv49DXP6rdDYPmgfIJjyU4
         apEuIT82SgSDCQt0lLDL8TrqV9yVy7bjIUgDmncb0TF8hdLyygeXeZYjvL7QEZ4tRtES
         GsK60IBwMTCpVTaThplHLxzURjw3klKjI6U1Y8FRfyozfDOvlt3vY7foNAY+r9lNiZSW
         v9MzOONZwULtampUBqlu67c01SVCNGOGGRFsKWmm0bfCNS3KYFQrIWGnlQnKhvsHWj0n
         Kme3wEYeCGfFRtlsvI1LY5zy/om/3hCc5K3L+Gwaix/BflhWdTHJ+IUccZR5du5ENj12
         Jl0Q==
Received: by 10.180.105.163 with SMTP id gn3mr32895494wib.2.1341871404925;
        Mon, 09 Jul 2012 15:03:24 -0700 (PDT)
Received: from beczulka ([89.100.125.149])
        by mx.google.com with ESMTPS id n6sm37994900wie.7.2012.07.09.15.03.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jul 2012 15:03:23 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1SoM37-0002do-VU; Mon, 09 Jul 2012 23:03:21 +0100
Content-Disposition: inline
In-Reply-To: <20120626223215.GB8336@beczulka>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQmAvHRULXc2YwSrizDgwlfeK1axg6o6aWUKK8KTpSIMgCcyTHS3kQfKJX5/72/aDsalskH6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201228>

On Tue, Jun 26, 2012 at 11:32:15PM +0100, Marcin Owsiany wrote:
> On Tue, Jun 26, 2012 at 03:03:07PM -0700, Junio C Hamano wrote:
> > Marcin Owsiany <marcin@owsiany.pl> writes:
> > 
> > > diff --git a/git-svn.perl b/git-svn.perl
> > > index 0b074c4..2379a71 100755
> > > --- a/git-svn.perl
> > > +++ b/git-svn.perl
> > > @@ -1612,9 +1612,9 @@ sub post_fetch_checkout {
> > >  		}
> > >  	}
> > >  
> > > -	my $valid_head = verify_ref('HEAD^0');
> > > +	return if verify_ref('HEAD^0');
> > >  	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
> > 
> > Given that your original motivation was "I do not want master, I am
> > using something else for my primary branch", I change that still
> > shows "update-ref refs/heads/master" smells like sweeping something
> > under the rug
> 
> I'm not so sure... With this change, git-svn will only create master on
> the initial "clone" and I think that's fine. It's consistent with what
> "git clone" does when cloning a regular git repository.
> 
> It seems that I have slightly misinterpreted git-svn's actions in my
> initial post in 2009. I thought it always updated "master" to the
> most recent upstream commit. In reality it only every _creates_ it at
> the most recent commit. But never fast-forwards it if it pre-exists.
> 
> This makes my idea to do the same to "my something else instead of
> master" much less attractive. In fact I don't think such behaviour would
> be useful.
> 
> I think with the suggested patch git-svn works as I would like it to:
>  - creates "master" at initial checkout - consistent with git clone
>  - using a different "tracking-like" branch is possible with "dcommit"
>  - does not re-create "master" on fetch - so the annoying part is gone

Any comments?

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
