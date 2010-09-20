From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 20:20:27 +0200
Message-ID: <1jp4vak.uzmm6w190gd2rM%lists@haller-berlin.de>
References: <4C973E5B.4090201@gmail.com>
Cc: in-gitvger@baka.org (Seth Robertson), git@vger.kernel.org
To: art.08.09@gmail.com (Artur Skawina)
X-From: git-owner@vger.kernel.org Mon Sep 20 20:20:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxkyl-0007M9-Pi
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 20:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab0ITSUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 14:20:33 -0400
Received: from mail.ableton.net ([62.96.12.115]:50005 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab0ITSUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 14:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=z3B5jnAjliSFibweg3tq4K524uc4Q3qc2a+4ypwSjOo=;
	b=gbHbu3Q7aJA1Zvpt983fln5aeJG3Bp99YXKeg+OtPskxOdrjEol7obYUltcWwjvOr7y3b5aUfyKOUTBIvtGtJoDp/uEWDZc1L9RYYmXQ8C7NvzHzJ5Rd+SrJGKVhkPcHRReS1Z8bHgJ54HH/3gmnFpQjEq52kPjmuHEC77pGSwM=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1Oxkya-0003CG-4f; Mon, 20 Sep 2010 20:20:28 +0200
In-Reply-To: <4C973E5B.4090201@gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156646>

Artur Skawina <art.08.09@gmail.com> wrote:

> >>          -AA-- subtopic
> >>         /     \
> >>        A---B---C topic
> >>       /         \
> >>  D---E---F---G---H---I---J---K---L---M---N master
> >>                           \         /
> >>                            O---P---Q another-topic
> >>
> >>
> >> In the above example, the subtopic branch merge from AA to C prevents
> >> you from finding out what branch B is on using the original script.
> >
> >   Called with "B" "master", it returns H
> 
> No, it will return both C and H, just like my one-liner;

Right, there was a bug in my script: it doesn't work if B is a direct
parent of the next merge. (For A, it would correctly return only H.)  To
fix that, you'd need this version:

#!/bin/sh

git rev-list --ancestry-path --merges --reverse "$1".."${2-master}" \
  | while read ref
do
  if [ "$1" != "$ref"^ -a -z "$(git rev-list --ancestry-path "$1".."$ref"^)" ]
  then
    git --no-pager log -1 --pretty=oneline "$ref"
  fi
done

But of course, since your version is so much faster, I'll no longer
bother with mine.  Thanks!

-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
