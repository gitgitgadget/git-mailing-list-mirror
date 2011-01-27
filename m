From: Adam Tkac <atkac@redhat.com>
Subject: Re: [PATCH] Pass "-O xhtml" param to highlight instead of "-xhtml"
Date: Thu, 27 Jan 2011 13:03:23 +0100
Message-ID: <20110127120323.GA3416@traged.englab.brq.redhat.com>
References: <20110126171118.GA867@traged.englab.brq.redhat.com>
 <m339ofbb9t.fsf@localhost.localdomain>
 <7vaainjq7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jochen Schmitt <Jochen@herr-schmitt.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 13:03:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiQZp-0003OQ-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 13:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab1A0MDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 07:03:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353Ab1A0MDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 07:03:44 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0RC3Otw025708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Jan 2011 07:03:25 -0500
Received: from localhost (dhcp-25-165.brq.redhat.com [10.34.25.165])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p0RC3Nn1021414;
	Thu, 27 Jan 2011 07:03:24 -0500
Content-Disposition: inline
In-Reply-To: <7vaainjq7f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165576>

On Wed, Jan 26, 2011 at 01:43:48PM -0800, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> Current highlight utility doesn't recognize "--xhtml" parameter, it
> >> recognizes only "-O xhtml" parameter.
> >> 
> >> Reference: https://bugzilla.redhat.com/show_bug.cgi?id=672293
> >
> > Shouldn't the above be in commit message?
> 
> Actually, I prefer not having that "Reference" in the commit message
> myself, but I do want to have some relevant details
> missing from the proposed commit message but is in
> that ticket (especially the comment #5) in the commit message.
> 
> > In highlight 2.4.5 '-O' means "name of output directory", i.e. --outdir.
> > There is no --out-format either.
> 
> Thanks for digging about 2.4.5; in that case, unlike the redhat ticket
> hinted, this change may not be backward compatible enough, as it seems
> that the compatibility goes only back to 3.0.something.

Right you are, I digged too shallowly, thanks for your inspection.

> 
> >
> > WTF this backward incompatibile change in highlight... the only
> > solution that would make it work both for old and for new versions is
> > to rely on the fact that HTML is default output format, i.e.
> >
> >   	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> >   	          quote_command($highlight_bin).
> >  -	          " --xhtml --fragment --syntax $syntax |"
> >  +	          " --fragment --syntax $syntax |"
> >   		or die_error(500, "Couldn't open file or run syntax highlighter");
> 
> Adam, Jochen?  How does the counterproposal look to you?
> 
> Without knowing much about highlight nor using gitweb in general myself,
> the above looks a bit more reasonable fix to the issue, if the default
> format has been and will stay to be HTML.

The proposal looks like the best (and the only one) correct solution.
I will send updated patch.

Regards, Adam

-- 
Adam Tkac, Red Hat, Inc.
