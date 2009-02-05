From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFH: git show HEAD:$SUBMODULE
Date: Thu, 05 Feb 2009 09:35:53 -0800
Message-ID: <7vwsc4eqh2.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902051744520.7491@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8AM-0007nv-8U
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZBERgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZBERgB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:36:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbZBERgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:36:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E59399792D;
	Thu,  5 Feb 2009 12:35:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC2A79792B; Thu,
  5 Feb 2009 12:35:55 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902051744520.7491@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Thu, 5 Feb 2009 17:46:51 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 733AB85C-F3AB-11DD-9395-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108585>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> at the moment, 'show HEAD:$SUBMODULE' fails horribly, as git-show abuses 
> the revision walker to parse the command line parameters, and the revision 
> walker does not like a non-existing commit.
>
> Instead, it would be nicer to show the user something like
>
> 	HEAD:$SUBMODULE
> 	submodule at commit $COMMIT_NAME
>
> However, I have no clue how to go about getting that.  I want to avoid 
> having to parse the parameters twice, but I also do not want to fsck up 
> the revision walker...
>
> Ideas?

This is not an idea but it falls into the same category as handling this
in a way different from the current code.

	$ cd Documentation
        $ git show HEAD:git.txt

You really shouldn't letting revision machinery to parse it if you want to
see these work in the way you want, because both in your example and in
the often asked-for "relative to cwd" example, what you are *asking for*
is not just an object name, but you are using the mechanism that is meant
to be used for one.

I personally think reusing the "object name" syntax for either of the
above usages is a mistake, though.  If HEAD:$submodule_path is a notation
for naming an object (which happens to resolve to a commit) and HEAD:git.txt
is a notation for naming a blob object that is found at the top level of
the tree-ish that can be called HEAD, they should retain the same meaning
throughout the system and "git show" shouldn't be messing with the
semantics of the notation.
