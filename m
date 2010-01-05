From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 2/6] t5541-http-push.sh: add test for unmatched,
 non-fast-forwarded refs
Date: Tue, 5 Jan 2010 18:01:32 +0800
Message-ID: <20100105180132.e573fff2.rctay89@gmail.com>
References: <20091224154057.33611ae7.rctay89@gmail.com>
	<20091224154005.a642c8ec.rctay89@gmail.com>
	<20091224154158.15ba580f.rctay89@gmail.com>
	<20100105063546.GB19368@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 11:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS6GN-0003YM-IG
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 11:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab0AEKBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 05:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840Ab0AEKBn
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 05:01:43 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:57913 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab0AEKBm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 05:01:42 -0500
Received: by yxe26 with SMTP id 26so15453204yxe.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Erc2ZJn4wcjF3jU1w0WoRMJhVPhtzrxk7bdSy9JzpLs=;
        b=Zw2pEtBwK4o69CK3y/sE/yIFsW14pjrcz+QUkj7lzUHAQZu4iA3LDNt3BKzs8or3aO
         tptQUFbtfa4o/W8o6wQIm1x9DQc5Cd7vuZMcCxwpvKKNTmKEYgpC7J5zj+ALVILzbWnn
         r8/TpkTRRqxUyyIWzQoY0ysRtWqoyFcQsiZrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=QjibHhD9VKheLeFbVt4KZO3JQqFiF3Xz3l8iT6ZnvBQCXJokYnBm9GOpotA18hOLmI
         TX06Ovf3OFMtT2VRanrmUDOR+i8fEfi48hW31CX1ffHFz3vfRsRlBBrB83ql4Kpn7jsY
         TJPrU/yt263xX3PGak41om9SPSyBngYaoPl80=
Received: by 10.90.121.1 with SMTP id t1mr13752532agc.19.1262685699594;
        Tue, 05 Jan 2010 02:01:39 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 13sm9564234gxk.13.2010.01.05.02.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 02:01:38 -0800 (PST)
In-Reply-To: <20100105063546.GB19368@coredump.intra.peff.net>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136181>

Hi,

On Tue, Jan 5, 2010 at 2:35 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 24, 2009 at 03:41:58PM +0800, Tay Ray Chuan wrote:
>
>> Test that when non-fast-forwarded refs cannot be matched without an
>> explicit refspect, the push fails with a non-fast-forward ref status=
 and
>> help message.
>
> I don't understand what you're testing here. If it's not matched, the=
n
> how is it a non-fast-forward? Isn't it simply unmatched?

Let me rephrase this as:

  Some refs can only be matched to a remote ref with an explicit
  refspec. When such a ref is a non-fast-forward of its remote ref,
  test that pushing them (with the explicit refspec specified) fails
  with a non-fast-foward-type error.

> Your test:
>
>> +test_expect_failure 'push fails for non-fast-forward refs unmatched=
 by remote helper' '
>> + =A0 =A0 # create a dissimilarly-named ref so that git is unable to=
 match the refs
>> + =A0 =A0 git push origin master:retsam
>> +
>> + =A0 =A0 echo "change changed" > path2 &&
>> + =A0 =A0 git commit -a -m path2 --amend &&
>> +
>> + =A0 =A0 # push master too. This ensures there is at least one '"'p=
ush'"' command to
>> + =A0 =A0 # the remote helper and triggers interaction with the help=
er.
>> + =A0 =A0 !(git push -v origin +master master:retsam >output 2>&1) &=
&
>> +
>> + =A0 =A0 grep "^ + [a-z0-9]\+\.\.\.[a-z0-9]\+[ ]*master -> master (=
forced update)$" output &&
>> + =A0 =A0 grep "^ ! \[rejected\][ ]*master -> retsam (non-fast-forwa=
rd)$" output &&
>
> Looks like you're just testing the usual "master -> retsam is not a
> fast-forward" case. I don't understand how this is different from the
> previous tests. Can you elaborate?

The problem in question is that a non-fast-forward error is not being
reported, and this test sets up a situation to trigger this - it's not
meant to be just another non-fast-forward test.

--=20
Cheers,
Ray Chuan
