From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Mon, 31 Mar 2014 12:54:46 -0700
Message-ID: <xmqq7g7a5ek9.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
	<1396202583-2572-2-git-send-email-mst@redhat.com>
	<xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
	<20140331192604.GF12208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:55:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUiIO-0004F6-4i
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbaCaTy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbaCaTyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD06977112;
	Mon, 31 Mar 2014 15:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1NhgADWwenewq9AWhphk9rBndKQ=; b=KOKPHo
	U4R9Wi+rSJ42KoZTMkhPHGzS58qTsQY08FonJJNpKMkvawV3NT2mvGikpHNb6ScY
	57av0frKCE7OTFWqEoGwaUiirVrbw4Aa5TM1tvBVQXOXG94stMmu/KODlZP4rt85
	G5Q5rGTav4c9v5+Uy2w5vjXhYsQJvqt4iyOPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y7H0xOmJ/Re92HrAi//z0p6SSE9MbM9M
	c4IbQzLLJ/XpazTbRNqLKuHz/9TwVrucGgVacer1JBi1GdVBsuGSET82nYbyigzQ
	S6dSGictAJ4sxTpZmjuJkj05WsNuedVsgNnQbzU2dSbqchBX7uNYPmwfuYf5gGaH
	OHZJzTdovIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E2A47710F;
	Mon, 31 Mar 2014 15:54:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9AF77710D;
	Mon, 31 Mar 2014 15:54:53 -0400 (EDT)
In-Reply-To: <20140331192604.GF12208@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 31 Mar 2014 22:26:04 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53E91038-B90E-11E3-BF87-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245521>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> The hash used is mostly an internal implementation detail, isn't it?

Yes, but that does not mean we can break people who keep an external
database indexed with the patch-id by changing the default under
them, and "they can give --unstable option to work it around" is a
workaround, not a fix.  Without this change, they did not have to do
anything.

I would imagine that most of these people will be using the plain
vanilla "git show" output without any ordering or hunk splitting
when coming up with such a key.  A possible way forward to allow the
configuration that corresponds to "-O<orderfile>" while not breaking
the existing users could be to make the "patch-id --stable" kick in
automatically (of course, do this only when the user did not give
the "--unstable" command line option to override) when we see the
orderfile configuration in the repository, or when we see that the
incoming patch looks like reordered (e.g. has multiple "diff --git"
header lines that refer to the same path, or the set of files
mentioned by the "diff --git" lines are not in ascending order),
perhaps?
