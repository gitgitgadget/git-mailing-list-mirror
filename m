Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E73E469
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB23A2
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:13:18 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 539FD24184;
	Tue, 24 Oct 2023 16:13:15 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvNm7-xAU-00; Tue, 24 Oct 2023 22:13:15 +0200
Date: Tue, 24 Oct 2023 22:13:15 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
Message-ID: <ZTglW0fQnSTV+TnD@ugly>
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
 <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com>
 <xmqqpm143p46.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqpm143p46.fsf@gitster.g>

On Tue, Oct 24, 2023 at 10:30:01AM -0700, Junio C Hamano wrote:
>Phillip Wood <phillip.wood123@gmail.com> writes:
>>>> Unfortunately "fixup -C" only copies the commit message not the
>>>> authorship
>>> 
>>>> (that's usually a good thing
>>>>
>>> why? what would that be useful for?
>>> it seems rather counter-intuitive.
>>
>> In the same way that you do not want to change the author date when
>> using a fixup to move a small hunk from one commit to another most
>> users do not want to update the author information when they make a
>> small change to a commit message using "fixup -C"
>
>Exactly. [...]
>I wouldn't be able to use "rebase -i" to
>make typofixes to commits made out of received patches if the
>operation changes the authorship.
>
>> "fixup -c/-C" were conceived as a way to reword a commit message at
>> the same time as optionally fixing up the commit's content.
>
>Yup, it still is a "fix", meaning the identity and the spirit of the
>commit being fixed are unchanged.  What it aims to achieve, how it
>implements the behaviour it wants to give its users, who thought of
>that change, all that are the same as the original.
>
ok, i think i finally got it. it would have never ocurred to me to make 
a command for that - i just use "squash" and throw away the extra lines.  
but i guess it sort of makes sense if you use rebase as a 
non-interactive execution backend for instructions that are fully 
determined long in advance by heaping commits at the end.

> It may be a nice addition to optionally allow users to use 
> --reset-author (or better yet, --author="Na Me <a@dd.re.ss>") with 
> "fixup"
>
that's kind of the opposite of what i'd want - the "pre-fixup" commit 
already has the equivalent of that by virtue of being fresh. so it would 
be more like --copy-author. but i'd go with adding -ca/-CA variants 
instead, for brevity.

>but if the "-c" variant can be concluded with "commit --amend 
>--reset-author" to achieve the same effect, that may be sufficient.
>
from the above follows that the equivalent of my original request would 
be appending "exec git commit --amend -C <orig>" to the "pick 
<pre-fixup>" + "fixup <orig>" commands. which is of course horrible, and 
i'd never remember to actually do that. it will be hard enough to 
retrain myself to use -CA instead of -C.

regards

