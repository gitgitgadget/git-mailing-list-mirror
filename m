From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH v2 0/2] clone: simplify progress message
Date: Mon, 10 May 2010 16:22:54 -0700
Message-ID: <4BE8954E.3030405@pcharlan.com>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net> <4BE7166A.5030107@pcharlan.com> <20100510054756.GB13340@coredump.intra.peff.net> <4BE7E09F.3040303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 11 01:23:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBcK9-00055l-TH
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 01:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743Ab0EJXXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 19:23:04 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:60354 "EHLO
	swarthymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757428Ab0EJXW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 19:22:56 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a2.g.dreamhost.com (Postfix) with ESMTP id 1306FEE873;
	Mon, 10 May 2010 16:22:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4BE7E09F.3040303@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146860>

On 05/10/2010 03:31 AM, Michael J Gruber wrote:
> Jeff King venit, vidit, dixit 10.05.2010 07:47:
>> On Sun, May 09, 2010 at 01:09:14PM -0700, Pete Harlan wrote:
>> 
>>>> I guess it comes down to how much detail we want to show.
>>> 
>>> For me it isn't only a matter of detail; I find "Cloning into 
>>> bar/.git" misleading, since bar is getting more than a .git 
>>> directory.
>> 
>> Yeah, I can buy that line of reasoning. Junio's nitpick aside, I 
>> think most users perceive the clone process as creating the whole 
>> "bar" directory.
>> 
>>> Thank you for looking at this.  I agree with you, and have added 
>>> a second patch that implements that.
>> 
>> These patches look good to me. I agree with Junio about just 
>> squashing them.
>> 
>> -Peff
> 
> Back from a conference, I'm being late for the party (Which way
> round is better? ;) ).
> 
> But I still want to suggest not sacrificing correctness for "user's 
> expectations" and rather trying to do combine them. So how about 
> saying
> 
> Cloning into $GIT_DIR... Checking out branch $branch in $WORK_DIR...
> 
> where the latter happens for non-bare repos only, of course, and 
> incidently confirms the use of "-b" or of the default.
> 
> Michael

Thanks for looking at this.  The patch you posted reports, e.g.:

  % git clone foo bar
  Cloning into /tmp/git/bar/.git...
  done.
  Checking out branch master into worktree bar.
  %

I'd like to see "worktree" either omitted or replaced with "working
directory".  Git works on trees, but "working directory" is a term
ordinary users understand and "bar" is a directory being populated
with files so there's nothing wrong with the user thinking of it that
way.

But on a different note, I think we don't have to be so verbose.  If
the user asks for details with -v then be as chatty as we want, but
for the most part operations that succeed should do so quietly.

My original (unsent) patch was based on master from a couple of weeks
ago and was merely going to remove the db-initialization message and
replace it with nothing, so a successful local clone would look like:

  % git clone foo bar
  %

I don't think it needs to be more complicated than that.  And there's
real value in silent success: every message output has to be read by
the user because it might be an error message.

Since Junio solved the original problem in a different way (still
reporting a message but making it less scary) I made a patch to make
his message more (in my opinion) friendly, but I think output from
normal commands should be as simple as possible.

At my previous job I converted a team of ten or so people from
Subversion to Git, and virtually everyone on the team besides myself
considered Git difficult to use and not worth the trouble.  We didn't
have enough time with it (three months) so I couldn't tell if they
ever would have come around, but each little thing that a user could
perceive as complicated adds up.

So: I'm fine with your patch (with a removed "worktree" or replace it
with "working directory") if writing a thorough message is considered
desirable.  But my vote is for more simple output (as in my patches),
or better yet nothing at all unless there's a problem.  The user can
ask for progress with -v if they want it.

--Pete
