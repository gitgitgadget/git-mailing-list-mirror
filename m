From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv5 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Sun, 3 Oct 2010 13:41:33 -0600
Message-ID: <AANLkTi=9-rVwPN0aMg5cdhtV9yYnXCgPV4deAe3ke3At@mail.gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
	<1286082644-31595-17-git-send-email-newren@gmail.com>
	<20101003145122.GF17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 21:41:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2URJ-00082V-D8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab0JCTlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:41:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab0JCTle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 15:41:34 -0400
Received: by fxm14 with SMTP id 14so1394672fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EleXFN9G0vadwnDQM0aNlhArFXfeQvaEpFZf6HGyS98=;
        b=Ul9wptxglfGgai9heDnXkBVliW6BT6FLWpS/7J2/hEVCFUA5TjcMiXDwIU+tkCxULs
         r8NKGN76yxxDeN8JsT9Gi9Q3JDsF3IfyuWmqRJnJ3YxqGRyxWKjMfD747PswTUNT+E8U
         XsjOl4as6Q+p/zaML+bN0k/o07088gIrQBFQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cEZERY/m46DNNfW2L0R3Szvm0hTFQRQBq98u/5EKmKmmesjqcCafR6f4dZYbsJKghH
         JttGmnqDODys3k4HiKjWmTn/EbO9R7sERLihjZ8g25IRlzjCHJMDSXLIlh3Q7fEV3lLK
         MCFL8tlA4ZOdR4mq/P5zbh7MaXQroPtbF7QIU=
Received: by 10.223.118.199 with SMTP id w7mr1378251faq.81.1286134893153; Sun,
 03 Oct 2010 12:41:33 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sun, 3 Oct 2010 12:41:33 -0700 (PDT)
In-Reply-To: <20101003145122.GF17084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157898>

On Sun, Oct 3, 2010 at 8:51 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> I think this should read
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0portable_unset () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unset "$@"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> (or || true). =C2=A0That is, if I try
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0portable_unset "foo bar"
>
> then on platforms where an envvar named "foo bar" is allowed,
> this should unset it, no?
>
> Also, maybe a comment could guide people in using this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# In some bourne shell implementations, th=
e "unset" builtin
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# returns nonzero status when a variable t=
o be unset was not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# set in the first place.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Use portable_unset when that should not =
be considered an
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# error.
>
> An update to t/README would be nice, too. :)

Yes, all the above sounds good, as does your other changes on this
series that I didn't yet comment on; I made the relevant changes for
all these comments.  Thanks!
