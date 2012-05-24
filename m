From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 13:07:03 -0700
Message-ID: <7vtxz5wdg8.fsf@alter.siamese.dyndns.org>
References: <4FBE2335.2090903@jpk.com>
 <20120524171640.GB3161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <haggerty@jpk.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeJa-0005Cb-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934183Ab2EXUHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:07:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757397Ab2EXUHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:07:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D721787AE;
	Thu, 24 May 2012 16:07:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z+4CAQo3trU/5G3D8LA3qAPeb2o=; b=jXoiRj
	6tQSLTeHyD/EEHksS040mo/5Cwe/41FvoLxvQ1FQQbaz0vyb6+CwTpqkSuWuMwA/
	xhnHe2bpoQ0xajhPfkNFg1haLh2LcV8tDHPJigvTEXjenHSuRhMs7Snb1KtqBynn
	HMIIi0zxWvy3yXUcMoZ76+Kcc6UAkSWvP0zpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YNeZvQt/BZfWb4WIixaF+FJ1q686o2gw
	yusbwcjoniK2cHe6A2afbh1dCNMkU3e3+IweX9z0EMbquK8YhDCw9xCJFa+ssMqI
	XuWDx6tuDumYYMr1j/GVKrxv0paoNvYqhRZmwHheLYDlpdLPkWyhn6cgGwifu0iV
	ND4CoUn3y3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEE1887AD;
	Thu, 24 May 2012 16:07:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32E7387AC; Thu, 24 May 2012
 16:07:05 -0400 (EDT)
In-Reply-To: <20120524171640.GB3161@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 May 2012 13:16:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0885B1CE-A5DC-11E1-81FD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198413>

Jeff King <peff@peff.net> writes:

> On Thu, May 24, 2012 at 02:01:57PM +0200, Michael Haggerty wrote:
>
>> On my setup, the above commit causes 12 tests in t4014 to fail.  For
>> example, test 25:
>> 
>> >-Message-Id: <0>
>> >+Message-Id: <1135adfeed86678c55e1aad7c568046ee8215660.1337860646.git.mhagger@michael.(none)>
>
> Thanks for the report. I know exactly what the issue is, as it came up
> in the discussion of the original series. 43ae9f47ab stopped using
> git_committer_info (which looks at $GIT_COMMITTER_EMAIL) for the end of
> the message-id and started using the default-generated email directly.
>
> Nobody should care, because either:
>
>   1. The defaults set up a reasonable hostname for your machine.
>
>   2. They do not, but you adjust it by setting user.email. Otherwise,
>      your author ident would have this bogus email in it.
>
> The only setup that _would_ care is if the generated default is bogus
> and you set $GIT_COMMITTER_EMAIL in the environment and relied on that
> to get a sane value. Which is exactly what the test environment does.

Or they worked to create their series in a good machine, pull it down to
another machine during their lunch break, and run format-patch to send it
out after the final eyeballing.  Perhaps they are not supposed to be
working on the project in question during the day at work, so the work
machine does not have user.email set up correctly yet.

> The question is, is what it is doing sane and something we should care
> about? Or is the test broken (it fails to parse the message-id that
> contains ".(none)", but I am not even sure that is intentional and not
> simply lazy regex writing in the test).

I doubt that it was carefully written to try to exclude ".(none)".

It somewhat curious---it seems to want to grab everything after "<" up to
the first occurrence of ">"---why isn't this pattern matching?

> This is unlikely to match anybody's real-life setup, but we do use it in
> the test environment. And furthermore, it's what we have always done,
> and the change in 43ae9f4 was about cleaning up, not fixing any bug; we
> should be conservative and keep the behavior identical.

I agree with the last sentence. I wouldn't be surprised if somebody was
indexing patch e-mails on the list, keyed with their Message-Id: field,
and using the key as something more than just a random "uniqueness" token.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Note that we check the environment outside of the usual strbuf_trim that
> happens to the default email. And outside of fmt_ident, which trims
> whitespace, as well. So compared to the state before this series,
> something like:
>
>   GIT_COMMITTER_EMAIL="$(printf 'foo@bar\n')" git format-patch ...
>
> is now broken.

True, and setting GIT_COMMITTER_EMAIL to that value will not break other
uses because they trim.  But as we discussed before, we do not strongly
stop users from deliberately adding unnecessary whitespaces around names
and e-mails that they themselves configure (i.e. user.email and these
environment variables), so it probably is not a huge deal.

> It also strikes me as a little ugly that this code path
> needs to care about $GIT_COMMITTER_EMAIL at all.

Do you mean "why committer and not author"?  It primarily is because we
want to see "who is this person who wants a unique token tied to his
identity" and author and committer ident are both equally reasonable
choices.  But we have picked to use committer in these cases long time
ago.

If you mean "why environment and not an API call?", then I would have to
agree.  ident_committer_email() call, that returns a sanitized version,
would have been a natural way to write this, if it were available.

> I can rework the ident interface to provide a more sanitized broken-down
> version of the ident if we care.

That is a healthy thing to do in the longer term, I would guess.

>  builtin/log.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8010a40..3f1883c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -739,8 +739,11 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
>  static void gen_message_id(struct rev_info *info, char *base)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> +	const char *email = getenv("GIT_COMMITTER_EMAIL");
> +	if (!email)
> +		email = ident_default_email();
>  	strbuf_addf(&buf, "%s.%lu.git.%s", base,
> -		    (unsigned long) time(NULL), ident_default_email());
> +		    (unsigned long) time(NULL), email);
>  	info->message_id = strbuf_detach(&buf, NULL);
>  }
