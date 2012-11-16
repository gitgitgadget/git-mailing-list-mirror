From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Local clones aka forks disk size optimization
Date: Fri, 16 Nov 2012 12:25:29 +0100
Message-ID: <50A622A9.4040709@drmicha.warpmail.net>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com> <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com> <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com> <CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com> <CAH5451m4saVa7-NLbVbXp7q8ca5_0N4FLk3wYaqxLT=AE5frbw@mail.gmail.com> <CALZVapmBM78UtjAiNm2VoeWuetCiyxN70mTxbG14SQh5a5RCeQ@mail.gmail.com> <CAH5451=Tk=zjkYbK0720VBkAA12VRCAE_Dx8bBkoXba60ho8AA@mail.gmail.com> <CAMK1S_ioQQWXaOO8Na=7M4QhaaUNQ8ySVM-E_2bk6m4TyvRpeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Javier Domingo <javierdo1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 12:25:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZK3Y-0000iD-IO
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 12:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab2KPLZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 06:25:34 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39725 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749Ab2KPLZc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 06:25:32 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DAE44205AB;
	Fri, 16 Nov 2012 06:25:30 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 16 Nov 2012 06:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=7nBJOTxX0uJ6Xxc6kCAQRX
	18RC8=; b=m3ZM6vM2nF2RBYbssxL/ZXtkqVymDWfYeFbiBIA9/EQPriRUGs9U76
	tbAgbitNoFZKC26v1WXupW4F9Ky+qxkZqirYCf7z70wjy0wmeTI7sV5uFx8hwhPO
	YuANetpnODaZJEahHAgyJyaCCakOUC4sFErNBrUaC1m51jaBPpGWU=
X-Sasl-enc: 7Jc/DE+DoHwpNm2Va4AjvdwxR8sL1diL10sJAwpGG1TM 1353065130
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2D50F8E01F8;
	Fri, 16 Nov 2012 06:25:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMK1S_ioQQWXaOO8Na=7M4QhaaUNQ8ySVM-E_2bk6m4TyvRpeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209871>

Sitaram Chamarty venit, vidit, dixit 15.11.2012 04:44:
> On Thu, Nov 15, 2012 at 7:04 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>> On 15 November 2012 12:15, Javier Domingo <javierdo1@gmail.com> wrote:
>>> Hi Andrew,
>>>
>>> Doing this would require I got tracked which one comes from which. So
>>> it would imply some logic (and db) over it. With the hardlinking way,
>>> it wouldn't require anything. The idea is that you don't have to do
>>> anything else in the server.
>>>
>>> I understand that it would be imposible to do it for windows users
>>> (but using cygwin), but for *nix ones yes...
>>> Javier Domingo
>>
>> Paraphrasing from git-clone(1):
>>
>> When cloning a repository, if the source repository is specified with
>> /path/to/repo syntax, the default is to clone the repository by making
>> a copy of HEAD and everything under objects and refs directories. The
>> files under .git/objects/ directory are hardlinked to save space when
>> possible. To force copying instead of hardlinking (which may be
>> desirable if you are trying to make a back-up of your repository)
>> --no-hardlinks can be used.
>>
>> So hardlinks should be used where possible, and if they are not try
>> upgrading Git.
>>
>> I think that covers all the use cases you have?
> 
> I am not sure it does.  My understanding is this:
> 
> 'git clone -l' saves space on the initial clone, but subsequent pushes
> end up with the same objects duplicated across all the "forks"
> (assuming most of the forks keep up with some canonical repo).
> 
> The alternates mechanism can give you ongoing savings (as long as you
> push to the "main" repo first), but it is dangerous, in the words of
> the git-clone manpage.  You have to be confident no one will delete a
> ref from the "main" repo and then do a gc or let it auto-gc.
> 
> He's looking for something that addresses both these issues.
> 
> As an additional idea, I suspect this is what the namespaces feature
> was created for, but I am not sure, and have never played with it till
> now.
> 
> Maybe someone who knows namespaces very well will chip in...
> 

I dunno about namespaces, but a safe route with alternates seems to be:

Provide one "main" clone which is bare, pulls automatically, and is
there to stay (no pruning), so that all others can use that as a
reliable alternates source.

Michael
