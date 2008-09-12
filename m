From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar
 archive
Date: Fri, 12 Sep 2008 07:57:47 -0500
Message-ID: <48CA674B.9080900@gmail.com>
References: <48C34EC7.9040102@gmail.com>	<20080908180317.GA6123@diana.vm.bytemark.co.uk>	<48C56AD9.6040007@gmail.com> <2008-09-12-14-21-13+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke8F5-0001Zw-K5
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYILM6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 08:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYILM6M
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:58:12 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:63727 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbYILM6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:58:10 -0400
Received: by an-out-0708.google.com with SMTP id d40so95578and.103
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=HzjP9gR3UEuUc0k55VOke3Attl+C/VP+sLMAQOwtqFc=;
        b=pCR18izcp0J43Ib3hknG/xCd/WKXxbZcPjROxDLLgIFXyWECdIKPwKA6ZJiVUQmPsp
         zFDNRNDa20bj5Vk68nVz4peQvWwv1M/5tYfcPZthcE+c2wXrOK60d2g7SczK5bz2BSM5
         s/kauZmwAcKErY/Cy0m96hZZO+UEYVgcKD2w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=TGM5tV/S9By7/uUk7jT4WFbdF81fn7AgNpKoj6YJ1Rv44eWpW90B+Cce3+WUYdx8ev
         eAD37o1E2mN0ZwEk6QSMVis5HjqyQgmGa6D2hTDoe2ero495a93NwENmQttFpyHvAcYa
         YwTo/1l6C1CjdotDVB17laP+rhFyZUg+HnzBU=
Received: by 10.100.154.19 with SMTP id b19mr5049203ane.98.1221224290241;
        Fri, 12 Sep 2008 05:58:10 -0700 (PDT)
Received: from ?192.168.2.35? ( [74.239.78.188])
        by mx.google.com with ESMTPS id c20sm21167045ana.21.2008.09.12.05.57.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 05:58:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <2008-09-12-14-21-13+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95723>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Samuel Tardieu wrote:
>>>>>> "Clark" == Clark Williams <clark.williams@gmail.com> writes:
> 
> Clark> [...] is to see if I can ease StGit's patch
> Clark> import rules a bit, since quilt accepts pretty much anything as
> Clark> long as there's a diff in there somewhere. I bomb out regularly
> Clark> importing the -rt series using StGit, because some people don't
> Clark> put complete email addresses in their patches.
> 
> Two things that would be great would be:
> 
>   - to be able to import patches with "-p0" (people not using git
>     often sends such patches)

I'm not sure how easy this is going to be. It looks like the patch is applied with
'git --apply' from the file stgit/git.py:apply_patch(). The default '-p' value is 1,
so we'd have to figure out how to pass the 0 along and then get it into the
apply_patch() function.

> 
>   - to be able to find where the patch should be applied; I sometimes
>     receive patches for GCC directory "gcc/ada/", diffed from there,
>     and if StGit could see that the patch only makes sense there and
>     not at the top-level it would be great as well
> 

Zowie, I thought I only had to worry about folks sending patches with incomplete
information. So you get patches to the ada compiler that are rooted in gcc/ada (e.g.
patch in tarball says "./ChangeLog", instead of gcc/ada/ChangeLog) rather than at a
top level? Only way I could see to deal with that would be to try and pass in the
appropriate prefix from the command line.

My current plans are to clean up the first cut at the tarfile logic, then write a
test to keep Karl happy, then try to come up with a way to deal with importing
patches that don't have complete email addresses, no descriptions, etc. Once I get
through that, I'll see if we can deal with weirdly rooted patch series.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjKZ0sACgkQqA4JVb61b9eg2ACffDv+FXsL1NifMvxr1tbO2c3s
Hc4AoJPb/RZJrpqT6QybeZrj8rNFJg1y
=ccj/
-----END PGP SIGNATURE-----
