From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v2 1/4] Prevent diff machinery from examining 
	assume-unchanged entries on worktree
Date: Tue, 11 Aug 2009 08:34:11 +0700
Message-ID: <fcaeb9bf0908101834n7cc7cfaakbf2d92fe8f32e9b1@mail.gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-2-git-send-email-pclouds@gmail.com> <alpine.DEB.1.00.0908101800480.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MagG8-0001ea-3v
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 03:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZHKBeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZHKBeb
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 21:34:31 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:5845 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZHKBea convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 21:34:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so3755498and.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vRCOcDb2jhyoNwLFxBie2gD9cuwpfnMaHwRSD8cjukY=;
        b=il74A11Ty+XNkNo+HVh2yPQi/kfBU8jVmH71uE8RAQcDW/oFpewGY//QCcrC4DoCkf
         m7ScFMrQRw4e48gCxXIKXm2+J0VI4rk+2s1/9QCm47jq41KfTxWvYCbRqtvi4YCdx3pj
         P698s5c6QFPgzH86cdOcVbwMubC9F+J2yFHrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jiK3L6GpM/lnGrBv6xl4+hI8QWFceFYIUFQ53qvfzrIgakr5XiFaC9XvsvkVMOelyH
         r9PN+Iyib/hI6iQwDAdBkz6jxdCE73t68fqPuQKxnwTUCWDZuFblbahBjZmuitdN4Vcj
         ot2RL01AVfqg7QlO2Z8EXOZBGEsMX5+i6hP8Q=
Received: by 10.100.252.9 with SMTP id z9mr4568422anh.34.1249954471132; Mon, 
	10 Aug 2009 18:34:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908101800480.8324@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125508>

2009/8/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> +test_expect_success 'setup' '
>> + =C2=A0 =C2=A0 echo zero > zero &&
>> + =C2=A0 =C2=A0 git add zero &&
>> + =C2=A0 =C2=A0 git commit -m zero &&
>> + =C2=A0 =C2=A0 echo one > one &&
>> + =C2=A0 =C2=A0 echo two > two &&
>> + =C2=A0 =C2=A0 git add one two &&
>> + =C2=A0 =C2=A0 git commit -m onetwo &&
>> + =C2=A0 =C2=A0 git update-index --assume-unchanged one &&
>> + =C2=A0 =C2=A0 echo borked >> one &&
>> + =C2=A0 =C2=A0 test "$(git ls-files -v one)" =3D "h one"
>> +'
>
> Maybe use test_commit, to make it more readable?

Thanks. I did not know that (or forgot already). Will use it.

>
>> +
>> +test_expect_success 'diff-index does not examine assume-unchanged e=
ntries' '
>> + =C2=A0 =C2=A0 git diff-index HEAD^ -- one | grep -q 5626abf0f72e58=
d7a153368ba57db4c673c0e171
>> +'
>> +
>> +# TODO ced_uptodate()
>
> What is this about?

It tests "if (ce_uptodate(ce) || (ce->ce_flags & CE_VALID))" and I was
pretty sure it hit ce_uptodate() first, so the second expression was
not tested.
--=20
Duy
