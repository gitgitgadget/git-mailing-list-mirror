From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 12:06:49 -0700
Message-ID: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	<7vbo91z30e.fsf@alter.siamese.dyndns.org>
	<vpqzjwl9se7.fsf@grenoble-inp.fr>
	<7vppxhxltk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnz0-0005ic-3G
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953Ab3DZTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:06:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757846Ab3DZTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:06:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14971A389;
	Fri, 26 Apr 2013 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L9n7//z7Ad42Wnd+WNFcalefuPQ=; b=tmstgj
	C0XEjjJbo3T5Ep1f0Hdv0CTdwwhbZkh7XKMFvIi3N9CbV+CGl0WxKfH+izYxhSXW
	e1Uc4HE43oyB4Z0LlhNrdf8ZtFFqiD2AwnAZ15mYJItA2EEuLUcZbYH3xpHWBJY5
	r4vzJ72QmaqyVJBKUzNwmXMJstw43EwsObjRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=apNKeu0cOS2FFiW1Xu0UuT9cd8hqGuiD
	bT8plhCAMrcqneQGd5IxY26EBSaXguVA6AZTPfEKaeNIgooQGhmLxdBnEKy4f+Av
	97vo2uniM98izQh06jXfHi93okNPy5F6iwjHu5iN1mFB4hnB52DV/tDeADS0o76J
	iNSclnbYhhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E79881A388;
	Fri, 26 Apr 2013 19:06:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57D521A387;
	Fri, 26 Apr 2013 19:06:51 +0000 (UTC)
In-Reply-To: <7vppxhxltk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Apr 2013 10:07:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73B5E83E-AEA4-11E2-A777-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222557>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> The nice thing with the confirmation dialog is that it shows the list
>> before asking (and unlike 'rm -i', it asks only once).
>
> I wouldn't object to having "clean -i", which automatically defeats
> the requireforce option.
>
> As to a huge single list you have to approve or reject as a whole, I
> am on the fence.  When running "rm -i", I often wished to see
> something like that, but I am fairly sure that I'll call it unusable
> the first time I see a list with a few items I want to keep while
> removing all others.

Elaborating on this a bit more, hoping it would help people who want
to design the "--confirm-before-doing" option...

The primary reason I think the user will find "We are going to
remove these.  OK?" irritating is that most of the time, there are
only a few items that the user would want to keep.

	$ rm --confirm-before-doing -r path
	... list of three dozens of items, among which
        ... there may be two items that should be kept
        Remove all? [Y/n]

After seeing this prompt and saying 'n', the user would _not_ thank
the command for reminding about these precious two items, because
the only next step available to the user is to remove the remaining
34 items manually.

"Confirm in bulk before doing" feature can become useful if it had a
"line item veto" option in the confirmation time.  The interaction
then could go like this:

	$ rm --confirm-before-doing -r path
	path/foo    path/frotz/nitfol    path/sotto
        path/bar    path/frotz/xyzzy     path/trail
        ...            ...               ...     
        Remove (list items you want to keep)? path/frotz

and the user could instruct it to remove everything other than those
inside path/fortz.  If the user do not want to remove anything,
there is an option to ^C out of the command.
