From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Tue, 21 Oct 2008 15:36:40 -0700
Message-ID: <7vd4htwp6v.fsf@gitster.siamese.dyndns.org>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>
 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
 <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
 <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SLONIK.AZ@gmail.com, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:38:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsPrc-0001k6-C0
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 00:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYJUWg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 18:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYJUWg4
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 18:36:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYJUWgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 18:36:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD98E70E78;
	Tue, 21 Oct 2008 18:36:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D412D70E74; Tue, 21 Oct 2008 18:36:47 -0400 (EDT)
In-Reply-To: <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>
 (Alex Riesen's message of "Wed, 22 Oct 2008 00:06:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2A1D428-9FC0-11DD-8382-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98822>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> 2008/10/21 Junio C Hamano <gitster@pobox.com>:
>> "Leo Razoumov" <slonik.az@gmail.com> writes:
>>
>>> Even though the old behavior is "long established", it introduces
>>> unnecessary ambiguity. If I have two repos
>>> ...
>>
>> Of course.  Now you know why people don't name such a pair of repositories
>> like that ;-).
>
> FWIW, I support Leo on that. The "established" behavior is stupid.

I am not inclined to respond to such an emotional argument.  On the other
hand, it is fair to say that the existing behaviour is established,
because it is backed by a long history, which you can objectively verify.

If you think about it deeper, you will realize that it is not even clear
if it is "stupid".

More importantly, the behaviour is consistent with the way how "git fetch"
and "git clone" DWIMs the repository name by suffixing .git when the input
lacks it.  And this DWIMmery comes from the expectations that:

 (1) people name their repository project.git; and

 (2) people like using and seeing short names (iow, "clone
     git://$somewhere/project" is preferred over "clone
     git://$somewhere/project.git");

If a repository whose real location is git://$somewhere/project.git is
cloned/fetched as git://$somewhere/project by people, recording the merge
source using the shorter name used by people to fetch from it is more
consistent.  The patch breaks this consistency [*1*].

What is clear is that you would confuse yourself if you have two
repositories A and A.git next to each other, and that is primarily because
it breaks the above expectation.

git core-level rarely imposes such policies, but what Porcelains do is a
different matter.

Hence the suggestion: don't do it.

[Footnote]

*1* It would be a different matter if the patch at the same time removed
the fetch/clone DWIMmery.  At least such a patch would be internally self
consistent.
