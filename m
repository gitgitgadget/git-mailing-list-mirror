From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Sun, 12 Sep 2010 19:22:27 +0200
Message-ID: <AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
	<4C8CF231.6090403@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Alejandro_Riveira_Fern=C3=A1ndez?= <ariveira@gmail.com>
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Sun Sep 12 19:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuqGA-0001FU-Qv
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 19:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab0ILRW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 13:22:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44338 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab0ILRW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 13:22:28 -0400
Received: by iwn5 with SMTP id 5so4269488iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EGqe9aDRPdcYvrrr2IHkAdHiVCposGrjQGP4ECZsF0g=;
        b=K8/Gh2dvWbe1LqpI/JFLKFdNfgLCWql41OHWG9IygqVvSNyl6AydKwqPCPF5EnH8FN
         7i4KLQRh6W64bsxNwFq6OSIiINs8/m271zrS9a6g39OXFsQyRB5Rb0alcxyhy0Dl6bX+
         cSxq36Ujk1x2pe1XtHOp6756h7Kt65Us8MHuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hFvUtE+UhLz8dzw8jQS6e8LbulrdDR0oLkfitI0z0ctQLMebDk06VmhkB5pPU5SByt
         tG7N626CfgkzKe9UmS5v4oe7hfu2qV36eSK6+uc1U8u8whKFvvrnKVLtBYoaXyLB2Xiz
         Yo/rQxhANQW7vjs2/44dgOkMmu6wHOeJ7A6Y4=
Received: by 10.231.15.8 with SMTP id i8mr4713554iba.12.1284312147790; Sun, 12
 Sep 2010 10:22:27 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Sun, 12 Sep 2010 10:22:27 -0700 (PDT)
In-Reply-To: <4C8CF231.6090403@borg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156038>

2010/9/12 Kent Borg <kentborg@borg.org>:
> Firing up a Python session and manually running the git-p4
> findUpstreamBranchPoint() I get back something reminiscent of the com=
mit
> I made at your suggestion:
>
> =C2=A0['remotes/p4/master', {'change': '160991', 'depot-paths':
> ['//depot/imgeng/sw/inferno/kernel/linux-2.6.33-quatro']}]
>
> I thought it looked reasonable, but when I try to run the git p4 summ=
it,
> at line 811 in git-p4 it is doing:
>
> =C2=A0git rev-list --no-merges remotes/p4/master..master

Ok, so if you call this on the cmd line, it should output sha1's on
all commits that will be submitted (in reverse order) to p4. If it
doesn't, this may well be a good place to dig for a solution.

Say that you have only one commit to submit to p4. We'll call it X.

The parent of X should then be the commit that remotes/p4/master is
pointing to. If it isn't, you can try to:

1) git checkout -b my_p4_branch p4/master
2) git cherry-pick X # we'll call this cherry-picked commit Y
3) git rev-list --no-merges remotes/p4/master..my_p4_branch
  * if it lists Y and only Y, try
4) git p4 submit

-Tor Arvid-
