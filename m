From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: shorten "push.default is unset" warning message
Date: Tue, 23 Feb 2016 11:05:08 -0800
Message-ID: <xmqqtwkz1c4b.fsf@gitster.mtv.corp.google.com>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:05:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYIGy-0000I7-0H
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbcBWTFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:05:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754264AbcBWTFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:05:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE7CE44A8D;
	Tue, 23 Feb 2016 14:05:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nKa3DXATQnGc4T0U67HwVUE8IVo=; b=kq0oeh
	nrtFGtXW75jHvvyvEsPd6fdXPgGZYc3P4LIioLJm84g3PYkkZZMgDH4+tYdYkJXc
	lLMoNv8YydDuo59FSwci9K5wpwy7z8KrApyjT+NvD/hTCr61YrHrkdEh8Dvl0wI4
	RQigN7zQlCqdsaCYyC+jiS91hZQxg6U2jFS6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nx2Ztl3tGAP7wzwk+w0fKVemxH30xJ+0
	QOc8wJM3ib8Tt0tPsynoUV/sUthhDe+MG+NAYO8vUM0PGgbSvbkwvUjZKWJCuypm
	X9qK5KB009vow8HsQNt96AWmIe7dg5exa7Uzuw0/WfWZ0MIm0cS8gDPw040MWF8M
	Nj9au7DbORU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5D5A44A8C;
	Tue, 23 Feb 2016 14:05:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50C2A44A8A;
	Tue, 23 Feb 2016 14:05:10 -0500 (EST)
In-Reply-To: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
	(Matthieu Moy's message of "Tue, 23 Feb 2016 14:59:04 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C362148-DA60-11E5-A216-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287100>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The warning is mostly seen by beginners, who have not set their
> push.default configuration (yet). For many of them, the warning is
> confusing because it talks about concepts that they have not learned and
> asks them a choice that they are not able to make yet. See for example
>
>   http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0
>
> (1260 votes for the question, 1824 for the answer as of writing)

The punchline of that question is:

    I can obviously set it to one of the values mentioned, but what do
    they mean? What's the difference between simple and matching?

It tells us that "See 'git help config'" is not such an effective
message to help such a user.

> Shorten the warning and mention only the way to remove the warning
> without changing the behavior. Keep a pointer to the documentation so
> that people willing to learn can still find the alternative behaviors
> easily.

While I admit that I usually am the most cautious one when dealing
with any change, I am not sure if this rephrasing helps very much.
As we saw, the sentence you kept, "See 'git help config'", is not
effective in helping those stackoverflow users.  Removal of the
other parts of the message the patch does does make sense, as we
know these users do not read, so they are merely noisy black pixels
on the screen.

If most people are happy with "simple" (and certainly that was the
assumption and hope behind the transtion we made at 2.0), we may be
better off removing the warning altogether.  Keeping "and adopt the
new behaviour" part pretends to be offering a chance to make an
informed choice, but it will forever be unclear to the non-reader
what the implication of not adopting the new behaviour is anyway, so
overall we won't see reduced hits at stackoverflow with this change.

After all, push.default configuration is hardly the only case where
there are other ways to use Git that may match the user's situation
better, and we do not advertise "Oh by the way you can do things
differently, study the manual" for any of them with a warning
message like this.  Those who want to do different things know to
seek settings to tweak.

The above analysis considers _only_ those who go to stackoverflow.
For those who do read, perhaps "See 'git config help'" may have some
value, but again, many aspects of the system can be tweaked, and we
do not advertise that everywhere, so...

> Eventually, the warning should be removed completely, but this can wait
> a couple more releases or years.

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/push.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 960ffc3..00eba2f 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -205,26 +205,12 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>  }
>  
>  static char warn_unspecified_push_default_msg[] =
> -N_("push.default is unset; its implicit value has changed in\n"
> -   "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
> -   "and maintain the traditional behavior, use:\n"
> -   "\n"
> -   "  git config --global push.default matching\n"
> -   "\n"
> -   "To squelch this message and adopt the new behavior now, use:\n"
> +N_("push.default is unset; its default value has changed in Git 2.0 from\n"
> +   "'matching' to 'simple'. To squelch this message and adopt the new behavior, use:\n"
>     "\n"
>     "  git config --global push.default simple\n"
>     "\n"
> -   "When push.default is set to 'matching', git will push local branches\n"
> -   "to the remote branches that already exist with the same name.\n"
> -   "\n"
> -   "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
> -   "behavior, which only pushes the current branch to the corresponding\n"
> -   "remote branch that 'git pull' uses to update the current branch.\n"
> -   "\n"
> -   "See 'git help config' and search for 'push.default' for further information.\n"
> -   "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
> -   "'current' instead of 'simple' if you sometimes use older versions of Git)");
> +   "See 'git help config' and search for 'push.default' for further information.");
>  
>  static void warn_unspecified_push_default_configuration(void)
>  {
>
> --
> https://github.com/git/git/pull/201
