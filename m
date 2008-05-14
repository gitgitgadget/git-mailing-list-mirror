From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH v2] revision.c: really honor --first-parent
Date: Wed, 14 May 2008 12:34:54 +0200
Message-ID: <20080514103454.GA28610@cuci.nl>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com> <1210605156-22926-1-git-send-email-hjemli@gmail.com> <20080513201522.GA11485@cuci.nl> <8c5c35580805131343kc115df6yd7ce3281fb3e6171@mail.gmail.com> <7vej85suc2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 12:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwEKw-0001l3-JB
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 12:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYENKe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 06:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYENKe4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 06:34:56 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:49969 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbYENKez (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 06:34:55 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 95F225461; Wed, 14 May 2008 12:34:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vej85suc2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82094>

Junio C Hamano wrote:
>"Lars Hjemli" <hjemli@gmail.com> writes:
>>>  - Your code now doesn't simplify the (IMO) convoluted walk, and still
>>>   marks things as seen, even though in the first-parent case, these
>>>   commits are not really seen at all.  It implies that your code
>>>   generates differing output, depending on the merges present.

>> I don't think so. My code should neither follow nor mark as SEEN any
>> parent but the first (but I could obviously be wrong).

>A major part of the "convoluted walk" is the (il-)logic that skipped
>earlier SEEN parents and treated the first unseen one as if it was the
>first parent, which is not exactly Stephen's fault.  It was placed by
>yours truly in the very original code but it was done without much
>thought.

>I think your patch is the correct fix for that convolution, regardless of
>the traversal order stability issue Stephen mentions.

I agree that Lars' patch prevents parts of the tree to go "dark" (so did
my patch).
However, without either patch, that implies that the current --first-parent
code has a high probability of obscuring parts of the tree depending on
traversing order (in any tree which contains at least one merge).

So, I'd say, since the current code does not and cannot work reliably
for anyone specifically using --first-parent (with every merge
encountered, the probability of correctness is multiplied by 0.5 at
most/least), you are going to do them a favour anyway by fixing the code,
then why not simplify the convolution and make the code rock-steady (and
implement my patch)?

Anyone using --first-parent in production now has an embarrassingly high
probability of missing commits in his generated lists (I know that I
noticed the problem within 5 minutes from actually trying to use the
flag to get meaningful output).  So fixing and simplifying the code now
is rather unlikely to create any more surprises than the current code
already presents to existing users (if any).
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.

What if there were no hypothetical questions?
