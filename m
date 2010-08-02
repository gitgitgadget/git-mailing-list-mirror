From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: mention "git pull" in error message for non-fast
 forwards
Date: Mon, 2 Aug 2010 14:12:49 -0500
Message-ID: <20100802191211.GA2180@burratino>
References: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og0Sn-0007Vt-3w
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab0HBTOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 15:14:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33936 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0HBTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:14:12 -0400
Received: by wwj40 with SMTP id 40so4251095wwj.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9S+i28doIJk4wMK4qa5uP9GIgIRYmteVL9z3lMUrt+U=;
        b=IJyHCaSr+A0fiqVWMlNbDLVTwpfT9pL4ImEq2yGijFNtdgDOjEYczy3qpXsG+yNwpg
         +M8tsTSL/XB9OFrU3k+3dxHllgsZt7XynloZpTO/faS1xUhWT6rDjUAHsy+BHtYevQQx
         tsJproWoIDU6m5vdelx3USRHzeYSpzq93xL2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=okttIXaA3/oYnX6IspsCNweXAlP8a6fzp49mymS+Ry+w95x0qDhu8qTKwwRRi+sNbG
         78lJjm3/uffS0roYjrqeksqgTwi6zfnhfqvngwtoV8L71JcB4Uj0Yv7ZB5A3B2fzsn1/
         uh9kswLoSaMLAIDCrwKvmmG1LpvPoSPmvuVPQ=
Received: by 10.227.157.17 with SMTP id z17mr5125908wbw.122.1280776450733;
        Mon, 02 Aug 2010 12:14:10 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id b18sm5256165wbb.13.2010.08.02.12.14.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 12:14:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152441>

Hi Matthieu,

Matthieu Moy wrote:

> +++ b/builtin/push.c
> @@ -130,8 +130,8 @@ static int push_with_options(struct transport *tr=
ansport, int flags)
> =20
>  	if (nonfastforward && advice_push_nonfastforward) {
>  		fprintf(stderr, "To prevent you from losing history, non-fast-forw=
ard updates were rejected\n"
> -				"Merge the remote changes before pushing again.  See the 'Note a=
bout\n"
> -				"fast-forwards' section of 'git push --help' for details.\n");
> +				"Merge the remote changes (e.g. 'git pull') before pushing again=
=2E  See the\n"
> +				"'Note about fast-forwards' section of 'git push --help' for det=
ails.\n");

Your change is good.

This reminds me: sometimes people blindly =E2=80=9Cgit pull=E2=80=9D a =
rebased history
just to avoid a non-fast-forward push, and it irks me to no end.  So if
I were running the world, the output would be:

 error: rejected non-fast-forward push to '<url>'
 hint: To prevent you from losing history, non-fast-forward updates are
 hint: rejected by default.
 hint: See the 'Note about fast-forwards' section of 'git push --help'
 hint: for details.

and the relevant section of the manual would explain that

 1. if upstream is ahead of you, you may want to "git pull"

but

 2. if upstream rebased, you may want to "git pull --rebase", and
    yell at upstream a little while at it.

and

 3. if the history you are pushing to is both (1) known to be unstable
    and (2) wrong, you can override it with
    "git push <remote> +<refspec>".  Be sure to make sure the
    =E2=80=9C[receive] denyNonFastForwards=E2=80=9D setting is unset co=
rrectly in this
    case.

Jonathan
