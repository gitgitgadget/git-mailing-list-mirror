From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 3/4] git check-ref-format --print
Date: Mon, 12 Oct 2009 23:49:30 -0500
Message-ID: <20091013044929.GA30342@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock>
 <20091012053141.GD11106@progeny.tock>
 <7vococ6v73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 06:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxZE6-0003pV-0g
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 06:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZJMEll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 00:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZJMElk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 00:41:40 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56360 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZJMEli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 00:41:38 -0400
Received: by ywh6 with SMTP id 6so8707036ywh.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Mc3nGrScOYxbMKfRxXVATNJrckTQ0fTqK1wkPA5+BRI=;
        b=xsIy2AM7HfEyfCGacmgE/nJLqmPqrw9QxpvacgjjchaAovg/KzdrQ27Gs3bwu+unLk
         txX76+pe/6A+ScxceLSaoy4EewdbGALA6f3J0SXBN+KgvbtUErf/pzJConv0iFwFwdwB
         BH5H7Nj7rbLKlRL56JAnDxRklcMZ0he0xAs9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZQefR67bEyWF/ZMp9VugvyPD1vDZXuRhPJK823q7l4LjK1716RmO06sk6Xf4vvqwew
         Ib25gXvjvh/vuVpU647+HMzg6ZPTmOoxRQEw18WJfRtj6xrJ3nRLf1mRqq33zzBFcpzv
         50RgBp+eclTJHjJrnCAvSBRZPrI30ir2tdoQA=
Received: by 10.150.166.21 with SMTP id o21mr11645442ybe.118.1255408861783;
        Mon, 12 Oct 2009 21:41:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2755096yxe.4.2009.10.12.21.41.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 21:41:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vococ6v73.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130127>

Junio C Hamano wrote:

> I do not disagree with a desire to help fixing the unicode insanity o=
n
> that platform, but I suspect that check-ref-format is a wrong place t=
o
> tackle the issue.  You would need a similar filter for outputs from t=
he
> likes of ls-files and "diff --name-only", iow, anything that deal wit=
h
> pathnames, no?
>=20
> It would have be something like "check-ref-format --print | iconv ...=
"
> pipeline (conceptually, if not forcing the pipeline to the end users,=
 that
> is).

GNU iconv does not write the various Unicode normalization forms, so it
would have to be something like "check-ref-format --print | charlint ..=
=2E"
instead.  Regardless of the filesystem, it seems reasonable to consider=
 =C3=A9
(U+00e9) and e=CC=81 (U+0065 + U+0301) the same character when it appea=
rs in a
ref name, and one way to achieve this would be to pick one normalizatio=
n
form and stick to it.  This does not seem so different from stripping o=
ut
empty path components.

As a side effect, that would deal with OS X=E2=80=99s strange handling =
of unicode
filenames for .git/refs/*.  Now that I think about it, if fighting OS X
were the only problem that needed to be solved, I don=E2=80=99t think I=
=E2=80=99d like
this solution so much.  The analogous solution to the also unsolved iss=
ue
of case insensitive filesystems is to force all ref names to lowercase.
Do we want to do that?  (The case insensitivity issue might not be as b=
ad,
since the relevant filesystems will at least _preserve_ the case of
filenames in .git/refs.  Should we copy them and smudge new ref names t=
o
match known ones that differ only in case?  Just thinking about the
problem makes me cringe.)

Coping with the unicode filename craziness in the working tree is a
separate issue, though probably a more important one.  I think Linus se=
t
up a framework for solving it in
<http://thread.gmane.org/gmane.comp.version-control.git/77827>.

Regards,
Jonathan
