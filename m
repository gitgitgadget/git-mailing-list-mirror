From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gui: Allow "Stage Line" to stage adjacent
 changes independently
Date: Tue, 15 Jul 2008 14:49:24 -0700
Message-ID: <7vy742zul7.fsf@gitster.siamese.dyndns.org>
References: <1216156261-9687-1-git-send-email-johannes.sixt@telecom.at>
 <1216156261-9687-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsPr-0002v9-I9
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbYGOVte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbYGOVte
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:49:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbYGOVtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:49:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 47B3A2DAE4;
	Tue, 15 Jul 2008 17:49:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F93D2DAE0; Tue, 15 Jul 2008 17:49:27 -0400 (EDT)
In-Reply-To: <1216156261-9687-2-git-send-email-johannes.sixt@telecom.at>
 (Johannes Sixt's message of "Tue, 15 Jul 2008 23:11:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E86B861E-52B7-11DD-B2E5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88601>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Consider this hunk:
>
>   @@ -10,4 +10,4 @@
>    context before
>   -old 1
>   -old 2
>   +new 1
>   +new 2
>    context after
>
> [Nomenclature: to "stage change 2" means to stage lines "-old 1" and
> "+new 1", in any order; likewise for "unstage" and "change 2".]

You lost me.

Do you mean to say that you always interpret the above hunk as:

   @@ -10,4 +10,4 @@
    context before
   -old 1
   +new 1
   -old 2
   +new 2
    context after

and call "replace 'old 1' with 'new 1'" as "change 1", "replace 'old
2' with 'new 2'" as "change 2"?

If it is what you are doing, it does not make much sense to me.  "new 1"
may correspond to "old 1" and "old 2" while "new 2" may be an independent
addition.  E.g.

   @@ -10,4 +10,4 @@
    context before
   -#define add(x,y) \
   - (x) + (y)
   +#define add(x,y) ((x)+(y))
   +#define sub(x,y) ((x)-(y))
    context after

I might want to pick bugfix of add() definition without using the new
definition of sub().

Please call

	"-old 1" - change #1
        "-old 2" - change #2
        "+new 1" - change #3
        "+new 2" - change #4

and try explaining what you are doing again, pretty please?
