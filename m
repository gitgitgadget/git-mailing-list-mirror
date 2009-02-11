From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Wed, 11 Feb 2009 01:05:43 +0100
Message-ID: <a1b6cb1b0902101605l75c17e64qf9b919264b8d550d@mail.gmail.com>
References: <a1b6cb1b0902101558s7df025c7hfe078638452413c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Geoffrey Lee <geoffreyj.lee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 01:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2dF-0001Us-5f
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 01:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbZBKAFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 19:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbZBKAFq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 19:05:46 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:63398 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbZBKAFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 19:05:45 -0500
Received: by bwz5 with SMTP id 5so187781bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 16:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lSMd5FSXmqkZXFDduFD/k8SUABockNG+0utoM6F+K1s=;
        b=MCcmAy1lLzDSGTWZjNpb7gwgFp/wc6TafokouNIVqALMnelvF2g2eE1UNTCTtbV8QV
         SyMSYcYyXwRGqF1qG7Om/9vvZ7YR7mVhze+b9IHDEe/C0/o0edOCC8+Ye+crLBEfk46f
         AqM0BhNVygxgw9JgjhVrj2rAdgS38eUP0TdsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lAwZGK9zlZy1+BbWhQInsC77KMCcgMEJWSe0oXVLnQMf3Oipzh6p8qbvisRXb6MQaZ
         sJlb2E3CaxlY/eLVqS/Mzh6mOsN7flhL6SsrH1CaH4r8fSzY6jxuatyb8CFPQFSOAp0K
         gb2jroLQE+f0eUekdRHckejpUUbvj3YMz5aP8=
Received: by 10.181.205.3 with SMTP id h3mr557050bkq.91.1234310743205; Tue, 10 
	Feb 2009 16:05:43 -0800 (PST)
In-Reply-To: <a1b6cb1b0902101558s7df025c7hfe078638452413c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109357>

On Wed, Feb 11, 2009 at 12:58 AM, Ulrik Sverdrup
<ulrik.sverdrup@gmail.com> wrote:
>> On Tue, Feb 10, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Jeff King <peff@peff.net> writes:
>> > How is it different from "git stash create"?
>>
>> Git stash doesn't touch untracked files, whereas git snapshot would.
>> Take another closer look at the table in the original post titled
>> "What are the differences between 'git stash' and 'git snapshot'?"
>>
>> -Geoffrey Lee
>
> I'm understanding this just as I read this, but it seems that implementing a
> git snapshot (I'm myself interested), could be done quickly with a new git.
> (When was git stash create introduced? I don't know it?)
>
> Something like this:
> cp .git/index .git/tmp-index
> GIT_INDEX_FILE=.git/tmp-index
> git add -N .
> git stash create

Ok I didn't test this. Stash creation fails because the add -N status
is not quite "tracked but no content staged", but rather you _have_ to
stage the files at a later point. git add -N is just a reminder thing?

Error output:
plugin-gui.log: not added yet
fatal: git-write-tree: error building trees
Cannot save the current index state

Shame, I wish the above script worked.

Ulrik Sverdrup


>
> So we use add -N to put all files into tracked but unstaged by default, but we
> keep our old index. Now stash is ready to save off the working directory, and
> further logic has to be applied on the returned commit to save it off..
>
>
> Ulrik Sverdrup
>
