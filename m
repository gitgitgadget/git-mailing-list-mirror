From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Sat, 18 Apr 2009 09:41:01 -0700 (PDT)
Message-ID: <alpine.GSO.2.00.0904180930390.16775@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net> <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de> <20090416094154.GA30479@coredump.intra.peff.net> <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
 <20090417115414.GA29121@coredump.intra.peff.net> <alpine.DEB.1.00.0904171514440.6675@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 18 18:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDeo-0000AO-OL
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbZDRQlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbZDRQlL
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:41:11 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:39452 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbZDRQlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:41:10 -0400
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n3IGf2nh016952;
	Sat, 18 Apr 2009 09:41:02 -0700 (PDT)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n3IGf1gT016948;
	Sat, 18 Apr 2009 09:41:01 -0700 (PDT)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0904171514440.6675@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116842>

Dscho,

On Fri, 17 Apr 2009, Johannes Schindelin wrote:

> Besides, you still will have a poison:
> 
> 	git config diff.defaultOptions --no-defaults
> 
> which is Russel's paradoxon right there.

I can cleanly modify my v3 to handle this case.  In diff_setup_done(), change 
this:

+	if (DIFF_OPT_TST(options, ALLOW_DEFAULT_OPTIONS))
+		flatten_diff_options(options, defaults ? defaults :
+			parse_diff_defaults(diff_setup(defaults =
+				xmalloc(sizeof(struct diff_options)))));

to this:

+	if (DIFF_OPT_TST(options, ALLOW_DEFAULT_OPTIONS) && (defaults ||
+		parse_diff_defaults(diff_setup(defaults = xmalloc(
+			sizeof(struct diff_options))))) && DIFF_OPT_TST(
+				defaults, ALLOW_DEFAULT_OPTIONS))
+					flatten_diff_options(options,
+						defaults);

All I did there was add the test DIFF_OPT_TST(defaults, ALLOW_DEFAULT_OPTIONS) 
to the condition that controls whether to perform the flattening.  Clean and 
clear.
                                  -- Keith
