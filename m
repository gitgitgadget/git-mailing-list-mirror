From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 07 Jul 2008 04:42:02 -0700 (PDT)
Message-ID: <m34p71gbuk.fsf@localhost.localdomain>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
	<7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
	<803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
	<7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
	<20080707111803.GF31490@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jul 07 13:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFp7c-0006jy-IO
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 13:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYGGLmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 07:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbYGGLmI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 07:42:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:43986 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbYGGLmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 07:42:06 -0400
Received: by nf-out-0910.google.com with SMTP id d3so639835nfc.21
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=JopfVnMhJMN4g+Mt23LB/ct2POHahCIsDo0bXReQLWQ=;
        b=s2eHpAhEh23goli+R4I+ToHg4X33gOtgWzk87PwHNvt7UYdnromyNmM4ZeF70/VuTC
         E/Km5Oe4n/kUKZnRor+UoYlDvHa9vdKybPLVcwMSzfKDycoX9DR74eCaSM7C/XTDU9dz
         HEYmR8gi7YKoIgIWotIjLYLRcGx1U4IQGdyqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=gHt7zRZmAs2KFK46PT46WP8leayhNOQwJDF0wz5cu3rfl7fkO26bvDWiEIwrnrE51j
         Qlk1RdhS9vsugrVGyqPoQq/Hym9EcPB1vSHcb3qzR0f4xF7uEYzxtMnL5womCYpJGAR4
         Xkbqz0dbCPYShD6ALs4zFXeIZki9uvPPtwmyU=
Received: by 10.210.28.6 with SMTP id b6mr3044551ebb.121.1215430923801;
        Mon, 07 Jul 2008 04:42:03 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.23])
        by mx.google.com with ESMTPS id z34sm6518278ikz.9.2008.07.07.04.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 04:42:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m67BfxHa004416;
	Mon, 7 Jul 2008 13:41:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m67Bfu0H004412;
	Mon, 7 Jul 2008 13:41:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080707111803.GF31490@mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87598>

Theodore Tso <tytso@MIT.EDU> writes:

> On Sun, Jul 06, 2008 at 11:28:36PM -0700, Junio C Hamano wrote:
> > The idea behind ORIG_HEAD is to have an anchoring point before an
> > operation that moves your HEAD in a drastic way.  Think if it as a
> > poor-man's reflog -- in fact it predates reflog.
> > 
> > That is why reset saves away the HEAD before it does its thing, so that
> > you can easily say "Oops, I did not mean it -- reset ORIG_HEAD" to flip
> > back to the previous state.  Both a fast-forward merge and a real merge
> > can be undone by resetting back to ORIG_HEAD.
> > 
> > So in that sense:
> > 
> >  (1) ORIG_HEAD is not strictly necessary these days, because we have
> >      reflogs;
> 
> True, but (and please correct me if I'm wrong) ORIG_HEAD will always
> be pointing out HEAD before the user typed pretty much any git
> porcelein command (which saves HEAD into ORIG_HEAD), but with reflogs,
> it you have to paw through multiple HEAD@{n} to find the 'n' which
> corresponds to state before executing the git plumbing command, since
> multiple git plumbing commands could have updated the HEAD's reflog,
> right?

You can always use _branch_ reflog, either in the <branch>@{1} form,
or in @{1} shortcut form.  @{1} should be equovalent to ORIG_HEAD
even for rebase.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
