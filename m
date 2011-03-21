From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: git status reads too many files
Date: Mon, 21 Mar 2011 21:39:32 +0100
Message-ID: <AANLkTikPL7Dx5AphGnd1TVAyLNgNh2WVd__Yom134VXb@mail.gmail.com>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
	<7vipvcs9xt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lt5-00081y-CU
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab1CUUjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 16:39:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33312 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188Ab1CUUjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 16:39:33 -0400
Received: by bwz15 with SMTP id 15so5347976bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rY4AXFqGbLaHEGeHibJ5mRNsrRbe+fmPm0yms6hW5Rc=;
        b=obmMu3cp/auCh7RgF37xnX0k6GrEZzjU9dBY+L3GOOxiEsEVFrVRnv6t6I1bB3vGdv
         QQYNX9w1JWxkyAxTHw5tZFT8YusBOJRtN11/Et/0CwHWw2SGw3cPn/6HXl6/ccWC46Gz
         VHPsutCWNT1KY442xpXzY0bqNNJMiDYN2v0Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kBByHGTjkRtSwTLuuuf/nxiK3Czf5SFLsgfu+QP3oCQQhojXSS2uVFxXrp2kYn77wV
         jAuRqTUUE2899PkWfq4xZj218a+JcE5rI27YstemgY4W7Vux+NKLo5MYLcMbwu70xl4w
         rl2GM5p0zyVChsNGvKRQnX7MTAiRatUYmKyzk=
Received: by 10.204.80.29 with SMTP id r29mr4130554bkk.195.1300739972514; Mon,
 21 Mar 2011 13:39:32 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Mon, 21 Mar 2011 13:39:32 -0700 (PDT)
In-Reply-To: <7vipvcs9xt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169666>

On 21 March 2011 17:41, Junio C Hamano <gitster@pobox.com> wrote:
> Lasse Makholm <lasse.makholm@gmail.com> writes:
>
>> This persistent across multiple runs of git status:
>>
>> $ strace -o /tmp/trace2 git status
>> # On branch there
>> nothing to commit (working directory clean)
>> $ grep ^open /tmp/trace2 | wc -l
>> 414
>> $
>>
>> ...until the index is touched:
>>
>> $ touch .git/index
>
> Don't do this; you are breaking the racy-git protection.

Yeah, I know, I was just proving a point... git reset (--hard?) HEAD
would achieve the same thing...

> I think we opportunistically update the .git/index file in "git statu=
s" to
> refresh the stat bits (but we don't error out when we cannot write a =
new
> index, as you may be only browsing somebody else's repository with on=
ly a
> read access to it). =A0It probably should be just the matter of addin=
g a bit
> of logic to notice that your index is racily clean.

I figured as much... My original thought of checkout ensuring an index
newer than any working file is stupid, of course, for a multitude of
reasons -- one of which is that the "next" timestamp may be a full 2
seconds away...

> Let me cook something real quick.

Sweet, thanks...

--=20
/Lasse
