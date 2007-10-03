From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by
	builtin-commit.c.
Date: Wed, 03 Oct 2007 17:53:58 -0400
Message-ID: <1191448438.7134.8.camel@hinata.boston.redhat.com>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
	 <20070930131133.GA11209@diku.dk>
	 <1191255975.25093.26.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0710011909291.28395@racer.site>
	 <20071003201129.GB25856@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdCAm-0002NV-Mx
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXJCVyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbXJCVyV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:54:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbXJCVyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:54:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l93Ls4YG021608;
	Wed, 3 Oct 2007 17:54:04 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93Ls4Uk029238;
	Wed, 3 Oct 2007 17:54:04 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93Ls3RL002707;
	Wed, 3 Oct 2007 17:54:03 -0400
In-Reply-To: <20071003201129.GB25856@diku.dk>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59898>


On Wed, 2007-10-03 at 22:11 +0200, Jonas Fonseca wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote Mon, Oct 01, 2007:
> > On Mon, 1 Oct 2007, Kristian H?gsberg wrote:
> > > On Sun, 2007-09-30 at 15:11 +0200, Jonas Fonseca wrote:
> > > > > +
> > > > > +extern int parse_options(const char ***argv,
> > > > > +			 struct option *options, int count,
> > > > > +			 const char *usage_string);
> > > > 
> > > > I think the interface could be improved a bit. For example, it doesn't 
> > > > need to count argument since the last entry in the options array is 
> > > > OPTION_LAST and thus the size can be detected that way.
> > > 
> > > Hehe, yeah, that's how I did it first.  I don't have a strong preference 
> > > for terminator elements vs. ARRAY_SIZE(), but Junio prefers the 
> > > ARRAY_SIZE() approach, I guess.  At this point I'm just trying the get 
> > > the patches upstream...
> > 
> > FWIW I like the ARRAY_SIZE() approach better, too, since it is less error 
> > prone.
> 
> OK, I must have missed that comment. Good point.
> 
> Thanks for the comments both of you. It's great to have something to
> work from. However, I also fear it will also require that some extra
> flags or information is added to the option information to make it more
> generally usable. But I guess that is easier to discuss in the context
> of a patch.

I just sent an updated option parser patch that incorporates your
suggestions along with a patch that ports builtin-add.c to use it.  I
looked briefly into porting over a few other builtins, but you're right,
we need a couple of extra features for this to be really worthwile:

      * OPTION_SET_FLAG: sets the bit (we need to add a bit value that
        the option parser can or in)
      * OPTION_CLEAR_FLAG: clear the bit
      * OPTION_ADD: adds the value to the destination integer
      * OPTION_CALLBACK: calls the given function when the option is
        matched.  We'll need this for builtin-grep that has positional
        args such as --and etc.

Also, the option parser should probably verify that a string option
isn't passed more than once.  Bundling of single letter options would be
nice to add.  But the patch I just sent out should be a good start, and
it lets us move forward with builtin-commit.c.

cheers,
Kristian
