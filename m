From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Sun, 03 Feb 2013 23:13:00 -0800
Message-ID: <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: jongman.heo@samsung.com
X-From: git-owner@vger.kernel.org Mon Feb 04 08:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2GF5-00012t-AT
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 08:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab3BDHNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 02:13:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab3BDHND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 02:13:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4109C962E;
	Mon,  4 Feb 2013 02:13:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6IoeNTeOLQ1033GaDf6T/93Vp6c=; b=GRe4AA
	QZUnXSYAyrK5jPFjs44f55PjFo6Q6mEPjeZQMIcxV+9EAGl+YsHEwGiQA3mq7i3/
	c3LF5/Ah5oI568CYvU+8jQwnRdqEcHWNGOoLuQsTqPXNJpfg9sqOB6EtCxwvYw67
	ENlW0AqpfHy696Aba7b4fSha+D9cy5G6TPYVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YQwLDMMByEaUBg1wPI2AVwdfsQwL6Ufn
	xBMCkAgxuAFc3/KWcsKjERwV95se4n9SfnUCAbCwqfh0lBnK+Hvr21IbUwY75UKz
	LneQuN5kCEWPyBgm9xYZLKTOS8hez4WfihNFh7AvqBKzWERHYr7c3tnUJfeyUij6
	moa2JZ8iBvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34357962B;
	Mon,  4 Feb 2013 02:13:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC433962A; Mon,  4 Feb 2013
 02:13:01 -0500 (EST)
In-Reply-To: <12070540.431901359961105650.JavaMail.weblogic@epml10> (Jongman
 Heo's message of "Mon, 04 Feb 2013 06:58:27 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FD33A06-6E9A-11E2-8052-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215360>

Jongman Heo <jongman.heo@samsung.com> writes:

> Jonathan Nieder wrote:
>> Jongman Heo wrote:
>> 
>>> Unfortunately, the patch didn't help to me.
>>
>>Thanks for testing.  Did you apply the patch to the older version of
>>git that generates builtin/.depend/fetch.o.d or the newer version that
>>consumes it?
>>
>>Curious,
>>Jonathan
>
> Hi, Jonathan,
>
> I applied the patch to newer version. 
>
> This time, I tried to apply the patch to older version of Makefile, and now the issue is fixed~. 
> Thanks~!

Yeah, that result is understandable, as .depend/*.o.d files will not
be rebuilt when the rules to build them changes in the Makefile.
Applying the patch to the Makefile in the pristine old tree, run the
build (which will generate .depend/*.o.d files with the corrected
rules), then checking out the new tree and running the build again
without "make clean", with or with the patch applied, would validate
that the patch fixes the issue for old ccache.

Thanks Jonathan for diagnosing, fixing, and thanks Jongman for
testing.
