From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 02/19] Allow fetch to modify refs
Date: Fri, 30 Oct 2009 05:22:18 -0700
Message-ID: <fabb9a1e0910300522je3d76aep160d87fe302f8779@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-3-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300151450.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3qVx-0004on-6E
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbZJ3MWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 08:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbZJ3MWh
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:22:37 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:36370 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbZJ3MWg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 08:22:36 -0400
Received: by ewy28 with SMTP id 28so2925235ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/MTMl12TJPNS8gvmHkYnvqsfHltDck9m8U5QyqbOpJg=;
        b=wqXNyGWneYOS2wXerDJ/CCVVrBWJxytaE3C6Sv3JohJKc+kpO8qSD0oR1ngiU0sufi
         wsr1IB95ji4+3zmWGTmiZ5tT3vsAYUvZ4i/RScKhORGPbNmNgCQwBM/fho+mBeLdhTEt
         18QCxknbB4RuZhEncC+fCTwUrWr9/Hd13VqZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J/1rs/cgc9tQWwMUeRQHjGu4OAHRkXfhuZ5f9qtvflDwqRgJABofWg7J48hcStHvVz
         2nC+26udsLFpZHzsRzXW355iZ6n1KwnJt+YE1LiNnvLYy24RrD0YxqncrrtUoACKEs88
         FgpwFcX7/mdvjlHv7I1N+f5ohFt48qzfqfeV4=
Received: by 10.216.93.12 with SMTP id k12mr517349wef.195.1256905358168; Fri, 
	30 Oct 2009 05:22:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910300151450.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131697>

Heya,

On Thu, Oct 29, 2009 at 22:56, Daniel Barkalow <barkalow@iabervon.org> =
wrote:
>> +++ b/builtin-clone.c
>> @@ -526,8 +526,9 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 refs =3D transport_get_remote_refs(trans=
port);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (refs) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapped_refs =3D wanted_pee=
r_refs(refs, refspec);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transport_fetch_refs(trans=
port, mapped_refs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *ref_cpy =3D wa=
nted_peer_refs(refs, refspec);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapped_refs =3D ref_cpy;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transport_fetch_refs(trans=
port, ref_cpy);
>
> Just drop this hunk; the change doesn't actually do anything. Otherwi=
se,
> the patch matches what I have.

Am I missing something? I thought we need this hunk since mapped_refs
is const, and transport_fetch_refs takes a non-const argument?

builtin-clone.c: In function =91cmd_clone=92:
builtin-clone.c:531: warning: passing argument 2 of
=91transport_fetch_refs=92 discards qualifiers from pointer target type

--=20
Cheers,

Sverre Rabbelier
