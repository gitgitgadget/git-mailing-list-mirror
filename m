From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are these bugs?
Date: Wed, 27 Aug 2008 18:20:01 -0700
Message-ID: <7vwsi2j5q6.fsf@gitster.siamese.dyndns.org>
References: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com>
 <7v1w0akolk.fsf@gitster.siamese.dyndns.org>
 <20080828010458.GE12354@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Git List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 03:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWCM-0008Jn-1r
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbYH1BUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYH1BUM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:20:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYH1BUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:20:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57BE752921;
	Wed, 27 Aug 2008 21:20:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A80D55291F; Wed, 27 Aug 2008 21:20:06 -0400 (EDT)
In-Reply-To: <20080828010458.GE12354@leksak.fem-net> (Stephan Beyer's message
 of "Thu, 28 Aug 2008 03:04:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 750E34AA-749F-11DD-B863-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94006>

Stephan Beyer <s-beyer@gmx.net> writes:

> Junio C Hamano wrote:
> 
>> "Jay Soffian" <jaysoffian@gmail.com> writes:
>> 
>> > I understand why "git reset" failed, but at best the error message is
>> > confusing to a new user.
>> 
>> This is in "patches welcome" category.
>
> <noise>
> But I still think it's stupid.
> </noise>

Yes I think it is stupid.  The dummy commit does not change the fact that
you need to special case it anyway, and special casing you can do without
the dummy commit that will contaminate the history.  We already have such
special case for "log -p" (--root used to be optional).  If rebasing onto
emptiness is problematic, the command should be taught how.

> So, for a patch, is it sane to just remove/clear the index
> if get_sha1("HEAD", sha1) fails?

As a general idea, yes, but details matter.

If the user says "git reset [--hard/--soft/--mixed] HEAD" from the command
line, we should say "You do not even have HEAD commit".  If "git reset"
deduced (incorrectly) that the user meant HEAD, and only in that case, we
should clear the index.
