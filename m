From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re* git diff/log --check exitcode and PAGER environment
 variable
Date: Fri, 8 Aug 2008 13:23:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <489C145B.5090400@sneakemail.com> <7vfxpfet8a.fsf@gitster.siamese.dyndns.org> <7v1w0zersg.fsf_-_@gitster.siamese.dyndns.org> <489C27DD.90603@sneakemail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2042188543-1218194583=:9611"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Peter_Valdemar_M=F8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 13:19:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRQ0J-0003Yt-FW
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024AbYHHLSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 07:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757026AbYHHLSa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:18:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:54639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757014AbYHHLS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:18:29 -0400
Received: (qmail invoked by alias); 08 Aug 2008 11:18:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 08 Aug 2008 13:18:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19a8CMhfh9abIubJhUYkIUULbC1Q9VVG5Yb5wODxr
	MjccAD0HkIOyj/
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <489C27DD.90603@sneakemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91656>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2042188543-1218194583=:9611
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Aug 2008, "Peter Valdemar Mørch (Lists)" wrote:

> I don't want to be a troll... But in my original post, I write that git 
> log exits with 0 even when there are --check failures *and* --no-pager 
> is used.

You seem to care enough.  That is good.  Because I will give you a few 
pointers to help yourself, and you can in return help us by submitting a 
patch:

- the code to be changed lives in log-tree.c.  Look for calls to the 
  function log_tree_diff_flush().  You need to check the exit status
  after that (needs to be done only when DIFF_OPT_TST(opt->diffopt, 
  EXIT_WITH_STATUS).

- you can get at the exit status with the call 
  diff_result_code(opt->diffopt, 0) (see the implementation in diff.c to 
  find out what the 0 means, and why it is correct).

- you need to accumulate the exit status (plural, with a long u) over all 
  calls to log_tree_diff(), best thing would be to add a member to the
  log_info struct.

- you need to test rev->loginfo->exit_code in the end, and return failure 
  if it is non-zero.  I think the place is in cmd_log_walk().

Bon chance,
Dscho

--8323329-2042188543-1218194583=:9611--
