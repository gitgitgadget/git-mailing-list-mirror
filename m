From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Mon, 20 Apr 2015 15:10:41 -0400
Message-ID: <20150420191041.GA14362@peff.net>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
 <20150419130745.GA20476@peff.net>
 <xmqqmw22lj7r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkH5l-0002Ap-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbDTTKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:10:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:47758 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753215AbbDTTKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:10:44 -0400
Received: (qmail 5686 invoked by uid 102); 20 Apr 2015 19:10:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 14:10:44 -0500
Received: (qmail 27656 invoked by uid 107); 20 Apr 2015 19:11:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 15:11:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 15:10:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw22lj7r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267488>

On Mon, Apr 20, 2015 at 11:59:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -334,7 +333,7 @@ true)
> >  	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
> >  	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
> >  	eval="$eval $gpg_sign_args"
> > -	eval="$eval -m \"\$merge_name\" $merge_head"
> > +	eval="$eval FETCH_HEAD"
> >  	;;
> >  esac
> >  eval "exec $eval"
> >
> > as we seem to special-case the name FETCH_HEAD. It assumes that
> > git-merge's parsing of FETCH_HEAD is the same as what we do in git-pull,
> > but that seems safe.
> 
> Unfortunately, "git merge"'s parsing of FETCH_HEAD forgets that we
> may be creating an Octopus.  Otherwise the above should work well.

That sounds like a bug we should fix regardless.

> > Unfortunately we still have to compute $merge_head ourselves here
> > for the "git pull --rebase" case.
> 
> That is not that unfortunate, I would say.

I guess not. It is only a few lines of sed. And having the details there
does let us customize the error cases. My main worry would just be a
maintenance one: that somebody modifies git-pull to calculate merge_head
differently, but it turns out that we ignore it when calling git-merge.
But that's probably not that likely to matter in practice.

-Peff
