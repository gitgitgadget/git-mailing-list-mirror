From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack.c: show correct command name that fails
Date: Wed, 18 Sep 2013 11:16:15 -0700
Message-ID: <xmqqvc1yuhao.fsf@gitster.dls.corp.google.com>
References: <1379511678-11611-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 20:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMMJ9-0002rl-31
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 20:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3IRSQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 14:16:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab3IRSQw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Sep 2013 14:16:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABF5B431F9;
	Wed, 18 Sep 2013 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QoUQQhP7zWdk
	PX65wLzDSod/eFA=; b=qiPB7B/pwOfiDeDwiZPYI0XvZFZmMBK1bHaegk9ZRryx
	KPVRuy2R+atB/LVfu7TUII3kCdkuvoQHkX//umm4EiQNB1rv4QI5Pnos95LjlTHK
	o2eBcdNJp6AVwjE88uQrrbnU75L261Q21eKKUj4cmEzVMIRKsjCluQ+AgB7Aef0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QmdErH
	h4WYoOgXl5tXrf2tUwdQdCzfcLOGhqGDLpg5jDWbl9mJGrPPRhkaNZSq543FDYOH
	dpjKZwhARKf84/X+/c4AK6YoXTqFNKoZlnPnKXtSPEtac72DFZna4r5134iIhl3W
	zOBJChprjFzdYquQFEwJvEIx7WyoOMmWkOoXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EA62431F8;
	Wed, 18 Sep 2013 18:16:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2544431F1;
	Wed, 18 Sep 2013 18:16:48 +0000 (UTC)
In-Reply-To: <1379511678-11611-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 18
 Sep 2013 20:41:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C047A6C-208E-11E3-938A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234978>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When --shallow-file is added to the command line, it has to be
> before the subcommand name, the first argument won't be the command
> name any more. Stop assuming that and keep track of the command name
> explicitly.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks; this dates back to v1.8.3.2 but it is at the end of an error
path and only for reporting, so it may not be worth merging it down
to the 1.8.3.x maintenance track.

I wondered if this is something we can have a test for easily.
Unlike the "--upload-pack" option, there is no way for the receiving
end to choose which index-pack (or unpack-objects) to run, but we
may force a failure by temporarily futzing with PATH to make a dummy
git-index-pack that always fails to be found or something silly like
that.

>  fetch-pack.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6684348..b259c51 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -688,7 +688,7 @@ static int get_pack(struct fetch_pack_args *args,
>  	const char *argv[22];
>  	char keep_arg[256];
>  	char hdr_arg[256];
> -	const char **av;
> +	const char **av, *cmd_name;
>  	int do_keep =3D args->keep_pack;
>  	struct child_process cmd;
>  	int ret;
> @@ -735,7 +735,7 @@ static int get_pack(struct fetch_pack_args *args,
>  	if (do_keep) {
>  		if (pack_lockfile)
>  			cmd.out =3D -1;
> -		*av++ =3D "index-pack";
> +		*av++ =3D cmd_name =3D "index-pack";
>  		*av++ =3D "--stdin";
>  		if (!args->quiet && !args->no_progress)
>  			*av++ =3D "-v";
> @@ -752,7 +752,7 @@ static int get_pack(struct fetch_pack_args *args,
>  			*av++ =3D "--check-self-contained-and-connected";
>  	}
>  	else {
> -		*av++ =3D "unpack-objects";
> +		*av++ =3D cmd_name =3D "unpack-objects";
>  		if (args->quiet || args->no_progress)
>  			*av++ =3D "-q";
>  		args->check_self_contained_and_connected =3D 0;
> @@ -770,7 +770,7 @@ static int get_pack(struct fetch_pack_args *args,
>  	cmd.in =3D demux.out;
>  	cmd.git_cmd =3D 1;
>  	if (start_command(&cmd))
> -		die("fetch-pack: unable to fork off %s", argv[0]);
> +		die("fetch-pack: unable to fork off %s", cmd_name);
>  	if (do_keep && pack_lockfile) {
>  		*pack_lockfile =3D index_pack_lockfile(cmd.out);
>  		close(cmd.out);
> @@ -782,7 +782,7 @@ static int get_pack(struct fetch_pack_args *args,
>  			args->check_self_contained_and_connected &&
>  			ret =3D=3D 0;
>  	else
> -		die("%s failed", argv[0]);
> +		die("%s failed", cmd_name);
>  	if (use_sideband && finish_async(&demux))
>  		die("error in sideband demultiplexer");
>  	return 0;
