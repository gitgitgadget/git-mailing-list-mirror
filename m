From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Large pack causes git clone failures ... what to do?
Date: Wed, 1 Sep 2010 12:32:58 +0930
Message-ID: <AANLkTikvkuCjm2+EmGLkWkucZrqxMH8vL9TBymfRk=0e@mail.gmail.com>
References: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
	<20100831180247.GF32601@spearce.org>
	<AANLkTi=O5SbLRttzR0YwrHVEMz5gxtdTo9Z5C6V1yE1e@mail.gmail.com>
	<AANLkTik2Ms6qjQAaa_H8GGwmTG1fsk+8GR2y7ZmLviY-@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 05:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqdbP-00059K-EJ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab0IADDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 23:03:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49539 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0IADDA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 23:03:00 -0400
Received: by wyb35 with SMTP id 35so8674977wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 20:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=9h0ndcQp3ULxYgfowt55I9bbRq+fP0Omdg9720Z16o4=;
        b=A5WJs2lXru3fOFIIAKaByAfzLtsdYxWGiRRfzqPVm3NLVzEmNt6I0Aqi/7QcATqdwA
         p5VtlGa00IFY0SgOCRdr8OK5CTTR2WAfXm1M5JbMiZkEWBc6YPj3UTpxxh8d4Gw3UYUV
         dPitEJgiRzneT+9DJ9retqhvi2M5kqbvlBZG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=csKSn1zjXmzkO7fTkWzMDgQjpscOStjsgyLdBvQyi8H6xX9ZEdZGpnvcawpMZ88XPR
         OdrzusE4ElE3NF+5lj+C8UtG74CmqoqtpArUjMp3UvznmIXp1R4KU8h/zAPmfhgnJd3V
         93B3/2cK+asO7WZp4+ROifCAvQu2uE3LrHmJM=
Received: by 10.216.235.106 with SMTP id t84mr7204362weq.46.1283310178983;
 Tue, 31 Aug 2010 20:02:58 -0700 (PDT)
Received: by 10.216.164.19 with HTTP; Tue, 31 Aug 2010 20:02:58 -0700 (PDT)
In-Reply-To: <AANLkTik2Ms6qjQAaa_H8GGwmTG1fsk+8GR2y7ZmLviY-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155007>

On Wed, Sep 1, 2010 at 11:23 AM, Geoff Russell
<geoffrey.russell@gmail.com> wrote:
> On Wed, Sep 1, 2010 at 7:33 AM, Geoff Russell
> <geoffrey.russell@gmail.com> wrote:
>> Thanks Shawn,
>>
>>...
>>> You really needed to run:
>>>
>>> =A0git repack --max-pack-size=3D.. -a -d
>>>
>>> The -d flag tells it to remove the old packs once the new packs
>>> are ready, and the -a flag tells it to reconsider every object
>>> in the repository, rather than just those that are loose.
>>
>> Ok, will try.
>
> The repack failed with a "fatal: Out of memory, malloc failed", perha=
ps I
> just need to try a machine with more memory!

Ok, I rsynced the directory to a machine with 12Gb of memory and ran th=
e
repack (git version 1.7.2.2) the repack worked (and quickly) but left
a "bad" sha1 file
behind:

$ git repack --max-pack-size=3D100M -a -d
Counting objects: 517563, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (154217/154217), done.
Writing objects: 100% (517563/517563), done.
Total 517563 (delta 353081), reused 465715 (delta 335261)
Removing duplicate objects: 100% (256/256), done.

$ git fsck
bad sha1 file: ./objects/5b/.fd25f132c21493b661978fc9362f673ea6e58b.cwx=
zjT
dangling commit c7a4ecaa1732869f9bfa21d948cb8714fd303713

I removed the bad file on the presumption that it was a working file
and reran the fsck and all looked okay.

Cheers,
Geoff.
