From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: Re: read() =?utf-8?b?TUFYX0lPX1NJWkU=?= bytes, more than =?utf-8?b?U1NJWkVfTUFYPw==?=
Date: Sun, 8 Feb 2015 12:05:34 +0000 (UTC)
Message-ID: <loom.20150208T125055-287@post.gmane.org>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de> <loom.20150207T182443-33@post.gmane.org> <54D67662.7040504@web.de> <CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com> <loom.20150207T232422-706@post.gmane.org> <CAPc5daXD_7XZD5Vag51BjrSZ0q1r9eMswhLmnpUFqqjrc9oSTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 13:05:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKQcY-0004CJ-Db
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 13:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbbBHMFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 07:05:46 -0500
Received: from plane.gmane.org ([80.91.229.3]:56992 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180AbbBHMFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 07:05:45 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YKQcR-0004AF-N2
	for git@vger.kernel.org; Sun, 08 Feb 2015 13:05:43 +0100
Received: from dslb-094-220-143-211.094.220.pools.vodafone-ip.de ([94.220.143.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 13:05:43 +0100
Received: from jojo by dslb-094-220-143-211.094.220.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 13:05:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.220.143.211 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263509>

Junio C Hamano <gitster <at> pobox.com> writes:

<snip>
> >
> > something like this:
> >
> > /* allow overwriting from e.g. Makefile */
> > #if !defined(MAX_IO_SIZE)
> > # define MAX_IO_SIZE (8*1024*1024)
> > #endif
> > /* for plattforms that have SSIZE and have it smaller */
> > #if defined(SSIZE_MAX && (SSIZE_MAX < MAX_IO_SIZE)
> > # undef MAX_IO_SIZE /* avoid warning */
> > # define MAX_IO_SIZE SSIZE_MAX
> > #endif
> 
> No, not like that. If you do (1), that is only so that the Makefile can 
override
> a broken definition a platform may give to SSIZE_MAX.  So
> 
>  (1) if Makefile gives one, use it without second-guessing with SSIZE_MAX.
>  (2) if SSIZE_MAX is defined, and if it is smaller than our internal
> default, use it.
>  (3) all other cases, us our internal default.


oops, yes, of course

/* allow overwriting from e.g. Makefile */
#ifndef(MAX_IO_SIZE)
# define MAX_IO_SIZE (8*1024*1024)
  /* for plattforms that have SSIZE and have it smaller */
# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE)
#  undef MAX_IO_SIZE /* avoid warning */
#  define MAX_IO_SIZE SSIZE_MAX
# endif
#endif
