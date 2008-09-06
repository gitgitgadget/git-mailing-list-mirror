From: David Aguilar <davvid@gmail.com>
Subject: Re: Re* git submodule output on invalid command
Date: Fri, 5 Sep 2008 21:22:18 -0700
Message-ID: <20080906042217.GB18930@gmail.com>
References: <1220631370-19777-1-git-send-email-pdebie@ai.rug.nl> <7vy726v30m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 06:30:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbpRX-0006cP-3a
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 06:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYIFE3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 00:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYIFE3d
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 00:29:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:49710 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYIFE3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 00:29:32 -0400
Received: by rv-out-0506.google.com with SMTP id k40so713863rvb.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 21:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=f5tuu0Wu7RRPKZe6sP70OS+vRoIlaqif9WdFI3x/nkc=;
        b=Q+wPVMHSQ7vDpvKyMS+biW2btmOFamcvbIEc5qNMD8Bn5XwZ7Ygcw/iB/1jHznFBw/
         JftqKvc7mrXz//5hB0wf+AyCxVHqFPY3NXzCQj++KAfPu5niw89/zFTvcfngckbt6d2B
         5UEsfpa0qQHQE75cbivw4lazNZMe+dXjt/xi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OudRQLTEYn2ei2BS5Bjwqsue8dkxbUnxZFvGj+dQvLxiXpeThr98YW1wcvIfbkXo5g
         QBzjlFw4iCD76YcpgAANrUVIeUVpFBwm7E0lETAA58O8I2Ynx2DPWYbbKJfecT0V+OMR
         NPkeNHcT4lim1qcgsYwZuX+2F52bQn+kDMMRc=
Received: by 10.141.50.11 with SMTP id c11mr7118388rvk.222.1220675371706;
        Fri, 05 Sep 2008 21:29:31 -0700 (PDT)
Received: from gmail.com ( [208.106.56.2])
        by mx.google.com with ESMTPS id c20sm2027148rvf.3.2008.09.05.21.29.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 21:29:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy726v30m.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95059>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> Pieter de Bie <pdebie@ai.rug.nl> writes:
> 
> > ..., something like 'git
> > submodule satsus' is valid and should return nothing, because there are
> > no submodules in the 'satsus' path. However, I still feel this should
> > produce a warning.
> >
> > I'm sure there is a nicer way to alert the user than my patch below, which
> > warns if the user did not supply any valid paths. Anyone else got a more
> > satisfying approach?
> 
> "ls-files --error-unmatch" would warn you of mistyped nonexistent paths,
> but "git submodule Makefile" would still catch the Makefile from the
> toplevel superproject happily and will not complain without checking after
> filtering by submodules.
> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 1c39b59..3aae746 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -59,7 +59,12 @@ resolve_relative_url ()
> >  #
> >  module_list()
> >  {
> > -       git ls-files --stage -- "$@" | grep '^160000 '
> > +       git ls-files --stage -- "$@" | grep '^160000 ' ||
> > +       if test -z "$@"; then
> 
> Shell nit; this must be "$*" not "$@", right?

I added the module_list() function when moving the duplicated
code into a separate function.  The code was lifted verbatim.
I can submit a patch cleaning that up if it should indeed use
"$*".  Just let me know.

Thanks,

-- 

	David
