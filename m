From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/ PATCH] revert: Allow arbitrary sequencer instructions
Date: Tue, 2 Aug 2011 09:52:44 +0200
Message-ID: <CAP8UFD367s-0gSbmX7N3Ddakc1cZxWb_eU-+Uy5Vr0gbY8m8SA@mail.gmail.com>
References: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
	<1312260884-5087-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 09:52:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo9mT-000384-TZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 09:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab1HBHwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 03:52:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33573 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1HBHwo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 03:52:44 -0400
Received: by yia27 with SMTP id 27so3915046yia.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bAHu/Bhjzf/mL15rJ26ULsdpQhbBoqrXgyxJ5bBP/yE=;
        b=D9wPOIO+pzYC+QkB890YHv/GseKNGyB/fIpxzIqCAt9sGCdZwDnns7ipWVr3tT4eQF
         Apg21B1xn9UodziRlOVZmqLZTNSzhqw5ooGIy5SToI1bA55waqCdtRNA5qRai2Mx9qoF
         4W71G/PBYVHpqoxfyajLN1wRq8lw8gljwfGUE=
Received: by 10.146.186.34 with SMTP id j34mr3691400yaf.16.1312271564167; Tue,
 02 Aug 2011 00:52:44 -0700 (PDT)
Received: by 10.147.35.16 with HTTP; Tue, 2 Aug 2011 00:52:44 -0700 (PDT)
In-Reply-To: <1312260884-5087-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178447>

Hi Ram,

On Tue, Aug 2, 2011 at 6:54 AM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
>
> =A0 =A0 =A0 =A0if (get_sha1(sha1_abbrev, commit_sha1) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> - =A0 =A0 =A0 return lookup_commit_reference(commit_sha1);
> + =A0 =A0 =A0 commit =3D lookup_commit_reference(commit_sha1);
> + =A0 =A0 =A0 if (commit) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 insn =3D xmalloc(sizeof(struct replay_i=
nsn));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 insn->commit =3D commit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 insn->action =3D action;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return insn;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return NULL;
> =A0}

I'd suggest:

       commit =3D lookup_commit_reference(commit_sha1);
       if (!commit)
               return NULL;

       insn =3D xmalloc(sizeof(struct replay_insn));
       insn->commit =3D commit;
       insn->action =3D action;
       return insn;

Thanks,
Christian.
