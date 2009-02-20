From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wierd git over http behaviour
Date: Thu, 19 Feb 2009 22:23:23 -0800
Message-ID: <7vab8hiq3o.fsf@gitster.siamese.dyndns.org>
References: <1d3f23370902192213g560020b3h7a2459c1439e5e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Williams <john.williams@petalogix.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 07:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaOol-00086V-3Q
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbZBTGXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZBTGXa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:23:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbZBTGXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:23:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B42D39BD46;
	Fri, 20 Feb 2009 01:23:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A82019BD41; Fri,
 20 Feb 2009 01:23:25 -0500 (EST)
In-Reply-To: <1d3f23370902192213g560020b3h7a2459c1439e5e5c@mail.gmail.com>
 (John Williams's message of "Fri, 20 Feb 2009 16:13:20 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FCD47BB8-FF16-11DD-9BAE-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110803>

John Williams <john.williams@petalogix.com> writes:

> Strange thing is, when doing an http fetch of said tree, it gets no updates
> to the tree later than about Jan 13 this year, even though the tree itself
> has many, many commits since then (its origin is Linus's tree and we pull
> regularly).  Heads created later than that date are also not visible (doing
> git branch -a) in the clone pulled over http.  Clones made using git: are
> fine.

Most likely you would want to run git-update-server-info from
project.git/hooks/post-update hook.  A sample shipped with git looks like:

    #!/bin/sh
    #
    # An example hook script to prepare a packed repository for use over
    # dumb transports.
    #
    # To enable this hook, rename this file to "post-update".

    exec git-update-server-info

make sure it is executable.

    $ cd linux-2.6-microblaze.git/hooks
    $ ls -l post-update
    $ chmod +x post-update

And then run "git update-server-info" just once in the repository.  I see
it was run on Jan 22nd and not since then, but the latest of your refs
have Feb 19th timestamp.  Every time somebody pushes into this repository,
you would need to run the command, and post-update hook is a standard way
to do so easily.
