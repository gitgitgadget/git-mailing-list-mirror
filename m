From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 15:54:26 -0400
Organization: Twitter
Message-ID: <1438113266.18134.26.camel@twopensource.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAxM-0000Zo-PD
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbbG1Ty3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:54:29 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35916 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbG1Ty2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:54:28 -0400
Received: by qkdv3 with SMTP id v3so55962036qkd.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ZMkOSEEtlbLvDis3kG6wCa/AkbxNKPZpeKA6aQlahzM=;
        b=mbXhgH+7TfzWGrWn85qiZdXBp8RT2S+8/ekW+WAhMOO6x43ZFn7ZnImsuDhE/QdL6t
         uEQ7EwnWRKs6CQIrN2K3fne+OWwRjvflRzDkWLm0AvIjfUXcFDahpA14FknF52a0Nch1
         WZVlzZQ6AymqYYSGaK3FLfJmyWHAMsiYbnne+X8/cZ4f+XVdNQLpicGMnSawN7mBiYb1
         HfgGGS5XVB86hB9TAmsoKkRNIvpCOHAzNmzWx/6TpE9imniCw4sfj+e3zsDU7sCWU4RW
         V+WnAi/SWnaAQa7rpG8Tt2QhXugmoS1Z+miP2YmUVnGW37NC9HKYHK7ONifOXQKNQOxx
         SCsQ==
X-Gm-Message-State: ALoCoQkXlfj4VZx/0wdAu1rN2TIOtO1FE8KtojHNFdMNwYliob6DjhW2qTWbaarN6L8Slc8cO6ZY
X-Received: by 10.55.23.33 with SMTP id i33mr51133883qkh.89.1438113267952;
        Tue, 28 Jul 2015 12:54:27 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id o5sm11867367qko.49.2015.07.28.12.54.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 12:54:27 -0700 (PDT)
In-Reply-To: <xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274822>

On Tue, 2015-07-28 at 12:50 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > When we unpack trees into an existing index, we discard the old index
> > and replace it with the new, merged index.  Ensure that this index has
> > its cache-tree populated.  This will make subsequent git status and
> > commit commands faster.
> 
> Wouldn't it make repeated calls to "git merge" and friends to build
> a long history slower, when the user does not run "git status" in
> between?  E.g. "git cherry-pick -4 $other_topic", where you would
> not even have a chance to run "git status" in the middle.  What do
> the pros-and-cons look like?

I have not benchmarked, but I suspect it would not make those slower.

The work done to produce the cache-tree is work that the commit would
otherwise have to do.  So we're spending extra time in one place to
eliminate that work in a different place.
