X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 09:10:39 -0800
Message-ID: <m2odqwlqi8.fsf@ziti.fhcrc.org>
References: <loom.20061124T143148-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 17:10:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=h2+SEsJBYpM4gGD02nQrDHejJbrps2+yRLv89/Hi/LTsWjTrw9wJhC1N0PNEHGty4nLWYr2qHTFHjWAZxIoP0WCc373Dm2vFKstDn2kGbBkRr/KBjQHXVZcJQH9rtSP/yAMPUXK7QoMeMLk2pL+e8KzqIQd3zRKpktHdLy55Ang=
In-Reply-To: <loom.20061124T143148-286@post.gmane.org> (pazu@pazu.com.br's message of "Fri, 24 Nov 2006 13:36:35 +0000 (UTC)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32230>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GneZT-0007Wo-JA for gcvg-git@gmane.org; Fri, 24 Nov
 2006 18:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757799AbWKXRKg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbWKXRKg
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 12:10:36 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:12781 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1757799AbWKXRKf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 12:10:35 -0500
Received: by nz-out-0102.google.com with SMTP id s1so479469nze for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 09:10:35 -0800 (PST)
Received: by 10.64.84.3 with SMTP id h3mr1287226qbb.1164388234960; Fri, 24
 Nov 2006 09:10:34 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id f17sm18005649qba.2006.11.24.09.10.34; Fri, 24 Nov 2006 09:10:34 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> writes:
> ... compared to the standalone svn client. I'm working with repositories over
> the internet, using not-so-fast links, but still, a svn checkout takes somewhere
> around 5 to 10 minutes, while git-svn fetch takes at least 10 times that just to
> fetch the initial revision. Later fetches also take *a lot* more time than a svn
> update would.

[warning: I _think_ this is how it works, but not 100% sure]
When you use git-svn to fetch from an svn repository, you make a
separate request for each commit that occurred on the remote svn
repos.  When you use the svn client, it only needs to compute and
download one delta .

If you are not already using the Perl SVN bindings (you will need to
build svn from source), you should give them a try.  They are much
faster.

My experience has often been the opposite, but I think that is because
I work with an svn repository where I track a directory that has many
many subdirs.  The svn working copy traversal is so slow that even
with the extra network overhead, git + git-svn ends up being faster
for fetch (and much faster for any local operation).

