From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to
Date: Tue, 08 May 2007 19:59:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081958240.24220@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <alpine.LFD.0.99.0705081005400.24220@xanadu.home>
 <7vwszj10kn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 02:00:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZbI-0003WH-4Q
	for gcvg-git@gmane.org; Wed, 09 May 2007 02:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967897AbXEIAAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 20:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970442AbXEIAAG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 20:00:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49491 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967897AbXEIAAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 20:00:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ00KBPYNUGLV0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 19:59:54 -0400 (EDT)
In-reply-to: <7vwszj10kn.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46642>

On Tue, 8 May 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > @@ -65,7 +65,20 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >  	if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
> >  		return error(FAILED_RUN, argv_reflog[0]);
> >  
> > -	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
> > +	if (num_loose_objects() > 0) {
> > +		do_repack = 1;
> > +	} else {
> > +		struct packed_git *p;
> > +		unsigned long num_pack = 0;
> > +		if (!packed_git)
> > +			prepare_packed_git();
> > +		for (p = packed_git; p; p = p->next)
> > +			if (p->pack_local)
> > +				num_pack++;
> > +		if (num_pack > 1)
> > +			do_repack = 1;
> > +	}
> > +	if (do_repack && run_command_v_opt(argv_repack, RUN_GIT_CMD))
> >  		return error(FAILED_RUN, argv_repack[0]);
> >  
> >  	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
> 
> Is this even correct?
> 
> When your repository is fully packed, if you decided to discard
> one of your topic branches with "git branch -D", what does this
> code do?  We see no loose objects, we see only one pack, so the
> unreachable objects are left in the pack?

Right.  OK, scrap that.


Nicolas
