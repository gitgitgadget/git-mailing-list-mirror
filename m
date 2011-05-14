From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #06; Fri, 13)
Date: Sat, 14 May 2011 10:37:55 -0700
Message-ID: <7vsjsh5gjw.fsf@alter.siamese.dyndns.org>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
 <BANLkTimHdZ_9PUg509Yb7g2Oyp3qk0cKdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 19:38:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLIn4-0007hS-LJ
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab1ENRiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 13:38:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab1ENRiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 13:38:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3675A57D2;
	Sat, 14 May 2011 13:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bOiEZBrpWxodG4XNAT+2jfKQ4OY=; b=dpYZAb
	AQfGKjXGdzb2pBaI9hD5OQeSFTZeeB0y80BrAn218F8k2kgpQwqAvHz++eouQQ4U
	2Adabw4ak54IbhIJM8YvndFdt1u76W1h97rXvwgBLo9Bdogsw0LBCeakm/72rY3w
	YpEKXUQOy0QkZLqxbdxROH4Rdz3reqyC04TJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R5Al6iFK/EsmAAXcxwWTj8DbILxNtWkF
	YJ7n8w52TB/AUP18lWuN3Rj6a0d9C+lQSSsZXgMhpbmOLFzOLSa7/UmqJ4qg3HuF
	0Fzyk7rn3I9MP3iiRxixX2BhUKz3G+prjilZUW48CLwQLRzeEGrMlg/A/9xYsMcl
	kOSE5tZkI94=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14EF057D1;
	Sat, 14 May 2011 13:40:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B8DA57D0; Sat, 14 May 2011
 13:40:03 -0400 (EDT)
In-Reply-To: <BANLkTimHdZ_9PUg509Yb7g2Oyp3qk0cKdA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 14 May 2011 10:03:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3522844A-7E51-11E0-B50C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173596>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> The counterpart to jc/bigfile to cover the write-out codepath. This does
>> not yet have "read directly from pack or loose object without slurping the
>> whole thing in memory" yet, which is still work in progress.
>
> You haven't sent this to git@vger, or it failed to deliver to me.

That is because it is still in flux and not ready for public viewing yet.

> Anyway, do you plan to extend sha1_object_info_extended() further...

By definition a topic that is still in flux does not have concrete plans
for everything. I haven't gone far enough to be interested in adding a
support for something the other parts of the system do not support.

It is a lot more important to support the data types and representations
that are supported by the other parts of the system already, and fill the
missing parts. "git add" will learn to handle huge blobs natively in the
jc/bigfile topic. This topic is about handling huge blobs in the checkout
codepath. Without it, the system is useless if you cannot check them out
even if you can add them.

The sending side of "git push" (aka "send-pack") and "git fetch" (aka
"upload-pack") should also be Ok because pack-objects has known to handle
large blob in a pack by copying the bits straight without re-deltifying.

I however think the receiving end still wants to hold everything in core.
It would be the natural next thing to fix around this area before doing
anything else. If somebody is interested, look at the receiving end
("index-pack" and "unpack-objects") while I am still busy in this topic.

Multiple people working on separate independent areas who share a
reasonably narrow common agenda tend to speed up the development.  At the
very end of Linus era of git, after he wrote pack-objects, he worked on
the object transfer protocols and unpack-objects, and I took the local use
of the data in packed objects in read_sha1_file() codepath. There weren't
much overlap or conflicting design decision in our works, and it turned
out great. The common agenda in this case was to make the new object
representation (i.e. packs) useful throughout the system.

On the other hand, multiple people working in a similar area with
different agenda tend to step on each other's toes.
