From: Garrett Cooper <yaneurabeya@gmail.com>
Subject: Re: [BUG] inconsistent behavior with --set-upstream vs --set-upstream-to
Date: Tue, 2 Apr 2013 10:30:35 -0700
Message-ID: <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
References: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com> <20130402172333.GB24698@sigill.intra.peff.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN539-000116-C9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab3DBRam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:30:42 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:42578 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab3DBRam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:30:42 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so283438dad.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=UA0E8fvf8tOKlUMpALUpradZm8xe+cxfisxBI1dXpdg=;
        b=SiFJ8ewmQYg2dNzNePTxNYk0zv4ajowkpCekofrn+ZZpvHE8OrgRU0hqpzBASXjf/7
         mMrIf3+X54xfY/K/XHhCNUXqkGBXhiWCCx/6qCLioUQGppmAwHxliw4eY0vWKufnED50
         nam/oR7bBkVQ8frWbxt60Ki67rUUXY7ZO35IpDAp4UaYLVz9zFLKVP9ovlAo+DlJf6pu
         HvoznlDRgbhKSFO1FJmLA2tQBpGNEc35+FxtiMTAenrNmdmW6FN00ieducehfyMwfKr6
         MUOBecMFa4a3cjzMey6e+mjGZcBBLEvfA4V5tV5J6B5l0eRJyQrRm+uv+nJSh2PCLzKW
         vRPg==
X-Received: by 10.66.168.6 with SMTP id zs6mr26223237pab.5.1364923841363;
        Tue, 02 Apr 2013 10:30:41 -0700 (PDT)
Received: from [10.15.106.233] (mobile-166-147-081-078.mycingular.net. [166.147.81.78])
        by mx.google.com with ESMTPS id t5sm2502393pbi.10.2013.04.02.10.30.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 10:30:40 -0700 (PDT)
In-Reply-To: <20130402172333.GB24698@sigill.intra.peff.net>
X-Mailer: iPhone Mail (10B329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219813>

On Apr 2, 2013, at 10:23 AM, Jeff King <peff@peff.net> wrote:

> On Tue, Apr 02, 2013 at 10:07:01AM -0700, Garrett Cooper wrote:
> 
>>    It looks like git branch --set-upstream-to doesn't function with 1.8.1.3 until I run --set-upstream. Is this a known bug?
> 
> No, but I do not think that is exactly what is going on.
> 
>> root@fuji-current:/usr/src # git branch --set-upstream-to origin/pjdfstest-onefs pjdfstest-onefs
>> fatal: Not a valid object name: 'origin/pjdfstest-onefs'.
> 
> This is complaining that origin/pjdfstest-onefs does not actually exist
> Does it? If the pjdfstest-onefs branch exists on the remote, do you need
> to do a "git fetch" to make sure we have a local
> refs/remotes/origin/pjdfstest-onefs tracking branch locally?
> 
>> root@fuji-current:/usr/src # git branch --set-upstream origin/pjdfstest-onefs pjdfstest-onefs
>> The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
>> Branch origin/pjdfstest-onefs set up to track local branch pjdfstest-onefs.
> 
> This did _not_ create the remote-tracking branch refs/remotes/origin/pjdfstest-onefs.
> It created a new local branch called "origin/pjdfstest-onefs" (i.e.,
> refs/heads/origin/pjdfstest-onefs), whose upstream is another local
> branch "pjdfstest-onefs". That "backwards" order to the arguments is why
> --set-upstream is deprecated; many people have made the same mistake.
> 
>> root@fuji-current:/usr/src # git branch --set-upstream-to origin/pjdfstest-onefs pjdfstest-onefs
>> Branch pjdfstest-onefs set up to track local branch origin/pjdfstest-onefs.
> 
> Note how it says "local branch" here; you are not tracking anything at
> the origin. You are tracking a local branch that happens to have
> "origin/" in the name.

I push the branch to origin/ and then things tend to work, but since I obviously had been doing things wrong what's the correct order of operations for creating a branch and setting the upstream appropriately?

Thanks!
-Garrett

PS I love git as a tool, but I really wish the workflows were simpler or more straightforward, and error messages were clearer. It seems like this would help prevent usage errors like this..