From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically update it
Date: Mon, 14 Apr 2014 11:50:44 -0700
Message-ID: <xmqq7g6rpwxn.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
	<xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
	<CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
	<xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com>
	<xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
	<CACsJy8ASAvopmyhawmUkuFk4DjBd2opL1kxu_jtopTDr80BWPg@mail.gmail.com>
	<7vmwfrmb6a.fsf@alter.siamese.dyndns.org>
	<CACsJy8C=a6a4COBdG9uLo5XNViK6Lb3+ZyWM1P_e9p7qu+shkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 20:51:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZlyH-00030I-83
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 20:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbaDNSuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 14:50:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096AbaDNSus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 14:50:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 119A37CF90;
	Mon, 14 Apr 2014 14:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V7mnbCzYI3nD9vb/bki6jPye4Oo=; b=ZpQreM
	VSi+KLudSzDc/u0dXhdH9MNsM+NNrzs2aYbooQWHQudErbyuNJElYQTAf0+TGp1p
	M8N3lESooQXss1VE3zPjQCmRSIvmMDA3Tqob/ip4/CibW6u+gMI+xZHp5w6vEtPJ
	sgV6ACXND+ZsqhHjXoRFvtbReNaAvVuSrIAds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCisslh00pVar8ldMrJv03hWN+mNz0NN
	81J0uvc10gmt9ynxL5uanpaveNarC3JHFewll3MacWw0yfxJwNjfoICssFQAaa4v
	NQO1hT4bJvVcoVtqWjBco3k6hplll3Mg1dBslqd1onNmHHUqPyDvxHgqm83krEaB
	BGqD99GEVNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC92D7CF8F;
	Mon, 14 Apr 2014 14:50:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B44A7CF8D;
	Mon, 14 Apr 2014 14:50:46 -0400 (EDT)
In-Reply-To: <CACsJy8C=a6a4COBdG9uLo5XNViK6Lb3+ZyWM1P_e9p7qu+shkQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 12 Apr 2014 17:13:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B05C6B74-C405-11E3-A007-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246256>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Apr 12, 2014 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> In the spectrum between useful and insane, there is a point where we
>> should just tell the insane: don't do it then.
>
> ... A process' dying is a
> way of telling people "this is insane" without having to draw a line
> between dos and dont's in documents.

Fair enough.  Instead of "that is insane and you may end up
recording what you do not intend to", being able to say "that is
insane and you will see some commands failing when you may end up
being in such a situation" is a lot more explicit.

Thanks for injecting some sanity to me.

> Serializing write access to make both competing processes is nice, but
> that's a separate step that may or may not be worth pursuing. And I'm
> towards not worth pursuing.

I think we are in agreement on that point.

I would want to see the proposed "read without locking, compute
heavily and then take a lock and revalidate before writing it out,
or fail" done with a focus on not hurting the "sane" use pattern,
i.e. making the "revalidate" part as light as possible.  I however
cannot seem to find any optimization opportunities other than the
"open, read and compare the checksum".  Two I thought and discarded
are:

 - checking timestamp of the index file itself, and failing when it
   has changed (without opening or reading the checksum) is not
   good; it is optimizing for the wrong case, because we would need
   to check the checksum anyway when the timestamps match.

 - checking i-num of the index file itself, and failing when it has
   changed (without opening or reading the checksum) is not good,
   either.  Creating "index.lock", writing to it and renaming it to
   "index", keeping the "index" during the whole period, would
   ensure that the index file that results with this single cycle
   would get a different i-num from the original, but if that is
   done twice or more, the same i-num can be reused and defeat the
   check.
