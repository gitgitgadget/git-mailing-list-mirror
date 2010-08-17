From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 19/24] merge script: handle -m --log correctly
Date: Tue, 17 Aug 2010 17:55:22 +0800
Message-ID: <AANLkTimrrfVsP=yduEmstuhm=Y-Km=HmoYgAvRkmQf91@mail.gmail.com>
References: <20100817065147.GA18293@burratino>
	<20100817070656.GS22057@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 11:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlItH-0007H1-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab0HQJzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:55:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39979 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0HQJzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 05:55:22 -0400
Received: by pzk26 with SMTP id 26so2282496pzk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Afg5fV0ojN/YogINo6fOYUcZzOebGE/0RRS9BvndZ8A=;
        b=Y6jTFlAwxA4sB9wnMjxbOqKLk+qBt2KaKSCsGrXEf4+PS7aV9PaFBiTYzMsiK0Nfh+
         Ma9Q+dTBK8pRzaKl1GBTEw7T3JxYmwYv2bfiVV/8BLeItYfU0NzRdYCeZCiiaLv8uYaA
         HcA+OT1ffy92e/nCzAGKPhgsfC7cMd2U+lI48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NC8TyfoAeQdpc0IUZrV/11ws/z9LMw46oV/tLqVZ9jlw8cdxQ2/hKSTVUla0supkLy
         nw4knW1Bp++i2roNAjxYH/RU08oxCCl+pGU5QLbpqhblI3YkkMR1WI6D7D98BDNgJ3p/
         HuSn7lHdK2FoC57zrOfz/YRrjXMROtBWtQrFQ=
Received: by 10.142.140.19 with SMTP id n19mr5591319wfd.271.1282038922497;
 Tue, 17 Aug 2010 02:55:22 -0700 (PDT)
Received: by 10.142.226.8 with HTTP; Tue, 17 Aug 2010 02:55:22 -0700 (PDT)
In-Reply-To: <20100817070656.GS22057@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153743>

On Tue, Aug 17, 2010 at 3:06 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Based on v1.7.1.1~23^2 (merge: --log appends shortlog to message if
> specified, 2010-05-11). =A0Without this change, the scripted
> (non-builtin) merge does not pass t7604.
>
> Cc: Tay Ray Chuan <rctay89@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the heads up.

> diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-mer=
ge.sh
> index bab3da9..91e33a3 100755
> --- a/contrib/examples/git-merge.sh
> +++ b/contrib/examples/git-merge.sh
> @@ -294,12 +294,18 @@ else
> =A0 =A0 =A0 =A0# the given message. =A0If remote is invalid we will d=
ie
> =A0 =A0 =A0 =A0# later in the common codepath so we discard the error
> =A0 =A0 =A0 =A0# in this loop.
> - =A0 =A0 =A0 merge_name=3D$(for remote
> + =A0 =A0 =A0 merge_msg=3D"$(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for remote
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0merge_name "$remote"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 done | git fmt-merge-msg $log_arg
> - =A0 =A0 =A0 )
> - =A0 =A0 =A0 merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 done |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test "$have_message" =3D t
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git fmt-merge-msg -m "$=
merge_msg" $log_arg

hmm, when did git-fmt-merge-msg learn -m? Mine (1.7.2.1.219.gf2a27) doe=
sn't.

--=20
Cheers,
Ray Chuan
