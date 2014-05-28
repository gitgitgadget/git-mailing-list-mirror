From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: optionally reject case-clone branch names
Date: Wed, 28 May 2014 13:56:31 -0400
Organization: Twitter
Message-ID: <1401299791.18134.74.camel@stross>
References: <1401231368.18134.63.camel@stross>
	 <xmqq7g55esg5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:56:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpi5f-0008ID-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbaE1R4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:56:34 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:37658 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaE1R4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:56:34 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so18589503qgf.21
        for <git@vger.kernel.org>; Wed, 28 May 2014 10:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=1JLbkxNzzmK1pc10eEjcl3OzJPF0GMBdbOSwNvCcnLs=;
        b=SfEGLpbKPcO+AMN1D+aif4Wj207ccy9i90sOR/guP2Jm0OLZYuSTJjU89R2/Ao0q2f
         TfO8QZuH5YlX8Zsr3j+fi3Bmw0NYLkO7ZJP6Gj1PMj1W9grJgH9Qtes7lzNkZezKZ9s0
         8BFQF4BbD/HnX8hqIniYy4XciEAVozEel0fUgDtxq40Hy0SLOCbGEcYRMGUUgZvPvtIN
         KaGI6xdGZGJUV0dJ//arUGB8t7EllCoDnd6hDn7jWZK8QAnA9ae6KH6mwLj/7M17xlMA
         lyDX4PnAfqFKNWH+nSK2kBJfHC3dyX/jFkzcahgDL/6Y+AU3mTjD66V4HqzbEVKvGSjh
         eMqg==
X-Gm-Message-State: ALoCoQlCmEEviPB+uLGLstokQK84YJFpm1pdDHK8Na/+tCI5RVYridzO3q7WMRDG2NWGv2kS8e7S
X-Received: by 10.140.82.180 with SMTP id h49mr1792138qgd.84.1401299793101;
        Wed, 28 May 2014 10:56:33 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id j3sm31560718qaf.6.2014.05.28.10.56.31
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 10:56:32 -0700 (PDT)
In-Reply-To: <xmqq7g55esg5.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250302>

On Wed, 2014-05-28 at 10:14 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > RFC follows:
> >
> > 1. On a case-insensitive server, git receive-pack ought to always reject
> > branches which are same-but-for-case of existing branches.
> > 2. On a case-sensitive server, the same rule by default, with an option
> > to allow the old behavior.
> >
> > Let me know if, should I write these patches, they would be likely to be
> > accepted.
> 
> There is another a lot simpler possiblity, no?
> 
> 3. On any server whose administrator chooses to enforce "one case
>    variant only" rule, install a pre-receive hook that enforces the
>    rule.

The reason I discovered this issue is that a user came to me to complain
that suddenly their pulls were failing.  Then I had to track down what
the actual problem was (a colleague actually pointed it out to me).

We could add some hooks, but we have a lot of repos, some of which
already have unique hooks that we would have to edit.  And this approach
wouldn't help the next person who gets into this situation, who would
have to again figure out what went wrong, and add the appropriate hook.

Basically, I'm trying to take a poka-yoke approach. Does this seem
reasonable?
