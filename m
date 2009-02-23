From: Gerd Knops <gerti-git@bitart.com>
Subject: Re: Getting diff in commit-msg hook?
Date: Mon, 23 Feb 2009 12:58:59 -0600
Message-ID: <D857B1FF-A49F-4158-852A-FCCB19FFD06C@bitart.com>
References: <loom.20090222T205429-30@post.gmane.org> <7vhc2lx4mc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbg9C-0004O0-3P
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 20:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZBWTFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZBWTFy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 14:05:54 -0500
Received: from mail.bitart.com ([75.146.45.42]:39579 "EHLO
	mail.summitsite.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbZBWTFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 14:05:54 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Feb 2009 14:05:54 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.summitsite.info (Postfix) with ESMTP id D84072220336;
	Mon, 23 Feb 2009 12:59:16 -0600 (CST)
X-Virus-Scanned: Debian amavisd-new at localhost
Received: from mail.summitsite.info ([127.0.0.1])
	by localhost (summitsite.summitsite.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hemvB8Q1gyFi; Mon, 23 Feb 2009 12:59:14 -0600 (CST)
Received: from [192.168.42.242] (unknown [75.146.45.44])
	by mail.summitsite.info (Postfix) with ESMTPA id BD2F2222021B;
	Mon, 23 Feb 2009 12:59:14 -0600 (CST)
In-Reply-To: <7vhc2lx4mc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111171>


On Feb 22, 2009, at 8:35 PM, Junio C Hamano wrote:

> Gerd Knops <gerti-git@bitart.com> writes:
>
>> When I commit certain files, I would like to send a diff via email to
>> interested parties.
>>
>> So I added a commit-msg hook, which checks the list of files for  
>> that commit.
>> That part works fine. However in the email I would like to include a
>> diff of the file(s) in question.
>>
>> Now when I run "git diff -- '$file'", I get no output, probably  
>> because the
>> file is in some semi-committed state.
>>
>> So how can I obtain a diff for a file in a commit-msg hook?
>
> How are you getting the list of files for the commit in that commit- 
> msg
> hook?  I think you are doing something like
>
> 	"git diff --cached --name-only"
>
Actually I was parsing the comments from the proposed log message, but  
that
was a bad idea as there are no comments when using "git commit -m  
msg". The
above command works much better, thanks!

> The new state you are committing is in the index, and "the diff for  
> the
> commit" is "what is the difference between the state of the previous
> commit and the state of this commit records", so
>
> 	" git diff --cached"
>
> should give you what you want (and you do not need to do that per  
> path.
>
I could swear I tried that... Anyhow, working as advertised. Thanks  
again!


> Having said all that, I imagine you would realize that you do not  
> want to
> do this inside any of the hooks triggered by "git commit", as you  
> learn to
> work with git more.  I suspect you would probably find a hook  
> triggered
> when you push into another repository is more appropriate place for  
> doing
> this kind of thing.

You are right, it would make more sense to have a hook on the remote
(subversion) repository, but for various reasons it is much easier for
me to add a hook on my end. Ideally I'd have a local hook for
"git svn dcommit" that would let me get the list of committed files,
filter for the ones I am interested in and email the diff. But I was
not able to find such a hook.

Thanks for your help!

Gerd
