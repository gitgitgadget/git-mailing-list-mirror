X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 19:47:40 +0100
Message-ID: <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	 <20061118184345.GO7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 18:47:59 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZCG/IWBixivVCkCdcst5gyRjgDkdTszi6vNRJlMAFyVCO4WIsnPXoQguSuiUW1Qc05GNn2+L/HmRCA+3yw3qEmpz9yaMUyAIJ+0qJdeROt+mgqsFOBI+ffVq5m1Nq9CW0rLDGOik/H+qv8YczIRjZzcuXxYush5DZG1nHw8pP1Y=
In-Reply-To: <20061118184345.GO7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31789>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlVEK-00085o-G4 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755318AbWKRSrn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756367AbWKRSrn
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:47:43 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:58908 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1755318AbWKRSrl
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:47:41 -0500
Received: by py-out-1112.google.com with SMTP id a29so654390pyi for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 10:47:41 -0800 (PST)
Received: by 10.35.39.13 with SMTP id r13mr4785327pyj.1163875660364; Sat, 18
 Nov 2006 10:47:40 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 18 Nov 2006 10:47:40 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/18/06, Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Nov 18, 2006 at 07:38:11PM CET, Junio C Hamano wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
> > > Time needed to execute git-peek-remote in my box with cold cache currently is:
> > >
> > > - git tree 2.347 ms
> > > - linux tree 2.144 ms
> > >
> > > And refs are *already* packed in both repos.
> > >
> > > Looking at packed-refs file, it contains something like:
> > >
> > > d9b0f913ce0508fcc83e642e0241f373428368e5 refs/tags/v1.4.3
> > > 4314f5982d2aac08001a977fc0b1b611e858e025 refs/tags/v1.4.3-rc1
> > >
> > > while I would need something like git-peek-remote output,
> > >
> > > d9b0f913ce0508fcc83e642e0241f373428368e5        refs/tags/v1.4.3
> > > e0b0830726286287744cc9e1a629a534bbe75452        refs/tags/v1.4.3^{}
> > > 4314f5982d2aac08001a977fc0b1b611e858e025        refs/tags/v1.4.3-rc1
> > > 1965efb1599f59b8e3380335d1fa395e2008a30b        refs/tags/v1.4.3-rc1^{}
> > >
> > > Because the sha value a tag points to is needed to match against
> > > git-rev-list output so to identify tagged revisions.
> > >
> > > Would be possible to store in packed-refs also the dereferenced tag
> > > info, so that cold opening of a repository would be much faster?
> > >
> > > Just to give an idea, with warmed up cache, refs reading times are:
> > >
> > > - git tree 43 ms
> > > - linux tree 28 ms
> > >
> > > Thanks
> > > Marco
> > >
> > > P.S: In case it's not clear I don't suggest to read directly the
> > > packed-refs file with the added info, but always to use
> > > git-peek-remote that _would_ became much faster.
> >
> > I think the question is why you would want to run peek-remote.
> > Do you use the ^{} peeled-onion information and if so how and
> > why?
>
> My wild guess would be to attach tags to the right commits in qgit?
>
Yes. It is. From a list like

> > > d9b0f913ce0508fcc83e642e0241f373428368e5        refs/tags/v1.4.3
> > > e0b0830726286287744cc9e1a629a534bbe75452        refs/tags/v1.4.3^{}
> > > 4314f5982d2aac08001a977fc0b1b611e858e025        refs/tags/v1.4.3-rc1
> > > 1965efb1599f59b8e3380335d1fa395e2008a30b        refs/tags/v1.4.3-rc1^{}
>
qgit (but also gitk FWIK) extracts

e0b0830726286287744cc9e1a629a534bbe75452
1965efb1599f59b8e3380335d1fa395e2008a30b

Stores in a quick look-up container and then checks against loaded
commits to, as Pasky says, attach the nice green markers to tags.

