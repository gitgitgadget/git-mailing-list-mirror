From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: allow detached checkout when --branch takes a tag
Date: Fri, 6 Jan 2012 18:09:16 +0700
Message-ID: <CACsJy8BSzQiTScOhvQjLz8mQZC0g3fEOayBxn7n65t1tKwWnsw@mail.gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com> <20120105141844.GA26771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 06 12:09:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj7gL-0006ss-3e
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 12:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153Ab2AFLJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 06:09:49 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57838 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119Ab2AFLJs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 06:09:48 -0500
Received: by eaad14 with SMTP id d14so895829eaa.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 03:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LBRxv1lEQ+0Ell4/I/60XobozuGEDPIYBcp5a3x0+EQ=;
        b=Ejygva9Duy3ZOTBClQjquorCghKB8WXNwJ4bmf9d6B7dqTo9CgZ4isAdHE13Wfqdvc
         28LG8GC5UQYmuy2097coZmlFzBV+sdV8+oeUxe0qii/MW+sri+y4UmYm9wmdbxgQILmn
         zOwppAsAcEEZa5OM/xJ0jEsiszYiMSnSVuvBI=
Received: by 10.204.145.74 with SMTP id c10mr2349294bkv.62.1325848187167; Fri,
 06 Jan 2012 03:09:47 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Fri, 6 Jan 2012 03:09:16 -0800 (PST)
In-Reply-To: <20120105141844.GA26771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188021>

2012/1/5 Jeff King <peff@peff.net>:
>> @@ -721,6 +722,14 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_release(&head);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!our_head_points_at) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&head, "refs/tags/");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&head, option_branch);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 our_head_points_at =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find_ref_by=
_name(mapped_refs, head.buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&head);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!our_head_points_at) {
>
> Hmm. The context just above your patch that got snipped does this:
>
> =C2=A0 =C2=A0strbuf_addstr(&head, src_ref_prefix);
> =C2=A0 =C2=A0strbuf_addstr(&head, option_branch);
> =C2=A0 =C2=A0our_head_points_at =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0find_ref_by_name(mapped_refs, head.buf);
>
> where src_ref_prefix typically is "refs/heads/", and clearly you are
> meaning to do the same thing for tags. But the use of "src_ref_prefix=
"
> is interesting.
>
> It is always "refs/heads/" unless we are cloning into a bare mirror, =
in
> which case it is "refs/". So with your patch in the non-mirror case,
> doing "--branch=3Dfoo" would try "refs/heads/foo" followed by
> "refs/tags/foo". Which makes sense. But in the mirror case, it will t=
ry
> "refs/foo" followed by "refs/tags/foo", which is kind of odd.
>
> I wonder, though, if the original code makes any sense. By using
> "refs/", I would have to say "--branch=3Dheads/foo", which is kind of
> weird and undocumented. I think it should probably always be
> "refs/heads/", no matter if we are mirroring or not.

--branch should not be used with --mirror in my opinion. --branch
changes HEAD so it's no longer an exact mirror.
--=20
Duy
