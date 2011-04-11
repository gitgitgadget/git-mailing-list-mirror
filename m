From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 16:18:02 +0530
Message-ID: <20110411104801.GA18448@kytes>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <201104110518.04413.chriscool@tuxfamily.org>
 <20110411044900.GA20939@kytes>
 <201104110820.20342.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 12:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Efv-00022C-TI
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 12:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab1DKKsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 06:48:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59346 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab1DKKst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 06:48:49 -0400
Received: by iwn34 with SMTP id 34so5494381iwn.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OfOciHdTZkalai5IUv6KUuBWIxktxtfF6R56dP+MXyY=;
        b=P6Be2SdqL7WbwEEFLyLBghWWDmVQZ1VWboBNhh/dlrR+x+ISju+xV5t9NVXwOXd4lm
         9YZeGTFJSoFXFtScYoF9L/IL0qpUE87U1iJAtJfwSlxt6pjq2zySAon92s4rUyJLnqa0
         WbRLJMmnMDP8GoDOMnKquD31X0DGyaZb8Adko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ec398EPkdltYyUJI1FBc8yUDmIJ9l+ZNLK1Gs0boK6TU+vtg8E9xRUrF+99ebb1uY5
         4YMEsgYngGolLdPEmHHl0cO0fbS6vd6iejAa5Ex8tZNRMsOav+eem0pz7WiC4SVNPOoS
         DACiivcuZrpt12kh8/OzoJ1ovK0RLLVblvDzs=
Received: by 10.43.46.136 with SMTP id uo8mr3670799icb.346.1302518929243;
        Mon, 11 Apr 2011 03:48:49 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e9sm4151362ibb.15.2011.04.11.03.48.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 03:48:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104110820.20342.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171327>

Hi Christian,

Christian Couder writes:
> On Monday 11 April 2011 06:49:05 Ramkumar Ramachandra wrote:
> > > > 3. From the format of the TODO and DONE files, one more thing should
> > > > be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> > > > format.  This part will go into the sequencer.  Then I'll use a
> > > > cherry-pick specific file to keep the command-line options.  Yes, I'm
> > > > trying to work on Daniel's idea [3] from the very start.  Is this a
> > > > good idea?
> > > 
> > > I think that the TODO and DONE file format will need at one point to
> > > include options and it is simpler if this change is done early. Using a
> > > cherry-pick specific file to keep the options is not very generic for a
> > > sequencer that could be used for many things.
> > > 
> > > For example, as we have rebase --interactive, we will probably want to
> > > have cherry-pick --interactive, and when editing the TODO file we might
> > > want to use different cherry-pick options when picking different
> > > commits.
> > 
> > Point noted -- I shouldn't narrow down the various things I can do
> > with a single commit early on and lock us into a more restrictive
> > design.  However, I'm not in favor of making it too generic; I
> > certainly wouldn't like to edit an instruction sheet that looks like
> > this:
> > 
> > cherry-pick -m 1 -s -r 83a4fe9
> > revert -n 3a6fe42
> > cherry-pick -x --ff dacfe41
> > cherry-pick -s recursive -Xpatience b31d4e2
> 
> I wouldn't like either, but I would like it even less if it was like this:
> 
> pick 83a4fe9 # -m 1 -s -r 
> revert 3a6fe42 # -n 
> pick dacfe41 # -x --ff 
> pick b31d4e2 # -s recursive -Xpatience 
> 
> I mean that of course people should not use too many options for no good 
> reason, but if they do need to use some options, it's better if they are shown 
> like in a shell, as they will be more familiar with them this way.
> 
> There is no point of making options look different to prevent people from 
> abusing them.

You're right -- no point obscuring things.  I can't help thinking that
there must be a more elegant representation.  I'll think about it for
a while, and try to come up with something.

> > It'll become impossible to tell which options are disallowed over what
> > else, and it'll become a nightmare to debug when something goes wrong.
> > My idea is that we add commit-specific options in an optional
> > backward-compatible manner later:
> > 
> > pick 83a4fe9
> > revert 3a6fe42 # -n
> > pick dacfe41 # -s
> > pick b31d4e2
> > 
> > That way, there'll be two sets of options:
> > 
> > 1. One "global" set of command-line switches that applies
> > to all the commits, which will be written to a command-specific
> > location.  The sequencer itself knows nothing about this.
> 
> I don't see the point of this global set. And if the sequencer knows nothing 
> about it, the user may not know about it too and so may not understand how 
> things work.

Hm.  I originally wanted this so that each commit in the instruction
sheet isn't polluted with the same command-line options, but this
doesn't seem to be a good solution.

-- Ram
