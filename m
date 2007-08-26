From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sun, 26 Aug 2007 01:02:50 -0700
Message-ID: <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com><7v1wdqud0z.fsf@gitster.siamese.dyndns.org><52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com><7vsl66svv4.fsf@gitster.siamese.dyndns.org><C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com> <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 10:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPD5J-0004Lt-Pa
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 10:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXHZIC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 04:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXHZIC4
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 04:02:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:22553 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbXHZICy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 04:02:54 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1628854wah
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 01:02:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=WcylT1jZA2MLQlGXgGQndDFKUgvN6V1ewnAN5ujOV7RVtc+CQDu7LMmyIM6hxnnxN/DjCa+2JVxoS9dcqkKHn1s0aNcuvW84lTPJ1j8cGtDSozKSwvhawVk2OcMq8ZVXckSyqDw8lSLT4xI2wlk7LHWgJ2TdDBZNxnMMpBzTxRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=q+4QOORAsIn2UJXpv+AhlrepChNgCbEfMhmVDt/tG7fAfo9EFM4OoCb81j8arHgdZECl96W6r47RPq0+m56LHafdC7JR+l/a6fExK82QAJfrkbvQ6JcOp++MQEFdjPSW5/Bzsj+sFlLh8cNZWE7QxYpBVg/XEbSwQlMtzLvZeZ8=
Received: by 10.114.56.1 with SMTP id e1mr1223773waa.1188115373912;
        Sun, 26 Aug 2007 01:02:53 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j31sm5312789waf.2007.08.26.01.02.52
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 01:02:53 -0700 (PDT)
In-Reply-To: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56678>

----- Original Message ----- 
From: "Junio C Hamano" <gitster@pobox.com>
> Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:
> 
>> I thought I did: I've observed that these problem are caused by
>> storing metadata in regular files (that exist both in repo/index and
>> in workplace).
> 
> And that observation solves the initial checkout issue how?
There is always only one place to check for metadata - the index.

>> My knowledge of Git internals is quite limited, but if *I* were to do
>> it right now, I'd introduce a META entry in every TREE object that
>> would point to a BLOB that contains combined content of
>> .gitattributes, .gitignore etc.
> 
> A tree that has .gitattributes (and I am assuming in the longer
> term you can use "ignore" and "precious" in .gitattributes
> instead of using .gitignore) POINTS TO A BLOB already, so what
> you are saying does not add anything to what we already have,
> other than that you are renaming .gitattributes to "META ENTRY".

Almost true! The difference is: META BLOBS are not created as files in the workspace (not during checkout, not ever).
In order to edit it you'd have to use 'git meta' command.
So once again, there is only one place to check for metadata - the index.

> When you do "git checkout -- this-path", you are checking things
> out from the index and at that point you may not have _any_ tree
> yet (think "before initial commit").  A "META ENTRY" that exists
> only in a tree does not work -- it has to come to index somehow
> for it to work with how git works.

I don't fully understand the difficulty. Here is how I see the initial checkin to work:
Let's say you just did 'git init' and want to add file.txt with unusual crlf. So you don't want automatic translation.
What you'll do is:
* git meta
  In vi you put 'file.txt -crlf'
  git creates a TREE object in the index with only entry META that point to BLOB with this file.
  so it's kind of an empty tree from user's perspective.
* git add file.txt
  while adding the file git consults META BLOB from the TREE (stored in index) and does not do any crlf translation
  the TREE now contains 2 entries: META, and BLOB for file.txt
* git commit
   nothing special here

Now someone else doing initial checkout:
* git checkout
  Before writing file.txt to disk git consults META BLOB (in the index) and does not do any crlf translation.

- Dmitry
