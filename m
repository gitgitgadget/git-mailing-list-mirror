From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 08/16] remote-svn, vcs-svn: Enable fetching to private
 refs
Date: Tue, 28 Aug 2012 10:53:06 -0700
Message-ID: <7vvcg228tr.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:03:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q8K-0003pV-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab2H1SDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:03:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2H1SC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:02:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77F629228;
	Tue, 28 Aug 2012 14:02:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=FFrTOiKSZfmVkw8gSWffu5QwJzQ=; b=ZDpeJfctDrXBdhTd7fII
	2ErLsm1fMs6q6aXQz9vJUO0c1KP1FSHCOk3YeVLAcuvvXmC8UA26soNlUbLapUAW
	JfFNaUcVgPwLC4rqUst6QYcbBrFb7Hac3GwZwIKW74uIqHbuVPYV+DY/q8vEjW8J
	EiHToprxdHsZNhUX4SOIZR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BNq64NQm/CaFEvNWtIm9LuJKQaoVM6Sxky7eQldVH8xDIX
	6vXzQ/AmhoD/Rh7oEYvqYuQNQruAd6+Z32kZG3vyIkm22ZMnJ7En96oDGVV7kHrn
	i1mE9/r+8jj0YeJVgGhZ/5vBxQmX8CHzWqW4jdST8XF/aKQ3C5cgOcmVH6Z0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64C629227;
	Tue, 28 Aug 2012 14:02:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B93869223; Tue, 28 Aug 2012
 14:02:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 992AD9C6-F13A-11E1-B279-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204443>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> The reference to update by the fast-import stream is hard-coded.  When
> fetching from a remote the remote-helper shall update refs in a
> private namespace, i.e. a private subdir of refs/.  This namespace is
> defined by the 'refspec' capability, that the remote-helper advertises
> as a reply to the 'capabilities' command.
>
> Extend svndump and fast-export to allow passing the target ref.
> Update svn-fe to be compatible.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> ...
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index d81a078..288bb42 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -299,22 +299,22 @@ static void handle_node(void)
>  				node_ctx.text_length, &input);
>  }
>  
> -static void begin_revision(void)
> +static void begin_revision(const char *remote_ref)
>  {
>  	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
>  		return;
>  	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
>  		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
> -		rev_ctx.timestamp);
> +		rev_ctx.timestamp, remote_ref);
>  }
>  
> -static void end_revision(void)
> +static void end_revision()

Don't.

>  {
>  	if (rev_ctx.revision)
>  		fast_export_end_commit(rev_ctx.revision);
>  }
