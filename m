From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Sat, 23 Oct 2010 17:12:35 +0700
Message-ID: <AANLkTin-W_GF97APs8fHJim0pFbNDGKv6KAnWPDVbiKP@mail.gmail.com>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
 <20101021033042.GA1891@burratino> <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
 <20101021160134.GA3732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at
To: Jonathan Nieder <jrnieder@gmail.com>,
	Enrico Weigelt <weigelt@metux.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 12:13:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9b60-0000JB-Kt
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 12:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab0JWKM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 06:12:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64107 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab0JWKM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 06:12:57 -0400
Received: by wyf28 with SMTP id 28so1737699wyf.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=raBqUHjN7UpRFTkWUrBaOweCcUOCLfqbnQQo0exaRto=;
        b=Ci5DSp0WKHFEp9RxhhuOWZIDPEOUntiQ55VAXE6qXk7nSOAad5CAk9/f0YqzX4mGqk
         D/f3yEQl3z3wnE9XIqYHvbCXq3crp5CBgqIETT6Rmtu0AXU0ze64qLTCkWCCxx7+DuKC
         Lz+PAbGtZz8agnMM6fIHeAQVXZHIpJx2jwlYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=otZZHXGIc253GulHZ/5SWC38tuXWxoqX7JPhciuaegEEXPdaBsmRV61yBBNip/GOrg
         GHYTP9ggwCmNFcbbrWiMPG+keCb2VowSra8XlWUyV2XdmrYU9NfFeKSrBruvr4xcFAua
         080gsvDJusjfIFvAri8isMN1Pek3JXbMUnvkY=
Received: by 10.227.68.206 with SMTP id w14mr4028891wbi.144.1287828776053;
 Sat, 23 Oct 2010 03:12:56 -0700 (PDT)
Received: by 10.216.241.138 with HTTP; Sat, 23 Oct 2010 03:12:35 -0700 (PDT)
In-Reply-To: <20101021160134.GA3732@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159775>

On Thu, Oct 21, 2010 at 11:01 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Nguyen Thai Ngoc Duy wrote:
>> On Thu, Oct 21, 2010 at 10:30 AM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>
>>> Speaking of which, it is not clear to me that core.worktree should
>>> fall under the forbidden case discussed above. =C2=A0If it does, wh=
at is
>>> the point of making it configurable?
>>
>> I was not the one who introduced core.worktree, so I can't really
>> tell. Maybe less keystrokes?
>
> Yeah, it seems you're totally right. :(

Actually I have my part in this mess too: f5e025a (Documentation:
always respect core.worktree if set - 2009-12-29). I probably just
updated the document according to the code. It matches what Enrico
expects (i.e after .git discovery, worktree defaults is "../", if
core.worktree exists, follow it instead). Going back to the first
commit that introduced separate worktree, 892c41b (introduce
GIT_WORK_TREE to specify the work tree - 2007-06-06), core.worktree is
no different than --work-tree.

So what should it behave? Either revert f5e025a and update the code to
disregard/warn core.worktree if GIT_DIR/--work-tree is unset, or keep
the current behavior, i.e. core.worktree is different from
--work-tree/GIT_WORK_TREE.

The cleanup commit, e90fdc3 (Clean up work-tree handling -
2007-08-01), also gives something interesting regarding bare repo:
"--work-tree=3Dbla overrides GIT_WORK_TREE, _which overrides core.bare =
=3D
true_, which overrides core.worktree, which overrides GIT_DIR/.. when
GIT_DIR ends in /.git, which overrides the directory in which .git/
was found.". I don't like this overriding chain, which is why I
proposed to die() if core.bare is set and worktree is explicitly
specified.
--=20
Duy
