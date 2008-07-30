From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT 1.6.0-rc1
Date: Wed, 30 Jul 2008 08:10:12 +0200
Message-ID: <20080730061012.GA4437@blimp.local>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org> <20080728063838.GB4234@blimp.local> <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org> <20080728213727.GA3721@blimp.local> <7vr69dky93.fsf@gitster.siamese.dyndns.org> <7v4p69jefb.fsf@gitster.siamese.dyndns.org> <7vljzlhyt8.fsf@gitster.siamese.dyndns.org> <20080729211745.GA3879@blimp.local> <7vmyk0bb5r.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 08:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4wL-0003eB-H9
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 08:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYG3GKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 02:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbYG3GKR
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 02:10:17 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:24997 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYG3GKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 02:10:17 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf4C8=
Received: from tigra.home (Fac01.f.strato-dslnet.de [195.4.172.1])
	by post.webmailer.de (mrclete mo28) (RZmta 16.47)
	with ESMTP id 306d78k6U4KKtO ; Wed, 30 Jul 2008 08:10:13 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 15375277BD;
	Wed, 30 Jul 2008 08:10:13 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id E7EA936D18; Wed, 30 Jul 2008 08:10:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmyk0bb5r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90750>

Junio C Hamano, Wed, Jul 30, 2008 00:03:44 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> >> Alex, I ran the full test with this, but only on Linux boxes; obviously
> >> not on any flavor of Windows.  I think it is correct, and the "first line
> >> of defence" fix is the same as your patch, so I'd assume it would work for
> >> you as well.  But extra eyeballs are always appreciated.
> >
> > Well, it works on Cygwin too. And I had my eyeballs on the code
> > (wondered first if it will cause more fs accesses than before: it
> > will, in the racy check. Which is correct, AFAICT)
> 
> I thought racy check won't even trigger for gitlinks, no?
> 

I didn't know. But now, come to think of it, there wouldn't be much
point - the gitlinks are always compared by content, aren't they?

> ce_modified_check_fs() has 3 call sites:
> 
>  - the call site in ie_match_stat() is protected with is_racy_timestamp()
>    that is always false for gitlinks;
> 
>  - the call site in ie_modified() we just took care of in the current
>    thread;
> 
>  - the other call site is in ce_smudge_racily_clean_entry(), which is
>    called from write_index() but it also is protected with
>    is_racy_timestamp() that is always false for gitlinks.

So, the change in ce_modified_check_fs is not really needed, because
the gitlink case is never executed?
