From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
	submodules
Date: Sun, 18 Jan 2009 22:31:28 +0100
Message-ID: <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
	 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
	 <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>
	 <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>
	 <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfGI-0000Xl-I4
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbZARVba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbZARVba
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:31:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:33614 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbZARVb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:31:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1331666wah.21
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V2Ph0Zub4TN4ISgx7eN6Y2NZO26JzfPpcoe5lra1/n8=;
        b=HQfJVyPgzrqS3/oPyci3wTSGzX+7Wcoxnnri200BFbq9h++H5W/C1dqSu6Y6wtX7Ir
         svc+EwhNNHsomneMJnIRkCP++KRK0nnz26AWt5FOrcOZgGPFOsEA+MjCZEHgmYNFDSy8
         HPQho/pLp1WB2mYEvCcNKLy8kDFvTAbz1Xb7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rkF+nWpi4KhPLzsRJpKx74xobkN14RS5B1WErE4llAml9yOiCEkkLH5yWgv5H6vaFY
         TII2t8Zsccx/yn3FkTI4YcybpEck2vxUirQjuB1RyLO2fK6Hti6Op+MM5gX+QsGuHbEN
         d0xFL3ehkAp7Mg6S6nlPJhD2+yVKnqwilmUx0=
Received: by 10.114.196.13 with SMTP id t13mr3549745waf.82.1232314288663; Sun, 
	18 Jan 2009 13:31:28 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106288>

On Sun, Jan 18, 2009 at 22:02, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 18 Jan 2009, Lars Hjemli wrote:
>
>> On Sun, Jan 18, 2009 at 19:33, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > On Sun, 18 Jan 2009, Lars Hjemli wrote:
>> >> Actually, I want this to work for bare repositories by specifying the
>> >> submodule odbs in the alternates file. So if the current submodule odb
>> >> wasn't found my plan was to check if the commit object was accessible
>> >> anyways but don't die() if it wasn't.
>> >
>> > Please make that an explicit option (cannot think of a good name, though),
>> > otherwise I will not be able to use your feature.  Making it the default
>> > would be inconsistent with the rest of our submodules framework.
>>
>> Would a test on is_bare_repository() suffice for your use-case?
>
> No.  Inconsistent is inconsistent.
>
>> If this isn't good enough, how do you propose it be solved?
>
> As I said, with an extra option that you _have_ to pass when you want
> that behavior.

My concern is how to discern between wanted and unwanted submodules in
a bare repository.

With my proposed solution `git archive --submodules HEAD` in a bare
repository would only include the content of the submodule repos
listed in objects/info/alternates (since the commit referenced by the
gitlink would then be reachable).

But you mentioned that you had a repository where all the objects of
all the submodules where stored in the odb of the superproject. With
my solution, `git archive --submodules HEAD` in your (bare) repo would
then always include the content of all the submodules (since all the
objects would always be reachable), and I believe this is the behavior
you don't like.

So, would you rather have something like `git archive --submodules=foo
--submodules=bar HEAD` to explicitly tell which submodule paths to
include in the archive when executed in a bare repo?

--
larsh
