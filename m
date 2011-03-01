From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Tue, 1 Mar 2011 18:50:52 +0700
Message-ID: <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 12:51:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuO6z-00078M-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 12:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1CALvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 06:51:25 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59022 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1CALvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 06:51:24 -0500
Received: by wyg36 with SMTP id 36so4567030wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 03:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=V+2cPeaHD+x7eEVGPrN9N7e3dae9CGfmaiO1bKYPbzw=;
        b=B+RV1V8o9QCOIWbC5fdMs3TZzmuChEcKteSXcrenDxzcHJ9PCxC+mTzt6w6e53I2EW
         z7LMUp9SLfhwTqz4CcA290xB0ob+e/Z0JKbon0Iq/XnmAQOo0PNgCHae7dNQHUhmHiUN
         0x6biJG73UIWdCPbBcxLL7s01W6w26NKN/x4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JT7cSg3MZlQzwG8JyhL96IR0d+JTCQGX3jTlMHPkm1ZZJPnr/3YYZwIzR2yxyTZPQP
         vdtM1xmNCi9iTFhzf5A3wsDfqLH/RhlPvCwM2caX69wwbhNfr74297oD+ua45bWV0WGt
         GmBuNolFNBWEIVB3Ij8QBTPKH/c31EK3cuK9g=
Received: by 10.216.163.69 with SMTP id z47mr5952012wek.43.1298980282076; Tue,
 01 Mar 2011 03:51:22 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 03:50:52 -0800 (PST)
In-Reply-To: <4D6CD593.2090705@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168212>

On Tue, Mar 1, 2011 at 6:16 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:13:
>> 2011/3/1 Michael J Gruber <git@drmicha.warpmail.net>:
>>> Introduce a leading ':' as the notation for repo-wide pathspecs.
>>>
>>> This is in line with our treeish:path notation which defaults to
>>> repowide paths.
>>>
>>> Heck: Even ':./path' works for pathspecs, and I have no clue why!
>>
>> If you are going to turn pathspecs into something more complex,
>> reserve room for future extension. I have negative pathspecs that can
>> utilize it.
>>
>> I take it, from now on people must refer file name ':foo' as './:foo'
>> with your patch?
>
> That is up for discussion, of course. When discussing a new approach for
> file mode dependent attributes, I was hoping to get through with
> symlink:path, and did not. But it was decided that something like
> :symlink:path would be good enough, in the sense of avoiding enough
> possible conflicts. That made me hope that :path would be, too.

Take me down. I'm going crazy now.

Another, less cryptic choice, is to make these special notations
separate from true pathspecs. For example, instead of ":foo" we can
say "--root foo". get_pathspec() and friends can be updated to remove
--root and rewrite the next pathspec. Extensibility is obvious.
Problems are plenty:

 - may be confused with command line options without "--" as separator
("-:" on the other hand is not, but looks weird)
 - '-' is not a reserved letter, the same as ':'
 - ...

> (I have not checked for interaction of those two, which are in flight.)
>
> I would think that file names like ":foo" are problematic on msys
> already, so in a sense they are no-no already, and free to take as
> special notation.

Back to what I'm writing above, '-' may be chosen over ':' even
without separation because UNIXers are trained that '-' is usually the
beginning of something special, I suppose most of us would go with
./-blah for file names.
-- 
Duy
