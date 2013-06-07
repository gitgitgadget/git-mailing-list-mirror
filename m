From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or upstream
Date: Fri, 07 Jun 2013 11:34:20 -0700
Message-ID: <7vhah9u5w3.fsf@alter.siamese.dyndns.org>
References: <20130607124146.GF28668@sociomantic.com>
	<CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
	<7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
	<CALkWK0m0QDGVUmHkmzC7G6it9fJafQCh8+423-NOyMwq9yts1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leandro Lucarella <leandro.lucarella@sociomantic.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:34:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1UZ-0000C1-Ki
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab3FGSeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:34:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756364Ab3FGSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6576B269C7;
	Fri,  7 Jun 2013 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TmzJ5neRbVidIp+5tAGbCdE8qxI=; b=IqZIpO
	OtbqSUzmKom5AVuLY2q4owBBBgH030plv7jMKT5mp9iEF9IUz0yQdjtVwBVrcaPL
	+LkkAu92X2Vp5/NOANsmh1IvivvoRIbolt4sQU8Dhn9cZl9aIOf8pZupANOn2QcJ
	3sEZjADFXi43AfZktayus3UUzznVxozMqNyPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OsbUEF5qXUxYJLqFlGa5ko9H4kXw9TWy
	rxz7S8VmzWexG9mOxyaOXadrhRS4dH3nhoqVj2iTdmCElOUUDTGM4T22nXp7gd8i
	mAxhHCbEE5VdnG2w3HxPDtRNB8gNpdA4gvqBEtJBYssHThdyxfaWW58/F/eVOYzA
	HIZzsmH1yHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA41269C6;
	Fri,  7 Jun 2013 18:34:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1594269C5;
	Fri,  7 Jun 2013 18:34:21 +0000 (UTC)
In-Reply-To: <CALkWK0m0QDGVUmHkmzC7G6it9fJafQCh8+423-NOyMwq9yts1Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 22:21:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEFCD81A-CFA0-11E2-B468-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226663>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> This shows the "triangular" support in 1.8.3 is only half-finished;
>> the other half was discussed a few weeks ago ($gmane/224604)
>
> I intentionally omitted that detail, because it is not directly
> related to this bug.  We have to fix the existing simple and upstream,
> whether or not we introduce branch.<name>.push.  I've personally
> stopped working on branch.<name>.push, and am focusing on getting @{p}
> first (you've already seen a dirty wip).  The transport code
> underlying the push is dirty enough, and I'd first like to understand
> it before bolting on more features.
>
>> I think the
>> natural extension of the current end-user configuration would be to
>> redefine "upstream" mode to push to update the branch with the same
>> name
>
> Right, so does this work?

It might be a beginning of a change in the right direction (I didn't
check the codeflow), but given that the test that comes after the
one you removed is looking at branch->merge[0] and deciding what to
do, and branch.$name.merge should *never* affect anything when
remote.pushdefault or branch.$name.pushremote is in use while
deciding what is pushed out or if the push is allowed, I do not
think the removal of these five lines alone can possibly "work".

> diff --git a/builtin/push.c b/builtin/push.c
> index 2d84d10..b253a64 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -137,11 +137,6 @@ static void setup_push_upstream(struct remote
>  	if (branch->merge_nr != 1)
>  		die(_("The current branch %s has multiple upstream branches, "
>  		    "refusing to push."), branch->name);
> -	if (strcmp(branch->remote_name, remote->name))
> -		die(_("You are pushing to remote '%s', which is not the upstream of\n"
> -		      "your current branch '%s', without telling me what to push\n"
> -		      "to update which remote branch."),
> -		    remote->name, branch->name);
>  	if (simple && strcmp(branch->refname, branch->merge[0]->src))
>  		die_push_simple(branch, remote);
