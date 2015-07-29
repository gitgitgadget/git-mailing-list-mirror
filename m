From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 19:17:31 -0700
Message-ID: <xmqqd1zbbtc4.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:17:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKGw6-0005YL-JF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 04:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbbG2CRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 22:17:34 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34782 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbG2CRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 22:17:33 -0400
Received: by pdbbh15 with SMTP id bh15so80421014pdb.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 19:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eIC25Zpjb1GqqIlfIcrGmJOEv2fMVUlGux0UspJ5LVA=;
        b=PAEFAqrZNugyFNSrSth3k+wOVFdDqksNdiUgARjVFzvENds27FsI/ScScnNAV/l8sv
         4POwAlVkZTKx8tZtGiILI7cslU84Uz+bdhQqGCmFBeJa2GTUrdxVaNWwcLGKBLlcN1/E
         IiZywvCZhOeS9r9hYwb5Jeed5O82QTJhEOzaQlxRkDrK7iGadAqc9vni4etqUndy/HhU
         pwf6o66fh6qmaWrWco/SePFrCrHFKN8zUYXu0OQcZQYUI6ELnHmKKoaUIoor14BQJ6hR
         nC6KsvXJuZ0swt+kihM9KUX/TNBerQfxRsyqZ6PSashtcBzS1ICqij6TFSh+6vnokT/b
         9wUQ==
X-Received: by 10.70.21.161 with SMTP id w1mr693086pde.169.1438136253019;
        Tue, 28 Jul 2015 19:17:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id fk5sm37692456pab.40.2015.07.28.19.17.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 19:17:31 -0700 (PDT)
In-Reply-To: <CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 01:43:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274874>

Johan Herland <johan@herland.net> writes:

> In fact, you can easily do a notes merge in a _bare_ repo...

You keep repeating that but I do not think it is relevant at all.

If you have a bare repository, you either

 (1) do not have any worktree associated with it; or

 (2) have worktrees associated with it elsewhere, but its parent
     directory is *not* the root of any worktree.

If (1), what are found outside GIT_COMMON_DIR (e.g. HEAD) is found
inside GIT_DIR, so if we leave NOTES_MERGE_REF and friends outside
GIT_COMMON_DIR and create the NOTES_MERGE_WORKTREE in GIT_DIR, that
would work just as fine as it currently does.

If (2), what are found outside GIT_COMMON_DIR (e.g. HEAD) is still
found inside GIT_DIR (that is now per worktree, but for your bare
repository, that is the repository directory itself).  Again, if we
leave NOTES_MERGE_REF and friends outside GIT_COMMON_DIR and create
the NOTES_MERGE_WORKTREE in GIT_DIR, that would work just as fine as
it currently does.

And as long as NOTES_MERGE_REF is made per $GIT_DIR ("per worktree"
is the phrase I am refraining deliberately here, because all the
worktrees have their own private area, and in addition, your bare
repository has one, too) that is protected against "multiple
checkout", all worktrees and your bare repository can perform
independent notes-merges.

Perhaps you meant by "per repo" to mean "per $GIT_DIR" in this
message, and if that is the case, then I think we are in agreement.
