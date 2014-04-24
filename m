From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/9] patch-id: document new behaviour
Date: Thu, 24 Apr 2014 15:12:14 -0700
Message-ID: <xmqqzjjatm0x.fsf@gitster.dls.corp.google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
	<1398331809-11309-5-git-send-email-mst@redhat.com>
	<20140424173325.GK15516@google.com> <20140424212639.GA9129@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com, peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:12:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRsk-00021G-CH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbaDXWMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:12:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758229AbaDXWMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:12:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38C6380754;
	Thu, 24 Apr 2014 18:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BS3jZ8n+Co09Mw7QSFA3/6msZOE=; b=yZ4Qrx
	SEPJbpQmgGptS8/09AHEDU8/HIN+tQlx6TA8DR5S7R2J4QuqaPvZcrfTDdrH5Wu5
	oe+kUC1Y3chdR8FvCtAx/A9tZAGAgNqseji/PAcm2ZZSn248CIr30H4rwzCCoh2/
	jGOgpyY8Fn9v5A4KhHGoU7q2f9tvjUVboKqNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xo2BpFOYVKBboFjQJgiS0ZEiGP5GhoJj
	7OI3k6VqMdlwhcfGRL1lR4OCjWbWgZlXGfbCqX3er+/xvEIuVibiwptuq3PdrJsS
	YG4myIw+Nx3DbvypBNn2leta4ALTVFvxErYZ0KR+3JOq2tCjty9Ljd4aeDBPS6e+
	LeuFvM2uLLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B53A80753;
	Thu, 24 Apr 2014 18:12:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0319180750;
	Thu, 24 Apr 2014 18:12:16 -0400 (EDT)
In-Reply-To: <20140424212639.GA9129@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 25 Apr 2014 00:26:39 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E813C4C-CBFD-11E3-8F07-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247015>

"Michael S. Tsirkin" <mst@redhat.com> writes:

>> > +--unstable::
>> > +	Use a non-symmetrical sum of hashes, such that reordering
>> 
>> What is a non-symmetrical sum?
>
> Non-symmetrical combination function is better?

I do not think either is very good X-<.

The primary points to convey for "--stable" are:

 - Two patches produced by comparing the same two trees with two
   different settings for "-O<orderfile>" will result in the same
   patchc signature, thereby allowing the computed result to be used
   as a key to index some metainformation about the change between
   the two trees;

 - It will produce a result different from the plain vanilla
   patch-id has always produced even when used on a diff output
   taken without any use of "-O<orderfile>", thereby making existing
   databases keyed by patch-ids unusable.

The fact that we happened to use a patch-id that catches that
somebody reordered the same patch into different file order and
declares that they are two different changes is a more historical
accident than a designed goal.

I would even say that we would have used the "stable" version from
the beginning if we thought that "-O<orderfile>" would be widely
used when these two features both appeared.  Even though I was the
guilty one who introduced it, I'd admit that "-O<orderfile>" has
merely been a curiosity from its inception and has been a failed
experiment, not in the sense that the feature does not work as
adverertised (it does), but in the sense that it is not widely used
(evidenced by the lack of complaints on missing diff.orderfile for a
long time) at all.  With "-O<orderfile>" being a failed experiment,
the "unstability" did not matter, so it has stuck.

The only two things worth mentioning about "--unstable", if our
future direction is to see diff.orderfile and "--stable" a lot more
widely used, are:

 (1) it keeps producing the same patch-id as existing versions of
     Git, so users with existing databases (who do not deal with
     reordered patches) may want to use it; and perhaps

 (2) it will not consider a patch taken with "-O<orderfile>" and
     another without it from the same source the same patches.

Mathmatically speaking, mentioning "non-symmetrial" might be one way
of expressing the latter point (2), but stressing on that alone
without mentioning (1) misses the point.  (2) is _not_ a designed
feature, so it is not very interesting.  Unless you have an existing
database, there is no reason to use "--unstable".

On the other hand (1) is a very relevant thing to mention, as we are
talking about a feature that, if unused, may break existing users'
data.
