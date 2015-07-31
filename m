From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 1/2] worktrees: add die_if_shared_symref
Date: Fri, 31 Jul 2015 18:08:45 -0400
Organization: Twitter
Message-ID: <1438380525.4735.26.camel@twopensource.com>
References: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
	 <CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
	 <1438377312.4735.10.camel@twopensource.com>
	 <CAPig+cRZ4PicP7J0Hdwb1+E9JbE=wsfqEaVX6X4ERST2_nJrxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 00:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLIU3-0008Ty-Kv
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbbGaWIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 18:08:51 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35890 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbGaWIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 18:08:48 -0400
Received: by qkdv3 with SMTP id v3so34029686qkd.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 15:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=LyVfUEa3s8C1OSllpRWj3C1apFtbJjH8tkdgJC31A5M=;
        b=Wv8irjr7trPseeghxZP2Fx5gMzK4x6YYOJOBzeL3s2C6MyNQFIuQ3e4UGaRUOmtTOo
         KlaeWiC6oBv8Dd30quucrEHyZNoAriP43MUgIygpxsRzXiHaK9krc6/Gi/gPWgvPGehO
         Me4o7tgSaAOpsDJdSGvv9lWQrk72kYXipL3bz/fmxXUJjkZ1xQhoE2hanEg40RIOt3zA
         pI8owIJY8UNJZMH0bmB+uu9FZWwcpVcDEhbxDPSozc9uR/ux48uzrvxMO2tgx5RIxPRR
         jfL1HAKhidSDs1Fdo1E7nBAcR2zk2tDWh86hE2WXIxEzu9sKlRKIznnSkbFH2j8Z5/yi
         CtSA==
X-Gm-Message-State: ALoCoQmRLNm+cuEC9POhlzSalzOcq3Fx8YPMsVxNFFYWbEJBcz8OSUM4xzAZfvP6TPpQLhhBihL/
X-Received: by 10.55.26.151 with SMTP id l23mr8082347qkh.10.1438380527929;
        Fri, 31 Jul 2015 15:08:47 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 60sm2902532qgy.37.2015.07.31.15.08.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2015 15:08:46 -0700 (PDT)
In-Reply-To: <CAPig+cRZ4PicP7J0Hdwb1+E9JbE=wsfqEaVX6X4ERST2_nJrxw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275084>

On Fri, 2015-07-31 at 17:36 -0400, Eric Sunshine wrote:
> On Fri, Jul 31, 2015 at 5:15 PM, David Turner <dturner@twopensource.com> wrote:
> > On Fri, 2015-07-31 at 15:35 -0400, Eric Sunshine wrote:
> >> On Fri, Jul 31, 2015 at 3:01 PM, David Turner <dturner@twopensource.com> wrote:
> >> > Add a new function, die_if_shared_symref, which works like
> >> > die_if_checked_out, but for all references.  Refactor
> >> > die_if_checked_out to work in terms of die_if_shared_symref.
> >> >
> >> > Soon, we will use die_if_shared_symref to protect notes merges in
> >> > worktrees.
> >>
> >> I wonder if the diagnostic:
> >>
> >>     'blorp' is already checked out at '/path/name/'
> >>
> >> emitted by check_linked_checkout() needs to be adjusted for this
> >> change. It still makes sense for die_if_checked_out(), but sounds odd
> >> for die_if_shared_symref().
> >
> > How about:
> >
> > 'refs/notes/y' is already referenced from 'NOTES_MERGE_REF' in
> > '/home/dturner/git/t/trash directory.t3320-notes-merge-worktrees/'
> >
> > Does that make sense?
> 
> That might be the best we can do for the generic case of
> die_if_shared_symref(), but I wonder how easily the typical user would
> understand it when trying to checkout a branch already checked out
> elsewhere. One concern is that that message almost comes across as an
> internal Git error (thus inscrutable), whereas:
> 
>     % git checkout blorp
>     'blorp' is already checked out at '/some/path/'
> 
> seems (to me) pretty clearly a user error, thus more easily understood.

Sorry, I meant that for the non-HEAD case.  For the
die_if_already_checked_out case, the original error message would
remain.

But I'll just go ahead and do it the nice way.
