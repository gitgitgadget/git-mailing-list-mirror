From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 16:16:42 +0200
Message-ID: <8c5c35580705250716j27695a01kd1db222be6c7eac7@mail.gmail.com>
References: <11800866643203-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0705251157450.4648@racer.site>
	 <8c5c35580705250646h12f4f30bt301f4c4bdc2ad530@mail.gmail.com>
	 <Pine.LNX.4.64.0705251451530.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrab3-0002LX-AM
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762635AbXEYOQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762382AbXEYOQo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:16:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:13424 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbXEYOQn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:16:43 -0400
Received: by nz-out-0506.google.com with SMTP id n1so344897nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 07:16:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aZF4UqrrwcWZkhPU0AMgzbZJEm+m5vapUzs45FxlxdlLNUp6jkErRWlO9Rg6YVKfmW+EPc+Ghn5obJ4/Ss9EcxRtsTy9Gk5qEob8niOWwbzHLSdSeWueZT43A1tD8sLql45Kp0fVOsKoT9VdMi1zhf/zSeVbj3m7lQY33q8vS4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fHNdJmUxLbqZ8B6RxCByW3VUekLC3b83SWzrxBWclHZPNjAGz16Whp1R7kI0CkuWPxXD3hQfz7wxpgEzWJRpSOGDN8VneKXplU/CoroNvPCJn9fCFcLHSsJdQs/S0sEfl1Cr845IJpEMfCPoMdz4cN5V/Dtdu1c5E8bCmYqsLls=
Received: by 10.114.196.1 with SMTP id t1mr1513122waf.1180102602357;
        Fri, 25 May 2007 07:16:42 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 25 May 2007 07:16:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705251451530.4648@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48379>

On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 25 May 2007, Lars Hjemli wrote:
> > On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Fri, 25 May 2007, Lars Hjemli wrote:
> > > > +             die "Unable to find current revision of submodule '$path'"
> > > > +
> > > > +             if test "$subsha1" != "$sha1"
> > > > +             then
> > > > +                     $(cd "$path" && git-fetch && git-checkout -q
> > > "$sha1") ||
> > >
> > > This will make a detached HEAD, right? Do you want that? (I am not
> > > really interested in submodules myself, so I haven't thought about it,
> > > and I haven't followed that monster discussion.)
> >
> > Well, we might want to be smarter about this, but on the other hand: if
> > the user cares, he can always do 'cd $path && git checkout $branch',
> > since 'git submodule -u' will skip submodules with the correct commit
> > checked out.
>
> Fair enough, I guess...

The only alternative I can think of is to check if module.$path.branch
is specified in .gitmodules: if it is, and it's pointing at the wanted
sha1, the right thing would be to checkout that branch. Any other sort
of dwim is bound to get it wrong.


>
> > > I'll let Junio comment on that command line parsing...
> >
> > Heh, I'm a shell illiterate...
>
> ;-)
>
> I guess Junio would like one of his famous
>
>         case ,"$init","$update",[...] in
>         *1*1) usage
>         esac
>
> to prevent running with two actions...

Ahh, that's something I can handle


>
> > > All in all, I like it: it is short, to the point, and it should do the
> > > job (maybe with a few enhancements like "--update" without arguments
> > > means _all_ submodules).
> >
> > Well, it does (or should) update all initialized submodules, but maybe
> > that's not what you meant?
>
> Oops. I meant "init".

Hmm, it does (or should) clone all submodules if you run 'git
submodule --init' (no paths specified). Did it fail for you?


-- 
larsh
