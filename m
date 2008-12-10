From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from epic fail (deleted .git/objects/pack)
Date: Tue, 09 Dec 2008 16:19:50 -0800
Message-ID: <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
References: <1228867861.14165.19.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 01:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LACpH-0007Zj-5o
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 01:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYLJAT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 19:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbYLJAT6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 19:19:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYLJAT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 19:19:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DB0A61880A;
	Tue,  9 Dec 2008 19:19:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A6E0218825; Tue, 
 9 Dec 2008 19:19:51 -0500 (EST)
In-Reply-To: <1228867861.14165.19.camel@starfruit.local> (R. Tyler Ballance's
 message of "Tue, 09 Dec 2008 16:11:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45A0F5B0-C650-11DD-8745-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102663>

"R. Tyler Ballance" <tyler@slide.com> writes:

> I really wish I didn't have to ask this question, as we discussed in
> #git early this morning, whiskey is the likely answer.
>
> For unexplainable reasons one of our sysadmins got trigger-happy when he
> tried to prune a temp_pack file generated and left in a
> developer's .git/ directory after a git operation aborted (disk quota
> exceeded)
>
> As a result, the sysadmin killed the developers
> entire .git/objects/pack/ directory. (insert copious amounts of whiskey
> here)
>
> He did not however delete all the other contents of .git/objects (00/,
> 01/, etc)
>
> Is there a feasible way that I can properly recover
> the .git/objects/pack directory such that the developer who had their
> last two weeks of local work thrashed can get it back?

I do not know about "feasible" and "properly", but ...

 (0) take backup of the repository of this unfortunate developer.

 (1) make a fresh clone of the central repository that this unfortunate
     developer's work started out from.

 (2) copy the contents of the .git/objects/pack/ of that clone to the
     developer's .git/objects/pack/.

See if "fsck --full" complains after that.  If the repository was not
repacked during that period, all objects created by the activity by the
unfortunate developer would be loose, so ...
