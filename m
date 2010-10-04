From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 16:03:05 +0200
Message-ID: <AANLkTikgLzczp1Gkmcg2v35oE2bKxBtxY389Z76FJDRz@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com>
 <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
 <201010032019.09244.j6t@kdbg.org> <20101004074916.GK24884@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Thomas Adam <thomas@xteddy.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 16:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ldg-00074H-1k
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab0JDODa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 10:03:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49783 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0JDOD3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 10:03:29 -0400
Received: by ewy23 with SMTP id 23so1830845ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=7ZO0HB7h8yVTq2hgzkWccoX4OoGVq1AHXJV/sKFsl1E=;
        b=xbKBDAFc0kdLH3tdBzpO7//NHAzExwcM+TwRDMvIPCBZQyGqJIsGD2YFbNKYrv4dH6
         mb3yZ+mXhtb3f+7Js6pYTrYlf5pX6izlslhHi2pzyuUIj1s2UtFSWE38mqGgI88CG6qP
         vNBcjU76XAcmNRmOT/KJBF93RgidAZnn0TooE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=vAl4HH7kxxK5iGfvHrt/NgZqYo2+kjUHXaXJB/LtNRUxQpwXBpA4VSxcQ07wwoncAa
         /ieKlIlFKEaBR/6Da+l8smVUQpNzJ/OSRYuS3MRefBw9fYEneZpJCkQaUgkIjnGih32G
         HlUcCLprwQaNfJoJiqQH37P5VQ5K3uD1GJtjc=
Received: by 10.239.183.212 with SMTP id v20mr902644hbg.25.1286201007853; Mon,
 04 Oct 2010 07:03:27 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Mon, 4 Oct 2010 07:03:05 -0700 (PDT)
In-Reply-To: <20101004074916.GK24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158052>

On Mon, Oct 4, 2010 at 9:49 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Johannes Sixt wrote:
>> On Sonntag, 3. Oktober 2010, Thomas Adam wrote:
>
>>> It's a real shame about the code duplication here. =A0Can we not av=
oid
>>> it just by doing:
>>>
>>> unsigned char c1 =3D (ignore_case) ? tolower(*match) : *match;
>>> unisgned char c2 =3D (ignore_case) ? tolower(*name) : *name;
>>>
>>> I appreciate that to some it might look like perl golf, but...
>>
>> It has been discussed, and IIRC, the concensus was to keep the code
>> duplication because this is an inner loop.
>
> Did anyone time it? =A0If it really is not dwarfed by other computati=
on,
> then how about (warning: ugly!)
>

I believe it was timed. I was the one who reacted on this the first
time around, and I seem to remember that the performance impact was
indeed significant. This function is used all the time when updating
the index etc IIRC.
