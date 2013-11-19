From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] Rename suffixcmp() to ends_with() and invert its result
Date: Tue, 19 Nov 2013 14:28:08 -0800
Message-ID: <xmqq4n7881s7.fsf@gitster.dls.corp.google.com>
References: <20131117083930.4177.79411.chriscool@tuxfamily.org>
	<20131119191322.GA4212@google.com>
	<20131119.220438.1634671089949485179.chriscool@tuxfamily.org>
	<CALWbr2yG7XOhuZa9bf6sXRV=m49dTPNyPZ9JUU2-_2G8ZJsCTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git <git@vger.kernel.org>, apenwarr@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>, ae@op5.se
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 23:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VitmM-0008Ej-02
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 23:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab3KSW2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 17:28:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3KSW2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 17:28:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7AC54245;
	Tue, 19 Nov 2013 17:28:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cX6h0S5N/B0iclAVe4YvV6qmQh0=; b=ybXPbo
	d6kmlG9jE+6BNimMXxQ3mgfmYvpozmnut9v/hLaqC0MbJb3CLxfgmQAG1mkCaZpI
	Jen3jTxKWRsdNyfkBi/vfUdgPwE/busPqgV9RRaBfKUYgnZ0OCSlLpeLehzISMFZ
	+tIt4ujO127lvomNN1ch0YqvHsKT0m7Gl/FSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=skn+MtuURe4Z2jBd5h43CqhsKGa5rRyD
	ozFFY6+n5XkKpTHwkzd3JSFN0zK45ZPqHftYtpVRLdZ9Rn5A9pWsa+9WodfqmVw7
	ZzCUg4MCVuwNXADA0+iR3wXsHIoQvyPSMiYWgtNUlctQYkS529LsgG7vzdTt3/wm
	SQkBl7JcHso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E70D54244;
	Tue, 19 Nov 2013 17:28:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B4BD54243;
	Tue, 19 Nov 2013 17:28:11 -0500 (EST)
In-Reply-To: <CALWbr2yG7XOhuZa9bf6sXRV=m49dTPNyPZ9JUU2-_2G8ZJsCTg@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 19 Nov 2013 22:32:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF6E93F6-5169-11E3-9323-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238054>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Tue, Nov 19, 2013 at 10:04 PM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> To avoid spamming the list again, I am going to send the following
>> patches from the 86 patch long series to replace prefixcmp() with
>> starts_with():
>>
>> [PATCH v2 00/86] replace prefixcmp() with starts_with()
>> [PATCH v2 01/86] strbuf: add starts_with() to be used instead of prefixcmp()
>> [PATCH v2 02/86] diff: replace prefixcmp() with starts_with()
>> [PATCH v2 08/86] transport*: replace prefixcmp() with starts_with()
>> [PATCH v2 40/86] environment: replace prefixcmp() with starts_with()
>> [PATCH v2 86/86] strbuf: remove prefixcmp() as it has been replaced with starts_with()
>>
>> If there are no problems with them, then I will suppose that most of
>> the patches are ok and probably send them all unless I am asked not
>> to.
>
> I'm not exactly sure I understand the point of not squashing all those
> patches together ?
> It's not like one is going without the others, or that the commit
> message provides some new information (except for the name of the
> file, but that is not very relevant either). The downside is that it's
> _many_ messages to bypass when reading mails from small-screen devices
> :-)

The only plausible reason I could think of is to avoid clashing with
topics in-flight, but then the approach to produce per-file patch is
not perfect for that purpose, either, when more than one topic in
flight touch the same file at different places.

I'd say probably the best organization would be something like:

 * A set of clean-up patches to normalize oddball usages of existing
   functions (e.g. normalize 'prefixcmp(a,b) != 0' in some file(s)
   to 'prefixcmp(a,b)');

 * A single patch to introduce the new function(s), to be applied on
   top of 1.8.5;

 * A large patch to convert all uses of prefixcmp to starts_with and
   suffixcmp to ends_with in the 1.8.5 codebase;

 * A patch for each topic in flight to convert newly introduced
   prefixcmp/suffixcmp to starts_with/ends_with, to be applied after
   the topic graduates to 'master' after 1.8.5; and then finally

 * A separate patch to remove prefixcmp and suffixcmp, to be applied
   after _all_ in-flight topic has graduated to 'master'.
