X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-svn and empty directories in svn (was: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher)
Date: Wed, 29 Nov 2006 08:15:12 -0800
Message-ID: <m2slg2rzzj.fsf_-_@ziti.fhcrc.org>
References: <loom.20061124T143148-286@post.gmane.org>
	<20061128054448.GA396@soma> <20061128102958.GA5207@soma>
	<20061128105017.GA20366@soma>
	<9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
	<9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com>
	<m2bqmr1rnw.fsf@ziti.fhcrc.org> <20061128201605.GA1369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 16:15:37 +0000 (UTC)
Cc: Pazu <pazu@pazu.com.br>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=fxeVIO1zbvBqc1dKT7XRfILxdVlXFMqIyc+uYQE0iAE/JwUfF01IoBzj0ppDD29II9ffYmAA6O7LSoS4j5ZKILoS18kOTs3NCjfXZ1uJ6fIFRQGAUmvFgyVE8cWdIXjL6h20NfcPyJJvjFYRrKAX8XNhApsW8wlHA9YOst3HU/o=
In-Reply-To: <20061128201605.GA1369@localdomain> (Eric Wong's message of "Tue, 28 Nov 2006 12:16:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32648>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpS5W-0003dm-5L for gcvg-git@gmane.org; Wed, 29 Nov
 2006 17:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967448AbWK2QPF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 11:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935845AbWK2QPE
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 11:15:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:29406 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935812AbWK2QPC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 11:15:02 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2949619nfa for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 08:15:01 -0800 (PST)
Received: by 10.49.29.3 with SMTP id g3mr6486266nfj.1164816900333; Wed, 29
 Nov 2006 08:15:00 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id p20sm29539075nfc.2006.11.29.08.14.58; Wed, 29 Nov 2006 08:15:00 -0800
 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Hi Eric, and list,

Eric Wong <normalperson@yhbt.net> writes:
> Seth Falcon <sethfalcon@gmail.com> wrote:
>> I think that presently git-svn does not create empty dirs when pulling
>> from svn.  It would be nice to have such directories created since
>> some projects will expect the empty dir to be there (no need to track
>> it in git, IMO).
>
> Git itself cannot easily track empty directories (at least as far as
> update-index and checkout) goes.
>
> What I *can* do is run mktree and to force the creation of tree objects
> with a 4b825dc642cb6eb9a060e54bf8d69288fbee4904 (empty) sub tree and run
> commit-tree on it, but checkout/checkout-index would still need to be
> modified to support it.
>
> Is that something the git community wants?

I recently encountered a situation where code wasn't working for me
because git-svn didn't create an empty dir that is present in svn.

I'm not trying to argue for the sense/anti-sense of tracking empty
dirs in an scm, but I think this is an issue worth addressing in some
fashion.  Here's why.

I think there are many potential git users out there who are currently
svn users.  And git-svn is a really nice way to get started, but this
sort of stumbling block could really turn people off.  For example, it
made me look pretty dumb when I carelessly complained to my colleague
about his code not working and then it turns out to be because my
super-advanced scm tool "messed things up".

One simple thing (I think it would be simple) is that git-svn could
issue a loud warning when it encounters an empty directory that it is
going to ignore.

I don't understand the implications adding the tracking of empty dirs
to git.  I suspect it has been discussed before, but haven't yet gone
fishing in the list archives.  I imagine it would make the argument
easier for folks wanting to switch a project from svn to git if this
wasn't one of the differences.  For good or bad, I've often heard this
svn feature as a motivator to switch from cvs.


+ seth
