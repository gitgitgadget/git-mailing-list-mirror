From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for "git stash branch"
Date: Sun, 06 Jul 2008 12:53:02 -0700
Message-ID: <7v1w26eqn5.fsf@gitster.siamese.dyndns.org>
References: <20080702195947.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0807021447200.9925@racer>
 <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org>
 <20080702195401.GA17214@toroid.org>
 <7vprpw80bw.fsf@gitster.siamese.dyndns.org>
 <20080703022316.GA25433@toroid.org>
 <7v63rn61yj.fsf@gitster.siamese.dyndns.org>
 <20080703061605.GB3815@toroid.org> <20080706112333.GA6477@toroid.org>
 <alpine.LSU.1.00.0807061453540.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 <20080706144542.GA8677@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 21:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFaJG-0005cH-ES
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 21:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820AbYGFTxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 15:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757706AbYGFTxL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 15:53:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384AbYGFTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 15:53:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC79B1D3D0;
	Sun,  6 Jul 2008 15:53:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1751F1D3CF; Sun,  6 Jul 2008 15:53:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 283C9456-4B95-11DD-91D3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87548>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-07-06 14:54:44 +0200, Johannes.Schindelin@gmx.de wrote:
>>
>> AFAICS the previous version is in 'next' already: 
>> 656b50345239293929ad8c639c5f1941c6b867ad
>
> Oh, I see, thanks. I misunderstood the request. Here's a separate patch
> to just add the test.

Oh, there is no misunderstanding.  You couldn't have possibly known if the
main body of the patch will go to 'next' or just be dropped when I said
"you might also want to have tests" to you.

> +test_expect_success 'stash apply' '
> +	echo foo > file &&
> +	git commit file -m first
> +	echo bar > file &&
> +	git stash &&
> +	echo baz > file &&
> +	git commit file -m second &&
> +	git stash branch stashbranch &&
> +	git commit file -m alternate\ second &&
> +	git diff master..stashbranch > output &&
> +	test_cmp output expect &&
> +	test 0 = $(git stash list | wc -l)
> +'

The title is probably not 'stash apply' but 'stash branch'.  Don't you
want to also validate that:

 - "stash branch" command switched to the new branch "stashbranch"?

 - before making "alternate second", the index and the working tree have
   expected contents?  and

 - the final shape of the history looks correctly forked (i.e.
   "stashbranch" branches at the commit before "-m second" commit was
   made)?

>  test_done
> -- 
> 1.5.6
