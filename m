From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Fri, 8 Apr 2011 18:39:58 +0700
Message-ID: <BANLkTimqeFxO5dSX2J3w9rBqkNALZzTWyQ@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com> <7v62qqhm9h.fsf@alter.siamese.dyndns.org>
 <BANLkTinkXVSFYqqZ+pHK0w8ij5YtPMfKEA@mail.gmail.com> <7v8vvlgblx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8A3J-00009c-9b
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 13:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab1DHLkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 07:40:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64563 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab1DHLka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 07:40:30 -0400
Received: by bwz15 with SMTP id 15so2755745bwz.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WAm3BlHnnOcPmlBk/TNrUy8yvkiuqiWuZSdh3xJFL8c=;
        b=IWNeQev7NvwEjrkgU2BEN7RjOn1/zc7YQSpBAooEVnTfQAxBk27Onza5kfkRZR+Ha/
         jKx+FLkGLx+XxwXEoMIdTrJCbXTWUiuWBdmCZhXIqJtj8BWTBxiRJUt3ebmjAvxkMaIe
         g8lX5rX8ZL4Ee9D049ykl2HDsNKoOfK6HZ7uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CLdwXcCG5XyEQTtki06YsDe/LdzDpDh6WDLOKpeGmfwrdJrOGeoqcD23Ah/cnS2gMT
         gdN1GOgqwFws4p1LUd0DH6kGtlHvHxDL/5ZXYvzWbGHCq1WxyTit1XC7CduSlKSPS+S+
         pW8plissSG3zlEXcyRKU1WkWnnv9l3zey2ntM=
Received: by 10.204.189.76 with SMTP id dd12mr1771752bkb.206.1302262829224;
 Fri, 08 Apr 2011 04:40:29 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Fri, 8 Apr 2011 04:39:58 -0700 (PDT)
In-Reply-To: <7v8vvlgblx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171122>

On Fri, Apr 8, 2011 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2011/4/7 Junio C Hamano <gitster@pobox.com>:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (('a' <=3D ch && ch <=3D 'z') ||
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ('A' <=3D ch && ch <=3D 'Z')) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&sb, "[%c%c]",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tolower(ch), toupper(ch));
>>
>> Nice try. You know you are going to pay a high performance price for
>> that, don't you ;) Maybe also worth mentioning in document that this
>> applies to ASCII charset only (as opposed to Unicode).
>
> You know this is a throw-away patch, just to illustrate that some thi=
ngs
> are doable with a hack to add more code to get_pathspec(), while othe=
rs
> would need a bigger restructuring, don't you?
>
> Besides, _if_ the user wants to do something costly, as long as the
> implementation does not harm common cases, it _still_ is better to ma=
ke
> the code do the work, no?

I was thinking of the latter rather than the former. And I agree. Just
wondering how slow it (fnmatch in general) can be compared to plain
prefix. I guess we will know soon if this patch gets in and users
start to use it.
--=20
Duy
