From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Wed, 08 Jan 2014 15:42:09 -0800
Message-ID: <xmqqeh4iavn2.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 09 00:42:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W12lR-0000K4-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 00:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbaAHXmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 18:42:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757831AbaAHXmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 18:42:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58EB2624A9;
	Wed,  8 Jan 2014 18:42:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5xVsmw9oOl5vJuQD6g+C5f81YQ=; b=Q2f6Au
	PHgJigbTa5StEulLsKSxUMI3o8oETuxqn4ssYtpLIQuTeRrXXfAMQ1X7twAdNGGO
	duH4w0SXzpMFiRhejgdQCsGkdlxMJCzCHvJHp7N27vnZ/D1h/NL8clJtevERPGbV
	mZ6I+oFga3M/TpfSeyHsxE3kTh7/hMZZF4QMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2y83Aay/5FPLAup91ZjNppH+jwvoVD3
	TNeFefCa7uugCYw/7SU1FdRKGVrKJfUm5WF9lwaxKFRd704dIeLTTcbrFro/TW64
	EUkcvOa+CO6pEETOUgecEH2WogbRJ0gtURxtkQXHC81kKrxxMYuxosLkn+YbJnxF
	/kCF2nXhvaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47EAC624A8;
	Wed,  8 Jan 2014 18:42:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C7D8624A5;
	Wed,  8 Jan 2014 18:42:12 -0500 (EST)
In-Reply-To: <20140108093716.GE15720@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jan 2014 04:37:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F3E92E8-78BE-11E3-9344-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240230>

Jeff King <peff@peff.net> writes:

> In a triangular workflow, you may have a distinct
> @{upstream} that you pull changes from, but publish by
> default (if you typed "git push") to a different remote (or
> a different branch on the remote). It may sometimes be
> useful to be able to quickly refer to that publishing point
> (e.g., to see which changes you have that have not yet been
> published).
>
> This patch introduces the <branch>@{publish} shorthand (or
> "@{pu}" to be even shorter). It refers to the tracking

If @{u} can already be used for upstream, why not allow @{p} but
require two letters @{pu}?  Just being curious---I am not advocating
strongly for a shorter short-hand.

Or is @{p} already taken by something and my memory is not
functioning well?

> branch of the remote branch to which you would push if you
> were to push the named branch. That's a mouthful to explain,
> so here's an example:
>
>   $ git checkout -b foo origin/master
>   $ git config remote.pushdefault github
>   $ git push
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The implementation feels weird, like the "where do we push to" code
> should be factored out from somewhere else. I think what we're doing
> here is not _wrong_, but I don't like repeating what "git push" is doing
> elsewhere. And I just punt on "simple" as a result. :)
>
>  sha1_name.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 50df5d4..59ffa93 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -435,6 +435,12 @@ static inline int upstream_mark(const char *string, int len)
>  	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
>  }
>  
> +static inline int publish_mark(const char *string, int len)
> +{
> +	const char *suffix[] = { "@{publish}" };
> +	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
> +}
> +
>  static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
>  static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
>  
> @@ -481,7 +487,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  					nth_prior = 1;
>  					continue;
>  				}
> -				if (!upstream_mark(str + at, len - at)) {
> +				if (!upstream_mark(str + at, len - at) &&
> +				    !publish_mark(str + at, len - at)) {
>  					reflog_len = (len-1) - (at+2);
>  					len = at;
>  				}
> @@ -1100,6 +1107,69 @@ static int interpret_upstream_mark(const char *name, int namelen,
>  	return len + at;
>  }
>  
> +static const char *get_publish_branch(const char *name_buf, int len)
> +{
> +	char *name = xstrndup(name_buf, len);
> +	struct branch *b = branch_get(*name ? name : NULL);
> +	struct remote *remote = b->pushremote;
> +	const char *dst;
> +	const char *track;
> +
> +	free(name);
> +
> +	if (!remote)
> +		die(_("branch '%s' has no remote for pushing"), b->name);
> +
> +	/* Figure out what we would call it on the remote side... */
> +	if (remote->push_refspec_nr)
> +		dst = apply_refspecs(remote->push, remote->push_refspec_nr,
> +				     b->refname);
> +	else
> +		dst = b->refname;
> +	if (!dst)
> +		die(_("unable to figure out how '%s' would be pushed"),
> +		    b->name);
> +
> +	/* ...and then figure out what we would call that remote here */
> +	track = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, dst);
> +	if (!track)
> +		die(_("%s@{publish} has no tracking branch for '%s'"),
> +		    b->name, dst);
> +
> +	return track;
> +}
> +
> +static int interpret_publish_mark(const char *name, int namelen,
> +				  int at, struct strbuf *buf)
> +{
> +	int len;
> +
> +	len = publish_mark(name + at, namelen - at);
> +	if (!len)
> +		return -1;
> +
> +	switch (push_default) {
> +	case PUSH_DEFAULT_NOTHING:
> +		die(_("cannot use @{publish} with push.default of 'nothing'"));
> +
> +	case PUSH_DEFAULT_UNSPECIFIED:
> +	case PUSH_DEFAULT_MATCHING:
> +	case PUSH_DEFAULT_CURRENT:
> +		set_shortened_ref(buf, get_publish_branch(name, at));
> +		break;
> +
> +	case PUSH_DEFAULT_UPSTREAM:
> +		set_shortened_ref(buf, get_upstream_branch(name, at));
> +		break;
> +
> +	case PUSH_DEFAULT_SIMPLE:
> +		/* ??? */
> +		die("@{publish} with simple unimplemented");
> +	}
> +
> +	return at + len;
> +}
> +
>  /*
>   * This reads short-hand syntax that not only evaluates to a commit
>   * object name, but also can act as if the end user spelled the name
> @@ -1150,6 +1220,10 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
>  	if (len > 0)
>  		return len;
>  
> +	len = interpret_publish_mark(name, namelen, cp - name, buf);
> +	if (len > 0)
> +		return len;
> +
>  	return -1;
>  }
