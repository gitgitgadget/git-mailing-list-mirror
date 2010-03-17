From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 13:13:47 -0500
Message-ID: <20100317181347.GA26376@progeny.tock>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com>
 <1268768556-32176-1-git-send-email-marcnarc@xiplink.com>
 <20100316214717.GA24880@progeny.tock>
 <4BA0FBC7.3080305@xiplink.com>
 <20100317175320.GA26124@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrxkG-0000UP-5c
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab0CQSNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 14:13:23 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:40272 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab0CQSNW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 14:13:22 -0400
Received: by pzk38 with SMTP id 38so1071360pzk.33
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=t4gGta/zzZJ3rRcuvAqF1QekiKwDgdaGseXc4a+Fkzc=;
        b=blfigwJBRdjOBg+k8IzQ0BYgPSrQFVqrsgoI/WQlWkMaewMuxvyo/FR4AZGXPLMWXx
         ALJO7QegPF0LZivDoL9nX8a8ve+H+CSjeKegvMAYcLtbDSuMaNYg/x1Tv4QStsX6GZhH
         xr8oWUGAMwEfVPtREPqW09mnos/KpZ/aE20j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=j7srLs9bk3c66yOH/vO4c5wmU5LbY263QAs+QpQH3t/r7gCSSSnsHI3YLHPe3+z4n8
         q5WqzVk6uG140FfStId3nKXHeesNtGZSrD8JnMkDWc0PwH+wythGXyrpE/VQUSLLlb3d
         hiNNmYOnhKu103yVBvjZSuUdEsrBZ5Yj2/sN0=
Received: by 10.141.91.10 with SMTP id t10mr1280990rvl.127.1268849601816;
        Wed, 17 Mar 2010 11:13:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6566320iwn.11.2010.03.17.11.13.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 11:13:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317175320.GA26124@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142423>

Hi again,

Sorry to keep talking to myself here...

Jonathan Nieder wrote:

> To take advantage of the changes from F, someone merges topic2 into
> topic and builds on it:
>=20
>                     .. X --- Y [topic]
>                    /  /
>    B' --- C' --- D'  F [topic2]
>   /                 /
>  A -- ... -- M --- E ... --- U [master]
>=20
> Now someone decides it is time to merge topic into master.  The
> merge-base for Y and U is E, and the result is a that the changes fro=
m
> topic are reverted.

Almost certainly bad.

> What I had missed: it would be just as dangerous to simply merge topi=
c2
> directly.  Merging =E2=80=98master=E2=80=99 into =E2=80=98topic=E2=80=
=99 does nothing to prevent that.

Might be bad, might not, depending on what topic2 is about.

> The new advice: when using rebase --no-ff this way, be sure to rewrit=
e
> _every_ branch that includes those commits but doesn=E2=80=99t includ=
e U.

Or rather: rewrite every branch that you want to make supersede U.

Surprisingly tricky.

I prefer the =E2=80=9Crevert the faulty revert=E2=80=9D technique becau=
se it is more
transparent.  If it is only possible to re-merge now because of
developments that occured in topic, a simple revert would create a
non-bisectable history, but Johannes=E2=80=99s trick (or the uglier met=
hod I
described before) should work.

 git checkout master
 : >> .git/info/grafts
 cp .git/info/grafts .git/info/saved-grafts
 echo $(git rev-parse M M^) >> .git/info/grafts
 git merge topic;	# being sure to mention M in the commit message!
 mv .git/info/saved-grafts .git/info/grafts

Jonathan
