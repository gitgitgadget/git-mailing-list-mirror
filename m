From: John Szakmeister <john@szakmeister.net>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Thu, 29 Sep 2011 21:02:58 -0400
Message-ID: <CAEBDL5VD1nkVK1b_zN+jFAnSrK5X3va0nMdUwypghBcFbz2s0Q@mail.gmail.com>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 03:03:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9RVQ-0003yd-2r
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 03:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab1I3BC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 21:02:59 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47923 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab1I3BC6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 21:02:58 -0400
Received: by vcbfk10 with SMTP id fk10so954309vcb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 18:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XyldA58OeNEmpCSRtpnOxUynh23NQ2YhUPdedwn8N2s=;
        b=Jg1bsVBFOw5HDORFNjNWJQNTIfjYpq03injuizFaUJhGgjbMH3l/fsQ2NQw5DJF6Oy
         4JqdvGKj0ETGxKItJp7ATRuLhZCiITkChGF75VuLB2FaKHR/C+iBCscmEj070zNwDlhO
         dt3qjuNuH3RYIspu7M3k8Tm9755QC8fiF83FQ=
Received: by 10.220.77.85 with SMTP id f21mr2678700vck.43.1317344578290; Thu,
 29 Sep 2011 18:02:58 -0700 (PDT)
Received: by 10.220.75.144 with HTTP; Thu, 29 Sep 2011 18:02:58 -0700 (PDT)
In-Reply-To: <7vk48rq854.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: r6U_zIkJGtzsP43fVJYSf9Dk6Po
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182458>

On Thu, Sep 29, 2011 at 6:46 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
[snip]
> According to that definition, because "master" has dir/file1, and the
> index is unchanged since "next", we would add dir/file1 to the index,=
 and
> then check dir/file1 and dir/file3 out of the index. Hence, we end up
> resurrecting dir/file3 out of the index, even though "master" does no=
t
> have that path.
>
> This is somewhat surprising.

That is surprising!  It explains something I saw just yesterday which
closely mirrors your recipe.

> It may make sense to tweak the semantics a little bit. We can grab th=
e
> paths out of the named tree ("master" in this case), update the index=
, and
> update the working tree with only with these paths we grabbed from th=
e
> named tree. By doing so, we will keep the local modification to dir/f=
ile3
> (in this case, the modification is to "delete", but the above observa=
tion
> hold equally true if dir/file3 were modified).

That seems sane.

> An alternative semantics could be to first remove paths that match th=
e
> given pathspec from the index, then update the index with paths taken=
 from
> the named tree, and update the working tree. "git checkout master dir=
"
> would then mean "replace anything currently in dir with whatever is i=
n dir
> in master". It is more dangerous, and it can easily emulated by doing=
:

This is equally sane, but is probably closer to my expectation.

[snip]
> =C2=A0* This is a behaviour change, but it may qualify as a bugfix. I=
 dunno.

Personally, I lean towards it being a bugfix.

-John
