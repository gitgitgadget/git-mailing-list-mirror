X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: impure renames / history tracking
Date: Thu, 2 Mar 2006 07:05:44 +1300
Message-ID: <46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
	 <4405C012.6080407@op5.se>
	 <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Mar 2006 18:08:11 +0000 (UTC)
Cc: "Andreas Ericsson" <ae@op5.se>, "git list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mBLNlJFzfCufABpXcsVUNMxBlAP4wTHFLJFR61BeOrrd3hYdJgb5gqhhuJuD5eqoCNgrMiUPK9nILbzMqdRtdqS9GgM9JgejgM5jHFfW9fkEzkMzlpUReBX2gT3VCma5TP0w3nG/BdDY22Oob2upnkgL3koKMe/UH1kYPG3nFwk=
In-Reply-To: <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FEViE-0003td-Dz for gcvg-git@gmane.org; Wed, 01 Mar
 2006 19:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932165AbWCASGF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Mar 2006
 13:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCASGF
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 13:06:05 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:41335 "EHLO
 wproxy.gmail.com") by vger.kernel.org with ESMTP id S932165AbWCASGE convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 13:06:04
 -0500
Received: by wproxy.gmail.com with SMTP id i27so198237wra for
 <git@vger.kernel.org>; Wed, 01 Mar 2006 10:06:03 -0800 (PST)
Received: by 10.54.101.15 with SMTP id y15mr2351784wrb; Wed, 01 Mar 2006
 10:05:45 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 10:05:44 -0800 (PST)
To: paul@hibernia.jakma.org
Sender: git-owner@vger.kernel.org

On 3/2/06, Paul Jakma <paul@clubi.ie> wrote:
> I mean:
>
>         $ git checkout project
>         $ git pull . master
>         $ git checkout -b tmp project
>         $ git diff project..master | <git apply I think>

The moment you 'merge' by using git-diff | patch you lose all the
support git gives you, because you are discarding all of git's
metadata! git's metadata is about all the commits you are merging, and
is good enough that it will help future merges across renames.

You should really use git-pull/git-merge at that point.

My guess is that you do this to achieve what you describe later:

> Presume that 'project' in the workflow is defined as
>
>         "achieve one goal with one commit to the master"
>
> So by definition, it always correct that the project only ever has
> one commit.

What happens if you rephrase that to read: "achieve one goal with one
merge to the master"? Long term, it gives you much better support from
the SCM. If a particular commit broke something, you can use
whatchanged, log, annotate and bisect to figure out in which /small/
commit things went astray.

And you can modify your practices ever so slightly to match the
benefits of the old model:

 - force merge message editing in git-merge, and prepare appropriate
commit messages for your merges
 - write a modified git-log that displays only the merges to master

that way, you get the best of both worlds.

> The trouble is that /sometimes/ projects do indeed 'rename and
> rewrite' a file. At present, chances are git might not notice this,

It will, if you preserve git's metadata.

The thing is that with any scm that tracks metadata of some kind, the
moment you bypass its tools and do diff|patch to discard the
metadata... well, you lose its benefits...

And what I've found, managing a project with 13K files, is that in
practice git does far better tracking renames than several SCMs that
do explicit tracking. Don't be distracted by the 'we don't track
renames posturing'. We do, and it's so magic that it just works.

cheers,


