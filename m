From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove filename from conflict markers
Date: Wed, 01 Jul 2009 01:36:03 -0700
Message-ID: <7vljn8ls0c.fsf@alter.siamese.dyndns.org>
References: <20090628154559.GA29049@old.homeip.net>
	<7v63ed5pvi.fsf@alter.siamese.dyndns.org>
	<20090701123310.6117@nanako3.lavabit.com>
	<20090701075634.GA18326@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Renold <martinxyz@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLvId-0000PX-BO
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 10:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZGAIgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZGAIgF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 04:36:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64170 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZGAIgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 04:36:00 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701083603.TETA20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Wed, 1 Jul 2009 04:36:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id AYc31c0024aMwMQ04Yc3lY; Wed, 01 Jul 2009 04:36:03 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=SBpeI9OMwxYA:10 a=5QjctsA2NNtlthwRM8kA:9
 a=aO4oD4ksqEH9_jcHPLNuZI7bZ9QA:4
X-CM-Score: 0.00
In-Reply-To: <20090701075634.GA18326@old.homeip.net> (Martin Renold's message of "Wed\, 1 Jul 2009 09\:56\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122575>

Martin Renold <martinxyz@gmx.ch> writes:

>  test_expect_success "result contains a conflict" "test_cmp expect a1"
>  
>  git ls-files --stage > out
>  cat > expect << EOF
> -100644 da056ce14a2241509897fa68bb2b3b6e6194ef9e 1      a1
> +100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1      a1
>  100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2      a1
>  100644 fd7923529855d0b274795ae3349c5e0438333979 3      a1
>  EOF

I think Nana's patch also had this, but what is this hunk about?  IOW, why
does stage #1 (common ancestor's version) even change?

Is this a virtual ancestor in a criss-cross recursive merge?

> @@ -93,8 +93,8 @@ test_expect_success 'refuse to merge binary files' '
>         git add binary-file &&
>         git commit -m binary2 &&
>         test_must_fail git merge F > merge.out 2> merge.err &&
> -       grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
> -               merge.err
> +       grep "Cannot merge binary files: HEAD vs. F" merge.err
> +       grep "Merge conflict in binary-file" merge.out
>  '

At the end of the first "grep" && is missing.  But more importantly, would
this new output format really as informative as you claim, even when the
file that cannot be automerged due to its binaryness is not named
"binary-file" but simply say "X"?  The merge.err output shows that there
were some file that failed to merge due to being binary, and merge.out
output owuld show that "X" had conflict.  Would it be just as easy for the
end user to connect these two as it used to be?

I for now am assuming no mechanical end user is parsing this output to
figure out what to do, but that assumption might even be wrong.
