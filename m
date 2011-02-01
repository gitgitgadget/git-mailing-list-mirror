From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 22:52:34 +0700
Message-ID: <AANLkTinJVa++tttPDav1g1+w128fWsouM=+gf14eUOOK@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 16:53:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkIXf-00034Q-LR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 16:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1BAPxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 10:53:08 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53683 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab1BAPxG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 10:53:06 -0500
Received: by wyb28 with SMTP id 28so6823906wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=9Or7+Uc14Ib9nracIX/sDFmfzaMN+clyvbZlArlPGTQ=;
        b=anToQMRSuHJUeUHWcb7haPg+vslavxFtyf9Zr1ZE8m3FHsKVCMrEdaZ0ZpJw6PfT8N
         yYXMW7IIqIbet6fsmw96KRRw1qfzctDoGbakWwcIGZRmeGOd9uoHBRS2PFny5nmBeoK1
         ZQcxgdm27TnUGtLedTt9dXM02HeVGR/vNzKT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DSIEKMirbkcXnNzTuZbMmIFCRSx9mV+GXH/OmHYE/bSzQKH9hx9dOrS/txjKImzM9m
         AOOR0PVHKHqxla9qEhil0xsCbe7b1kW6+bWGU7gfo1JhKjE+HQiaT/XeeJvcqYNFJEWc
         /ylC3KeO/NhW50s8PjDRnzm7OFKCK9l0WR0ww=
Received: by 10.216.169.71 with SMTP id m49mr7616955wel.4.1296575585039; Tue,
 01 Feb 2011 07:53:05 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 07:52:34 -0800 (PST)
In-Reply-To: <201102011451.17456.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165819>

On Tue, Feb 1, 2011 at 8:51 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Sun, 30 Jan 2011, Jonathan Nieder wrote:
>> > support for tracking empty directories
>>
>> Tricky to get the UI right. =C2=A0I am interested in and would be gl=
ad to
>> help with this one.
>
> Also one needs to remember that this would require adding extension
> to git index, because currently it tracks only files, and not
> directories. =C2=A0Explicitly tracking directories in the index could=
 be
> useful for other purposes...
>
> The major difficulty of this is IMHO not the UI, but tracking all tho=
se
> tricky corner cases (like directory/file conflict, etc.).

Sort order in index is quite special/strange and must be handled
correctly when dirs and files are mixed. There are already special
directories in index: the submodules. Current git code treats
S_ISDIR() and S_ISGITLINK() the same in ce_to_dtype() and some more
places. You need to decouple it somehow.

I tried this (for another purpose) and pulled back. I recall Shawn had
a tree-based index implementation, don't know if he still has it.
Could be a good point to start adding dirs to index.

Actually tree-based index with dictionary (something like trees in
packv4) is a good feature itself. It could shrink index size down a
lot. index is frequently read/written so small index helps (webkit's
index is 16M, 4M after gzipped).
--=20
Duy
