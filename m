From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed, 1 Dec 2010 21:44:42 +0100
Message-ID: <AANLkTinLuF74UKaTMNX84FJt+PNoKkkOr3LaXDSCFqdz@mail.gmail.com>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
	<20101201194441.GB27347@burratino>
	<7vaakputxs.fsf@alter.siamese.dyndns.org>
	<20101201203132.GB27845@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 21:44:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtXm-0007EZ-Al
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab0LAUoo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 15:44:44 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43504 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0LAUoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 15:44:44 -0500
Received: by ewy5 with SMTP id 5so3857758ewy.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 12:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r/YawMkPLgphJBuAbiRLRdOBuke0ULAJF2Z1aqLdzm8=;
        b=wd9i+jS93lKrtVdHaMcUNutV8H0d12u5uIya9Yttb9a0EK/+C4Cw/L2cM+4yOE7ZNc
         JMRXHF/Ou67hwJ9vJnVRAPsVS7aTy0xGBRYVgohPynVQBR7nVU3m2mZCvC4cH/7M05h+
         n05cwyc52/HUERKcJ/OoFG0/9iHodh8ovBNS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yFopAcf/EpYpqJXd0iURxpvmO+bpRFM1PC10HlJiX0HhNCce44IbyHqaS/MhiNeNvb
         eYN4XW/7tk0szE20Fn8szIBmh5oLhEQ/jOc/Q4/vlsrl6iTQ2wQUcltGCURmcedeW2WY
         hZybo95uTe6vEfRZm2ZAWD9EZw6psyq4iTWis=
Received: by 10.213.8.65 with SMTP id g1mr6051136ebg.49.1291236282655; Wed, 01
 Dec 2010 12:44:42 -0800 (PST)
Received: by 10.213.9.83 with HTTP; Wed, 1 Dec 2010 12:44:42 -0800 (PST)
In-Reply-To: <20101201203132.GB27845@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162606>

> If "--show-c-function" output is the problem, perhaps we should know =
a bit
> better about what C function header looks like?

In fact the "--show-c-function" output is the problem. But I think that
a change can't be rejected because of another issue.
The style of placing "goto"-statements, which leave a function to the
end of that is used in many other projects. And I think
it's very usefull.

2010/12/1 Jonathan Nieder <jrnieder@gmail.com>:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> A space before the "bad_graft_data:" label would improve future
>>> diff --show-c-function output.
>>
>> Hmm, I actually do not think we encourage that (nor we should).
>>
>> =C2=A0 =C2=A0 $ git grep -e '^ [a-z0-9]*:' -- '*.c' | wc -l
>> =C2=A0 =C2=A0 23
>> =C2=A0 =C2=A0 $ git grep -e '^[a-z0-9]*:' -- '*.c' | wc -l
>> =C2=A0 =C2=A0 42
>>
>> If "--show-c-function" output is the problem, perhaps we should know=
 a bit
>> better about what C function header looks like?
>
> Thanks for checking. =C2=A0Yes, I think so.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git grep --show-function strbuf_release =
-- http.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http.c=3Dstatic int http_request(const cha=
r *url, void *result, int target, int options)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http.c: strbuf_release(&buf);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http.c=3Dcleanup:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http.c: strbuf_release(&tmpfile);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http.c=3Dint http_fetch_ref(const char *ba=
se, struct ref *ref)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http.c: strbuf_release(&buffer);
>
> The following gives me some joy.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/.gitattributes b/.gitattributes
> index 5e98806..5888a53 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,3 +1,4 @@
> =C2=A0* whitespace=3D!indent,trail,space
> =C2=A0*.[ch] whitespace=3Dindent,trail,space
> +*.[ch] diff=3Dcpp
> =C2=A0*.sh whitespace=3Dindent,trail,space
>
