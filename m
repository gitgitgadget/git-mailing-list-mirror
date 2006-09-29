From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Fri, 29 Sep 2006 12:56:05 +0200
Message-ID: <451CFBC5.3020006@op5.se>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0609270810470.3952@g5.osdl.org>	<20060928081757.GF8056@admingilde.org> <7v64f8xs7p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 12:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTG2R-0002EQ-C8
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 12:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWI2K4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWI2K4L
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 06:56:11 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:22699 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932156AbWI2K4I
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 06:56:08 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 20A396BD11; Fri, 29 Sep 2006 12:56:07 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D66336BD0F; Fri, 29 Sep 2006 12:56:05 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64f8xs7p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28107>

Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> 
>>> It should at least never be superlinear, I believe.
>> So if we want to keep the logarithmic scale we can do some maths:
>> ...
>> But only I have not succeeded in solving these equations, I always stop
>> at the last invariant :-(
> 
> There is another constraint you did not mention.  Here is the
> output from my another failed experiment:
> 
>  .gitignore                       |    1 -
>  Documentation/git-tar-tree.txt   |    3 +++
>  Documentation/git-upload-tar.txt |   39 -----------------------------
>  Documentation/git.txt            |    4 ----
>  Makefile                         |    1 -
>  builtin-tar-tree.c               |  130 +++++++++++++++-----------------------
>  builtin-upload-tar.c             |   74 ----------------------------------
>  git.c                            |    1 -
>  8 files changed, 53 insertions(+), 200 deletions(-)
> 
> The deletion from Documentation/git-upload-tar.txt looks much
> larger than addition to builtin-tar-tree.c in the above, but
> there are 50 lines added to builtin-tar-tree.c (which is why
> this experiment is a failure).
> 
> Because we are dealing with non-linear scaling, the total of
> scaled adds and scaled deletes does not equal to scaled total.
> We can deal with this in two ways.  Scale the total and
> distribute it, or scale adds and deletes individually and make
> sure the sum of scaled adds and deletes never exceed the width.
> Obviously the former is easier to implement but it was _wrong_.
> 
> The fitting algorithm in the posted patch scales the total to
> fit the alloted width and then distributes the result to adds
> and deletes.
> 

Why not just take the stupid and simple solution and make it:

file1   | +31,-19    +++
file2   | +19,-106   ---
file3   | +10,-10    ###

That is, show the number of lines that actually changed, and print a 
fixed number of plusses or minuses after the numbers to make it easy to, 
at a glance, check if more lines were added than deleted or vice versa.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
