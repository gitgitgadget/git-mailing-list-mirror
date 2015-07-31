From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 1/2] worktrees: add die_if_shared_symref
Date: Fri, 31 Jul 2015 17:15:12 -0400
Organization: Twitter
Message-ID: <1438377312.4735.10.camel@twopensource.com>
References: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
	 <CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 23:15:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLHeK-0005DF-DT
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbbGaVPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:15:20 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35396 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbGaVPP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 17:15:15 -0400
Received: by qkbm65 with SMTP id m65so33610437qkb.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 14:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=v2Y+ULssAM6ngrLTnzfFSw8nytYRkDbF0rMO8P9bZIU=;
        b=DlE+yCZ+sCQT+by52Myk1CR7D5GAWFgvaRqbsw7zAwku3dQEoRATRCKjOU1UayE95F
         vr+UCBp4ZhR5gIYD2OJBM3S8Zn7A/kcwROy7F9NFED4goh91dvWTjp+dfW3lKqlI+Brs
         JfKP/JIoHuZYjuHk70xqvOFPTxHn5Qd8V9FGFULhH6PN+w8XeSUsIShRmGHG70l0Iq+8
         6zmX8kie4JgwlANfc0+19bMZiI2ukCv/1iHhsg2qSuT2lMCIhQFoTzmwJpx9gRR+jNqB
         SXaSjMcyBWA8QfAzYomxGeJoLlVudefdCCtEmg9vJUw/FHjFB2vREsVTU1dwmfSOjQSK
         bBtw==
X-Gm-Message-State: ALoCoQlXXJOeJnfICCiOLpQTCRfAMYrKvg9sCQa/p6WspvLC4edAaupRh8HCXnWB6OwLBqqU53Vu
X-Received: by 10.55.15.147 with SMTP id 19mr7753103qkp.81.1438377314379;
        Fri, 31 Jul 2015 14:15:14 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id g6sm2845057qgd.10.2015.07.31.14.15.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2015 14:15:13 -0700 (PDT)
In-Reply-To: <CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275077>

On Fri, 2015-07-31 at 15:35 -0400, Eric Sunshine wrote:
> On Fri, Jul 31, 2015 at 3:01 PM, David Turner <dturner@twopensource.com> wrote:
> > Add a new function, die_if_shared_symref, which works like
> > die_if_checked_out, but for all references.  Refactor
> > die_if_checked_out to work in terms of die_if_shared_symref.
> >
> > Soon, we will use die_if_shared_symref to protect notes merges in
> > worktrees.
> 
> I wonder if the diagnostic:
> 
>     'blorp' is already checked out at '/path/name/'
> 
> emitted by check_linked_checkout() needs to be adjusted for this
> change. It still makes sense for die_if_checked_out(), but sounds odd
> for die_if_shared_symref().

How about:

'refs/notes/y' is already referenced from 'NOTES_MERGE_REF' in
'/home/dturner/git/t/trash directory.t3320-notes-merge-worktrees/'

Does that make sense?

It's not the only place in the error messages that mentions
NOTES_MERGE_REF, so I think we expect users to understand
NOTES_MERGE_REF.  The alternative is to move the error handling to an
even higher level so we can give a notes-specific message.  I don't
think that's necessary, but I'll do it if others do.

<snip; will fix>
> > + */
> > +extern void die_if_shared_symref(const char *symref, const char *branch);
> 
> s/branch/referent/ or something?

I went with "target" (by analogy to the target of a symlink).  
