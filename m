From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/32] rev-list: support traversing in narrow repository mode
Date: Tue, 24 Aug 2010 22:11:43 -0600
Message-ID: <AANLkTimmd-6CWEA9qjHGnAn8svjU+iEFDxwbck6KAQtX@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:12:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo7LI-0005df-U0
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab0HYELt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 00:11:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65484 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab0HYELr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 00:11:47 -0400
Received: by fxm13 with SMTP id 13so77570fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C4l5DW3yp9SUppGt6MtOsQcCTXm7nDYtistQLaiZN9M=;
        b=eAxOKeMn0XC9sgkkeBMtjqvHyhr5wxDgu440HUftNpxMvmBMqFw1lsVnVCYJJPPU+c
         r4hVxtkXScVqXyFguimV23BL1PstY23uP8KQXRaA1N9Hfxu/EkBB1WT1PjQf9lu/IO1z
         0g/9TB2h6ICxwyaRVWHSFElaExCzYzrVmWh5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B0wrz5vVuA1VRH/65nBLlJs4QOLE+K/Y17v9LKn5zikYxrUvLlU5wNt0WCDAHfGaHv
         WCN1Lzl/jMPbKmMtNVPALjnLcMIq+1atuR8gmXTqLJO7DpXfiEMPKnrLSx7Zlvy4SnzV
         tgfNSeyjq34QJzm5EBV/HJZ3gleEaqgDd8wwU=
Received: by 10.223.121.133 with SMTP id h5mr6860254far.74.1282709503368; Tue,
 24 Aug 2010 21:11:43 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 21:11:43 -0700 (PDT)
In-Reply-To: <1282688422-7738-11-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154411>

2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> In this mode, only trees within revs->narrow_prefix is traversed. Thi=
s
> narrows down the whole repository to the given subtree. This mode wil=
l
> be used by upload-pack/pack-objects to create a narrow pack, and by
> all git operations in narrow repository (i.e. $GIT_DIR/narrow exists)=
=2E

My fix-rev-list series I posted is going to cause a few conflicts with
this patch...

<snip>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!subtree)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ; =C2=A0 =C2=A0 =C2=A0 /* no subtree restriction, go on */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (S_ISDIR(e=
ntry.mode) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0!strncmp(entry.path, subtree, subtree_len) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0entry.path[subtree_len] =3D=3D '\0')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ; =C2=A0 =C2=A0 =C2=A0 /* inside subtree, go on */

Instead of writing your own comparison code, you may want to consider
using tree_entry_interesting() here.  That would also provide you with
a natural extension to multiple subtrees, rather than your currently
hardcoded single tree.  You may want to take a look at
tree-diff.c:show_tree() for inspiration here.
