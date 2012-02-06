From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 06 Feb 2012 13:10:12 -0800
Message-ID: <7vwr7z653f.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:10:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVpP-00017S-JG
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab2BFVKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 16:10:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab2BFVKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 16:10:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AA517AE5;
	Mon,  6 Feb 2012 16:10:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R3Q6lsfUlC6z
	GuxiYhglSP92rck=; b=mmkJx8ffjorRSWtmu0+zPqCpR4nrK/a0QcRsXBVSFVhE
	o5e6U0k62XrtpOQ5d+VT5YumUF/ZbIY/35J01ayMkrma+XBOuF5VyWOzG/Tvl67q
	3caoLLe+rhoiI5W8D4iZt0fpojdFTMlDbtBuiDy0XdJWLP7XEz6/AGsXrKywioY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lTg3sZ
	KaESt2F7VdvsKASyGFwbnxjdM//sfXi6yj3+dfTSotwSzY0gSOviWBNGuVI5CdbE
	OXc2JUyPRi+QcRCwyj0cxEa7NyPiX8139dhmG05i3bZrxxB2vrSu6vrDesRHWgzx
	p1re+aQh9eZzmMbhpaBMLYV7YXVnUbBw2jJ3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 320417AE4;
	Mon,  6 Feb 2012 16:10:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 918D57AE2; Mon,  6 Feb 2012
 16:10:14 -0500 (EST)
In-Reply-To: <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 17:57:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F68F7330-5106-11E1-A9EA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190104>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 9c1d395..ec548ea 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -123,8 +123,16 @@ subdirectories.
>  	Record only the fact that the path will be added later. An entry
>  	for the path is placed in the index with no content. This is
>  	useful for, among other things, showing the unstaged content of
> -	such files with `git diff` and committing them with `git commit
> -	-a`.
> +	such files with `git diff`.
> ++
> +Paths added with this option have intent-to-add flag in index. The
> +flag is removed once real content is added or updated. By default yo=
u
> +cannot commit the index as-is from until this flag is removed from a=
ll
> +entries (i.e. all entries have real content). See commit.ignoreInten=
tToAdd
> +regardless the flag.
> ++
> +Committing with `git commit -a` or with selected paths works
> +regardless the config key and the flag.

It still is not clear to me how best to sell this change to the end-use=
r
community.

IIRC, the original motivation of intent-to-add "add -N" was in response=
 to
users who curse Git because they often forget to add new files before
committing, and they wanted to say "Here I have a new file, it is not
complete yet, but I do not want it left out of the commit. While my mem=
ory
is fresh, let me tell Git to keep an eye on it, so that it can remind m=
e
if I forget to add the final contents."  For them, the current "did you
forget to add them?  If so tell me the final contents for at least the
paths you will be changing with this commit" error was a perfect safety
solution.

It turned out that the benefits described we see above in the context,
"This is useful, among other things, ...", were of more value, and for
these use cases, i-t-a entries ceased to mean "I may forget, so I am
telling you now, please remind me when I say commit."  And "did you
forget?" error is hinderance for them.

But does that mean nobody will ever need "please remind me lest I forge=
t"?
Just the original requestor of the "add -N" feature may still be using
git, but more importantly, isn't it the case that those who have been
using it merely for the other side effect (e.g. 'git diff') sometimes w=
ant
the "please remind me" safety?

I suspect that some among 1 million Git users would want the "please
remind me", so a solution with configuration variable without command l=
ine
override is not ideal (command line without any configurability is fine=
 as
long as we have a good default).

I am beginning to think "safety by default, which can be turned off by
learned users, but still can be turned on on demand" may be a lot easie=
r
to sell this.  That is:

 - commit.ignoreIntentToAdd defaults to `false`; the default will never
   change.  The users can set it to `true`.

 - "commit --ignore-intent-to-add" can be used without setting the
   configuration or to defeat an explicit `false`, for a one-shot reque=
st.

 - "commit --honor-intent-to-add" can be used to defeat an explicit
   `true`, for a one-shot request.

The third one is a bit funny, as it is a way to bring back safety when =
the
user earlier decided that he does not need that kind of safety (i.e. "I
only say 'add -N' for `diff` and stuff, I will never forget to add real
contents before committing"), so it will almost never be used, because
these users who set 'ignoreIntentToAdd =3D true' do _not_ expect Git to=
 help
them in remembering to add the real contents.  And having to add a funn=
y
option just for the sake of completeness is often an indication that th=
ere
is something fundamentally wrong in the system that the option tries to
express an interface into it.

Without conclusion... Sigh...
