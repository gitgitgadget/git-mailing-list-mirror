From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Wed, 29 Sep 2010 21:22:24 -0600
Message-ID: <AANLkTikf8DogBmprAxh+VusQvn5e3BOJz41fn+5Uiu9k@mail.gmail.com>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 05:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P19j5-0006Mw-MY
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 05:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab0I3DW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 23:22:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58535 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab0I3DWZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 23:22:25 -0400
Received: by fxm4 with SMTP id 4so456710fxm.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 20:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CUmiRHYK7n4V/dNJkIeg54bgTMNFPKUv7XOQzW8ZKuE=;
        b=QNIcBD9Z+dUcgHRHG2WkK9v7IFy5GZnJTwWt4x64Hc9MD2ECENxMk4F0Lv1f4Ez64u
         FMsOiOd2Ggo06ULqA0o2sBzFCSGyZc4OBySEc/lGZuyRJ9y6tFqjeFM3+/SZa3JXJcIp
         m+DAPaVUbzgckE3udcvhnX/hpJWp4dbR8Ee3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rpttyfBRkoeto9ANn1OnpcURDB1s/8sYg6FXmdSlLhqvMkYIGDTwv1mySb1eorahgJ
         NeZNyRFfixcSAqb6rV5W2I2d9X8BSFRct9slymkACCVQpGW7EHkYlk+86pc/rkHICSDS
         Zf/RXJ0nHKmXWpATXQAXv/Hsfj6V49RJF/coc=
Received: by 10.223.106.142 with SMTP id x14mr2961394fao.21.1285816944424;
 Wed, 29 Sep 2010 20:22:24 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Wed, 29 Sep 2010 20:22:24 -0700 (PDT)
In-Reply-To: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157628>

Hi,

On Wed, Sep 29, 2010 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * en/rename-d-f (2010-09-08) 2 commits
> =C2=A0- merge-recursive: D/F conflicts where was_a_dir/file -> was_a_=
dir
> =C2=A0- t3509: Add rename + D/F conflict testcase that recursive stra=
tegy fails
>
> I am not entirely convinced this is a regression free band-aid; need =
to
> look at this a few more times.

When you rerolled pu after 1.7.3, I noticed this series missing, and
thought I should combine it with my en/merge-recursive series (which
would mean keeping the testcase patch, but the other patch morphs a
bit as it combines with one of the patches from the bigger series).
Now, I'm curious if I should have kept it separate.  Preferences?


Also, although not mentioned in this what's cooking email, I noticed
you also merged en/merge-recursive into pu.  I'll note that there a
couple regression I know of in that series, particularly in handling
of cases with o->call_depth>0.  They're pretty rare so the series
might be safe enough for pu, but I thought you should know they are
there.  In particular,

* Some of the tests break on MacOS X due to it's weird "wc"
* a combined D/F conflict at <path> when there is also a conflict of
some sort at <path>.<ext> can result in <path> not being correctly
removed and git being unable to populate <path>/*.
* Some D/F conflicts combined with criss-cross merges result in a
premature git exit with "BUG: There are unmerged index entries" when
merging merge-bases.

The first two were trivial to fix; I've got them in a reroll I'm
preparing.  The third one, if only interested about regressions
relative to master rather than making sure the merge is performed
correctly, I believe is relatively easy.  But the more general case of
solving all the o->call_depth>0 case is going to be difficult.  I've
started a separate thread about that.

Elijah
