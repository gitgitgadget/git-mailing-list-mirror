From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach fsck and prune about the new location of temporary
 objects
Date: Thu, 24 Jul 2008 23:07:50 -0700
Message-ID: <7vd4l2xzrd.fsf@gitster.siamese.dyndns.org>
References: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0807250233031.4140@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 08:08:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMGU5-0004s5-MW
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 08:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbYGYGH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 02:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYGYGH6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 02:07:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYGYGH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 02:07:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 928DB3B897;
	Fri, 25 Jul 2008 02:07:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9422D3B896; Fri, 25 Jul 2008 02:07:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807250233031.4140@eeepc-johanness> (Johannes
 Schindelin's message of "Fri, 25 Jul 2008 02:33:52 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 067E4E0C-5A10-11DD-BA52-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90003>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 24 Jul 2008, Brandon Casey wrote:
>
>> Since 5723fe7e, temporary objects are now created in their final destination
>> directories, rather than in .git/objects/. Teach fsck to recognize and
>> ignore the temporary objects it encounters,
>
> It somehow feels wrong for fsck to ignore anything that could be used.

Back when we created temporaries in .git/objects/, these tmp_obj files
were not even checked nor looked at, because fsck_object_dir() checked
only those 256 fan-out directories, so this is nothing new.

And these tmp_obj files are something we _expect_ to be in the object
directory.  The user can ^C out object creation codepath anytime, and we
do not reference the final destination objects from refs nor the index to
preserve the integrity of the repository when that happens.  In other
words, they are crufts, but they are not something unusual nor get alarmed
about.

And it also is the right thing to do to remove them in prune.
