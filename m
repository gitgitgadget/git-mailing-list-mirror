From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] config: add core.sharedconfig
Date: Thu, 09 Dec 2010 10:13:24 -0800
Message-ID: <7vwrnig6gr.fsf@alter.siamese.dyndns.org>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
 <1291907388-9068-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 19:13:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQl08-0006iO-L6
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 19:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab0LISNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 13:13:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0LISNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 13:13:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 589E63B74;
	Thu,  9 Dec 2010 13:13:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tkHvp7fIo3pX
	yu1GQxVEaQLVS4g=; b=xiPu6gZZBYvc69/hYzYPyE5KEI3EhS+7Jcob2zCCeUWV
	ZDcr/++Zjwe6t1VV3l96FYphLvAeLpKMe5l6423ycPvmL8uN/NIfEBT+2yZ2vplM
	I18szoSIimrf8eaCeqBb093ffLCvIkAFqL5RkYFfq5p4DCzXUNh1TczzXk4fvQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Mfo2d/
	rYL07QPRUmuEkBreAmZkTv1+0mCA/PTJav8hpT5pPHTN67wZG8CcgZcUleZp1dQ3
	zrmXNj/jONpIaJ7SYUE5EUu8vUXba2x6gpeMu226PlT2ewHFqsNn1gzjzM5laUe6
	itDdT38FeEhRK0BimtDQWC/WDORlq+I5jfDj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29BBD3B72;
	Thu,  9 Dec 2010 13:13:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 059D83B71; Thu,  9 Dec 2010
 13:13:49 -0500 (EST)
In-Reply-To: <1291907388-9068-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  9 Dec
 2010 22\:09\:48 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 145B6DE6-03C0-11E0-AEB7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163301>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> core.sharedconfig can take anything that resolves to a blob.
> $GIT_DIR/config will override the shared config. Nested shared
> config is not allowed.
>
> No protection is provided. It's up to the project to maintain good
> config. The config could be in a separate branch that only a few
> people are allowed to push, for example. To be safest, just put SHA-1
> there.
>
> git-fsck and git-prune should learn about this key and protect it fro=
m
> being pruned.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Hopefully nobody sets core.sharedconfig =3D :path/to/config or simil=
ar
>
>  And I should not open $GIT_DIR/config twice. Well, it does not hurt
>  much.

That kind of sloppy thinking adds up, though.

> @@ -910,6 +918,12 @@ int git_config(config_fn_t fn, void *data)
> =20
>  	repo_config =3D git_pathdup("config");
>  	if (!access(repo_config, R_OK)) {
> +		git_config_from_file(get_shared_config, repo_config, NULL);
> +		if (core_shared_config) {
> +			ret +=3D git_config_from_sha1(fn, core_shared_config, data);
> +			found +=3D 1;
> +		}
> +

What is the point of this "found++" when you will increment it for find=
ing
the repository-local configuration anyway?

>  		ret +=3D git_config_from_file(fn, repo_config, data);
>  		found +=3D 1;
>  	}

I originally liked what the first two tried to do, but think about the =
use
case.  How would this whole thing work?

 - The user clones from the project to get a repository with a working
   tree;

 - The user somehow learns that s/he can run one command to get
   project-wide preference of the project:

     $ git config core.sharedconfig refs/remotes/origin/config:git.conf=
ig

 - Everything hopefully should work the way project wishes in that blob=
,
   unless the end user later overrides them by adding different setting=
s
   to .git/config.

How is that different from:

 - The user clones from the project to get a repository with a working
   tree;

 - The user somehow learns that s/he can run one command to get
   project-wide preference of the project:

     $ ./setup-project-preference.sh

   Typically, such a ./setup-project-preference.sh script would only
   consist of a series of "git config $foo $bar", so any user who can s=
ay
   "git config core.sharedconfig $foo" should be able to use it as well=
=2E

 - Everything should work the way project wishes with the settings made=
 to
   .git/config by the script, unless the end user later overrides them =
by
   modifying settings in .git/config.

One minor difference is that some configuration variables are additive,
and you cannot subtract from them with your approach.
