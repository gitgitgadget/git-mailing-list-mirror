From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sat, 08 Dec 2007 19:22:49 -0800
Message-ID: <7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 04:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1CoS-0007p8-1R
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 04:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbXLIDXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 22:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbXLIDXI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 22:23:08 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:35889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbXLIDXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 22:23:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F29AC4CC9;
	Sat,  8 Dec 2007 22:22:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 265904CC8;
	Sat,  8 Dec 2007 22:22:52 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712082134350.5349@iabervon.org> (Daniel
	Barkalow's message of "Sat, 8 Dec 2007 21:35:48 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67591>

Daniel Barkalow <barkalow@iabervon.org> writes:

> How's this? I vaguely tested it, and it doesn't break existing tests, and 
> it matches my guess at how the old code worked, at least maybe.

Well, contrib/examples/git-ls-remote.sh is your friend and you do not
have to "guess".

It did, for each ref $path it got from peek-remote, this:

		for pat
		do
			case "/$path" in
			*/$pat )
				match=yes
				break ;;
			esac
		done

I do not think pathspec_match() matches the string in a way compatible
with the above loop, and calling get_pathspec(prefix, argv) with
anything but a real path is a misuse of the interface.

I think if you do fnmatch(3) that would be compatible with the shell
loop.
