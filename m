From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 14:30:35 +0100
Message-ID: <200911171430.36227.jnareb@gmail.com>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr> <7viqd9isbm.fsf@alter.siamese.dyndns.org> <vpqlji5plyn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 14:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAO8x-0006bg-7h
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 14:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbZKQNaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 08:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbZKQNaj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 08:30:39 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:47117 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZKQNai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 08:30:38 -0500
Received: by bwz23 with SMTP id 23so6993784bwz.29
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 05:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Dkhj0/LEFjJPv+tZlclQ/omZ107I6bV2VPOFZZ/+H/8=;
        b=FFY6eyfYQnH+6hI7CTsa48kGmOfxTrESgn0RqR4DUzc6ALVa9i2g+itdZ4/mcIzhPx
         qON01pDWkXOL9Kyjg508ScvtsL4YhW8P0vW861uvEwPPTadYDS4uCQQER+dMI8JpmkpW
         Mpe9Jw4deltHOCgqlr2ild6UytXsJ7Dlto8C4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H5zmKYS5ZXZy+oDxLQj6DKli3s0Z6unOp4bwE5V+ktcVcYgJbOcJW5eG9gUQHj2hBo
         WNjWERJi3w0UqdA6jkaeBpVCEKll/wKxGsjEVCifM/oz+qD4UPiubxHbVotKdoS/gUDA
         9mpH10s8x8XvcrAQUi9P0dUAuJcN+nKwWnGBs=
Received: by 10.204.3.22 with SMTP id 22mr5684709bkl.181.1258464642300;
        Tue, 17 Nov 2009 05:30:42 -0800 (PST)
Received: from ?192.168.1.13? (abwu104.neoplus.adsl.tpnet.pl [83.8.244.104])
        by mx.google.com with ESMTPS id 16sm2166997bwz.15.2009.11.17.05.30.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 05:30:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqlji5plyn.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133089>

Dnia wtorek 17. listopada 2009 09:57, Matthieu Moy napisa=C5=82:
> Junio C Hamano <gitster@pobox.com> writes:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> It would be nice to have an option to git-config which would do suc=
h
>>> expansion, as a separate type similar to --int and --bool, e.g.:
>>>
>>>   git config --path section.key
>>>
>>> so that not only core.excludesfile could use this new feature, but =
for
>>> example also core.worktree, commit.template, gitcvs.logfile,
>>> mailmap.file, and perhaps also *.receivepack and *.uploadpack
>>
>> What should "git config -l" do for these (and core.excludesfile)?
>=20
> I don't know what it "should", but it "does" not do the expansion. I
> had the same questionning when testing the patch, I'd have liked to b=
e
> able to write a simple test-case like
>=20
> $ git config core.excludesfile '~/foo'
> $ git config --i-dont-know-what core.excludesfile
>=20
> to go through this codepath. Maybe we can just say
>=20
> $ git config --default core.excludesfile
>=20
> to say "call git_default_config(...) on this before printing it". My
> understanding is that this is what the C code is doing, we should
> allow the shell scripts to do the same.

I think it is a very good idea.  Nevertheless it can apply only to
config variables git core knows about, and not for example for git-gui,
or gitk, or qgit, or tig, or StGIT, etc. configuration.  Therefore
"git config --path" would be still needed.

--=20
Jakub Nar=C4=99bski
Poland
