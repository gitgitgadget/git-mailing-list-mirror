From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Sat, 05 Jul 2008 23:27:14 -0700
Message-ID: <7vd4lro7ct.fsf@gitster.siamese.dyndns.org>
References: <20080701150025.GD5852@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 08:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFNk9-0006ZL-Vw
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 08:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbYGFG1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 02:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYGFG1X
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 02:27:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbYGFG1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 02:27:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4568B1B3F7;
	Sun,  6 Jul 2008 02:27:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6F3951B3F6; Sun,  6 Jul 2008 02:27:16 -0400 (EDT)
In-Reply-To: <20080701150025.GD5852@joyeux> (Sylvain Joyeux's message of
 "Tue, 1 Jul 2008 17:00:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9771FBAC-4B24-11DD-8E5D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87502>

Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:

> The 'master' version of git-submodule.sh fails to see that
> a/b/c/repository is an already existing repository and messes up the
> whole thing. The following patch fixes that.
> -- 
> Sylvain
>
>>From 2bca2e17a01cd81ce30f81750583ab943ab57ff0 Mon Sep 17 00:00:00 2001
> From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
> Date: Tue, 1 Jul 2008 16:45:04 +0200
> Subject: [PATCH] fix submodule add for non-toplevel in-project directories
>
> This patch fixes git-submodule add for submodules that
> already exist in the current package tree, in a folder
> which is not at toplevel, i.e.:
>
>   git submodule add a/b/c/repository

Which one is the commit log message ;-)?

Perhaps Documentation/SubmittingPatches needs a review?

> +test_expect_success 'adding an already-existing repository deep in the directory hierarchy' '
> +
> +        mkdir dir0 &&
> +        mkdir dir0/dir1 &&
> +        git clone init dir0/dir1/init &&
> +        git-submodule add dir0/dir1/init &&
> +        git-submodule status | grep "dir0/dir1/init"
> +'

I am not sure if this is fixing a sane use case.  "submodule add" is
documented to take:

    'git submodule' [--quiet] add [-b branch] [--] <repository> [<path>]

and you are adding at dir0/dir1/init a submodule that will interact with "init"
repository, so shouldn't that command line be something like:

	git submodule add init dir0/dir1/init

???

Confused..
