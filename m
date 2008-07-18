From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 16:09:40 +0100
Message-ID: <320075ff0807180809x599aefafw2c7fe88fea2691d2@mail.gmail.com>
References: <alpine.DEB.1.00.0807171351380.8986@racer>
	 <alpine.DEB.1.00.0807171513560.8986@racer>
	 <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
	 <20080717182253.GZ32184@machine.or.cz>
	 <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
	 <20080718091608.GL10151@machine.or.cz>
	 <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com>
	 <20080718100048.GN10151@machine.or.cz>
	 <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com>
	 <20080718144325.GR10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 17:10:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJrbY-0005cs-PC
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 17:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbYGRPJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 11:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYGRPJp
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 11:09:45 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:2321 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbYGRPJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 11:09:44 -0400
Received: by mu-out-0910.google.com with SMTP id w8so346788mue.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Bl6Lrsolmxh7RCd3IbuDXQMIBHOb59kXkVFQHzBw1E0=;
        b=MfwZXXoSXBv6hK4eqjYb9nywASi21tJNer81g2jU7U+WppKEB3SipfJYCv8exyMANN
         sJCwGvMo5fPbJORLRXG1a7806YvG49iHFHZFv9BieRRueoAuGkFgsIUgRoBdZ7vVITJL
         7j/PcrDoUd03J8u2dqVDd/u6vW/wyYYUJxiNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=s1ZphpQ8RhAZIRq34Fmfj3b4ijX1XjIEQ0UhZ/fEPk/WH0zjJJV+vOuXkySv10B3YK
         KhSfpAdzbk5L7vAycvHDn0WoSu2+t/y9gQA3lQUQDKIYF99mJE8smnENbPu58qOQc3gY
         xLhX4nc44o1TzVRXqr47VD/iRS5ovZ6rn7Oxc=
Received: by 10.103.214.8 with SMTP id r8mr196335muq.64.1216393780757;
        Fri, 18 Jul 2008 08:09:40 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Fri, 18 Jul 2008 08:09:40 -0700 (PDT)
In-Reply-To: <20080718144325.GR10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89047>

>> Ah - I understand. You're saying "you can't pull submodules when you
>> pull the supermodule, because you don't know which submodules might be
>> needed until you also merge / checkout the desired revision" ?
>>
>> Ack.
>
> That is something I might agree with, but my point is that within the
> submodule,
>
>        git pull
>
> simply isn't a sensible operation at all! You don't want to do any
> merges or whatever, just bring the submodule to a defined commit id.
> So you want to do something significantly different:
>
>        git fetch
>        git reset --hard <commitid>
>
> And that's what 'git submodule update' already does.
>

I wasn't wanting to do pull there - but either way, I agree :-)

>> Hm. It feels like each person could have some 'local' info in their
>> .gitmodules, and rules around merging; but I'm not sure of exactly
>> what, or how.
>
> Again, when customizing .gitmodules, you need to either give up on
>
>        (i) bisectability; it's not good enough to restore the canonical
>        .gitmodules contents on merge, since the bisect can run into one
>        of the commits on fred' branchs
>
>        (ii) publishing the exact same branch for testing and merging
>
> But I start to feel that the tradeoff of (ii) is really not so bad at
> alland this would be perhaps the most elegant solution. You can either
>
>        (a) make two parallel branches, one with your .gitmodules and
>        one with the upstream's
>
>        (b) probably better, stick a commit at the top of your branch
>        that will change .gitmodules to your locations; others can
>        check out fred, test things out, then merge fred^; you can even
>        generally go back in fred's commits if you just 'git submodule
>        update' right after checking fred out, since all the required
>        submodule commits will be probably already fetched.
>
> So I say just go for the (ii)-(b) combination. :-)
>

Hmm. Locally modifying my .gitmodules still feels bad because I don't
like either of those tradeoffs (but I don't have any sensible
suggestion yet).

As a bit of background (as to why I'd dislike (a) and (b)), we had a
team switch to git, and one of the really nice things is the ability
to share stuff around and branch freely - but the flipside of that is
that we tend to push to a central repo more rarely, so the advantages
of an continuous integration server become less. What we did is to
tell a centralised CI server the URLs of all the team's git
repositories, and it would periodically pull from them, speculatively
compile anything new, and run the big suite of tests - finishing up by
emailling them a heads-up that a particular state in their repo is
'bad'.

This was really popular as it was demonstrably better than anything we
could do with svn, and best of all, it's pretty much transparent - as
a user you don't have to do anything at all.

I could do it now by hacking about with files; it'd just be nice to
keep it transparent and make it a directly supported feature.
