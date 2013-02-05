From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 05 Feb 2013 09:27:31 -0800
Message-ID: <7v8v72u0vw.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 05 18:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2mJK-0005ZO-GM
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab3BER1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 12:27:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018Ab3BER1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 12:27:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25847C6B9;
	Tue,  5 Feb 2013 12:27:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ixv53GxGPadSMXGLb2dSANg9M9U=; b=vAyeQS
	4jtkfYUPSRLeyxW3iEUSKpf5WFWOL9yENdDATFugcPCOGHz7Jy6RGvjUrA6/gCrI
	fZy/f5ZKQYFAMNJMruLOQgpedfc7JV1PneaE3AR+LOF2OMi/2TZqNCmS06Eh9cQ+
	Dkq6z+syeSriiQqE4QEjrxnh5CDw6xK766SuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4Cw8pc4lVo3GTT4LgMtNFh8M1WvioSF
	z0Xk9YJr26p4jnlE5GZMy9sRSdU2/2p62pUVJeYUK6Qe1PZCcy6olIO7toy0u1Ad
	5UNCPVR96Qx8xIodxHpiRjciRl15fCu+1548nPnK4kAJ9TCFkqVjsLOWSygdCdm9
	ZZNgfae5kL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A334C6B8;
	Tue,  5 Feb 2013 12:27:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 426C3C6B6; Tue,  5 Feb 2013
 12:27:33 -0500 (EST)
In-Reply-To: <5110BD18.3080608@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 05 Feb 2013 09:04:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 535D9E1C-6FB9-11E2-A095-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215522>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would again like to express my discomfort about this feature, which is
> already listed as "will merge to next".

Do not take "will merge to next" too literally.  One major purpose
of marking a topic as such is exactly to solicit comments like this
;-)

> * I didn't see a response to Peff's convincing arguments that this
> should be a client-side feature rather than a server-side feature [1].

Uncluttering is not about a choice client should make.  "delayed
advertisement" is an orthogonal issue and requires a larger protocol
update (it needs to make "git fetch" speak first instead of the
current protocol in which "upload-pack" speaks first).

> * I didn't see an answer to Duy's question [2] about what is different
> between the proposed feature and gitnamespaces.

I think Jonathan addressed this already.

> * I didn't see a response to my worries that this feature could be
> abused [3].

You can choose not to advertise allow-tip-sha1-in-want capability; I
do not think it is making things worse than the status quo.

> * Why should a repository have exactly one setting for what refs should
> be hidden?  Wouldn't it make more sense to allow multiple "views" to be
> defined?:

You are welcome to extend to have different views, but how would
your clients express which view they would want?

Giving a single view that the serving end decides gives us an
immediate benefit of showing an uncluttered set of refs of server's
choice, without making the problem space larger than necessary.

> * Is it enough to support only reference exclusion (as opposed to
> exclusion and inclusion rules)?

Again, I do not think you cannot extend it to do positive and
negative filtering "exclude these, but include those even though
they match the 'exclude these' patterns I gave you earlier".

> * Why should this feature only be available remotely?

The whole point is to give the server side a choice to show selected
refs, so that it can use hidden portion for its own use.  These refs
should not be hidden from local operations like "gc".

I appreciate the comments, but I do not think any point you raised
in this message is very much relevant as objections.
