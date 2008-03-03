From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Mon, 03 Mar 2008 15:13:39 -0800
Message-ID: <7vhcfnfljw.fsf@gitster.siamese.dyndns.org>
References: <20080303221159.GA6875@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJrg-000486-6F
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 00:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYCCXNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 18:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbYCCXNy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 18:13:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYCCXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 18:13:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 84F4E25E1;
	Mon,  3 Mar 2008 18:13:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A225625E0; Mon,  3 Mar 2008 18:13:47 -0500 (EST)
In-Reply-To: <20080303221159.GA6875@hashpling.org> (Charles Bailey's message
 of "Mon, 3 Mar 2008 22:11:59 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75995>

Charles Bailey <charles@hashpling.org> writes:

> +	# Tabstop width.  Controls the number of spaces to which tabs are
> +	# expanded. Default is 8.
> +	# To change system wide add the following to $GITWEB_CONFIG
> +	# $feature{'tabstop'}{'default'} = [8];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'tabstop'}{'override'} = 1;
> +	# and in project config gitweb.tabstop = <width>
> +	'tabstop' => {
> +		'sub' => \&feature_tabstop,
> +		'override' => 0,
> +		'default' => [8]},

Some people say "Tabs are 8 characters, and thus indentations are also 8
characters.  There are heretic movements that try to make indentations 4
(or even 2!)  characters deep, and that is akin to trying to define the
value of PI to be 3."  Some people disagree.

But while viewing what is etched in the history, it does not hurt anybody
else if the viewer uses different tab width.  Choice is good.

However, a choice made by the hosting service that runs gitweb would not
help individual viewers with different tab-width taste.  Neither does
configuration that is per-repository.  Participants of the same project
would want to view contents with different tab-width.

Perhaps the tabstop "feature" should control _if_ the tab width of the
material gitweb feeds can be tailored at all (i.e. boolean).  And when
enabled, it would leave the choice of non-8 tab width to the browser (the
way to maintain per-client choice could be cookies or extra parameters, I
do not really care the details), and use that preferred tab-width in the
untabify function.

On the other hand, maybe the tab-width customization is not about user
preference but what tab-width was used when the contents were created.  In
such a case, probably the right thing to do would be to look at the
tab-width hints embedded in the file.  In such a case, probably the tab
width setting need to be per-path (e.g. *.c files may use standard 8,
while *.py may use heretic 4).  Again, site-wide or repository-wide
configuration would not help.

In short, I do not like the patch, not because I do not like customizable
tab-width, but because I think the customizability the patch offers is of
the wrong kind and too limited to be useful.

P.S.

It might be interesting to come up with a heuristics to _guess_ the tab
width used by the content creator by looking at the contents, by the way.
There obviously are Emacs "Local Variables" and "-*-" lines and equivalent
clues vim would leave, but you could probably also use indentation levels
as a cue.

And perhaps teach the underlying git commands a special flag to expand
tabs on the output.

	"git cat-file --expand=auto blob Makefile"
	"git diff --expand=8 HEAD^..HEAD frotz.c"

;-)



