From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Wed, 26 Mar 2008 09:45:01 -0700
Message-ID: <7vhcete8oi.fsf@gitster.siamese.dyndns.org>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil>
 <47E99B98.1060506@nrlssc.navy.mil>
 <1b46aba20803260421t4db4987gc6fc8b2e556032e0@mail.gmail.com>
 <47EA7927.9060201@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 26 17:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeYl6-0002qR-GZ
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 17:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbYCZQpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 12:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbYCZQpK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 12:45:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbYCZQpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 12:45:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B77FC2026;
	Wed, 26 Mar 2008 12:45:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0BBAD2025; Wed, 26 Mar 2008 12:45:03 -0400 (EDT)
In-Reply-To: <47EA7927.9060201@nrlssc.navy.mil> (Brandon Casey's message of
 "Wed, 26 Mar 2008 11:26:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78291>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Eventually filter-branch along with the rest of git will be rewritten
> in c and the need for many low-level git tools will vanish.

That holds true only for the tools shipped with git.git itself.  However,
you never should forget that people _script_ around git.  I do not see a
reason to stop supporting mktag in this discussion.

I would suggest:

 * make mktag.c a built-in first;

 * rename verify_tag() in mktag.c to verify_tag_buffer(), and update its
   implementation to tighten the format validation, perhaps along the
   lines you propose in your patch, and move it to tag.c.  By the way, I
   think tagger information should get the same validation as committer
   and author information gets elsewhere in the system;

 * add a call to verify_tag_buffer() you introduce above immediately
   before write_sha1_file() in builtin-tag.c, to make sure both programs
   produce valid tags, with the same definition of validity.
