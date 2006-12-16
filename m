X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 02:13:35 +0100
Message-ID: <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 01:13:49 +0000 (UTC)
Cc: "R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HNiMPLRqSQKTR9coXjP3A7T/hu6X7EKjb+ynUi0JfnphVlDGFZdrKGO0JOOVg/MT8Y/e1fjkb4azCKtu1YaPfOGatbUlOpScnPxKeDinpBct+cu3SKSuTmb577HfqYJ0FBcpGwxIRyAlZU3ijo7gsfJQ+aYFzEM9KMX+UduWmD8=
In-Reply-To: <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34582>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvO7T-0002f8-L0 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 02:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965306AbWLPBNl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 20:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbWLPBNl
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 20:13:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:61486 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965306AbWLPBNk (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 20:13:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1280594nfa for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 17:13:35 -0800 (PST)
Received: by 10.48.48.13 with SMTP id v13mr1871541nfv.1166231615603; Fri, 15
 Dec 2006 17:13:35 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Fri, 15 Dec 2006 17:13:35 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/16/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:

> I'm very open to suggestions here, but the concept growing in my head
> is based around Linus 'module'-file and keep things simple. A git
> configuration file that specifies:
> * link name for reference
> * local path to link
> * submodule source
> * submodule path to tree/blob
> * submodule commit / HEAD / branch
> * options (depth-limit , ...)
>
> I'm reconsidering having the path-name in the link, it should be
> sufficient to have two SHA1's, one for the commit and one for the
> tree/blob. Super-module should have the tree/blob in it's database so
> that the link part only is there for version information and reference
> (checking dirty state or history on the submodule). This way it easy
> to clone the super-project and use it without having to map up all
> sub-project sources. Sub-project sources is not important for version
> information and could always be specified in the project in a
> README-type of file.
>

See it as the link only is there for the version handling between
different modules and it's the module file that give an UI to the the
link (which project, branch, ....). Many users will not care whats
behind those links, but if they want to edit the link they have to
create the modules file or fetch it somewhere - it may even be
provided and version controlled in the project itself.

example tree object:

100644 blob <sha1 of blob>    README
100644 blob <sha1 of blob>    REPORTING-BUGS
100644 link <sha1 of blob>     <sha1 of commit>
040000 tree <sha1 of tree>    arch
040000 tree <sha1 of tree>    block
040000 link <sha1 of tree>     <sha1 of commit>

Note that the links functions exactly as the blobs and trees in the
database. The difference is that they origin from _a_subproject_ (we
don't care which in this stage) with the specified commit SHA1. If the
link isn't represented in the modules file, it's no big deal, it can
be added later on if needed.

If the blame-game begins or if we want to check what we're using on a
submodule level we can always pinpoint the exact file/tree content and
