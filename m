From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: add --long-tests option
Date: Mon, 16 Jun 2008 23:39:07 -0700
Message-ID: <7vy7547egk.fsf@gitster.siamese.dyndns.org>
References: <1213666142-24680-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 08:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8UsA-0002jF-S1
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 08:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbYFQGjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 02:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYFQGjZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:39:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbYFQGjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:39:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA3FA233A4;
	Tue, 17 Jun 2008 02:39:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C740233A2; Tue, 17 Jun 2008 02:39:16 -0400 (EDT)
In-Reply-To: <1213666142-24680-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Tue, 17 Jun 2008 03:29:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E61346C-3C38-11DD-A0B3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85264>

Lea Wiemann <lewiemann@gmail.com> writes:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 163167c..4cd99af 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -80,6 +80,8 @@ do
>  		debug=t; shift ;;
>  	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
>  		immediate=t; shift ;;
> +	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
> +		export GIT_TEST_LONG=t; shift ;;
>  	-h|--h|--he|--hel|--help)
>  		help=t; shift ;;
>  	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)

Hmm.

I am guessing that the reason why you do not unset GIT_TEST_LONG upfront
in the script is because the user can do:

	$ cd t
        $ GIT_TEST_LONG=t; export GIT_TEST_LONG
        $ ./t9999-this-test.sh
        $ ./t9999-that-test.sh

or even:

	$ GIT_TEST_LONG=t make test

without having to say --long-tests from the command line that way.  If
that is the case, however, I wonder if this --long-tests option is even
necessary.

Please do not get me wrong --- I am _not_ suggesting to unset (or set to
empty) GIT_TEST_LONG at the beginning of test-lib before command line
parsing.  I do want the ability to run all the expensive tests with a
single command line retained, as I expect it would be useful before a
major release.
