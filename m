From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 7 Nov 2014 17:13:47 +0700
Message-ID: <CACsJy8CPLvmbcdHHmfu6g0dUXJVQ8NhwqfGPD=-kcBmzF_ha6g@mail.gmail.com>
References: <20141107081324.GA19845@peff.net> <20141107083805.GA26365@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 11:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmgYi-0007p7-I1
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 11:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaKGKOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 05:14:19 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42565 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaKGKOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 05:14:18 -0500
Received: by mail-ig0-f175.google.com with SMTP id h3so12517843igd.8
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 02:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fHJgNF2gwspuqXiUQ+C11CVbOqfKyOtgzFDx3Yh540o=;
        b=GN0dyEisIZolFoMc0DqR6MAFJ8rfk4lvGuFBnCQdEZP04Xgly+xHTosMynQ6EMBgaB
         idiQ08SIRwreL84jEBagicJh3ctEzzxkwxKVfmSCcLAWHT4U/6sF914rCSajoLmmI5ce
         KzLTsIFjIMtH+4cM8q7ceg6jxjrFjS2qrH4lUcdMzOpbaF0CwKEAlaEyD51bbNz+dyZ2
         CyFfPZO9nrOFtXd2MW7328mFz4aSMzyXKMqeZah+pNoP82tBSnRhxGpMyNNwGYbkZTWj
         StUaoZPTUixBak1qvfjqNSO2OW+DKOYRMwVsfw7BefdOcxi1dQi06K56GNiYEIklMwbB
         ribQ==
X-Received: by 10.107.17.77 with SMTP id z74mr1255217ioi.86.1415355257704;
 Fri, 07 Nov 2014 02:14:17 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Fri, 7 Nov 2014 02:13:47 -0800 (PST)
In-Reply-To: <20141107083805.GA26365@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 7, 2014 at 3:38 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 07, 2014 at 03:13:24AM -0500, Jeff King wrote:
>
>> I noticed that "git checkout $tree -- $path" will _always_ unlink and
>> write a new copy of each matching path, even if they are up-to-date with
>> the index and the content in $tree is the same.
>
> By the way, one other thing I wondered while looking at this code: when
> we checkout a working tree file, we unlink the old one and write the new
> one in-place. Is there a particular reason we do this versus writing to
> a temporary file and renaming it into place?  That would give
> simultaneous readers a more atomic view.
>
> I suspect the answer is something like: you cannot always do a rename,
> because you might have a typechange, directory becoming a file, or vice
> versa; so anyone relying on an atomic view during a checkout operation
> is already Doing It Wrong.  Handling a content-change of an existing
> path would complicate the code, so we do not bother.

Not a confirmation, but it looks like Linus did it just to make sure
he had new permissions right, in e447947 (Be much more liberal about
the file mode bits. - 2005-04-16).
-- 
Duy
