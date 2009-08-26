From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
	mark
Date: Wed, 26 Aug 2009 05:54:01 +0200
Message-ID: <20090826035401.GJ3526@vidovic>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org> <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 05:54:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg9aU-00012b-Hg
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 05:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbZHZDyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 23:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756686AbZHZDyH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 23:54:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:40158 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678AbZHZDyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 23:54:05 -0400
Received: by ey-out-2122.google.com with SMTP id 25so901426eya.19
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Rm/WnS5Gm7rfzIlCPgBsELfmYZ/4TUN6xZWmKZgF0/g=;
        b=fpSqsI/SsoRZuNcrMh5bEO7gCAnRdZCmJn7qVYYqIHTcYqUbaEbOvJvfzrTk9qLwT9
         xkCT4To9KzZXlW6Yafp7PDH8f7el0Bvcm8R/BB6xho/PR3G9bJslrwe7HAezzdXmTQbl
         OQj24R5FYx+rXxdGIS6lvjurPCdWVR60vHW7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dWCKA9gTMYtRj43yhHGMj+JmPllmmn1bt8NwfOO0Pu3J/88QK4gW369UOz0r7SsEsF
         i5cAtg/m4jmvFj2lnVYewGbq44JJq0ssElrIsCx+eO+T62DZxrK0Gtpp0RFirxCSP/m5
         5tHPk56GKKvPdQ2vtkePDm/UZxaV1wSQ1kFrU=
Received: by 10.210.57.1 with SMTP id f1mr7610223eba.66.1251258846358;
        Tue, 25 Aug 2009 20:54:06 -0700 (PDT)
Received: from @ (91-164-128-218.rev.libertysurf.net [91.164.128.218])
        by mx.google.com with ESMTPS id 5sm1865121eyh.21.2009.08.25.20.54.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 20:54:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvdkbl4ul.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127062>

The 25/08/09, Junio C Hamano wrote:

> What I meant was that I would not want to spend any more of _my_ time on
> the definition of the scissors for now.  That means spending or wasting
> time on improving the 'pu' patch myself, or looking at others patch to
> find flaws in them.
> 
> Of course, as the maintainer, I would need to look at proposals to improve
> or fix bugs in the code before the series hits the master, but I would
> give zero priority to the patches that change the definition at least for
> now to give myself time to work on more useful things.

Ok, thank you.

> I think --ignore-scissors is a good thing to add, regardless of what the
> definition of scissors should be.  So your patch should definitely be
> separated into two parts.

Could find it at the end of the mails.

> >  #include "builtin.h"
> >  #include "utf8.h"
> >  #include "strbuf.h"
> > +#include "git-compat-util.h"
> 
> Inclusion of builtin.h is designed to be enough.  What do you need this
> for?

It is for the warning() call

  warning("scissors line found, will skip text above");

I've added. That said, moving this declaration to builtin.h could be a
good idea. Hint?

> > @@ -715,51 +717,63 @@ static inline int patchbreak(const struct strbuf *line)
> >  		if (isspace(buf[i])) {
> > +			if (scissors_dashes_seen)
> > +				mark_end = i;
> 
> I think you do not want this part, and then you won't have to trim
> trailing whitespaces from mark_end later.

Good eyes.

> > +			/*
> > +			 * The mark is 8 charaters long and contains at least one dash and
> > +			 * either a ">8" or "<8". Check if the last mark in the line
> > +			 * matches the first mark found without worrying about what could
> > +			 * be between them. Only one mark in the whole line is permitted.
> > +			 */
> 
> This definition makes "-            8<" a scissors.  

Yes. Instead of looking for dashes alone, I will give a try to something
like

	  if (!scissors_dashes_seen)
	    mark_start = i;
	  if (i + 1 < len) {
	    if (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2))) {
	      scissors_dashes_seen |= 02;
	      i++;
	      mark_end = i;
	      continue;
	    else if (!memcmp(buf + i "--", 2) {
	      scissors_dashes_seen |= 04;
	      i++;
	      mark_end = i;
	      continue;
	    }
	  }
	  if (i + 2 < len)
	    if (!memcmp(buf + i + 1, "- -", 3) {
	      scissors_dashes_seen |= 04;
	      i += 2;
	      mark_end = i;
	      continue;
	    }
	  if (buf[i] == '-') {
	    mark_end = i;
	    scissors_dashes_seen |= 01;
	    continue;
	  }
	  break;
	}
	
	if (scissors_dashes_seen == 07) {
	  ...

> it does not allow
> 
>     "-- 8< -- please cut here -- 8< -- --"

Actually, I believe this one should really not be a scissors line. If we
accept some random dashes around markers it will break the definition of
the mark itself.

As I said, I'd rather rules easy to define over others because if the
end-user scissors line doesn't work, he can refer to the documentation...

> nor
> 
>     "-- 8< -- -- please cut here -- -- 8< --"
> 
> nor
> 
>     "-- 8< -- -- please cut here -- -- >8 --"

...and symmetrical markers make sense to the user. Will add this.

> > +	if (!ignore_scissors) {
> > +		if (is_scissors_line(line)) {
> > +			warning("scissors line found, will skip text above");
> > ...
> > +			return 0;
> 
> Don't re-indent like this.  Just do:
> 
> 	if (!ignore_scissors && is_scissors_line(line)) {
>         	...
> 	}

Does the compilers (or a standard) assure that the members are evaluated
in the left-right order?

Otherwise, we may call is_scissors_line() where not needed.

-- 
Nicolas Sebrecht
