From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3] Accept tags in HEAD or MERGE_HEAD
Date: Fri, 19 Aug 2011 19:53:54 +0700
Message-ID: <CACsJy8CWFv3dvhd1rWdgc6i5f8xTz-skHxEvgw=hgVUPUW6Fmw@mail.gmail.com>
References: <1313545369-7096-1-git-send-email-pclouds@gmail.com>
 <1313674994-22902-1-git-send-email-pclouds@gmail.com> <7vd3g2a431.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 14:54:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuOak-0007bF-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 14:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab1HSMy0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 08:54:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42455 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1HSMyZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 08:54:25 -0400
Received: by bke11 with SMTP id 11so2191858bke.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1nevTyqoQGBMunFRITr5ImzqrAySoosHCMCTZzsepZQ=;
        b=aBUkJqYLibiWpHVX0V24Wj3GjHlhgmRzNBafs8KzDb7sDKuFJL9Ab8Uwk9etqfUpcz
         bi2q/Ot7L7cZQPo4aa+sj/VWhgmTfBxEfyCm5aoCfOiHBvmJIFHVt0RgUftqyjdfI5Kj
         JiPeh9aN8OLa0Mt7CQSTa8GPvV4uz8OETDWLk=
Received: by 10.204.155.81 with SMTP id r17mr425346bkw.19.1313758464140; Fri,
 19 Aug 2011 05:54:24 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Fri, 19 Aug 2011 05:53:54 -0700 (PDT)
In-Reply-To: <7vd3g2a431.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179699>

2011/8/19 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0static unsigned char head_sha1[20];
>> +static struct commit *head_commit;
>
> I was not happy with the file-scope global head_sha1[] already, and t=
his
> makes me even less happy. Was it too much trouble to keep them local =
to
> cmd_commit() and pass them around as arguments where necessary? =C2=A0=
If you
> pass around head_commit, is_null_sha1(head_sha1) can be replaced with=
 a
> check !head_commit so we may even be able to lose the head_sha1[] glo=
bal.
>
> And actually removing head_sha1[] is a necessary step from the correc=
tness
> point of view. The repository may have given an object name for a tag=
 in
> head_sha1[] and lookup_expect_commit() may have peeled it to a commit=
=2E
> The code may want to add the "HEAD" as one of the parents of a new co=
mmit,
> and head_sha1[] is no longer the place to pick that information up af=
ter
> your fix. The code needs to look at head_commit->object.sha1[] instea=
d.
> Losing the use of head_sha1[] variable and forcing the code to go to
> head_commit->object.sha1[] reduces the risk of such confusion.

I actually wanted to get rid of head_sha1 but it made changes bigger.
But the patch's become big already. Let me remove head_sha1[] (and
head[] in merge.c) globally, then put this fix on top.
--=20
Duy
