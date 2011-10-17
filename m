From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch 'jp/get-ref-dir-unsorted
Date: Sun, 16 Oct 2011 21:38:33 -0400
Message-ID: <4E9B8719.1090203@gmail.com>
References: <4E9B1E32.7030101@gmail.com> <7vfwispi8u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 03:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFcA6-0001MT-R2
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 03:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab1JQBih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 21:38:37 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49131 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1JQBig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 21:38:36 -0400
Received: by qyk27 with SMTP id 27so1251384qyk.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=btRGJemfpWkInAD131jqyIJWfcltn/JDKpeIw6UUJBI=;
        b=N4aFPq3c1CarK525+jKNBojE9zlfrMr475wcb8vFJyxhU591T2crCkpXt45eG/OwFy
         ugJSI1L6Yp4YVsxZc212DqZsbcxs5npjCdIj7IipNQBNLMrzGewmymWmtW4gDokzGRfY
         9+YxuNh7jj280SJ1QK6z6himNQ172URnOBSDY=
Received: by 10.229.185.202 with SMTP id cp10mr3661407qcb.44.1318815516077;
        Sun, 16 Oct 2011 18:38:36 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-73-114-154.washdc.fios.verizon.net. [173.73.114.154])
        by mx.google.com with ESMTPS id dn1sm1695776qab.10.2011.10.16.18.38.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 18:38:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vfwispi8u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183748>

On 10/16/2011 08:35 PM, Junio C Hamano wrote:
> Mark Levedahl<mlevedahl@gmail.com>  writes:
>
>> I have a project organized as a number of nested git modules (not
>> using git-submodule), and frequently use git-new-workdir to create the
>> nested modules.
>>
>> Since the above merge-commit, git-gui is confused by this arrangement
>> and reports every file in every nested module as being an untracked
>> file in the top-level (super) project.
> Could you come up with a simple reproduction recipe that prepares a
> superproject that has no file of its own, a submodule with a single file
> tracked, and attaches another workdir? If running git-gui in the resulting
> directory makes it misbehave, we could then isolate what git command that
> is invoked by git-gui has changed its behaviour.
>
> Thanks.
>

The following shows the problem for me:

#!/bin/bash
mkdir super sub
cd sub
git init
touch a
git add a
git commit -m 'file' a
git pack-refs --all
cd ../super
git init
git new-workdir ../sub sub
git-gui


git-gui shows "sub/a" in the list of Unstaged Changes. Note that the 
"git pack-refs" call is needed to get the failure.

Mark
