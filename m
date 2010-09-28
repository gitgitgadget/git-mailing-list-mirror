From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] pathspec: add tree_recursive_diff parameter
Date: Tue, 28 Sep 2010 12:38:55 +1000
Message-ID: <AANLkTinZt8kish9L2F-ad_boXByZTUj-BnYTp-vtePk0@mail.gmail.com>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
	<1284939000-16907-3-git-send-email-pclouds@gmail.com>
	<7vocbivnfs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 04:39:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Q60-0008F9-1s
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 04:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760573Ab0I1Ci6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 22:38:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46405 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759113Ab0I1Ci5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 22:38:57 -0400
Received: by wyb28 with SMTP id 28so4538530wyb.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 19:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FEbwGfUu/Wq6Pk7TbMb44pgrRoOJ3eRkvuX93xoq1M4=;
        b=BrWqUsTL/eYx/H/FXcMftBXrl8yMT50cVQOX6iMo8IhAhCLMQEMlboSUcqH/zpNNBF
         sEsTEikopiF/AGzO1woFRYOZzq8+u7TaIY8HcKNYUIfmDdnDsFYPk6G55KE2RSpSrmwv
         xSSKSRu+CyFLTKYLZflJIDGdubSJ1b0JXx3zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EU7DY418CN8h+0oVDNJGeMqH/hLHBoqcIfbKmLKCyV2ULscnKspAWPl9Mu4A8OyZSF
         I20Vmgg+ybjKGzJe1cR6N750Jbg/UR+DgnMyZV4DwETKOj4R5gxyYnMSQ5swnv0sblMA
         z7+0t9PnPdbjK3/i/sc7EvDJs+eNsrbLAc+z8=
Received: by 10.216.21.204 with SMTP id r54mr7017249wer.95.1285641535940; Mon,
 27 Sep 2010 19:38:55 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Mon, 27 Sep 2010 19:38:55 -0700 (PDT)
In-Reply-To: <7vocbivnfs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157384>

2010/9/28 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> When wildcard match is implemented, a full path is needed to do fina=
l
>> match. What type of diff_tree is performed determines how to treat
>> directories:
>>
>> =C2=A0- If it's recursive diff, directories are just an intermediate=
 step.
>> =C2=A0 =C2=A0All path must end with a file name. Thus, directories w=
ill be
>> =C2=A0 =C2=A0unconditionally matched.
>
> Hmm, I am not sure what you mean by this. =C2=A0If the pathspec says =
a/b*/c,
> you are in "a" and are deciding if you should descend to its subdirec=
tory,
> then you would surely want to be able to say:
>
> =C2=A0(1) Ah, the subdirectory I am looking at is "bar" and it does m=
atch "b*".
> =C2=A0 =C2=A0 It might contain "c"; I should descend into it.
>
> =C2=A0(2) Nope, the subdirectory I am looking at is "frotz" and it ca=
n never
> =C2=A0 =C2=A0 match "b*", so there is no point recursing into it.
>

I did not go that far, trying to analyse the pattern. When I wrote
"immediate step" I was thinking of "*foo" pattern, which effectively
means descending to any reachable directories because '*' matches
slashes too. I think that's the worst case.

Anyway I did not know that I could borrow some optimizations from
pathspec_matches() in builtin/grep.c.
--=20
Duy
