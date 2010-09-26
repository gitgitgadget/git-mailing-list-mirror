From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Sun, 26 Sep 2010 23:09:59 +0530
Message-ID: <20100926173956.GA15143@kytes>
References: <4C9E07B1.50600@workspacewhiz.com>
 <1285514516-5112-2-git-send-email-artagnon@gmail.com>
 <vpqmxr4piyf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvDx-0001MM-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab0IZRlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 13:41:13 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49442 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953Ab0IZRlN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:41:13 -0400
Received: by pwj6 with SMTP id 6so1005225pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aAnwglN1tYcSsOCMJe+CTHsTPtdfR2KFTBPX3Va55MA=;
        b=DeEXMB7cZVlC+ohf3kRSnojua8QwnyR69MEgZ/Rf3Ew1N9jkQxh7P/HZ7c/oyjXmyB
         A0D+LfjnbCRsakqUgwQ8Hb6r2gcz3YynedjpXHILo2Wv1RUTK/+CtHbV2oHexOlCHDMu
         Txfk1dqiBu+lSlkN/iVATm4UPW57sF3fn2UBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pr+6PjnT97KXq4oeyybgGgk0NRzYA+t2LNivfg11qR/jXNQOgc0e3yHshUwFPKk/pS
         xydM/AriOZr7kIzC4+aZZ0fxkE/GuZ3pKCCfupbLcQSVFvh2aF8STIqtF2sAv6MtKbB4
         szNXjEf/DbN+Wsa3jwcphVDmva4RKWIS2dTns=
Received: by 10.142.199.18 with SMTP id w18mr5305153wff.336.1285522872610;
        Sun, 26 Sep 2010 10:41:12 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v6sm6109008wfg.3.2010.09.26.10.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 10:41:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqmxr4piyf.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157243>

Hi Matthieu,

Matthieu Moy writes:
> I totally agree on the idea, and the implementation is OK. On the
> format of the message, you can try to make it more consistent with
> other error messages, like:

Thanks for the review.

> $ git merge branch
> error: The following untracked working tree files would be overwritten by merge:
>         one
> 	two
> Please move or remove them before you can merge.
> 
> That would give stg like:
> 
> echo >&2 "error: The following files have unstaged changes:"
> git diff-files --name-status -r --ignore-submodules -- >&2
> echo >&2 "Please commit or stash them to proceed."

Ok, sounds good.

> Also, you probably want to give all the error before you "exit 1",
> hence stg like:

Hm, is that a good idea? We want the output to be functional and
indicative: it should tell the user what to do immediately. I'm afraid
that displaying both errors will make the output very verbose. We can
just tell the user about the unstaged changes, and wait for them to
commit or stash it. Either way, both commit and stash will affect the
index by default :)

-- Ram
