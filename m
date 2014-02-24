From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Mon, 24 Feb 2014 08:57:23 -0800
Message-ID: <xmqqtxbobg98.fsf@gitster.dls.corp.google.com>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
	<BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de>
	<xmqqsird6137.fsf@gitster.dls.corp.google.com>
	<FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de>
	<xmqqr46w4a24.fsf@gitster.dls.corp.google.com>
	<8732A8C8-145E-47F5-BD9A-ECD6E9DE07EF@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:57:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyqV-00065G-8z
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbaBXQ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:57:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbaBXQ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:57:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF6A6C3BE;
	Mon, 24 Feb 2014 11:57:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ezAwm4qPEXxKaHrbDU6cksQVcGk=; b=R6LoDm
	94I3xoQ5QFErGsK178YA1Yjxu00v2o6mmQbNOQYb/TQrYVLWEgAtqCjJzrZ6fkYQ
	mMZR74qkHKdEfIaRgRvz2OzOjhl40m4CSGey3XNksH0S22w5VDa00fD6TDx9yfch
	Y23uEX76mOdNlJtTyqNoN78wsAW8IO7WAL3fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CEPbYWl3zYp/Wn7vt7Ue/evt5/TXfJYZ
	W/+i9TSJvyI8RVANJpLBKddpBp8eXPzaBOSQ01AvoKVXY/XgDRRxOznrktMKnZxL
	sk553erGBtTL+tKdXI/ImhOXfGQlfxiErGcIEQiHpmr95Hvcr4x/z8o4nAM4noR9
	PaqHSuZls90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD406C3BD;
	Mon, 24 Feb 2014 11:57:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68AD36C3BA;
	Mon, 24 Feb 2014 11:57:25 -0500 (EST)
In-Reply-To: <8732A8C8-145E-47F5-BD9A-ECD6E9DE07EF@quendi.de> (Max Horn's
	message of "Sat, 22 Feb 2014 01:55:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC6EC504-9D74-11E3-87F5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242612>

Max Horn <max@quendi.de> writes:

> On 21.02.2014, at 19:04, Junio C Hamano <gitster@pobox.com> wrote:
>
>>  Isn't it possible for some helpers to _do_ want to
>> tell us that it did not have to force after all by _not_ saying
>> "forced update" and overwrite ->forced_update with zero?
>
> Yes to the first part, no to the last bit: Yes, a transport helper
> can (and frequently does) tell us that no force happened -- by not
> saying "forced update".
> ...
>>  How do we tell helpers that do want to do so apart from other
>> helpers that say "forced update" only when they noticed they are
>> indeed forcing?
>
> I am not completely sure I even understand that bit?

I think I phrased it too imprecisely.

If nobody even knew about the "forced update" before hg helper, then
they by definition do not wish to overwrite, of course.  But I was
worried if we are closing the door for this possible scenario:

 * the calling side sets ref->forced_update to true before invoking
   the helper, knowing that this update is not fast-forward; and

 * the helper does a "magic" (after all, we are talking with an
   external mechanism, which may be a different SCM like darcs) to
   rebase our change on top of the history that the other side
   already have, and makes it a fast-forward, non-forced push.

Such a helper would want a way to say "You may have thought that
this does not fast-forward, but the push result ended up to be a
fast-forward update", and if we wanted to support that, one thing we
may need to allow it to do is to reset ref->forced_update to zero.

But I think I was worried too much into the future---I agree that
the code can stay as you proposed until such a remote-helper needs
more support, because "overwrite with zero" is necessary but is
probably not sufficient---it also may need to be able to tell us
what the final resulting commit of the push is, for example.
