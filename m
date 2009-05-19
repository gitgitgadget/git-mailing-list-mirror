From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Mon, 18 May 2009 22:20:45 -0700
Message-ID: <7vws8d8y8i.fsf@alter.siamese.dyndns.org>
References: <20090517153307.6403.73576.>
	<20090517153647.6403.44036.chriscool@tuxfamily.org>
	<7v3ab3exht.fsf@alter.siamese.dyndns.org>
	<200905190616.30132.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 19 07:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6HlP-0008S3-W6
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 07:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZESFVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 01:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZESFVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 01:21:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53570 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZESFVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 01:21:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090519052046.YBUF2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 19 May 2009 01:20:46 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id tHLl1b00B4aMwMQ03HLlk8; Tue, 19 May 2009 01:20:45 -0400
X-Authority-Analysis: v=1.0 c=1 a=4Mj9RkLmTmMA:10 a=wsYAPnAVpiQA:10
 a=dIu3SnmMAAAA:8 a=Ggj7XoTlUYTYiM_vJ0IA:9 a=ObwMDc9is8OJMlBWHpHyBpH_sgEA:4
 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <200905190616.30132.chriscool@tuxfamily.org> (Christian Couder's message of "Tue\, 19 May 2009 06\:16\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119492>

Christian Couder <chriscool@tuxfamily.org> writes:

> By the way, when you say that you suspect an attempt to replace an object 
> that is directly listed on the command line would not work very well with 
> the current replace series, is it related to the unparsing commit problem?

What I fear is something like this.

	git push $there 04a8c^2:master

It would need to parse 04a8c to find its second parent and then start
discussing what object to send with the other end.  "04a8c^2" is a direct
user input and should mean the same commit as git show "04a8c^2" would
give the user, so it obviously needs to obey the replace rules (making
04a8c parsed), but the object transfer should not look at replace at all
(that's the whole point of not using the "graft hack" that cannot be
sanely transferred to the other end).
