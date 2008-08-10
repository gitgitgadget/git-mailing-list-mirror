From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history
 simplification with paths
Date: Sun, 10 Aug 2008 12:19:13 -0700
Message-ID: <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSGSo-00063e-IE
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 21:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbYHJTTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbYHJTTU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 15:19:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbYHJTTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 15:19:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 58DC35411C;
	Sun, 10 Aug 2008 15:19:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8507B5411A; Sun, 10 Aug 2008 15:19:15 -0400 (EDT)
In-Reply-To: <1218375840-4292-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Sun, 10 Aug 2008 15:44:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B09295E-6711-11DD-B548-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91878>

Thomas Rast <trast@student.ethz.ch> writes:

>   $ g rev-list --pretty=oneline --full-history HEAD -- dir
> ...
> But --parents --full-history magically revives the merge:
> ...

Personally I do not think --full-history without --parents is of much
usefulness (I'd let Linus or somebody else defend this usage, or make it
imply revs.rewrite_parents otherwise).  If you remove that case from your
set of experiments in the equation, do the rest of the results make sense?

> More to the point, --simplify-merges actually shows the merge when
> --full-history does not, resulting in ...

One thing I forgot to mention (but the code of course does not forget to
do) in the series is that --simplify-merges implies revs.rewrite_parents
which roughly translates to your experiments from the command line to
always have --parents option.

>   $ git rev-list --pretty=oneline --sparse --parents --simplify-merges HEAD -- dir
>   e0083e6... aad9982... 984aa48... b3127f4... Merge branches 'side' and 'unrelated'
>   b3127f4... b60c459... d: unrelated
>   984aa48... b60c459... C: dir=B
>   aad9982... b60c459... B: dir
>   b60c459... ad7052b... A: dir
>   ad7052b... initial

I am not sure what one should expect from combination between these two
options.  --sparse says do not drop commits that are of no interest with
respect to the paths specified, while --simplify-merges tells it to
simplify merges so that the remaining graph shows only the ones that have
relevance to !TREESAME (iow "has some changes") nodes.
