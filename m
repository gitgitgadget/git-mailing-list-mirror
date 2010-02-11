From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH 1/4] Add base64 encoder and decoder
Date: Thu, 11 Feb 2010 23:37:37 +0900
Message-ID: <4B741631.40203@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>	 <1265717345-2118-2-git-send-email-mitake@dcl.info.waseda.ac.jp> <40aa078e1002090645s63449057hf88c89a232933680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, gitster@pobox.com,
	git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>, peff@peff.net
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 11 15:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaAs-0007PQ-IR
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab0BKOhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:37:41 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64020 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab0BKOhk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:37:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 40FECEAF5A8;
	Thu, 11 Feb 2010 23:37:39 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RpjCPG1Wh4A2; Thu, 11 Feb 2010 23:37:38 +0900 (JST)
Received: from [192.168.11.2] (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 1AD69EAF5A4;
	Thu, 11 Feb 2010 23:37:38 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <40aa078e1002090645s63449057hf88c89a232933680@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139591>

(2010=E5=B9=B402=E6=9C=8809=E6=97=A5 23:45), Erik Faye-Lund wrote:
> On Tue, Feb 9, 2010 at 1:09 PM, Hitoshi Mitake
> <mitake@dcl.info.waseda.ac.jp>  wrote:
>> +void base64_encode(char *out, const char *in, int inlen)
>> +{
>> +       const char *inp =3D in;
>> +       char *outp =3D out;
>
> ...Why? It's copying the pointers to pointers of identical type with
> different names, and never using the originals again... Looks like a
> sloppy extraction from another code-base to me.
>
>> +
>> +       while (inlen>=3D 3) {
>> +               *outp++ =3D base64char[(inp[0]>>  2)&  0x3f];
>> +               *outp++ =3D base64char[((inp[0]&  0x03)<<  4) |
>> +                                    ((inp[1]>>  4)&  0x0f)];
>> +               *outp++ =3D base64char[((inp[1]&  0x0f)<<  2) |
>> +                                    ((inp[2]>>  6)&  0x03)];
>> +               *outp++ =3D base64char[inp[2]&  0x3f];
>> +
>> +               inp +=3D 3;
>> +               inlen -=3D 3;
>> +       }
>> +
>> +       if (inlen>  0) {
>> +               *outp++ =3D base64char[(inp[0]>>  2)&  0x3f];
>> +               if (inlen =3D=3D 1) {
>> +                       *outp++ =3D base64char[(inp[0]&  0x03)<<  4]=
;
>> +                       *outp++ =3D '=3D';
>> +               } else {
>> +                       *outp++ =3D base64char[((inp[0]&  0x03)<<  4=
) |
>> +                                            ((inp[1]>>  4)&  0x0f)]=
;
>> +                       *outp++ =3D base64char[((inp[1]&  0x0f)<<  2=
)];
>> +               }
>> +               *outp++ =3D '=3D';
>> +       }
>> +
>> +       *outp =3D '\0';
>> +}
>
> If inlen is 0, a single '=3D' should be emitted (plus the obvious zer=
o
> termination). It could be that the code deals with that by making sur=
e
> that inlen never is zero, though.
>


Thanks for your review, I was careless...

I decided to use base64 and md5 stuffs OpenSSL provides.
I'll remove 1 and 2 of my patch series.

Thanks,
