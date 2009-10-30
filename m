From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 14:51:59 -0700
Message-ID: <7v3a50k0sg.fsf@alter.siamese.dyndns.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
 <20091030202628.GA26513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zOU-00029E-5a
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbZJ3VwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbZJ3VwJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:52:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbZJ3VwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00C9E8BD36;
	Fri, 30 Oct 2009 17:52:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XYNLWTN3U7qxaSoqWxsHaUtPDvo=; b=MPLZZT
	2JoHZk3PH78B3ddDllORz+b9kojYQWr2pMB5arVw97ROMfaNdIuBem5hlmo9b75J
	gfEG2lz5qP/AgurR58YLzwhrpgjAoQ+A2eV91nLKsvTm9RdiQzwoz7L3kO5Aq+TG
	VYS1jTXZ6M1x/BLOkCTLfO9lhOvP41+VbvTLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MblxaqlPEw/9C5oLWFnItyanbYEwT6+w
	MF7lN/U2E+2YuA1CStk96ZDHsYEBRCun5zDgdIEx3O1zyQlub8CW4923dOwL/hRc
	u7UN3h5My6GQvwH/HUGOTEWkGlwH9Dcfm9/7xePW3jo2xCYZE8Pc2qXcdeM6wu6b
	iEUxdJWycVQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C65488BD35;
	Fri, 30 Oct 2009 17:52:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3DE648BD32; Fri, 30 Oct 2009
 17:52:00 -0400 (EDT)
In-Reply-To: <20091030202628.GA26513@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 30 Oct 2009 16\:26\:28 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 777A1BC2-C59E-11DE-9DEB-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131758>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 30, 2009 at 05:36:34PM -0200, Erick Mattos wrote:
>
>> Anyway this update creates new options for choosing the source timestamp
>> or a new one.  And set as default for -c option (editing one) to take a
>> new timestamp and for -C option the source timestamp.  That is because
>> we are normally using the source as template when we we are editing and
>> as a correction when we are just copying it.
>> 
>> Those options are also useful for --amend option which is by default
>> behaving the same.
>
> Thanks, this is something I have been wanting. I have always thought
> that --amend should give a new timestamp, so that while I'm fixing up
> commits via "rebase -i" the commits end up in correct date order.
>
> Your patch seems to always use the old timestamp for -C, the new one for
> -c, and the old one for --amend. I would want it always for --amend.
>
> I talked with Shawn about this at the GitTogether; his counter-argument
> was that many people in maintainer roles will be amending or rebasing
> just to do little things, like marking Signed-off-by, and that the date
> should remain the same.

Yeah, author timestamp shouldn't be molested for that kind of thing,
although we should update commit timestamp.

Yuck, was this about author timestamp?  Please then disregard my previous
response about the default.  I do not think there is strong reason to
change the default for any of them at all, even though giving people to
update what they committed with --no-reuse-timestamp would be a good
addition.

I also suspect that comparing committer and author name may give us a good
way to tweak the default in a more user friendly way.
