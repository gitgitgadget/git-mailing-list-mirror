From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Method invokes inefficient new String(String) 
	constructor
Date: Thu, 9 Jul 2009 10:47:27 +0200
Message-ID: <551f769b0907090147x9b78604i77a095441f232703@mail.gmail.com>
References: <49C20D4E.5020203@gmail.com> <20090319160102.GQ23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpI0-0003h6-Ob
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZGIIrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2009 04:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZGIIra
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:47:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64312 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZGIIr3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:47:29 -0400
Received: by fxm18 with SMTP id 18so709fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MKZMucF0cPOCXFSR97ncRCMglsluHDT+PgGCrcYS14k=;
        b=tRFHur1BTdDEEVbQxxOg0VVmRa6f/EWdM+tGLZhkKtdFOr92kSUKwpI8HVRYFyD+/u
         dN8mDWF+FbVK5/RmCq4nndVZSEiIA2z97reyG/WFwtMVYNpQiAFQ/ruQlkRpQbWNp37g
         C9QcQp7j/s5O4bS9unyGufOnhmt6vFdN6LaTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m2kHkEXZE5S6cP9atPMXlAXD9orq1hSxDLqq7tTfDM4Gtv8f7kcdf+G8jtIM4+1ygA
         Gyq1Z1Qwyc/gDMm9TuNgPHsWQB7/ocuT9h7DN30Xw4avNd6HlbcYjyMOdhjz1D+xgYhC
         uTTMaXDXAd8WCoPTxUabzMcHXiWB+MtEFVzdU=
Received: by 10.223.111.211 with SMTP id t19mr137211fap.64.1247129247663; Thu, 
	09 Jul 2009 01:47:27 -0700 (PDT)
In-Reply-To: <20090319160102.GQ23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122948>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> Yann Simon <yann.simon.fr@gmail.com> wrote:
>> From FindBugs:
>> Using the java.lang.String(String) constructor wastes memory because
>> the object so constructed will be functionally indistinguishable fro=
m
>> the String passed as a parameter. Just use the argument String direc=
tly.
>>
>> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
>> ---
>> =C2=A0.../src/org/spearce/jgit/lib/RefDatabase.java =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
>> index 87f26bf..49da538 100644
>> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
>> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
>> @@ -447,7 +447,7 @@ private synchronized void refreshPackedRefs() {
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 final i=
nt sp =3D p.indexOf(' ');
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 final O=
bjectId id =3D ObjectId.fromString(p.substring(0, sp));
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 final Strin=
g name =3D new String(p.substring(sp + 1));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 final Strin=
g name =3D p.substring(sp + 1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last =3D=
 new Ref(Ref.Storage.PACKED, name, name, id);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newPack=
edRefs.put(last.getName(), last);
>
> I had a specific reason for forcing a new String object here.
>
> The line in question, p, is from the packed-refs file and
> contains the entire SHA-1 in hex form at the beginning of it.
> We've converted that into binary as an ObjectId, it uses 1/4 the
> space of the string portion.
>
> The Ref object, its ObjectId, and its name string, are going to be
> cached in a Map, probably long-term. =C2=A0We're better off shedding =
the
> 80 bytes of memory used to hold the hex SHA-1 then risk substring()
> deciding its "faster" to reuse the char[] then to make a copy of it.

However, using the trick newString =3D new String(aString.substring(),
i) does not work on all JVM.
With an IBM JVM, the newString will still contain the original array of=
 chars.

Another solution that work on all JVM could be:
newString =3D new String(aString.substring(i).toCharArray())
Or
newString =3D new String(aString.toCharArray(), i, aString.length() - i=
)

I like the latter one.

Yann
