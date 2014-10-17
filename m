From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is
 only temporary
Date: Fri, 17 Oct 2014 14:47:07 +0200
Message-ID: <54410FCB.6070908@gmail.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>	<543E85FA.6050404@xiplink.com>	<xmqqwq81w8az.fsf@gitster.dls.corp.google.com>	<543EDE6A.7040500@xiplink.com>	<xmqqsiipuifi.fsf@gitster.dls.corp.google.com>	<543EEAC4.8070204@xiplink.com> <xmqqfvepuhmy.fsf@gitster.dls.corp.google.com> <543FE3BE.9010307@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 14:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xf6wA-0002xz-FS
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 14:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbaJQMrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2014 08:47:14 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:58986 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaJQMrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 08:47:13 -0400
Received: by mail-la0-f46.google.com with SMTP id gi9so628404lab.33
        for <git@vger.kernel.org>; Fri, 17 Oct 2014 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HowXNO/8l+FUMirtk3d9EPIAvk/uIWwMprCRfywgUpQ=;
        b=QknoR4YCXemP+ThEmN5RQmHg//XhPWVA6OOqRB6+8auGF/SMD8CD3+Y4M28RrLejsD
         aUIqx0iht2jJY5i7HdeK25B1u9ZChxyn3EksHL51Pd4txMid28NA3mzPgtwmA8kFjnpx
         cR9q0IsByoT0KYSyVpg7iPik8rRRYP2f92+8+6AjHD8UP7kldkpKpXUAmdcTqlQvrIuD
         rjLcBWtln8sL9CYisGNsI1Du+i5FvQcL2BtP2u5sm9wDYikwCl8DxTcb4pCMDULJMWC4
         X2Mant3wINU7BNgBRdLRIuKjs9PVqFEfg6jungpkS7v+Tqu9WGm2P/XFAjbPKBJ4yoFr
         PsoQ==
X-Received: by 10.112.151.42 with SMTP id un10mr8472645lbb.21.1413550032231;
        Fri, 17 Oct 2014 05:47:12 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id ei11sm423070lad.0.2014.10.17.05.47.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Oct 2014 05:47:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <543FE3BE.9010307@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-10-16 17:26, Marc Branchaud wrote:

> I just don't see what difference the --borrow option makes.  Consider=
 the two
> cases:
>
> With just --reference=3D/local/pool/linux.git:
> 	1. Set up the alternates file with that path.

         x. Fetch object from origin not present in pool

> 	2. Copy gko's refs into refs/remotes/origin/.
> 	3. Set up refs/heads/master to refer to gko's HEAD.
> 	4. Checkout refs/heads/master (uses objects from local pool).
>
> With both that --reference and --borrow=3D../my/neighbour/linux-hack.=
git:
> 	1. Set up the alternates file with both paths.

         x. Fetch objects from origin not present in either pool
            or neighbour repo ("have" pool and neighbour)

> 	2. Copy gko's refs into refs/remotes/origin/.
> 	3. Set up refs/heads/master to refer to gko's HEAD.
> 	4. Checkout refs/heads/master (uses objects from local pool).
> 	5. Disassociate ourselves from the neighbour repo.
            which means roughly:

            5.1. Remove neighbour repo from alternates
            5.2. Fetch required objects from neighbour repo
                 ("want" neighbour, have ???)

It is possible that because of technical limitations --reference and=20
--borrow / dissociate / --temporary-reference / --object-cache are to b=
e
mutually exclusive.

> In both cases the first four actions have no need of the neighbour re=
po.  The
> second case's fifth action surgically removes the neighbour as an alt=
ernate
> object store, and we're left with the same clone we got in the first =
case.
> What was the point?

You are missing fetching object from your list of actions.

> It seems that in order to make something like --borrow useful, "git c=
lone"
> would somehow need to know which of the neighbour's refs you want to =
*also*
> clone, then copy any unique objects from the neighbour before disasso=
ciating
> from it.
>
> 		M.

--=20
Jakub Nar=C4=99bski
