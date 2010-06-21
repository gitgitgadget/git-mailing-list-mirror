From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 2/3] builtin/checkout: change -b from an OPTION_STRING to 
	a OPTION_SET_INT
Date: Mon, 21 Jun 2010 20:04:30 -0300
Message-ID: <AANLkTikyugBxwyCu0GY4dTLW6n_OQhIPNnPfd0_i6k0t@mail.gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org> <1277140782-4064-1-git-send-email-rctay89@gmail.com> 
	<1277140782-4064-2-git-send-email-rctay89@gmail.com> <1277140782-4064-3-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 01:05:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQq2z-0006W3-E4
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 01:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab0FUXEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 19:04:52 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:52923 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab0FUXEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 19:04:50 -0400
Received: by ywh36 with SMTP id 36so2781393ywh.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Oo19v/yseWWEK2rlx67mOea8/nqVVXQL/QzmdtwUoIo=;
        b=uXt6MsuhcBoZmlmAUtsf0kVrQc/sxDfW5o/vW4LynetkONoLR8N/sBXxqqoe6fkiQ0
         nyG2Alu4JQ2YduEFmI0JHXOp8oduBehbiJvHYW6vNvvMK8NXPp3HA77prlW8YNhdsWlr
         N8Cj7O3xIzrwR8UcCzjJch4CgW1NNlYSTFYdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oxuNalDUoC0pRcnqv4KteH2UeWYtCw/5k0NkGFXdgFWc3AHUEF3pkkT95bGq/rMrZl
         RcBFH8z8o2Q1MCyK32rrgZrokO6lozsH/kiRIqynUjRaox8DVcUbqTwYR7GHPs2iadX7
         gMMppvJRm7LDMIZdL5JsXOhXhpL3+bft6GIvY=
Received: by 10.150.117.17 with SMTP id p17mr4983722ybc.305.1277161490314; 
	Mon, 21 Jun 2010 16:04:50 -0700 (PDT)
Received: by 10.150.178.7 with HTTP; Mon, 21 Jun 2010 16:04:30 -0700 (PDT)
In-Reply-To: <1277140782-4064-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149458>

Hi,

2010/6/21 Tay Ray Chuan <rctay89@gmail.com>:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 1994be9..e794e1e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -32,7 +32,8 @@ struct checkout_opts {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int writeout_stage;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int writeout_error;
>
> - =C2=A0 =C2=A0 =C2=A0 const char *new_branch;
> + =C2=A0 =C2=A0 =C2=A0 int new_branch;
> + =C2=A0 =C2=A0 =C2=A0 const char *new_branch_name;

The change of name of the existent variable creates more hassle than
helps.

As you are adding a new option I suggest you to create a new
variable named new_branch_forced or whatever.  This way you avoid
making a lot of changes as you did and minimize the possibility of
adding new bugs by not catching all the problems affected by the
name change.

I think you have chosen to do that just because of the variable
names then I think you should find a variable naming alternative to
satisfy you without changing existing ones.

My suggestion is to do the same I did with --orphan
(const char *new_orphan_branch):
  * Create a C string variable that receives its data by a new
    OPT_STRING.
  * After making all tests needed, point new_branch to your created
    variable.
  * You will always know if your new option was used or not by
    checking nullity of the just created C string.

This way any existing implementation remains untouched and thus it
is much more easy to avoid bugs.

> @@ -692,8 +694,17 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 || opts.new_branch_log || opts.merge || opts.forc=
e))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die ("--patch =
is incompatible with all other options");
>
> + =C2=A0 =C2=A0 =C2=A0 if (opts.new_branch > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *arg =3D=
 argv[0];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!argc || !strc=
mp(arg, "--"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die ("Missing branch name");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.new_branch_na=
me =3D arg;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc--;
> + =C2=A0 =C2=A0 =C2=A0 }

You won't use this if you accept my previous suggestions.

To conclude, IMHO, I don't think this patch is a good thing to do.
/* I would like to point out that I am criticizing it but also
   presenting suggestions!  So it is a constructive critic!  ;-) */

Best regards
