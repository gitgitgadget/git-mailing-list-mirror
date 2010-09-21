From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: tig show <commit> not working anymore?
Date: Tue, 21 Sep 2010 08:56:21 -0400
Message-ID: <AANLkTi=AUiLJJp6JLqWoJufBFDUKa7u3Eg9Az5uGteqM@mail.gmail.com>
References: <20100916125337.GG5785@bowser.ece.utexas.edu> <4C922112.404@drmicha.warpmail.net>
 <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in> <AANLkTinwTSOVfdZkt8CM9DHy9mm9nPt133nvUNjUcQO1@mail.gmail.com>
 <20100920042522.GA21880@bluemoon.alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 14:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy2Ox-0007ZH-24
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 14:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab0IUM4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 08:56:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63187 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0IUM4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 08:56:43 -0400
Received: by gwj17 with SMTP id 17so1618541gwj.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=/xsNV4M2ZS/Pg4poxPprGWMLlPnXZ8TGUIZG08u5Syo=;
        b=tDYgIMinr38k8WVmzndou/iLVcUC/pTh+DPhldWQmVD9nBARQwpdC4wSJ7QsFAEmJE
         +lCEUJXPJSV0m2vLMsuZogfwxLG2oI2WC16eGN6mABXfDLPhZnAxdbHhorzRPIzZGVFU
         peic6kLYTI6ncAs1tWJToVfzad/Ai/993REtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        b=ir1c5L9w02vsAQw6JwdSR5H5jfjJbFEUnZBEt984ipVzc4BIedWwizSRGh0DrEUpUs
         yMkKzYg2UeJCg+uru+iIS/khBJAwXxP1f+QOdWW4UGsMjIApSJlCQ4FxgwMdO6BH8g/Q
         6IO/2fVph0ccp45mO0SbVSOfBx/l/RGwzLs+M=
Received: by 10.101.133.12 with SMTP id k12mr11112961ann.27.1285073802265;
 Tue, 21 Sep 2010 05:56:42 -0700 (PDT)
Received: by 10.231.39.194 with HTTP; Tue, 21 Sep 2010 05:56:21 -0700 (PDT)
In-Reply-To: <20100920042522.GA21880@bluemoon.alumni.iitm.ac.in>
X-Google-Sender-Auth: h_fb3VVXf5GiP4olCG-bCuawQEY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156720>

On Mon, Sep 20, 2010 at 00:25, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> On Sun, Sep 19, 2010 at 02:46:22PM -0400, Jonas Fonseca wrote:
>> You fix is not that far off but to fix the second issue I had to do
>> change the function responsible for expanding %(commit). Anyway,
>> should be fixed in 0.16.1.
>
> Unfortunately, this has introduced another (albeit minor) bug: it
> breaks the tree view in some cases. For example:
>
> git clone git://gitorious.org/taggrepper/taggrepper.git
>
> and run tig there, and press `t'. It always gives me a blank tree.
>
> The cause for this is that view->parent is null when the tree view
> is invoked, but you merely pass !view->parent in the call to
> format_argv in prepare_io.

Oops, I should really finish the tig.c split up branch and introduce a
test suite to catch stuff like this.

> A simple patch to fix this is attached below, but you might have other
> ideas or I might have missed something, or not added sufficient checks
> for the argv vector.
>
> As always, if I have missed something above, please do let me know.

Thanks for the patch and for reporting this. I've fixed this by using
view->prev instead of view->parent. The view->prev tracks the list of
views whereas view->parent tracks parents/child relationships in split
view mode. It was one of the things I refactored not long ago.

-- 
Jonas Fonseca
