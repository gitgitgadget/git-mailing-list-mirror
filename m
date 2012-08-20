From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/16] remote-svn: add marks-file regeneration
Date: Mon, 20 Aug 2012 16:20:27 -0700
Message-ID: <7va9xpgngk.fsf@alter.siamese.dyndns.org>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7vehn1gocn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 01:21:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3bHR-0002EA-2B
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 01:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab2HTXUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 19:20:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab2HTXU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 19:20:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6061597F0;
	Mon, 20 Aug 2012 19:20:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GcfStVWHrXTPQK9Ea8+4gfOWAGQ=; b=oCPfQy
	NNM9oET6V7Y2rozqId6cBwsXE20ED1QB5ygtIuyCKsditGc1c6EY/ZE8HhTLGG8l
	wOQ2RK7ncqpN7iR7znxA+xYhwhz0CSxwQADrNmFzR45xeiHTBUgjdfTVrb/tBR1Z
	IJ8uDJ+/6aUluAOEe/vk2vnSj+C6+S6vWmv4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mDii0FubNHf6HmYQz3jsbYpih/L/ak+9
	Kkx1/YUfjy0VqQ/RMZ8okrPPZsa0Rh1H845BYpb5awgXAwpHn7hlvUO9HfOii7pK
	GO4fR4CvLlRDVOPV0Sn7iIBFjHMyLvSKDOWrYcmvw9D6NThAnMbKoDGFh1ipzPCz
	xveZLtyOhCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C68397EE;
	Mon, 20 Aug 2012 19:20:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A71F797ED; Mon, 20 Aug 2012
 19:20:28 -0400 (EDT)
In-Reply-To: <7vehn1gocn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 20 Aug 2012 16:01:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1154342-EB1D-11E1-A281-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203909>

Junio C Hamano <gitster@pobox.com> writes:

> I think you meant something like:
>
> 	init_notes(NULL, notes_ref, NULL, 0);
>         marksfile = fopen(marksfilename, "r");
>         if (!marksfile) {
>         	regenerate_marks(marksfilename);
>                 marksfile = fopen(marksfilename, "r");
>                 if (!marksfile)
> 	                die("cannot read marks file!");
> 	} else {
>         	...
>
> Also there is another call to regenerate_marks() without any
> argument.  Has this even been compile-tested?

I've made regenerate_marks() to take (void) parameter list, as
marksfilename is a file scope static and visible to everybody, and
applied something like the above and queued the result in 'pu'.
