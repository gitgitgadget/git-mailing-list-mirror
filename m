From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Mon, 20 Aug 2012 15:35:53 +0200
Message-ID: <1701463.olu8UUX9CV@flomedio>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <5679616.CtEd2rlvlO@flomedio> <7v7gsum4oc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3S9X-0001nL-NU
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 15:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab2HTNgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 09:36:01 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41203 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab2HTNf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:35:59 -0400
Received: by bkwj10 with SMTP id j10so1856709bkw.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=7nB+q0a4HF+VjjQf1oejmHvzSTbZdxxtL/SypXgqSak=;
        b=SRnCkBFY16HgOyh0rnNKjclzgXoWRKCiwV/FOBfuRsckernABX0vatz39ewGJpxnjP
         XpqP+EBOkiyZ0vpJAjzgM2WClFcfA8UqURtClJa6WUXZmDH7j838tXkeZWB8wBHnoyEu
         wc/eWfeg//8+j1JvI6Y6MmYkw+nnFAeJyF3/CT1+ZhnmcfFuYfjhFh4izotWa+lYkuKo
         MnuBqtVrlnAHXTqjGXmHIOmY66nPFOHjcuZL/HFYEMM3+lESuKofDMk/GxzhY2YEV4qN
         JOi6rDAfrWba+ScK6UppknshQk5IwpcbUvQWcDQKMcxSbf3m+JkxUJVjV0PXHYK9qeUp
         zkTQ==
Received: by 10.205.126.13 with SMTP id gu13mr4293837bkc.79.1345469757947;
        Mon, 20 Aug 2012 06:35:57 -0700 (PDT)
Received: from flomedio.localnet (93-82-147-129.adsl.highway.telekom.at. [93.82.147.129])
        by mx.google.com with ESMTPS id n17sm6213383bks.6.2012.08.20.06.35.55
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 06:35:56 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7v7gsum4oc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203841>

On Sunday 19 August 2012 23:57:23 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> >> This change makes me uncomfortable.
> >> We are doubling up on hashing with fast-import.
> >> This introduces git-specific logic into vcs-svn.
> 
> IIUC, vcs-svn/fast-export is meant to produce a stream in the
> fast-import format, and that format is meant to be VCS agnostic,
> it would need a careful thinking to add anything Git specific to
> it.  If you make other people's importers unable to read from you
> because you tell them the contents of blob in Git's terms, that is
> not very good.

Good point.

> 
> > You have two choices of referencing that blobs later, by using a mark, or
> > by giving their sha1. Marks are already used for marking commits, and
> > there is only one "mark namespace". So I couldn't use marks to reference
> > the blobs in a nice way. This allows for referencing them by their sha1.
> 
> Surely you can, by using even and odd numbers (or modulo 4 if you
> may later want to mark trees and tags as well, but I doubt that is
> needed), no?

Currently, the mark number is equal to the svn revision number the commit 
corresponds to. I didn't want to break that, but not mandatory. We could also 
split the mark namespace by reserving one or more of the most significant bits 
as a type specifier. 
I'll develop a marks-based version ..
