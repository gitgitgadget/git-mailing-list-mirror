From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 14:06:29 -0700
Message-ID: <7v7gipe78q.fsf@alter.siamese.dyndns.org>
References: <20130523105310.GA17361@redhat.com>
	<CAMP44s18KCYEZaMTn_S2znocyr-WDCT5ciuzLoYaSHPQFc4XCw@mail.gmail.com>
	<7v4ndtftyf.fsf@alter.siamese.dyndns.org>
	<20130523210550.GA31421@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufcia-0003xP-7f
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923Ab3EWVGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:06:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758494Ab3EWVGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:06:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CF422BAE;
	Thu, 23 May 2013 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xt6u+xfXoxpaubKVyTC0VLc33Dg=; b=kkJeP5
	6npdoLILjOpJPYbs/ydHSfD0iHlMPckilrwOoLA0iew7AgGAs5Su1q06eyu+O+mu
	9g7iqw0CVxnS4EnCal7xMrtrU8GOQplr/XclcjkJeVbAfvKiAhrKi5kvf09P9yOL
	JzCLDNe1nHnjt+2y2skBr8UcQ98kyEnVWjzqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w+ORF5ZTkKLw6AbaQ0Wwmr6pjkFTOKAQ
	mfuxNi8m9gYv3ElhfI8okFMd6gfE4jdKaxKLh51nDQnIzBg94UjJ0HUmV0UzKZlM
	Tb0sApffaVf3W4/QQpVnlX9Mz69W4X7OqlLE1YQujLbOAoCl39Ey2Mp+NKi/yFX6
	+95m5tcnHtY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BF6C22BAD;
	Thu, 23 May 2013 21:06:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA0E422BAA;
	Thu, 23 May 2013 21:06:30 +0000 (UTC)
In-Reply-To: <20130523210550.GA31421@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 24 May 2013 00:05:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A415113C-C3EC-11E2-B3C3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225294>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, May 23, 2013 at 11:10:32AM -0700, Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > On Thu, May 23, 2013 at 5:53 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> Looks like push can't resolve tags to commits.
>> >> Why is that?
>> >>
>> >> linux$ git push -f $PWD v3.10-rc2:refs/heads/vhost-next
>> >
>> > Perhaps v3.10-rc2^{}. Yeah, totally and completely not-user-friendly,
>> 
>> More commonly "v3.10-rc2^0:vhost-next", if you are truly pushing it
>> out to a remote repository, but then it invites a puzzlement "What
>> do you plan to do next after pushing?  The only reason v3.10-rc2 is
>> used is because there is not yet a local branch that will host the
>> vhost-next changes that is built on top of that tag (otherwise you
>> would be pushing that branch to vhost-next)".
>> 
>> But in this particular case, you are force-pushing into the current
>> repository, and it is spelled much more commonly
>> 
>>     git branch -f vhost-next v3.10-rc2
>> 
>> I would think.
>
> That was just a bad example though, I really use it for
> push to remove.

Then it invites a puzzlement as you can see above.
