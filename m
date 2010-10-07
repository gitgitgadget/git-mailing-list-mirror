From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Thu, 7 Oct 2010 03:28:08 -0500
Message-ID: <20101007082808.GC10523@burratino>
References: <1286431561-24126-1-git-send-email-david.barr@cordelta.com>
 <AANLkTim_3m=YmyVL7eEoWDGwDwmuDJsYkQMgx8ciVPH0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 10:31:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3lst-0006QR-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 10:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760172Ab0JGIbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 04:31:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39938 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab0JGIbS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 04:31:18 -0400
Received: by gwj17 with SMTP id 17so182918gwj.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=P4A7uWrr0a65oUiGatOjE1CJEWRqisZZsT5+kgEJVH8=;
        b=a3o6v3vzsCeGeVTEFyA09HeUOtNBm3ys3D78tls4sjf2h/Fq1TE0DCplbNVplxrCzV
         6XsvaYUJgQMDv22WaWh9BTA1pPMhX70jz5R4PjAED71i+AOBZDHd6rAIeV8u4cKu5hAd
         dZWIjNabYsIankmg/xkdcEhYxIBKq5PfISiEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=S2yCSzCENRKTJpxvrLnjzF3J2L5b9Fga/DFWhhCHN4igtT4BWDNjHWBTUIHdijsfdV
         cKI+z/eek+Uq3Z6M5+1FZdNjmKy5ZIJJ5q//P/qKr9Ly7ML9Ey3S2tr1s0z6VO5vz1Qz
         HKJzJpzNm6LFQ5kVm5n/sPImKL97ttpG0BKFE=
Received: by 10.151.13.7 with SMTP id q7mr582306ybi.435.1286440278168;
        Thu, 07 Oct 2010 01:31:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q34sm1753134yba.10.2010.10.07.01.31.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 01:31:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim_3m=YmyVL7eEoWDGwDwmuDJsYkQMgx8ciVPH0@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158385>

Sverre Rabbelier wrote:
> On Thu, Oct 7, 2010 at 08:06, David Barr <david.barr@cordelta.com> wr=
ote:

>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1454,6 +1454,15 @@ static int tree_content_set(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D slash1 =
- p;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D strlen(=
p);
>> + =C2=A0 =C2=A0 =C2=A0 if (!slash1 && !n) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!S_ISDIR(mode=
))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die("Root cannot be a non-directory");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hashcpy(root->ver=
sions[1].sha1, sha1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (root->tree)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 release_tree_content_recursive(root->tree);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 root->tree =3D su=
btree;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!n)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("Empty pa=
th component found in input");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!slash1 && !S_ISDIR(mode) && subtree)
>
> What is this hunk about?

Ooh, ack for this part (though I agree with you that it ought to be
explained in the log message).

Most git commands do their writing to the object db via the index and
loose objects.  When you just have a pile of trees you want to convert
into commits, this is wasteful; for performance-critical operations
like filter-branch --subdirectory-filter, one might want a sort of
hash-object --batch-to-pack to write a pack directly.

=46ortunately we have fast-import (which is one of the only git command=
s
that will write to a pack directly) but there is not an advertised way
to tell fast-import to use a given tree for its commits.  So in
current git, one has the unpleasant choice of writing loose objects
without parsing the trees or writing straight to pack but having to
parse trees to do it.

This patch changes that, by allowing

	M 040000 <tree id> ""

as a filemodify line in a commit to reset to a particular tree without
any need to unpack it.  For example,

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""

is a synonym for the deleteall command.
