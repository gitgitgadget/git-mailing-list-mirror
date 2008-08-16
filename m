From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add tests for runpath switches in configure
Date: Sat, 16 Aug 2008 12:03:07 -0700
Message-ID: <7vmyjcdbpw.fsf@gitster.siamese.dyndns.org>
References: <1218891683-6048-1-git-send-email-gafunchal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giovanni Funchal <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 21:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUR4r-0003aa-J7
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 21:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbYHPTDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYHPTDO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 15:03:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYHPTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 15:03:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A21D463DA8;
	Sat, 16 Aug 2008 15:03:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E3B1363DA7; Sat, 16 Aug 2008 15:03:09 -0400 (EDT)
In-Reply-To: <1218891683-6048-1-git-send-email-gafunchal@gmail.com> (Giovanni
 Funchal's message of "Sat, 16 Aug 2008 15:01:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F95007F8-6BC5-11DD-AF8A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92553>

Giovanni Funchal <gafunchal@gmail.com> writes:

> Most systems (e.g. Linux gcc) use "-Wl,-rpath," to pass to the linker the
> runtime dynamic library paths. Some other systems (e.g. Sun, some BSD) use
> "-R" etc. This patch adds tests in configure for the three most common
> switches (to my best knowledge) which should cover all current platforms
> where Git is used.
>
> Signed-Off-By: Giovanni Funchal <gafunchal@gmail.com>

s/O/o/; s/B/b/; (this is not a reason to reject your patch; I am
making corrections, just for future reference).

> This second part of this patch follows the idea of Junio that Makefile changes
> should be minimal, but I think this is better solution because it uses
> CC_LD_DYNPATH directly instead of NO_R_TO_GCC_LINKER, and thus it is not
> anymore a matter of "to -R or not to -R".

I do not think I have enough time to make sure to build confidence that
the changes to the Makefile won't have any downside that break people's
existing setups that use handcrafted config.mak file before the 1.6.0
final.  I am very hesitant to take [PATCH 1/2].

I thought it would suffice to autodetect NO_R_TO_GCC_LINKER without
changing Makefile at all, which would have had no risk breaking people's
existing setups, so plase let me ask you why you went this route.

Is it because you needed to support both styles ("-Wl,-rpath,$path" and
"-Wl,-rpath $path"), iow, there are combinations of gcc/gld that you cannot
pass -R and need to pass some variant of "-Wl,-rpath", and they won't work
if you give "-Wl,-rpath=$(path)" (or "-Wl,-rpath,$(path)" for that matter)
as our existing NO_R_TO_GCC_LINKER make variable arranged to do?
