From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Let 'git <command> -h' show usage without a git dir
Date: Sun, 8 Nov 2009 05:03:41 -0600
Message-ID: <20091108110341.GA23737@progeny.tock>
References: <20080125173149.GA10287@edna.gwendoline.at>
 <20091108071152.GA20741@progeny.tock>
 <7vvdhlfk2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Gerfried Fuchs <rhonda@debian.at>,
	462557@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 11:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N75PM-0000oV-Tk
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 11:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbZKHKxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 05:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZKHKxv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 05:53:51 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:55312 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbZKHKxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 05:53:50 -0500
Received: by ywh40 with SMTP id 40so1927794ywh.33
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 02:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ob7EmWfVQ3FZLc50IjJ9qwiivQ498W1DJ0o8QH83HHw=;
        b=DdTjBm2ksXzae+EJiFkItgREfWKdgV084FVdWria9EBejzN3xY9SHSoJG5UijxvRkj
         geTAWiJ/MnaK8TFDUvaEj4wohDj3dbVbxi9MqIrtTOzBSzD/fLh+1mymLedlNJwNjpOq
         cHorEpyGsnOKCS1gQYSFLmu4YjSm2asCz0W4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X2HV1Mz6vtQAKe2SroeGydUqU4h/Jm54B6vnvduW7ZCEkdKRjwmrhwcKiXc9rNV/AW
         UHovTK8bJ42iTPtYzaA5PcHIv5TTjyCNcpkF4ysdNZflAmTtJltQmOg9KVqzCagDEQrR
         BS27MbojcfuC0ORjAOczydjY/SJ83NoExc7Ws=
Received: by 10.150.43.17 with SMTP id q17mr11178442ybq.197.1257677635510;
        Sun, 08 Nov 2009 02:53:55 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm851292gxk.0.2009.11.08.02.53.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 02:53:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvdhlfk2y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132391>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
>> +/*
>> + * Let RUN_SETUP, USE_PAGER, and NEED_WORK_TREE take effect even if
>> + * passed the -h option.
>> + */
>> +#define H_IS_NOT_HELP	(1<<3)
>=20
> Yuck.  Let's think of a way to avoid this ugliness.

Thank you. :)

> So I think the right approach is something like how you handled http-=
push;
> namely, check if the sole argument is "-h", and if so show help and e=
xit.
>=20
> 	Clarification. the following description only talks about "cmd -h"
> 	without any other options and arguments.
>=20
> Such a change cannot be breaking backward compatibility for...
[...]
>  * "grep -h" cannot be asking for suppressing filenames as there is n=
o
>    match pattern specified.

Okay, here=E2=80=99s a start.

-- %< --
Subject: Show usage string for 'git grep -h'

Clarification: the following description only talks about "git
grep -h" without any other options and arguments.

Such a change cannot be breaking backward compatibility.  "grep
-h" cannot be asking for suppressing filenames, as there is no
match pattern specified.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Is the long usage information really what is wanted here?  (I would
think yes, since there is no other way to get that, but sometimes all
I want is a reminder of the non-optional arguments.)

Without something like the previous patch, the usage information is
captured by a pager.  I know this is an accidental thing (not all
commands send their -h output through a pager), but it is very
convenient and mitigates the first effect somewhat.  Should
whatever -h always use with a pager?

The -h output is very long, and since it goes to standard error,
"git grep -h | head" does not succeed in capturing the best of it.

Usage errors caught in the same function die() currently.  I was going
to switch them to usage_msg_opt(), but because of the long usage
message, that would cause the error message to scroll off the
screen...

So I am not totally happy with this.  But it is certainly an
improvement over the output from before:

$ git grep -h
fatal: no pattern given.

I=E2=80=99ll sleep on it.  Thank you for the advice.

Good night,
Jonathan

 builtin-grep.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 1df25b0..01be9bf 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -788,6 +788,13 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_END()
 	};
=20
+	/*
+	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
+	 * to show usage information and exit.
+	 */
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(grep_usage, options);
+
 	memset(&opt, 0, sizeof(opt));
 	opt.prefix =3D prefix;
 	opt.prefix_length =3D (prefix && *prefix) ? strlen(prefix) : 0;
--=20
1.6.5.2
