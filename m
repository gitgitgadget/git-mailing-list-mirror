From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Revert behavior
Date: Tue, 09 Sep 2008 15:10:16 -0700
Message-ID: <7v63p53r93.fsf@gitster.siamese.dyndns.org>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
 <200809091538.13961.jnareb@gmail.com> <20080909212834.GC10544@machine.or.cz>
 <e06498070809091439q1c543807pd6e74b7ada32434@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>, "Jakub Narebski" <jnareb@gmail.com>,
	"Elijah Newren" <newren@gmail.com>,
	"Govind Salinas" <govind@sophiasuchtig.com>, git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdBQu-0001dM-9c
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 00:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYIIWK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYIIWK2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 18:10:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYIIWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 18:10:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CACA779B2D;
	Tue,  9 Sep 2008 18:10:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 12F3A79B2B; Tue,  9 Sep 2008 18:10:18 -0400 (EDT)
In-Reply-To: <e06498070809091439q1c543807pd6e74b7ada32434@mail.gmail.com>
 (Steven Walter's message of "Tue, 9 Sep 2008 17:39:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B508AF4-7EBC-11DD-BDA0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95448>

"Steven Walter" <stevenrwalter@gmail.com> writes:

> I agree with this.  That's part of the problem I have with schemes to
> make commands work similarly to other SCMs.  If you give, for example,
> eg a mode to act like "svn revert;" that all well and good until the
> user runs "git diff" and you're made a liar.  In svn, there would be
> no diff, because the files all match their respective upstream
> versions.  In git, you would see changes because the file no longer
> matches the last commit.

If you implement "eg svn-like-revert" to checkout the given paths out of
the last commit, instead of the index, shouldn't that be sufficient?

> It it a delicate balance to have the user interface match both the
> mental model of the user and the storage model of the tool.

I do not think it is that simple.

You could match the user experience to the mental model of the other tool,
by hiding the differences and insisting that people use only your tool.

The real issue is that you may need to castrate the underlying tool in
certain places if its world model is richer than the model the tool you
are trying to emulate.  Ignoring the index by making "svn-like-revert"
work on both index and the working tree file at the same time is a good
example of that.

If the castrated feature is truly too exotic and rarely useful for mere
mortals, that strategy works very well.  A simpler world model that lets
you do the same job equally well is a much better UI than the needlessly
complex one.  But if that is not the case, your users would eventually
graduate out of the training wheel and would want to use that feature you
hid away from them, and at that point they need to unlearn parts of the
simpler world model and shift their world view somewhat.  If you try to
support both classes of users, that become hard.

I have to admit that I used to have my own Porcelain when git was very
young, not because I did not like existing UI git had, but there was no UI
back then.  "My own" Porcelain is relatively easy -- I have to only cater
to my own needs and need to expose only the limited subset of the features
the underlying tool (in this case, the storage model and history view of
git) I understand, and nobody complains that he cannot access the parts I
do not expose to him.  Growing it to satisfy wider audience is the hard
part.
