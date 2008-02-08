From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: Adding gitweb.owner, last shot
Date: Fri,  8 Feb 2008 02:41:52 -0200
Message-ID: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 05:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNL4w-0005L9-Sm
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284AbYBHEmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbYBHEmU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:42:20 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:51679 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbYBHEmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:42:19 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 3F3C2700003CF;
	Fri,  8 Feb 2008 02:42:18 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73035>


After some study about the insertion of a new repository configuration,
which sets repository owner, it was decided by the group that creating
another small file inside .git/ is not a good idea. So I started to bench
the viability to add just the gitweb.owner configuration, using gitweb.owner
together with gitweb.description there is no major performance downgrade
compared to $projects_list , as seen below:

8<-------
These times i got with a 1000projects running 2 dd to generate disk IO.
Here comes the resultm
NO projects_list  projects_list
16m30s69          15m10s74       default gitweb, using FS's owner
16m07s40          15m24s34       patched to get gitweb.owner
16m37s76          15m59s32       same above, but without gitweb.owner

Now results for a 1000projects on an idle machine.
NO projects_list  projects_list
1m19s08           1m09s55       default gitweb, using FS's owner
1m17s58           1m09s55       patched to get gitweb.owner
1m18s49           1m08s96       same above, but without gitweb.owner
8<-------

The idea of creating only the gitweb.owner can be a case of study to
centralize all gitweb repository configuration in one file. Maybe even
change the way $projects_list is formated, as gitweb.cgi needs to check
repository configuration to get repository description to generate
projecT_list page, we could just list repository's directories.
