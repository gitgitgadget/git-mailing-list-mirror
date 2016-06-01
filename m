From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify
 worktrees by basename
Date: Wed, 1 Jun 2016 20:22:14 +0700
Message-ID: <CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com> <20160530104939.28407-1-pclouds@gmail.com>
 <20160530104939.28407-3-pclouds@gmail.com> <xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 15:22:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b866j-00053X-DP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 15:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbcFANWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 09:22:45 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36367 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbcFANWp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 09:22:45 -0400
Received: by mail-io0-f169.google.com with SMTP id k19so7509599ioi.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e5WeCvBdyp3lxelNSW8TxN09mrY1+Eyntt2hsZRTSbE=;
        b=HvFVGBNqHHu6oHb9zWP1B3ctneip6ssaev3rZmRg/BkC8/6WJDGe9R51ngUg4zFXaM
         tmGMALGR/YlHH+caz+LoihYCtzdU2k1Us904xhPlS2MjyQfyciiVRrTCBVKC95Ny0Oox
         piixKmVJ05y/3tt1TRYfA3m1D5Lrzpb7TG7MTydeP2g8EpqHCVSHZXWcIim5eOhk0Fbo
         F97v5UzkCgOyBHsGpyD1uGwlbYVKpWYe00PTcOvL7J+auUNzSJKfWcHStOPP/Gt61fSm
         LSS3tVpnr8PgDLYOYAtNyCKNaoMHRD8CpvM5AOROV5UvuAMeE5xKuccLlv2yjKM7f7LK
         j17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e5WeCvBdyp3lxelNSW8TxN09mrY1+Eyntt2hsZRTSbE=;
        b=malj+buwQcde9IAB64IIstxG4q2XLwSMOv9VdUAbw6iNa0F5+UChobUZIWPwqaETU1
         yiTsDvzfxIUhlD7ABzGSwGnuN1wocoiUPfloZe5ow3KoKtev8JQreYKKUiHdN7aV+s3L
         xkS1+zP6wdjd4r6RedvbnTtfr3UoXpTXrpDqQAD6/SwBAYowZbXCT6Lpaq4XY011bOLP
         YGtTCeuU98kJSFdBSf8v4QsXZ/gIKmPuDc2TP5DTGlpKesmIIp2/x0CLb+l8TO7gvXPi
         pNO95FeAels4tZMnkWbXO+c0cQIAkCVbGrL09DFjMI0IAWEef3Mn1pzq4oeyIWzvJzD/
         muQw==
X-Gm-Message-State: ALyK8tL5QwS647wZ1IH95m7mM14lwUqZvo2yyq4SYEeoX0SuxoVS1Zf80vP2CfMtLLSRnBw6qPIQO6uV+g/22w==
X-Received: by 10.107.159.84 with SMTP id i81mr5213499ioe.29.1464787364026;
 Wed, 01 Jun 2016 06:22:44 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 1 Jun 2016 06:22:14 -0700 (PDT)
In-Reply-To: <xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296084>

On Wed, Jun 1, 2016 at 12:51 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This allows the user to do something like "worktree lock foo" instea=
d of
>> "worktree lock <path/to/foo>". With completion support it could be q=
uite
>> convenient. While this base name search can be done in the same work=
tree
>> iteration loop, the code is split into a separate function for clari=
ty.
>
> Makes me wonder if you want to do this without calling basename(3)
> function at all.  I do not think such a feature would cost that much
> over what we see in this patch.
>
> That is, wouldn't you rather see "worktree lock to/foo" work when
> 'foo' is ambiguous but 'to/foo' is not?

I don't know. I suppose if people have to make `basename $path` the
same because of some weird build settings, e.g. abc/git and def/git,
then this basename selection becomes useless.

I had similar thought though, if you only have a worktree named "foo"
then "fo" or even "f" should be unambiguous and can also identify a
worktree, similar to short sha-1. But I discarded that idea because of
the higher chances that typos can select a wrong worktree. We would
need to convert or match both '/' and '\' in "to/foo" case because of
Windows, so it's not much easier than basename().
--=20
Duy
