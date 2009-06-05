From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] bisect: add parameters to "filter_skipped"
Date: Thu, 04 Jun 2009 23:48:29 -0700
Message-ID: <7vtz2vp45e.fsf@alter.siamese.dyndns.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org>
	<20090605041044.8885.91204.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 08:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCTER-0003eD-KD
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 08:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbZFEGs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 02:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbZFEGs2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 02:48:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62729 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZFEGs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 02:48:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090605064829.FWAS17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jun 2009 02:48:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 06oV1c0074aMwMQ046oVPM; Fri, 05 Jun 2009 02:48:29 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=PD12UfR0eMYA:10 a=tvif9lojWSkA:10
 a=dIu3SnmMAAAA:8 a=phIaW6NKzYYc16zDA-4A:9 a=_6KzXY8qDULGbPS2TRQA:7
 a=ITZMiz4ltN3KSCd78fo3jKLo6VIA:4 a=Rn8qiON8_f4A:10 a=Ki_CO6cFZFbJnxwg:21
 a=GI-dpVx2kBeAurzY:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120756>

Christian Couder <chriscool@tuxfamily.org> writes:

> because we will need to get more information from this function in
> some later patches.
>
> The new "int *count" parameter gives the number of commits left after
> the skipped commit have been filtered out.
>
> The new "int *skipped_first" parameter tells us if the first commit
> in the list has been skipped. Note that using this parameter also
> changes the behavior of the function if the first commit is indeed
> skipped. Because we assume that in this case we will want all the
> filtered commits, not just the first one, even if "show_all" is not
> set.

The way you use (*skipped_first == -1) as a marker to mean "we've already
checked more than one commit_list so even when we see a one to be skipped,
it won't be the first one" is unreadable, especially without explanation.
Worse yet, the above paragraph explains what the parameter does, but why
is it so special to skip the one that happens to be the first on the input
list, especially when one does not know how the list is sorted to begin
with.

I understand that the list is sorted by the "goodness" value, i.e. the one
that cuts the graph into closer-to-equal halves comes earlier in the list,
but still it is unclear why having to skip the best one is so special
compared to having to skip say the second best one, especially when you
imagine a case where the first two on the list are of equal "goodness"
value.
