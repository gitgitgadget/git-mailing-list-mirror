From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-v4: document the entry format
Date: Mon, 30 Apr 2012 21:00:24 -0700
Message-ID: <7vlilcczzb.fsf@alter.siamese.dyndns.org>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <xmqqzk9w93zu.fsf@junio.mtv.corp.google.com>
 <xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
 <87vckhuofj.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
	"David Michael Barr" <davidbarr@google.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 01 06:00:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP4GQ-0006IA-BK
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 06:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779Ab2EAEA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 00:00:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab2EAEA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 00:00:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 107E37856;
	Tue,  1 May 2012 00:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fWeP0oPStf+AygZ9uKeOuKpfCMQ=; b=AOzwKJ
	JYdUbi8eaIzvSxLeEe38kvQknvVF7C0RK9/bJPsouZj7LvpvaoWhkDoIz3SDE4sD
	K2RldbG78YyRwWXIg8/DQIxqjLkqDWlUteO3gKin/fRDVRnd58uSgPuFwW4c2owW
	Rgd+6KKNO2DohhRGSs3quvFZRCQbdWxdKylcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rjONjGX8ww99g/O+j3gYTXA0OiXNHqHu
	Wxq+9j4nSKcAqNw0xTF929uEGNY1spcu2xSqfonxHwGUUJ/lJImeZw3s5CC/H/Hr
	6EcNU3ipKYQOkWYV3oZyfUEBLZV1PHmzN4IdQMJR+XhkPx7EVxR5KLAnvp+Mf3Ir
	ndO28CqJ+7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06F6B7855;
	Tue,  1 May 2012 00:00:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A2C37853; Tue,  1 May 2012
 00:00:25 -0400 (EDT)
In-Reply-To: <87vckhuofj.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 30 Apr 2012 19:20:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E807442-9342-11E1-8E16-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196653>

Thomas Rast <trast@student.ethz.ch> writes:

> I seem to have completely missed the earlier series at
>
>   http://thread.gmane.org/gmane.comp.version-control.git/194660
>
> My bad.
>
> Thomas has been working on a prototype converter over the past few days,
> with results similar to (but not quite as good as) your numbers

The "entry-shrinkage" v4 itself is an afternoon hack (even though it is a
good hack), and any design that would not come close to its result is not
worth considering.  It is good to hear that the student is making progress
learning.

> I think there are actually several separate ideas here:
>
> * The prefix compression.  Thomas is not using this idea; we've been
>   toying with making the index bisectable (within each directory) for
>   fast single-entry lookups, which inherently conflicts with this.  The
>   directory-like layout partially achieves the same (elides common path
>   components).
>
> * The varint encoding (or offset encoding, but "varint" is something you
>   can google :-).  David suggested using it on stat() data, combined
>   with zigzag encoding and delta against the first entry in the
>   directory, which gives some good compression results.  Profiling will
>   have to say whether the extra decoding effort is worth the space
>   savings.
>
> * The lack of variable padding, which is a good idea -- in any case I
>   seem to remember Shawn complaining about it.

I am planning to merge this series early to 'master', before the GSoC
student really starts working on the code, perhaps by this Wednesday. The
earlier parts of this series refactor code to make things easier to
modify, and the later parts of it demonstrate by example both:

 (1) how the backward compatibility must be handled at the design level
     [*1*]; and

 (2) how such a design can be coded cleanly at the implementation level.

The hope is that this will give a solidified base to build whatever new
work on top of (perhaps call it v5). I do not mind David's further work
built on top of this series, but I think the entry-shrinkage design for v4
is good enough as-is. I am afraid that letting the code slushy again at
this point may make your student's work unnecessarily more cumbersome.

How do you want to proceed?


[Footnote]

*1* Here are the minimum requirements.

 - you can read both old and new formats (obviously);

 - by default you write out in the same version you read the original;

 - have a single simple command to explicitly specify what format to
   write out; and

 - make sure that the new format is something older readers can
   reliably notice is new and beyond the version they support
