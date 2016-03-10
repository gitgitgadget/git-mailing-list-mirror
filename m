From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3] add a commit.verbose config variable
Date: Thu, 10 Mar 2016 13:34:24 -0800
Message-ID: <xmqq7fhadnkv.fsf@gitster.mtv.corp.google.com>
References: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:34:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8E4-0007KB-Bm
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbcCJVe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:34:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932180AbcCJVe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:34:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 174F449A62;
	Thu, 10 Mar 2016 16:34:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zJMwj9IH7tENYQy+Vv6RYZe/ZQk=; b=ZzFdFt
	ZnoJORY9uXq3MTqido9spqDInSplgZBxarGVWKEslIMq6q5CRjeGYvQh4g0rNBrJ
	WAhE9VCXMgAEIDDjWoiVxKEr/ZypgWgZE56l6rmEtMyRvxD8ENQnHifl8LoIU+/l
	h3ICwhkX+TVRAjvX7OqSlGxde44xiFQMZAA+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bje261sOPoi1r4NLdFtIksV89TmJz1yO
	uEgziqU43Zpb450uE8sv87QxQ08IjTfzyFH+JxYc0ZTPtEk4nHkCbiZ2HjPrbZeF
	gKIMqMfh33U4xhifrHy9HYrdG+vj3g6sFPhPDihtnif2jmtNB/0hc4hEdkf57gE5
	4Pl9Pt4GODI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D3D749A61;
	Thu, 10 Mar 2016 16:34:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8618849A5E;
	Thu, 10 Mar 2016 16:34:25 -0500 (EST)
In-Reply-To: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Thu, 10 Mar 2016 18:58:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC8C65C4-E707-11E5-BA1A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288644>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index b3bd2d4..63ee0f2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1310,6 +1310,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  			return error(_("Invalid untracked files mode '%s'"), v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.verbose")) {
> +		verbose = git_config_bool(k, v);
> +		return 0;
> +	}
>  	return git_diff_ui_config(k, v, NULL);
>  }

Checking the code flow in cmd_commit(), we first do the config, and
then later call parse_options(), so it is clear that giving the
initial value of 0 or 1 depending on the boolean setting would be
all that is necessary to support "--no-verbose", which makes the
patch very compact.  Good.

But doesn't this belong to git_commit_config(), not
git_STATUS_config()?  Should "commit.verbose" make output from "git
status" verbose?
