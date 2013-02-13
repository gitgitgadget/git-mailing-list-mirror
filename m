From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Makefile: don't run rm without any files
Date: Wed, 13 Feb 2013 09:00:28 -0800
Message-ID: <20130213170028.GA410@ftbfs.org>
References: <1360771068-505-1-git-send-email-kraai@ftbfs.org>
 <7vtxpg9mxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 18:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5fhZ-00020A-J4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 18:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760082Ab3BMRAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 12:00:34 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:58320 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759829Ab3BMRAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 12:00:33 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U5fh6-0000F1-Hl; Wed, 13 Feb 2013 09:00:28 -0800
Mail-Followup-To: Matt Kraai <kraai@ftbfs.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
Content-Disposition: inline
In-Reply-To: <7vtxpg9mxq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216271>

On Wed, Feb 13, 2013 at 08:51:45AM -0800, Junio C Hamano wrote:
> Matt Kraai <kraai@ftbfs.org> writes:
> 
> > From: Matt Kraai <matt.kraai@amo.abbott.com>
> >
> > "rm -f -r" fails on QNX when not passed any files to remove.
> 
> I do not think it is limited to QNX.
> 
> > the clean target, since dep_dirs is empty.
> 
> And dep_dirs being empty under some circumstance shouldn't be
> limited to QNX, either.
> 
> I think your change does no harm, may be a good change if dep_dirs
> goes empty, but the justification is lacking.  What caused your
> dep_dirs to become empty in the first place?
> 
> I am scratching my head because I see
> 
>     OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
> 	$(XDIFF_OBJS) \
> 	$(VCSSVN_OBJS) \
> 	git.o
>     dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))

I don't set COMPUTE_HEADER_DEPENDENCIES, so it defaults to "auto".
The automatic detection determines that the compiler doesn't support
it, so it's then set to "no".  CHECK_HEADER_DEPENDENCIES isn't set
either, so about 20 lines below the dep_dirs assignment you quoted,
dep_dirs is cleared:

 ifneq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
 ifndef CHECK_HEADER_DEPENDENCIES
 dep_dirs =
 ...

Should I submit an updated patch with a different commit message?
