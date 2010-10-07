From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Thu, 7 Oct 2010 15:28:47 -0500
Message-ID: <20101007202847.GA13234@burratino>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 22:33:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3x9W-0006p3-Nl
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686Ab0JGUdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 16:33:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35535 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab0JGUdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 16:33:17 -0400
Received: by ewy23 with SMTP id 23so201594ewy.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bvnrz3/gSmCVeZCZV8rWiw3MtQxwQlljD6e1JccL3hw=;
        b=WjM6Mu4dhRybm9fzGqr3yBHDAqpDWxksQLiGBza8s3y/D4CylVVq0+MmHJKauJgocd
         bicSFLSpvqy1MRxcE0HYDiiGdgr9b9Kwr8JKkIWMwdSp3+5ee07wGNU4KmIvyxM3YmMo
         dZPPY2GUyrTicdGcsfQlsxOSlyUc7V2r4ElSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IrI97tm9Mq8J+bTVAgENFWUNb43D8ImBLn1FGskwXi7+rMzEfB01byu+Vdn71T3ESA
         JS1lNAxe0ZdzL9erLytaYuol74kprPeoQR0GEaH1c97BYgyuCCQ1ibLD+qNREdBKqWtA
         2wScQOTXyWEgmXLIIBBGVK5dy99fK85lpuyLY=
Received: by 10.213.4.15 with SMTP id 15mr866020ebp.49.1286483523897;
        Thu, 07 Oct 2010 13:32:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z55sm4078127eeh.21.2010.10.07.13.31.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 13:32:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158454>

Sverre Rabbelier wrote:

> This means nothing to me

Sorry for the lack of clarity.  Probably I should have just said:

| For a command (like filter-branch --subdirectory-filter) that wants
| to commit a lot of trees that already exist in the object db, writing
| undeltified objects as loose files only to repack them later can
| involve a significant amount[*] of overhead.
|
| Fortunately we have fast-import (which is one of the only git command=
s
| that will write to a pack directly) but there is not an advertised wa=
y
| to tell fast-import to commit a given tree without unpacking it.
|
| This patch changes that, by allowing
|
| =C2=A0 =C2=A0 =C2=A0 =C2=A0M 040000 <tree id> ""
|
| as a filemodify line in a commit to reset to a particular tree withou=
t
| any need to parse it. =C2=A0For example,
|
|	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""
|
| is a synonym for the deleteall command.

[*] how significant?  Numbers are always nice. :)

> Ok, so maybe I do understand, is it basically 'git read-tree
> 4b825dc642cb6eb9a060e54bf8d69288fbee4904' for fast-import?

Yep.

Thanks.
