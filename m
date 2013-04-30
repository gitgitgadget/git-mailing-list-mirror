From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 11:08:56 -0700
Message-ID: <7vwqrjdh6v.fsf@alter.siamese.dyndns.org>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
	<87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
	<20130430150430.GA13398@lanh>
	<7vehdsf19m.fsf@alter.siamese.dyndns.org>
	<CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
	<CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
	<CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:09:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEzH-0005aY-EN
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761274Ab3D3SJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:09:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760877Ab3D3SI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:08:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FFAB18FC4;
	Tue, 30 Apr 2013 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qomxkjBwVizgVf6FqBUw99ULaew=; b=sEiRiB
	R+xqDtEWtv6b9onw7We/4cWEzmLMwnOmHX1wyaZ6j83a2pdDbHD4yzt8RIVBy+yF
	WRq0O2Of9+Nnp5YQhvCSn2srr3DTfsVyzCEbsYWi7d5WADy3oV3QmR+1oAGEEkX3
	wN0H8Fwq8FINdyboVC4SxlnPqa6OpqiMh5IyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2oFHD4cqq0jV+4j08c1aVag9cJ6zZYk
	2jW+cRf7NVZHoRcjuFnQhkqnEiRuZa6Y08IxtdfrwjQsEKhM3iJ2FrGn2Er5QnWD
	WM1OaSfZ1I22emCEqAYF9xLo+tYn5rDy4lD7fQCzyHaUEfjvoxC58oWwAHlNLqjS
	cM2c9Yr0uJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73DEF18FC3;
	Tue, 30 Apr 2013 18:08:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F04B518FC0;
	Tue, 30 Apr 2013 18:08:57 +0000 (UTC)
In-Reply-To: <CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 30 Apr 2013 23:02:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0711D966-B1C1-11E2-BE24-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222978>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Felipe Contreras wrote:
>> Why would HEAD^0^0~4 work? Because the syntax is recursive.
>
> That's because you can compose with ^ and ^, while you can't with @
> and @.  Does @{0}@{0} resolve?

@{-1}@{0} does.  That means @{0} is a revision and not a ref, but @{-1}
is.

'"@" given alone' has to be a ref if we want @@{5.minutes.ago} to
resolve.
