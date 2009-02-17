From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 14:20:23 -0800
Message-ID: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
References: <200902142056.42198.trast@student.ethz.ch>
 <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org>
 <200902170944.08827.trast@student.ethz.ch>
 <200902170946.52093.trast@student.ethz.ch>
 <tJ6pp2ZnBjKVBLynGfYewBaGmSehbwZNLOShEvpXmtkD3IMXRugEKg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYKG-0005e7-64
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbZBQWUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZBQWUb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:20:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbZBQWUa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:20:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFE952B59C;
	Tue, 17 Feb 2009 17:20:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E05912B550; Tue,
 17 Feb 2009 17:20:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F3D3824-FD41-11DD-9805-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110457>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Notice the 'export' lines.  Comparing it to Thomas's v2 5/5 patch, it
> looks like the first line which sets the variables is correct and the
> export line should just be 'export MSG GIT_NOTES_REF' in both tests.

Thanks for catching my late-night typos.

Some shells do not like "export var=val", and the right way to write these
is to do an usual assignment and then export just variable names.

We need to fix the following:

$ git grep -n -e 'export .*=' --and --not -e '-export' pu -- t/
pu:t/t3301-notes.sh:42:	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
pu:t/t3301-notes.sh:48:	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
pu:t/t3302-notes-index-expensive.sh:32:		export GIT_INDEX_FILE=.git/temp;
pu:t/t3302-notes-index-expensive.sh:66:			export GIT_NOTES_REF=non-existing
pu:t/t9301-fast-export.sh:188:export GIT_AUTHOR_NAME='A U Thor'
pu:t/t9301-fast-export.sh:189:export GIT_COMMITTER_NAME='C O Mitter'
pu:t/test-lib.sh:101:		export GIT_TEST_LONG=t; shift ;;
