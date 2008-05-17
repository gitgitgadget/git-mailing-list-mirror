From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Sat, 17 May 2008 02:12:25 -0700
Message-ID: <7vve1dcn0m.fsf@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
 <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
 <7vprrpswof.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131552410.3019@woody.linux-foundation.org>
 <7vve1hrbct.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131811540.3019@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 17 11:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxITw-0008Fe-7S
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 11:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbYEQJMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 05:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYEQJMl
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 05:12:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYEQJMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 05:12:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A07B1454F;
	Sat, 17 May 2008 05:12:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C363D454B; Sat, 17 May 2008 05:12:29 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805131811540.3019@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 13 May 2008 18:14:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63068AAE-23F1-11DD-9467-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82336>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 13 May 2008, Junio C Hamano wrote:
>> 
>> With the change to remove the whole block, all tests still passes, and a
>> limited test with this:
>> 
>>         --- empty	2008-05-13 16:56:57.000000000 -0700
>>         +++ empty.1	2008-05-13 16:57:07.000000000 -0700
>>         @@ -0,0 +1 @@
>>         +foo
>> 
>> to update an originally empty file "empty" also seems to work.
>> 
>> However, with this change, it no longer allows you to accept such a patch
>> and treat it as a creation of "empty".  Instead we barf with "error:
>> empty: No such file or directory", if you do not have an empty "empty"
>> file in the work tree when you run "git apply" on the above patch.
>
> Ok, that's a bug. It should *not* require that existing empty file, since 
> "is_new" is -1. That's what -1 means: we don't know if it is new or not.
>
> So I think your patch is correct, but we need to fix the thing that barfs 
> to not barf if we don't know the status of "is_new"

Sorry for taking some time to follow this through (I've been busy with day
job).  Two patches follow this message to address this issue.
