From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Enhance performance of blame -C -C
Date: Tue, 15 Jul 2008 15:25:29 -0700
Message-ID: <7vhcaqzsx2.fsf@gitster.siamese.dyndns.org>
References: <200807160158.34994.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsyt-0006Ap-GV
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298AbYGOWZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbYGOWZi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:25:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbYGOWZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:25:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5818B3575E;
	Tue, 15 Jul 2008 18:25:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A72423575B; Tue, 15 Jul 2008 18:25:31 -0400 (EDT)
In-Reply-To: <200807160158.34994.angavrilov@gmail.com> (Alexander Gavrilov's
 message of "Wed, 16 Jul 2008 01:58:34 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F11C1B84-52BC-11DD-8C09-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88611>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> This pair of patches aims at increasing performance of copy detection in
> blame by avoiding unnecessary comparisons. Note that since I'm new to
> this code, I might have misunderstood something.
>
> There are two cases than I aim to fix:
>
> 1) Copy detection is done by comparing all outstanding chunks of the
> target file to all blobs in the parent. After that, chunks with suitable
> matches are split, and comparison is repeated again, until there are no
> new matches. The trouble is, chunks that didn't match the first time,
> and weren't split, are compared against the same set of blobs again and
> again. I add a flag to track that.
>
>   On my test case it decreased blame -C -C time from over 10min to
>   ~6min; 4min with -C80.
>
> 2) Chunks are split only if the match scores above a certain
> threshold. I understand that a split of an entry cannot score more than
> the entry itself. Thus, it is pointless to even try doing costly
> comparisons for small entries.
>
>   (Time goes down to 4min; 2min with -C80)

Ideas for both patches sound very sane.  Will take a deeper look later.

Thanks.
