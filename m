From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Patching bad commits
Date: Tue, 29 Jun 2010 00:24:18 +0200
Message-ID: <AANLkTikfrAk9xDNhcHDJupuWBKrxExKE1N78rJWDTUYF@mail.gmail.com>
References: <4c291e41.4f1ee30a.3484.fffff729@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 00:24:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTMkv-0002tB-4O
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254Ab0F1WYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 18:24:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49399 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0F1WYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 18:24:39 -0400
Received: by gyd12 with SMTP id 12so1133109gyd.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EYGzaoh8mj7UaKMdpbhrQ8MIAR8+s3UEQbg0LZeb8QM=;
        b=sFtVGCW0gIjYahUO48LKvMCpUK+ZIZYRs1E9udEo0GOn9AJWTuBJ5V8bbSFApNVAUN
         PdSNz/pHZ3VmuuG0nWouK1SpBVH8HyT+PGYWHbrRKxcKM38Xwhwxddm6HTSgMvrb/0OT
         qS1TO7//NAK05mq9LEbBCDu7A3KMARiIf48ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fD8x7EY4GrnAL+EwDjh6hy36jrfJrC859Sn/CAY2RhPFdW9YbE7ZiFrhu3DRCWLZaX
         x9syh5WCKxgfaRXiVhp+QhEATWVmNysxut+C0hA98m7UL4WtdiPgQEMuZPTNlLhq7/+5
         LngUsP829rILaJnOUy7z1JbCl4fcxUA1xhlik=
Received: by 10.100.74.4 with SMTP id w4mr7128862ana.117.1277763878453; Mon, 
	28 Jun 2010 15:24:38 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Mon, 28 Jun 2010 15:24:18 -0700 (PDT)
In-Reply-To: <4c291e41.4f1ee30a.3484.fffff729@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149867>

Heya,

On Tue, Jun 29, 2010 at 00:03, Michael Witten <mfwitten@gmail.com> wrot=
e:
> How about implementing something SIMILAR to "git notes" (perhaps
> even using "git notes") to store and apply patches for such bad
> commits?

Definitely use 'git notes' for this, I'd say this is a perfect use
case for it. Just store the patches in their own notes ref and you're
good to go.

> For instance, bisecting could transparently apply any patches that
> are necessary to make a bad commit actually buildable; such patches
> could be distributed as usual for the benefit of others.

Something like that should probably be guarded by a
switch/configuration value, but that sounds very useful.

> =C2=A0 =C2=A0* A plain patch file (or maybe a git tree of patches).

I guess in this form 'git bisect' could just call 'git am' on that
tree (regardless of whether it has 1 or more patches), which would
apply them in the usual order? It might be useful to instead stream
the contents of the note to 'git am', but I could imagine it being
useful to have the patches on disk (so that you can edit them, or look
at them when applying fails).

> =C2=A0 =C2=A0* A reference to another commit that should be checked
> =C2=A0 =C2=A0 =C2=A0out instead.

I'm not sure how useful that is, if you're just going to check out
another commit you might as well 'git bisect skip' the current one?
Well, I guess if the other commit is outside the bisect range but is
applied on top of the commit under inspection it makes sense. So makes
sense, only problem I see is that if that commit is on another branch
it might not be available locally.

> Is this a worthwhile idea?

I like this idea a lot, it's always bothered me that some commits can
just come up during git bisect as being untestable. The tricky part
will be to ensure that the patches you apply don't affect the bug ;).

--=20
Cheers,

Sverre Rabbelier
