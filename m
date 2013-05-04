From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/4] clone: open a shortcut for connectivity check
Date: Sat, 4 May 2013 08:10:55 +0700
Message-ID: <CACsJy8BSMkFGQcHxFD3wTn_PpC=qEFJ+vR_XygndzVnprye3Aw@mail.gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
 <1367584514-19806-1-git-send-email-pclouds@gmail.com> <1367584514-19806-5-git-send-email-pclouds@gmail.com>
 <7vwqrgxcoc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 03:11:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYR0c-0000Ke-VT
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 03:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763291Ab3EDBL0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 21:11:26 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:46612 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762217Ab3EDBL0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 May 2013 21:11:26 -0400
Received: by mail-ob0-f180.google.com with SMTP id uk5so1853369obc.39
        for <git@vger.kernel.org>; Fri, 03 May 2013 18:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jPR2wRrvrYQy4Phx+RzEhY85J+ElXM7RIrYKX6WbUKc=;
        b=tlbs2oCvz52BtfXOZ4N6h/nNkJzMafeNd94mEc+V9B8JjByrGnsi9XIjDeeZN0xV8I
         H5qoWy6eOmVftP2qDWDn1nhfuajgSykk2TYUIUnXaES7URy0pyiURTYOVye9yD9TyS20
         d4tkie1iRU68VodcQnDu7dpuqD2XqqtAJa4FmEa6WZQEo5ftSiGT3Ww1pf/G61rMrrP7
         VbKAFgqxSSIKa8I7gaazXm4dSFc22bHERPTOUg0uzO97K8oRRiNkA1G0XXpqo+AS6uP8
         Exw9PzTdsC9b8ShRIV1I9rkclIhalVrRFfY507E3ieZxAkkZSGrumpC0TSPd6T9u3uGk
         IBoA==
X-Received: by 10.60.57.3 with SMTP id e3mr3412838oeq.101.1367629885246; Fri,
 03 May 2013 18:11:25 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Fri, 3 May 2013 18:10:55 -0700 (PDT)
In-Reply-To: <7vwqrgxcoc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223349>

On Fri, May 3, 2013 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> In order to make sure the cloned repository is good, we run "rev-lis=
t
>> --objects --not --all $new_refs" on the repository. This is expensiv=
e
>> on large repositories. This patch attempts to mitigate the impact in
>> this special case.
>>
>> In the "good" clone case, we only have one pack.
>
> If "On large repositories" is the focus, we need to take into
> account the fact that pack.packSizeLimit can split and store the
> incoming packstream to multiple packs, so "only have one pack" is
> misleading.

I only had a quick look. But I don't think index-pack respects
packSizeLimit. pack-objects does but only when --stdout is not used,
which is not the case for pack transfer.

> I think you can still do the same trick even when we split the pack
> as index-pack will keep track of the objects it saw in the same
> incoming pack stream (but I am writing this from memory without
> looking at the original code you are touching, so please double
> check).

Yeah. As long we have only one incoming stream, we can still do the
same verification.

>> "index-pack + new checks" is still faster than the current "index-pa=
ck
>> + rev-list", which is the whole point of this patch. If any of the
>
> Does the same check apply if we end up on the unpack-objects
> codepath?

No. unpack-objects does not do this and check_everything_connected
should invoke rev-list like before.
--
Duy
