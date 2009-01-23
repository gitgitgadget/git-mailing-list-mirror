From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git diff colorization idea
Date: Thu, 22 Jan 2009 16:32:49 -0800
Message-ID: <7vhc3q6evi.fsf@gitster.siamese.dyndns.org>
References: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:34:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQA07-0000nV-6n
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbZAWAc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbZAWAc4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:32:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbZAWAc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:32:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0574D93840;
	Thu, 22 Jan 2009 19:32:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D62E89383F; Thu,
 22 Jan 2009 19:32:51 -0500 (EST)
In-Reply-To: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com> (Wincent
 Colaiuta's message of "Fri, 23 Jan 2009 01:00:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6032ECB4-E8E5-11DD-9540-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106810>

Wincent Colaiuta <win@wincent.com> writes:

> I'm also thinking that perhaps a per-character approach might be
> useful here instead of a per-word one (it would make that last hunk
> look better in the mock-up screenshot that I posted); if I go the per-
> character route then that suggests that "--color-chars" might be the
> right option name, and the color slots would then be
> color.diff.new.char and color.diff.old.char.
>
> Any feedback or suggestions before I get in too deep?

I personally find your "prposal" picture too loud to my eye.

I would have expected you to propose something like this:

  | _git_remote ()
  | {
  |-    local subcommands="add rm show prune <red>update</red>"
  |+    local subcommands="add <green>rename</green> rm show prune"
  |     local subcommand=$(__git_find_subcommand "$subcommands")"
  |     if ...

if the patch were to remove update and add rename, that is.  If there is
no deletion but only insertion, you would only see green.

And that way you do not need new color slots.  You can use new color and
old color as before, and the coloring will be done to highlight only the
parts that really matter.

If you were to go this route, I suspect that showing the unchanged part on
the preimage line in light gray might make sense, like:

  | _git_remote ()
  | {
  |-    <gray>local subcommands="add rm show prune<gray> <red>update</red>"
  |+    local subcommands="add <green>rename</green> rm show prune"
  |     local subcommand=$(__git_find_subcommand "$subcommands")"
  |     if ...

because there will be the same chars/words on the postimage line anyway.

Just 2c from somebody who does not like colors very much.
