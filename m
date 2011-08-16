From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add diffmerge as a pre-configured
 mergetool option
Date: Tue, 16 Aug 2011 03:09:52 -0700
Message-ID: <20110816100949.GA10859@gmail.com>
References: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
 <7vaaxrn10o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 12:10:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGb3-0007ww-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 12:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1HPKKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 06:10:04 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46966 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab1HPKKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 06:10:01 -0400
Received: by yie30 with SMTP id 30so3688393yie.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9OfJ99BtCNwhbOmNZCKRpAqTd/icjvTw2sy+/p6uvnM=;
        b=pq2O4UBHn3L25TPr2bDuE/SEjnR/bocfSTGu6EeAmqOlg2P5GgAVzFkf+7BQEkTr+/
         SOlHWxcZoTEw0flnsFSvC+p58mmu20df0aeDzZHE6WQJgWbv6RIH7nKG3Sy1jZtA51Q/
         rV5LDr6VoXorPHGH7DhPNA0bqbJakwdlJR624=
Received: by 10.236.186.36 with SMTP id v24mr15158852yhm.137.1313489400733;
        Tue, 16 Aug 2011 03:10:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c63sm4863146yhe.18.2011.08.16.03.09.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 03:10:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaaxrn10o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179428>


(continuing an old thread...)
http://thread.gmane.org/gmane.comp.version-control.git/134906/focus=135006

On Wed, Dec 09, 2009 at 04:08:55PM -0800, Junio C Hamano wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index 5b62785..5b29fef 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -46,7 +46,8 @@ check_unchanged () {
> >  valid_tool () {
> >  	case "$1" in
> >  	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
> > -	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge)
> > +	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge | \
> > +	diffmerge)
> >  		;; # happy
> >  	tortoisemerge)
> >  		if ! merge_mode; then
> 
> As we are in pre-release feature freeze, it doesn't matter very much if I
> take this patch now, so I'll let it sit in the list archive for now.
> 
> But I have to wonder about the maintainability of this file, if we have to
> add every time somebody finds yet another diff/merge backends that could
> be used, even a closed-source one.
> 
> There are only a handful of entry points that mergetool--lib defines, and
> by overriding what should happen when these entry points are called, an end
> user should be able to tell mergetool/difftool to use a new backend.
> 
> Perhaps it is a better approach to first eject bulk of code for the
> backends we currently support under these case statements into separate
> files, one per backend, move them to mergetool/ subdirectory in the source
> tree, install them as "$(share)/git-core/mergetool/$toolname", and at
> runtime source them?  That way, a patch to add a new backend can be as
> simple as adding a new file in mergetool/ and doing nothing else.  Also an
> end user can privately add support to a new backend much more easily.
> 
> Anybody want to try that approach?

I've started working on splitting this file apart and it is
coming along nicely.  I should have some patches soon.

We're approaching feature freeze so I will hold onto them for a
bit.  I worked the "meld should use --output with >= 1.5.0"
check into it too, which worked out nicely with the refactored
setup as that logic is neatly tucked away into the meld file.

Is it okay if we install the files into
$(git --exec-path)/mergetools/ instead?  I didn't spot an
obvious way to construct $(share)/git-core/ at runtime
(without dirname tricks that assume share=$(prefix)/share).
-- 
					David
