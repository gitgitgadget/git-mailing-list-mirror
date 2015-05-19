From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git p4 clone - exclude file types
Date: Tue, 19 May 2015 01:38:24 -0600
Message-ID: <CAFcBi89XwW48Goaap=OCVQ_CJrNa_hj5+DWtOHGOsrm6jMs-mw@mail.gmail.com>
References: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>
	<555A52BD.1030802@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 19 09:38:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuc6i-0004R9-7H
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 09:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbbESHi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 03:38:26 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32884 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbESHiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 03:38:25 -0400
Received: by qkgv12 with SMTP id v12so4135032qkg.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M8+nmmISh0wPMNlgVaTWBJoFO9pV6WYqYYpFOMhXkLM=;
        b=T4ORbEoz24t8YXv6yxT62vdoNoFBhV9QgNfJBqGFeuAwRaUYrbU2oP+6+rYao6IBqk
         FHcB091E958u7QAwHFVTMZnaFFi/skcb3lbe+txS+nuNbf72Znq9s0R9ZgwW0rEFf8qi
         WsLb8XaLAeA8sWegB4eZ+BeNPG1qlG19iTKOaTidqTQVAYLJbgfPFhBJ0cLAD0h87+FA
         y8wsx6fbscK7aoJfbdbVknnEKsmMyijc1Ej6KBQW4t9epbPH9lZCk69Rp3q73iWfUi+z
         Be5h2lrUKhe/PE00jEA/OTPButmN2HcU85/f9IZVGePwdTNaISrYlRHw+TFRabkMwwqT
         W6cw==
X-Received: by 10.140.83.116 with SMTP id i107mr33333059qgd.97.1432021104999;
 Tue, 19 May 2015 00:38:24 -0700 (PDT)
Received: by 10.140.93.44 with HTTP; Tue, 19 May 2015 00:38:24 -0700 (PDT)
In-Reply-To: <555A52BD.1030802@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269344>

Thanks Luke, looks like this does work for excluding files when using
git p4. Great!

Unrelated question...

While using git p4 I have noticed that most of the time the clone/sync
operations hang and I have to keep retrying. The Perforce depot I'm
currently working with is larger than I'd like and has a lot of binary
files which might be the cause. The point it gets to in the clone/sync
is always random and doesn't ever stop on the same files or file
types. Sometimes it'll die soon after starting, but other times it
almost completes and then dies. If I keep retrying, it will eventually
complete. I haven't been able to narrow down the cause, but I do
notice that the git-fast-import stops right as the clone/sync dies.
I'm wondering if git is overwhelmed and terminates. Have you ever seen
this? Any suggestions?

As always, thanks for the help while I work through this migration project.

On Mon, May 18, 2015 at 2:59 PM, Luke Diamand <luke@diamand.org> wrote:
> On 18/05/15 18:59, FusionX86 wrote:
>>
>> Hello,
>>
>> Anyone know of a way to 'git p4 clone' and exclude files by type or
>> name? For example, I want to clone a depot, but not pull down any .exe
>> files. Haven't been able to find an answer in docs or other searches.
>
>
> I think you can use a client spec which excludes the files you want.
>
> First, create a client spec that excludes the files you don't want:
>
> Client: myclient
> View:
>     //depot/mystuff/...  //myclient/...
>     -//depot/mystuff/...exe  //myclient/...exe
>
> Then clone with the --use-client-spec option:
>
> $ export P4CLIENT=myclient
> $ git p4 clone --use-client-spec //depot/mystuff
>
> And later on, when you want to catch up:
>
> $ cd mystuff
> $ git p4 sync --use-client-spec
>
> Luke
>
