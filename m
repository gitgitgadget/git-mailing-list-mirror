X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 17 Dec 2006 01:21:10 +0100
Message-ID: <e7bda7770612161621p324ba357x883ed28c46597750@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <em0fpq$45b$1@sea.gmane.org>
	 <e7bda7770612160705l61d1f350n70a8ba91754491c9@mail.gmail.com>
	 <200612161732.11746.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:21:20 +0000 (UTC)
Cc: git@vger.kernel.org,
	"Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2dbZi+oMCNgvk6hpaLAYCXORU0PNpXiPpGJahPVYlY+Zkrgj23kOqhuVJWephArF3qj26DkqG+NgLLTSMcWV74TE1+CzBvaewMR3637hMN/wAUfvxeP7nN+ILMn/Ez4gFd55VBi9lbiXPjFotcE61CitsSmoYeF2X0NCgz0hKI=
In-Reply-To: <200612161732.11746.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34669>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjmH-0005qe-RQ for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751409AbWLQAVN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWLQAVN
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:21:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:45345 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751483AbWLQAVL (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 19:21:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1534640nfa for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 16:21:10 -0800 (PST)
Received: by 10.49.55.13 with SMTP id h13mr5070405nfk.1166314870351; Sat, 16
 Dec 2006 16:21:10 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 16 Dec 2006 16:21:10 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Well, I just rather have than <sha1 of tree/blob> the definition
> of sparse checkout (for example subdirectory name, or file name,
> or glob pattern).

This is entirely an UI issue:

On 12/16/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:
> is based around Linus 'module'-file and keep things simple. A git
> configuration file that specifies:
> * link name for reference
> * local path to link
> * submodule source
> * submodule path to tree/blob
> * submodule commit / HEAD / branch
> * options (depth-limit , ...)



On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:
> And if you have that, you don't need <sha1 of tree/blob> in repository, in link object.

Correct. Since the commit contains all the version information, the
following combinations should give the same information iff we keep
the commit in the database:
1. <sha1 of commit> + <sha1 of tree/blob>
2. <sha1 of commit> + <symlink to tree/blob>

I used the sha1 because I wanted them to behave exactly like
trees/blobs in the database for operations that can disregard the
commit info. Now, if we keep the commit in the database as Linus
suggests we can reach the target from there with a symlink. This would
be more readable but also cost a few object lookups extra iterating
over the symlink.


> With sparse (for example defined by 'src/*.h') or partial (for example
> defined by 'Documentation/') checkout you should be able to merge
> upstream... unless conflicts are in the not checked out part.

This would be a great feature! Will this conflict with path shortcuts?
If so, we might consider two types of objects: "link" which cannot
merge upstream and "module" which can merge upstream and contains a
.git object repository.

IMHO, "module" is a more intuitive name for specifying a
(functionality wise fully fledged) submodule with a repository inside.
"link" could be used for just mirroring a tree/blob. I'm not sure if a
separation is needed on a technical level.


> Have you read  http://git.or.cz/gitwiki/SubprojectSupport on GitWiki?
Yes
> Have you tested the experimental submodule support (proof of concept)
Not yet


