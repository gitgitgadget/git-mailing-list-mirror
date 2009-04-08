From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH 1/3] git remote update: Report error for non-existing
	groups
Date: Wed, 8 Apr 2009 10:07:38 +0200
Message-ID: <20090408080738.GA24386@pvv.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org> <1239025262-16960-2-git-send-email-finnag@pvv.org> <7vprfnubyi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 10:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrSqU-0008Tu-5Y
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 10:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbZDHIHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 04:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZDHIHn
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 04:07:43 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:54423 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbZDHIHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 04:07:41 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LrSos-0007lL-7R; Wed, 08 Apr 2009 10:07:38 +0200
Content-Disposition: inline
In-Reply-To: <7vprfnubyi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116059>

On Tue, Apr 07, 2009 at 07:16:21PM -0700, Junio C Hamano wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> > @@ -1227,8 +1229,11 @@ static int update(int argc, const char **argv)
> >  
> >  	remote_group.list = &list;
> >  	for (i = 1; i < argc; i++) {
> > +		int groups_found = 0;
> >  		remote_group.name = argv[i];
> > -		result = git_config(get_remote_group, NULL);
> > +		result = git_config(get_remote_group, &groups_found);
> > +		if (!groups_found && (i != 1 || strcmp(argv[1], "default")))
> > +			die("No such remote group: '%s'", argv[i]);
> 
> I think you are trying to be silent about the case where the caller feeds
> you the default_argv[] array with this, but do we want to be more explicit
> about this so that we do die when the end user explicitly says "default"
> from the command line?

Are you thinking that "git remote update default" should only be allowed
if you have configured a group named default?

The old code would allow "git remote update default" and actually do the
same as "git remote update", so I wanted to keep the (possibly unwanted?)
behaviour. If we want to disallow it, we can just do
if (!groups_found && argv != default_argv) instead.

- Finn Arne
