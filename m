From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Mon, 20 Feb 2006 01:04:56 -0800
Message-ID: <7vwtfqcsef.fsf@assigned-by-dhcp.cox.net>
References: <7v3bieea32.fsf@assigned-by-dhcp.cox.net>
	<43F97F0D.9080500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 10:05:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB6yp-0002dy-3y
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 10:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWBTJFB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 04:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBTJFB
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 04:05:01 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:29682 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932253AbWBTJFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 04:05:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220090225.DOZO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 04:02:25 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F97F0D.9080500@op5.se> (Andreas Ericsson's message of "Mon, 20
	Feb 2006 09:34:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16471>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>
>> There now is further performance improvements for git-send-pack
>> to avoid sending a huge blob or tree object in its full
>> representation when we know the other end has a suitable object
>> to use as the base; instead we can just send it out deltified.
>> The other end would expand it to a loose object and this would
>> not make abit of difference in the resulting repository -- only
>> the bandwidth requirement reduction is visible [*1*].
>
> How likely is this to increase the CPU-power needed on the
> server-side? If there is a blob on the server-side, but far from the
> deltified object I suppose we have to look at each commit, perhaps
> only to discover that the client doesn't have them and we need to
> construct the blob anyways.

Not much.  It deliberately keeps the set of blobs and trees to
consider for remote base to minimum -- just the trees contained
in the boundary commits.  That way we may miss the best base
candidate that are further back in history, but it does not
matter because even using the less optimum one as a base saves
us from sending the base object at all.
