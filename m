From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Funny 'git describe --contains' output
Date: Wed, 29 Aug 2012 11:17:32 -0700
Message-ID: <20120829181731.GD3906@kroah.com>
References: <20120829044840.GA25869@kroah.com>
 <7vr4qqxmt8.fsf@alter.siamese.dyndns.org>
 <7vharmxkzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 20:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6mpn-0004iN-7q
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 20:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab2H2SRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 14:17:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41835 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab2H2SRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 14:17:36 -0400
Received: by pbbrr13 with SMTP id rr13so1656398pbb.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 11:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=T5/mtB0tm7SiadDTGkWyp0YnAOKojQ2OsakjhigNohs=;
        b=g+ukcFsMtGaezYMHiLQsrEmXNWNZOTZVPc1htdJ0xUN4aJfjA/SYRUfQNNFqw9ybtp
         chHPSuyRC0LqoMgYOLnKBcq7BbMpxMtJeYFBJ6TtqMhJPPislWf+C30XPnmE8SxLeKcf
         vWnjuJOAa3o3uBj0xDz6yiB347ICChpa+WYrFwUhGbyRf4hcm2RFOk4YhkTzM1K+D54Z
         7dKjQ1Hw/0EaA2wMvOiLJwrAKYLKDZSNaagQurzY5YdLKg7a0ez4djPWK/31bXdmLM1C
         4wFRsD3zJyqKPSiele2hnTyT1+fLIY7OPXeXCo5M5gKjyF+9IVGDELS8n05HrmRQoETU
         WSZA==
Received: by 10.66.76.197 with SMTP id m5mr4806047paw.66.1346264256317;
        Wed, 29 Aug 2012 11:17:36 -0700 (PDT)
Received: from localhost ([38.96.16.75])
        by mx.google.com with ESMTPS id ox5sm19715274pbc.75.2012.08.29.11.17.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2012 11:17:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkFXJc9gCAhYPSCJl2yNjB56U53DRiZwVrrbSVJMz7hYzoaVENJVr3yio82nWf7by4DHMxH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204491>

On Tue, Aug 28, 2012 at 11:36:46PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Greg KH <gregkh@linuxfoundation.org> writes:
> >
> >> In the Linux kernel tree, commit 0136db586c028f71e7cc21cc183064ff0d5919
> >> is a bit "odd".
> >>
> >> If I go to look to see what release it was in, I normally do:
> >> 	$ git describe --contains 0136db586c028f71e7cc21cc183064ff0d5919
> >> 	v3.6-rc1~59^2~56^2~76
> >> ...
> >> Any ideas?
> >
> > That is 59 + 1 + 56 + 1 + 76 = 193 steps away from the tag v3.6-rc1.
> >
> > $ git name-rev --refs=refs/tags/v3.5-rc1 0136db58
> > 0136db58 tags/v3.5-rc1~83^2~81^2~76
> >
> > which is 83 + 1 + 81 + 1 + 76 = 242 steps away from that tag.
> >
> > So it _is_ odd that the newly tagged tip merged a branch that had
> > smaller development since it merged the commit, but name-rev seems
> > to be measuring the steps it takes from the tags to reach the commit
> > and giving us the one that gives the shortest path correctly.
> >
> > Obviously, that is not the same as "which tag is the oldest one
> > among the ones that can reach this commit?"
> 
> As is usual for what I say, the above is an explanation of what we
> are seeing, not necessarily a justification.
> 
> Given a history of this shape:
> 
>         o---o---o---o TONS!!!
>                      \
>  ---o--o--o--o--o--Y--o---o---Z
>      \   /               /
>       \ /               /
>        X---------------o
> 
> where Y is v3.5-rc1 and Z is v3.6-rc1, "name-rev X" measures the
> distance of the shortest path between Z and X (Z^^2^ = 3 steps away)
> and between Y and X (Y~3^2 = 4 steps away), and uses the tag with
> the shortest path.
> 
> But in order to answer "which is the earlier tag that merges X",
> what "name-rev" measures is not very interesting.
> 
> What we want to see is the tag whose "weight" (imagine these commits
> are beads on strings, and you hold the tag between your fingers and
> lift it, pulling all the commits behind it on the history) is the
> smallest and reaches the commit X in question.  The distance on the
> shortest path to X totally ignores tons of merges that went into the
> mainline between Y and Z.  That is what makes name-rev not useful
> for this purpose.
> 
> That "weight" is what Linus's "rev-list | wc -l" showed, but it is
> fairly expensive to compute.  We do have a code that computes such
> weight in the history bisection code (it computes this exact weight
> for each and every commit that is still suspect, and picks the one
> that is half-way).  We know how to compute it, but I suspect that
> applying that code naively to name-rev would make it unusably slow.

Thanks for the full explaination.  "Normally" this never is an issue for
me, as this is the first time, in the history of Linux stable kernel
releases, that I've ever noticed this.  And I agree, it's probably not
something that can easily be resolved in git, given how it's calculated.

thanks,

greg k-h
