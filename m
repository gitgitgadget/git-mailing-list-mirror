From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Mon, 15 Jun 2009 22:56:20 -0700
Message-ID: <7vprd4g1rv.fsf@alter.siamese.dyndns.org>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
	<1245033541-15558-2-git-send-email-lodatom@gmail.com>
	<alpine.OSX.2.00.0906151927010.816@xor.localnet>
	<ca433830906151755t783fbf98k3fd09e4bdd6781e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Weiss <knweiss@gmx.de>, git@vger.kernel.org,
	Daniel Stenberg <daniel@haxx.se>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 08:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGRjG-000770-2f
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 08:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934682AbZFPF4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 01:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936442AbZFPF4V
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 01:56:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36950 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936451AbZFPF4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 01:56:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616055620.FCZY18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jun 2009 01:56:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4VwL1c00D4aMwMQ03VwMsm; Tue, 16 Jun 2009 01:56:21 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=M82w0W_vP8cA:10 a=pGLkceISAAAA:8
 a=AdQkqCZTRTnJRryFL8AA:9 a=G3kZ8nU4h7tqsp_tso9W_SlCUtkA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121654>

Mark Lodato <lodatom@gmail.com> writes:

> This brings up a good point: Should we (I) try to implement (client
> certificate) usability features in git to work around deficiencies in
> libcurl, or should we (I) write patches to fix/enhance libcurl
> directly?  The latter would be much easier (though I could be wrong)
> and would benefit other programs using libcurl, but would require
> users to upgrade libcurl to get these new features, and of course
> would rely on the libcurl developers accepting the patches.  I am
> willing to do either, but I think the libcurl route would be better.
> Any thoughts?

I agree that would be a better approach in the longer term.  There is no
point in many projects that use libcURL reinventing the wheel that could
be in the shared library.

Perhaps we could do both ;-).

That is, (1) give libcURL a way to allow callers ask if the key/cert is
encrypted, and then (2) on git side we only add code to ask libcURL using
that interface _only if and when available_; otherwise we do not even try
to bypass layers but just ask the user to tell us via configuration (or
command line).
