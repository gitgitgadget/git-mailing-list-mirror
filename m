From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 02:30:59 -0800
Message-ID: <7vabz9w270.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<200702200942.18654.andyparkins@gmail.com>
	<7vfy91ximy.fsf@assigned-by-dhcp.cox.net>
	<200702201021.58754.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 11:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJSH4-00036g-5b
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbXBTKbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 05:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbXBTKbC
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:31:02 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54965 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822AbXBTKbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 05:31:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220103059.OWBZ27628.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 05:30:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RmWz1W0061kojtg0000000; Tue, 20 Feb 2007 05:31:00 -0500
In-Reply-To: <200702201021.58754.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 10:21:57 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40229>

Andy Parkins <andyparkins@gmail.com> writes:

> Your prefixcmp() point about them being used so regularly made me wonder if 
> the following would improve readability:
>
> static inline ref_is_head(const char *a)
> {
>     return (prefixcmp(a, PATH_REFS_HEADS) == 0);
> }
> ...
>    if (ref_is_head(head))
>        head += STRLEN_PATH_REFS_HEADS;
>
> which expresses the intent of the code far more clearly.

If we _were_ doing the inline function, I would actually prefer:

        static inline ref_is_head(const char *ref)
        {
		return !prefixcmp(ref, PATH_REFS_HEADS);
        }

But at least to me,

	if (!prefixcmp(head, PATH_REFS_HEADS))
		head += strlen(PATH_REFS_HEADS);

is easier to follow than:

        if (ref_is_head(head))
                head += STRLEN_PATH_REFS_HEADS;
