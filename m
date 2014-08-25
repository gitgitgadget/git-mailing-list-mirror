From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Mon, 25 Aug 2014 11:26:36 -0700
Message-ID: <20140825182636.GO20185@google.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com>
 <20140822154151.GK20185@google.com>
 <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
 <20140822184515.GL20185@google.com>
 <20140823054646.GA18256@peff.net>
 <CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLyya-0004QF-5V
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbaHYS0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:26:40 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47581 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaHYS0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:26:39 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so20757029pdj.16
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WAkiJ1gEnXC7RLTF26ZQ/Xixju8PZNM3jHhfmdRWLBc=;
        b=vafGCA7A4cntl3uCt9BM7JbKN5PFgqQwtKod4VGQVK6woQuTy7w3efjgEqtdsKLKm6
         AyeHbe30X+0d8b0cmECwjsRh0GAG4YtXnE4eKCVwBXFZdv0HF2c5ZewSil7hT3PEltqw
         YQsp70TUUWllHCJ6t/emM98DfQdc43siW/Q8l4raFrsvot9M/5BFxF3/+fQ0j6J5866u
         40Q7e6QtYf/P1FfwCOtos4AXA9DKddVTJBJbHjKOvtYeeqhN5/76Ex9SrWXVLIsOQTQj
         StnmG3UOyoRcUjoe9yaiy/eNYAGHFlh2JcOmHW6bDMVb2VXzt21UR/6RfuRkeZd80hOZ
         WpMQ==
X-Received: by 10.70.102.175 with SMTP id fp15mr30524040pdb.52.1408991199314;
        Mon, 25 Aug 2014 11:26:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5425:d689:6054:193])
        by mx.google.com with ESMTPSA id b9sm447697pbu.91.2014.08.25.11.26.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 11:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255847>

Ronnie Sahlberg wrote:
> On Fri, Aug 22, 2014 at 10:46 PM, Jeff King <peff@peff.net> wrote:

>> Yeah, this weird "do not allow refs/foo" behavior has continually
>> confused me. Coincidentally I just noticed a case today where
>> "pack-refs" treats "refs/foo" specially for no good reason:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/255729
>>
>> After much head scratching over the years, I am of the opinion that
>> nobody every really _meant_ to prevent "refs/foo", and that code
>> comments like the one you quote above were an attempt to document
>> existing buggy behavior that was really trying to differentiate "HEAD"
>> from "refs/*". That's just my opinion, though. :)

It's still very puzzling to me.  The comment came at the same time as
the behavior, in v0.99.9~120 (git-check-ref-format: reject funny ref
names, 2005-10-13).  Before that, the behavior was even stranger ---
it checked that there was exactly one slash in the argument.

I'm willing to believe we might not want that check any more, though.

[...]
> There are also a lot of places where we assume that a refs will start
> with "refs/heads/" and not just "refs/"
> for_each_branch_ref(), log_ref_setup() (so no reflogs) is_branch() to
> name a few.

for_each_branch_ref is for iterating over local branches, which are
defined as refs that start with refs/heads/*.  Likewise, the only
point of is_branch is to check whether a ref is under refs/heads/*.
That's not an assumption about all refs.

log_ref_setup implements the policy that there are only reflogs for:

 * refs where the reflog was explicitly created ("git branch
   --create-reflog" does this, but for some reason there's no
   corresponding "git update-ref --create-reflog" so people have
   to use mkdir directly for other refs), plus

 * if the '[core] logallrefupdates' configuration is enabled (and it
   is by default for non-bare repositories), then HEAD, refs/heads/*,
   refs/notes/*, and refs/remotes/*.

This is documented in git-config(1) --- see core.logAllRefUpdates.

That way, when tools internally use other refs (e.g., FETCH_HEAD),
git doesn't have to automatically incur the cost of maintaining the
reflog for those.  What other refs should there be reflogs for?  I
haven't thought carefully about this.

It definitely isn't an assumption that *all* refs will match that
pattern.  But it might be worth changing for other reasons.

Jonathan
