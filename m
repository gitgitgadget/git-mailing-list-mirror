X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 21:56:44 +0100
Message-ID: <200612042156.44963.jnareb@gmail.com>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 20:54:56 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kitZE4L7DwxRZKXtjdp+JaJvst94H0Iz2kVCxCTWfWuYC7C5QzwQWZaJjXJH4OtxKn4Eqp61rDD2zVe0ZCsWdIkgxRgFvyP83IJ5XzKs6HwhLIA6hJCjRK5Q4XDYXVLGRgXKvIwmzD51U0spJj4LSeU8C9Jq7Zv4HuLmJCyO30A=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33248>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKpw-0003za-TK for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937187AbWLDUyu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937383AbWLDUyu
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:54:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:9645 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937187AbWLDUyt (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 15:54:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3120985uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 12:54:46 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr12603299ugm.1165265685878; Mon,
 04 Dec 2006 12:54:45 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 54sm30670090ugp.2006.12.04.12.54.45; Mon, 04 Dec
 2006 12:54:45 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Dnia poniedzia=B3ek 4. grudnia 2006 21:26, Linus Torvalds napisa=B3:
=20
>>>> On Mon, 4 Dec 2006, Jakub Narebski wrote:
>>>>=20
>>>>> [...] git should acquire core.filesystemEncoding configuration va=
riable=20
>>>>> which would encode from filesystem encoding used in working direc=
tory=20
>>>>> and perhaps index to UTF-8 encoding used in repository (in tree o=
bjects)=20
>>>>> and perhaps index.

> You guys are ignoring the _real_ problem.=20
>=20
> It has nothing at all to do with dependencies on external packages. T=
he=20
> REAL problem is that if you do locale-dependent trees and other git=20
> objects, git will STOP WORKING.
>=20
> A filename in a tree object _has_ to be see as a pure 8-bit character=
=20
> stream. They _have_ to be compared with "memcmp()", and they have to =
sort=20
> the same way and mean EXACTLY the same thing for everybody.

What I propose is having filename in tree object UTF-8 encoded. I don't
know if git relies heavily that filename encoding on filesystem (in wor=
king
area) is the same as in the index, is the same as in a tree object.
=20
Although I'm not sure what is the problem. You checkout non US-ASCII fi=
lename
out of git; the file can have strange characters in a name, but should
encode to the filename as is in git. The problem migh be some forbidden=
 by
filesystem characters in a filename perhaps.=20

Although Wolfgang Fischer wrote (to me and Johannes Schindelin) that HF=
S+
uses UTF8-NFC (Normalization-Form-Composed) when creating a file, while
readdir returns encoding used by HFS+, which is UTF8-NFD (Normalization=
-Form-
Decomposed). [Explitive censored]

> If a filesystem cannot represent that name AS THAT BYTE SEQUENCE then=
 the=20
> filesystem is broken. No ifs, buts, maybes about it. I'm sorry, but t=
hat's=20
> how it is.

We have some configuration variables to work around broken filesystems,
like core.ignoreStat, so why not core.filesystemEncoding.

--=20
Jakub Narebski
