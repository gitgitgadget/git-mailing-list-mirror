From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 19:36:12 -0800
Message-ID: <7vd4eabuxf.fsf@gitster.siamese.dyndns.org>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
 <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 26 04:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRIIF-0000NE-Vr
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 04:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbZAZDgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 22:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZAZDgU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 22:36:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZAZDgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 22:36:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D5FA1CE00;
	Sun, 25 Jan 2009 22:36:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE7031CE3C; Sun,
 25 Jan 2009 22:36:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D794E54-EB5A-11DD-B862-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107165>

Keith Cascio <keith@CS.UCLA.EDU> writes:

> I agree opt-in is always better with new grammar/semantics.  However, the 
> constraint I was trying to live inside is: if I call "git diff" on the command 
> line with no options at all

"git diff" is a Porcelain.

> Worth considering: I believe Git users who've written their own scripts are not 
> the type to use diff.primer blindly, if at all.

Perhaps this nonsense comes from your misunderstanding on the line between
the plumbing and the Porcelain.

Users of git, including me, would love to be able to use default options
in our $HOME/.gitconfig file when using "git diff" interactively, but will
refuse to see our scripts that we wrote using "git diff-files" and "git
diff-index" broken, because the reason we explicitly used these plumbing
commands is to avoid getting broken with a change from the underlying
version of git.  That's the whole point of output stability for the
plumbing.

If you want to be able to use -w or -b (or --color) in git-gui, you must
first vet the script to see if it can sanely operate on the output from
git-diff-index with such options, and after it is determined that it is
safe, it should give its users a way to pass that to the underlying
plumbing, or picked up such options from the configuration (perhaps using
the same diff.primer configuration).

This has to be a conscious opt-in process per script.
