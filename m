From: Angus Hammond <angusgh@gmail.com>
Subject: Re: Cherry-picking commits with empty messages
Date: Thu, 2 Aug 2012 11:10:35 +0100
Message-ID: <CAOBOgRbH_ddjW+DJiVSYt5bADEgqf_E+L9offvnF8SdH+GR50g@mail.gmail.com>
References: <20120801111658.GA21272@arachsys.com> <7vd33afqjh.fsf@alter.siamese.dyndns.org>
 <CAOBOgRZ9Ouan2htT9m3qBrUvae3nT1az3A61kiRMSJNyFv1MdQ@mail.gmail.com> <7vehnqdz9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:11:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwsMx-0005L3-1L
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 12:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab2HBKK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 06:10:58 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65248 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752436Ab2HBKK5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2012 06:10:57 -0400
Received: by lahd3 with SMTP id d3so5203349lah.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q6IzDZXHkRu1z4ySwITyJGrprU9yqh+jYvlYkKWII5U=;
        b=m3mskdYZlljc06I0c/pXsrsZIEX2nrSS8yhLisKeTWZsnDfS37v/eTjco+c9eocyOB
         xXlllBt+dAaNQ0vd1zk8S2hLWBLFQc3V9f+CfAdKAvuR7PtM2XgdKxd/PNS8eQSg6wL/
         DFDvYhy8WdxkV/H1mjbZZ5lLAIm4X2eKUICeg4WOiXpRwcbI5Q3dHKWbyOcqYjyXkJSG
         AQNZpXg8DZkWoYnDp/JUbthcGoNegTuRPw8PkFJolzvDZROSoZRWnVbbNeaUtA2AWii+
         mMOateirqQscqB47O1ei5kBpirqro4OkZRTT/YHSdC8Pb6NiC3/tIITP+6F/bi72l/nl
         eJqw==
Received: by 10.152.103.11 with SMTP id fs11mr5094140lab.23.1343902255788;
 Thu, 02 Aug 2012 03:10:55 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Thu, 2 Aug 2012 03:10:35 -0700 (PDT)
In-Reply-To: <7vehnqdz9t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202747>

On 1 August 2012 23:26, Junio C Hamano <gitster@pobox.com> wrote:
> I've read your entire response three times, and I am having a hard
> time deciding if you are against my suggestion, or you misread my
> suggestion.

My apologies, I can see how my message wasn't as clear as it could have been.

> I guess by "perpetuates" you meant there was already a commit with
> an empty message, by "the user does not want" you consider such a
> commit is a bad thing, and by "to ensure they don't TELL git", you
> meant it is the user's responsibility not to give an extra option to
> cause Git to replay a bad (= having an empty message) commit and
> leave it in the resulting history.

I was just trying to say that cherry-pick will only ever create a
blank commit message where one already exists in the repository, so
git shouldn't worry about copying that blank commit message,
especially since the user has explicitly told git (by running
cherry-pick) that they want those commits copied.

> It sounds to me that you are advocating for "git cherry-pick"
> without any flags to stop and do not commit when given a commit with
> an empty message.
>
> And that is what I thought I was suggesting.  Give users a support
> to say "git cherry-pick --allow-empty", but do not by default enable
> it.  Perhaps I sounded as if I was suggesting the opposite?

I meant the opposite, that without any flags it should just copy the
blank commit silently.

>> Secondly, I'd don't like the idea of a command that 99.9% of the time
>> will run completely independently, but then every so often will become
>> interactive.
>
> As "cherry-pick" is expected to stop and give control back whenever
> there is conflicts, this does not apply.  Any script that uses
> cherry-pick to replay an existing commit has to be prepared to see
> it stop and give control back to the script already, or the script
> is unusable.  Note that the script would not be buggy even if the
> only thing it does when it sees cherry-pick stop and give control to
> it is to abort and give control back to the user.

Fair enough, I don't make heavy use of cherry-pick, so that didn't occur to me.

Since you've pointed out that the scripting argument is invalid, I'm
now inclined to support what you originally proposed (by default
refuse to create an empty commit message, offer a flag to override
that default), but just wanted to clear up my original point since it
wasn't written very clearly.

Thanks
Angus
