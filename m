From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] patch-id: make it stable against hunk reordering
Date: Thu, 24 Apr 2014 11:13:19 -0700
Message-ID: <xmqq7g6ewq80.fsf@gitster.dls.corp.google.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
	<1398255277-26303-4-git-send-email-mst@redhat.com>
	<xmqq4n1k0wtw.fsf@gitster.dls.corp.google.com>
	<20140423175717.GB28308@redhat.com>
	<xmqqzjjbwvk9.fsf@gitster.dls.corp.google.com>
	<20140424062938.GA30231@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:13:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdO9W-0007cY-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620AbaDXSN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:13:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbaDXSN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:13:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0F77FEB3;
	Thu, 24 Apr 2014 14:13:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJ7RqF7ac4wTnQ5zmA3DGVn7+Tg=; b=UwhR2/
	u1zn8fFrzrvJ4NaelByAIJuPRztzXsf1oGMJGX+Hi1RX/1Y3//P+Wbg/KndSGp21
	fi/G9SpLfw3lv6EWa5ON/TmSbprvLHvD+0yGNCp/2R+LAoXYuPnAydw9ze3WTQbG
	syzxOGrS25VV08umD5/cOdWACNX2WFUUtsnYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R3M+Z9shCOMNKuR4e59YppGmCWjB89gZ
	+jbQPtpY0AxIHGLh1pkE7FO07dIm7Bb/OEMQZtPXFslDjlJhbxXCphALz2M5s3+2
	uOdZYo/y7nZ5Xa2nCwq1ys5D6hhx5P7j/6cBjpxzGbryWYe3zmGa6rPuvknOg84L
	M+iOg8E2LC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 216B87FEB2;
	Thu, 24 Apr 2014 14:13:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BACD7FEAF;
	Thu, 24 Apr 2014 14:13:21 -0400 (EDT)
In-Reply-To: <20140424062938.GA30231@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 24 Apr 2014 09:29:38 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E40D08E-CBDC-11E3-A66E-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246984>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Apr 23, 2014 at 03:05:42PM -0700, Junio C Hamano wrote:
>
>> After comparing the patches 4-6 and the one that has been in 'next'
>> for a few weeks, I tried to like the new one, but I couldn't.
>
> I'm fine with the one in next too.
> I was under the impression that you wanted me to change
> the behaviour so I worked on this,...

What I wanted to see was to make sure this would not kick in unless
the user explicitly asks.  "patchid.stable" configuration variable
is very much welcome, and if it defaulted to false with or without
"diff.orderfile", that would have been very much welcome.  Then
nobody will be surprised.

>> But "diff.orderfile" configuration is all and only about the
>> producer, and does not help the case at all.
>
> OK, we can just drop that, that's easy.
>
>> Compared to it, the previous version forced people who do not have a
>> particular reason to choose between the variants to use the new
>> "stable" variant, which was a lot simpler solution.
>> 
>> The reason why I merged the previous one to 'next' was because I
>> wanted to see if the behaviour change is as grave as I thought, or I
>> was just being unnecessary cautious.  If there is no third-party
>> script that precomputes something and stores them under these hashes
>> that breaks with this change, I do not see any reason not to make
>> the new "stable" one the default.
>
> Ah okay, so we just wait a bit and see and if all is quiet the
> existing patch will graduate to master with time?
> Totally cool.
> I thought you wanted me to add the config option, but if everyone
> is happy as is, I don't need it personally at all.

... or if we see problems, then build a fix on top to introduce
"patchid.stable" that defaults to false and not linking the feature
with "diff.ordefile".

Adding a new feature turned-off by default is the safer thing to do.
When nothing changes, by defintion there won't be a new breakage.
That is the default stance this project has taken for a long time,
and what made us trusted by projects that manage their source files
using our product.

It however is to favour stability and "no surprise" over progress,
and it may not be an optimal thing to do if the new feature is
compellingly good.  In some cases like this one, we may need to
experiment to find out the need of the users, and introducing the
feature with a configuration that is explicitly opt-in is one way to
do so.  We may or may not see many people using that feature without
disrupting existing users that way.

Cooking in 'next' with the feature turned-on by default is another
way that is riskier, but in this particular case, the population
that is likely to be affected are power users, which would match the
audience of 'next'---those who still want stability but want to be
closer to the cutting edge.
