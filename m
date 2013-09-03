From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] sha1-name: pass len argument to interpret_branch_name()
Date: Tue, 03 Sep 2013 11:40:37 -0700
Message-ID: <xmqqioyhsq8q.fsf@gitster.dls.corp.google.com>
References: <1378103670-3394-1-git-send-email-felipe.contreras@gmail.com>
	<1378103670-3394-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 20:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGvX2-0001D2-NV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 20:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760585Ab3ICSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 14:40:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760351Ab3ICSks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 14:40:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12D843EF82;
	Tue,  3 Sep 2013 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7/+8yihBFV16AcEwqIBc6FK6TeU=; b=R8+67W
	mh+2fosOLM9F9fvGUe+vL/pulGfJmU527d/WVNL34AiBX9GbJfgrqB0GHDMFZEl2
	tidOjvNnh8CllI+Q5lJyYc1/yR5kFKB3PO+z+rw+UrTycleDwUllXUxVns/CxuUq
	IvWP9SQCsQojQsDswysKl+bJBZqIYuWektEuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCbQysr8878/uQg53o2ivkhyOEVN6mS3
	ZIfKhZTxZkoai8YELDOQupY32vpURFCpF26cOj48ncosAtYrjVE/9lW7bwo7vfc/
	lD+toUrdk3p9jxT886duPt/+xGMJyXJrTq0Ml4xTUwaRpyf8EekgnzEPdW37p4k4
	RRYt0FZxsFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AFB33EF77;
	Tue,  3 Sep 2013 18:40:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D64D3EF53;
	Tue,  3 Sep 2013 18:40:41 +0000 (UTC)
In-Reply-To: <1378103670-3394-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 2 Sep 2013 01:34:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 563B8F2C-14C8-11E3-8BBD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233757>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is useful to make sure we don't step outside the boundaries of what
> we are interpreting at the moment. For example while interpreting
> foobar@{u}~1, the job of interpret_branch_name() ends right before ~1,
> but there's no way to figure that out inside the function, unless the
> len argument is passed.
>
> So let's do that.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Makes sense to me.  Thanks.

> ---
>  cache.h     |  2 +-
>  refs.c      |  2 +-
>  revision.c  |  2 +-
>  sha1_name.c | 10 ++++++----
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 85b544f..9fbc5fa 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -893,7 +893,7 @@ extern char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, i
>  
>  extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
>  extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
> -extern int interpret_branch_name(const char *str, struct strbuf *);
> +extern int interpret_branch_name(const char *str, int len, struct strbuf *);
>  extern int get_sha1_mb(const char *str, unsigned char *sha1);
>  
>  extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
> diff --git a/refs.c b/refs.c
> index 7922261..8fd5faf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1951,7 +1951,7 @@ static int remove_empty_directories(const char *file)
>  static char *substitute_branch_name(const char **string, int *len)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	int ret = interpret_branch_name(*string, &buf);
> +	int ret = interpret_branch_name(*string, *len, &buf);
>  
>  	if (ret == *len) {
>  		size_t size;
> diff --git a/revision.c b/revision.c
> index 84ccc05..3ef1384 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -200,7 +200,7 @@ static void add_pending_object_with_mode(struct rev_info *revs,
>  		revs->no_walk = 0;
>  	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
>  		struct strbuf buf = STRBUF_INIT;
> -		int len = interpret_branch_name(name, &buf);
> +		int len = interpret_branch_name(name, 0, &buf);
>  		int st;
>  
>  		if (0 < len && name[len] && buf.len)
> diff --git a/sha1_name.c b/sha1_name.c
> index 65ad066..93197b9 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1012,7 +1012,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
>  	int ret;
>  
>  	strbuf_add(buf, name + len, namelen - len);
> -	ret = interpret_branch_name(buf->buf, &tmp);
> +	ret = interpret_branch_name(buf->buf, buf->len, &tmp);
>  	/* that data was not interpreted, remove our cruft */
>  	if (ret < 0) {
>  		strbuf_setlen(buf, used);
> @@ -1046,14 +1046,16 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
>   * If the input was ok but there are not N branch switches in the
>   * reflog, it returns 0.
>   */
> -int interpret_branch_name(const char *name, struct strbuf *buf)
> +int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
>  {
>  	char *cp;
>  	struct branch *upstream;
> -	int namelen = strlen(name);
>  	int len = interpret_nth_prior_checkout(name, buf);
>  	int tmp_len;
>  
> +	if (!namelen)
> +		namelen = strlen(name);
> +
>  	if (!len) {
>  		return len; /* syntax Ok, not enough switches */
>  	} else if (len > 0) {
> @@ -1100,7 +1102,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>  int strbuf_branchname(struct strbuf *sb, const char *name)
>  {
>  	int len = strlen(name);
> -	int used = interpret_branch_name(name, sb);
> +	int used = interpret_branch_name(name, len, sb);
>  
>  	if (used == len)
>  		return 0;
