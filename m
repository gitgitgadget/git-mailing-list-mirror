From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 22:46:26 +0530
Message-ID: <20101018171624.GK22376@kytes>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes>
 <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7tKn-0006Rr-J3
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab0JRRRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:17:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58152 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0JRRRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:17:11 -0400
Received: by iwn35 with SMTP id 35so285371iwn.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NmJtDHUQ49fPb4UzerTS81Nn1yofa/HNdlMCqRNgyrc=;
        b=n933DCqZO5vQjqNMhmD7VE00pnne93lpaQPeLiiiPXzv04mns9cvdV2q8L3QO5wJw4
         brwuoffm+GtY6WRoylqD8n6V8K35HS/rYtivCbWNepaTeB4meBfjViFGgduY9rqkDUti
         3QZBZ1bOZGfYMlWnwkzqA5HCGX4TK1z0i7dpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CUEwdD6tPgM+oo9OX74OEuLIfDoicHKKtvarPk05tkv+sCreNkbdSuOF5PWrW3pwTP
         oiRog5z4tYlW9j/JO7gjsTLHoo70arJgu9rUr14LTYblRTAOteSD09dX+sWmYFUEg3Kj
         xUdY6apoeJc/67ewRYQKDUjRWSsk5VY/4m2Wc=
Received: by 10.231.191.138 with SMTP id dm10mr3613062ibb.126.1287422230357;
        Mon, 18 Oct 2010 10:17:10 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id a32sm6510020yhc.25.2010.10.18.10.17.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 10:17:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018165631.GA6718@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159268>

Jonathan Nieder writes:
> Sverre Rabbelier wrote:
> > I'm thinking we can just refuse to let through a commit that is
> > non-linear, as if there's a hook on the server side that rejects such
> > a history. Since we're representing the svn remote as a regular
> > remote, the user can just do 'git rebase @{u}" themselves if they end
> > up with a non-linear history.
> 
> Sounds good to me!

Ofcourse. I can't think of a sane way to deal with commits that aren't
based on upstream. We can't expect the user to rewrite the history,
push and expect it to work. I'm only looking at perfect two-way
mapping for a restricted set of operations on the Git-side.

> FWIW I just wanted to make sure people don't forget about the
> incompatible object models.  The pretend-upstream-has-a-vicious-update-hook
> approach sounds like a sane way to deal with this for pushing from
> git to svn (like (III) but making the user do more of the work).
> 
> Pulling from svn is a harder problem but luckily the single-upstream
> case is the usual case (so object model mismatches are easier to cope
> with as long as one can find the corresponding svn rev number for a
> given git object easily).

Yeah, I'm only looking at single-upstream SVN with stable revision
numbers, timestamps etc.

-- Ram
