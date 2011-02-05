From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Sat, 5 Feb 2011 17:32:05 +0700
Message-ID: <AANLkTingZB_+3W-PBATCVywjR31ft_AH+e0Z+4rsUR45@mail.gmail.com>
References: <1296894611-29398-1-git-send-email-pclouds@gmail.com>
 <1296899427-1394-1-git-send-email-pclouds@gmail.com> <20110205101412.GB1685@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 11:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlfRb-00078f-Pm
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 11:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab1BEKch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 05:32:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52484 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab1BEKcg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Feb 2011 05:32:36 -0500
Received: by wwa36 with SMTP id 36so3219657wwa.1
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jhr8k3h8gihYDXDXPSsVjuwuerq6l+4eSu+2opDIQjM=;
        b=AQFErejtkgs3IAPP/yE/mb9vOUNIhOyKvZ4z0jvJvQeZnUdgOIMFsKV7fv5uC0SgXP
         q69BNavM9buWdtafnePmY+ZwoTzghXWuDzRF0Z7VxKyshP+EJOdPMh4zFbNZhgWDSno2
         fRZbfgXc66/UHcNMtO4dXvE5tmHO+PuRCPS9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aHmOypzQdm3D4R4zWVErd05YDUG/EYf4w+b2MUjPDdcaAGoXB5KPCxRLXRdgfTMfad
         Hj2fVtWwoO6mtO0sio7tVoc9F7jzJmC1rP3PP46pcHMjoa5Y/UicocUbvXIBT57eQSyC
         R11dcP7xmeGqntZn1v4gJcieUyBjHQDwEVcCM=
Received: by 10.216.24.135 with SMTP id x7mr286520wex.43.1296901955135; Sat,
 05 Feb 2011 02:32:35 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sat, 5 Feb 2011 02:32:05 -0800 (PST)
In-Reply-To: <20110205101412.GB1685@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166085>

2011/2/5 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> +
>> +T1=3Df4ec99e8174c01eab488469b4c2680500bbb18da
>> +T2=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
>
> What are these trees? =C2=A0Do they need to be hardcoded?

I have uneasy feeling constructing a tree manually. Hardcoding it (or
less automatic check) makes me feel better. I'm cooking a patch to
make hash-object reject malformed trees/commits/tags. Then I'll remove
these SHA-1.

>> +
>> +test_expect_success 'setup' '
>> + =C2=A0 =C2=A0 printf "40000 empty\0\x4b\x82\x5d\xc6\x42\xcb\x6e\xb=
9\xa0\x60\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04" >newtree &&
>
> printf '\xab' is unfortunately unportable. =C2=A0I suppose
> this should rather say something like
>
> =C2=A0test_unequal () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s\n' "$1" >bad &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s\n' "$2" >actual &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! test_cmp bad actual
> =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0empty_tree=3D$(git mktree </dev/null) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tree_with_empty_subtree=3D$(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "040000 t=
ree $empty_tree =C2=A0 empty" |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git mktree
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_unequal "$empty_tree" "$tree_with_emp=
ty_subtree"

Hah! Was wondering how the heck they could create trees manually. So
it's mktree. Thanks!

> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> Sane?

Don't know. But it's definitely saner than my version.
--=20
Duy
