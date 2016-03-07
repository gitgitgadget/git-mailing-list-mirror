From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: show reference pointed by new tags
Date: Sun, 06 Mar 2016 16:18:03 -0800
Message-ID: <xmqq60wzta2s.fsf@gitster.mtv.corp.google.com>
References: <1457303694-16153-1-git-send-email-eric@engestrom.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
X-From: git-owner@vger.kernel.org Mon Mar 07 01:21:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acivr-0004jU-AY
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 01:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbcCGASJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 19:18:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750928AbcCGASH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 19:18:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAEEB4997B;
	Sun,  6 Mar 2016 19:18:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0acUwKPBmg8nVFSbdO+NOG9fCiY=; b=gG4Jjn
	fh7S35KsHhaMywTXRA9LRPHfxZMNjwmeGiouBz94Nw7/UyGJyVt5SX0DFgcxuMbS
	nb3MBEEW9RWKagyb0HPcxnvyOVkKj3gEVBLEL369MKsJRHZD0ODuxPV9kkbrzxAP
	qkSk5S2V3WGVNzT7k3vXr08jQVWsD5HE5p3Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0nCGzd+vmFfojE/e+GaYN/UoutAdlgj
	TaoUbAPhfyTy9lehI7X6bqJl2k+uYtCZ133LuFDsRSXsMPEEghnuRdfN5Vmhx3mM
	yqlUnq0bZBBOriEpPWNwx2pGXobGyiezKkoPOthzzkxoEqBLnPj8ToMHmOo0ACFp
	W82qWWfhnOs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D1E584997A;
	Sun,  6 Mar 2016 19:18:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 56F8449979;
	Sun,  6 Mar 2016 19:18:05 -0500 (EST)
In-Reply-To: <1457303694-16153-1-git-send-email-eric@engestrom.ch> (Eric
	Engestrom's message of "Sun, 6 Mar 2016 22:34:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0FF5684A-E3FA-11E5-848D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288373>

Eric Engestrom <eric@engestrom.ch> writes:

> Before, new tags had their names shown twice:
>  * [new tag]         v4.5-rc6   -> v4.5-rc6
>
> Instead, show the hash of the commit pointed to:
>  * [new tag]         v4.5-rc6   -> fc77dbd
>
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>

The report from update-local-refs is meant to show what "local"
names the updated ref has, i.e. what names you can refer the result
as.  If you fetched v4.5-rc6, the output tells you that you can
refer to it as v4.5-rc6 in your local repository.

Technically, you can also refer to the tag as fc77dbd, but I do not
see why a user would want to.

In addition, if I did:

    $ git fetch $his_repository 'refs/tags/*:refs/tags/his/*'

I'd see his 'v1.0' tag locally stored as 'his/v1.0', and that is
what is shown in the output as

  * [new tag] v1.0 -> his/v1.0

so that I know I can refer to his v1.0 as "his/v1.0", to
differenticate from the tag I happen to have created as v1.0 in my
local repository.

So, why is this change an improvement?

> ---
>
> This is my first dive into git's code, so it's likely I'm not doing things
> right. The first candidate for that is the literal `7`, which should probably
> be a variable, but I couldn't find what I should use instead.
>
> I'd be happy to fix this for a v2 :]
>
> Cheers,
>   Eric
>
>
>  builtin/fetch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e4639d8..93b2145 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -515,6 +515,7 @@ static int update_local_ref(struct ref *ref,
>  		if (starts_with(name, "refs/tags/")) {
>  			msg = "storing tag";
>  			what = _("[new tag]");
> +			pretty_ref = find_unique_abbrev(ref->new_oid.hash, 7);
>  		} else if (starts_with(name, "refs/heads/")) {
>  			msg = "storing head";
>  			what = _("[new branch]");
