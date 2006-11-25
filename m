X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 10:16:19 +0100
Message-ID: <8c5c35580611250116h466e3649p2630ee6641b6e6f4@mail.gmail.com>
References: <1164409429445-git-send-email-hjemli@gmail.com>
	 <7v1wns6q41.fsf@assigned-by-dhcp.cox.net>
	 <20061125064901.GB4528@spearce.org> <ek9078$m2j$1@sea.gmane.org>
	 <20061125085731.GG4528@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 09:16:33 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XaJrIRhJIxL6sGxjn372fkAnhSN+onWCFQ3ez5nQYuzER2IeYjwbv41wcUIYUPl6Rm6UgyKBzfD6JTD1WEiOKISd7YLkxXjrAMoZDzbHvS+WrjhpD6OPiQ7xbpieTE4tcjo8rhdn1z6lhiZVGoW/gpr7ppbSW74fx4S2hsclWiw=
In-Reply-To: <20061125085731.GG4528@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 1eae0782222197ab
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32271>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnte9-0001uA-KF for gcvg-git@gmane.org; Sat, 25 Nov
 2006 10:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966308AbWKYJQW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 04:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966312AbWKYJQW
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 04:16:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:47515 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S966310AbWKYJQV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 04:16:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1511313nfa for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 01:16:20 -0800 (PST)
Received: by 10.82.109.19 with SMTP id h19mr1697990buc.1164446179992; Sat, 25
 Nov 2006 01:16:19 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Sat, 25 Nov 2006 01:16:19 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 11/25/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > And of course reflog should store the fact of renaming branch.
>
> Yes, I think that's a worthwhile thing to log.  Problem is the
> logging system tends to throw away pointless entries (sha1 ->
> same sha1) so the rename log entry needs to be forced somehow...

Is it ok to put

static int log_ref_write(struct ref_lock *lock,
	const unsigned char *sha1, const char *msg)

into refs.h?

Then it should be possibly to do something like this:

  lock = lock_ref_sha1(ref, sha1);
  lock->force_write = 1;
  log_ref_write(lock, sha1, "Renamed oldname to newname");
  unlock_ref(lock);

...after moving the reflog...

-- 
