Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBC381DC
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="q54Txqdh"
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111FD101
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2023082200; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=Ti77VrKMQBSWUnM9afcHrF/jwVOrFZiKe+9T2WTJXTQ=; b=q54Txq
	dhjNILkJx/8NqxI5YpDyz5jvWjsxGsivXO6Gm/bhgl4EzoLO430WU/IYIq24p5WTg7xRxVtWigxKc
	X9M6djBwGvU96S0hoiXKqExA87WKR1Mn7ri2Bw87Pg8PafjXAG0hoDSaJMDfKwcsMlQxQcR9nng4M
	B5oZuBpqIuU=;
Received: from host-2-103-195-242.as13285.net ([2.103.195.242] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1r3HvR-000AqY-EP;
	Wed, 15 Nov 2023 15:35:33 +0000
Message-ID: <dc2b2553-419b-4d93-9b72-204838a6011f@iee.email>
Date: Wed, 15 Nov 2023 15:35:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git Rename Detection Bug
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: Jeremy Pridmore <jpridmore@rdt.co.uk>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Paul Baumgartner <pbaumgartner@rdt.co.uk>
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
 <9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email>
 <CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
 <xmqqzfzimuv2.fsf@gitster.g>
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqzfzimuv2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2023 23:09, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>> Could I suggest that we are missing a piece of terminology, to wit,
>>> BLOBSAME. It's a compatriot to TREESAME, as used in `git log` for
>>> history simplification (based on a tree's pathspec, most commonly a
>>> commit's top level path).
>>
>> We could add it, but I'm not sure how it helps.  We already had 'exact
>> rename' which seems to fit the bill as well, and 'blob' is something
>> someone new to Git is unlikely to know.
> 
> Also, as Philip said, TREESAME is a concept foreign to rename
> detection codepath.  It is a property of a commit (not a tree)

That (property of a commit?) wasn't really obvious to me.

I'd always thought of it as a comparison between two trees, commonly
those associated with two commits. Though it could also be thought of as
the operation "TREESAME to" that binds in the second tree.

 and
> tells us if it has the same tree object as its relevant parents (in
> which case it can be simplified away if it is a merge).  I do not
> mind rename codepath using a jargon (or two) to express "in trees A
> and B, this subtree of A records the same tree object as a subtree
> of B at a different path (i.e., the contents of these two subtrees
> at different paths are the same)" but the word used to express that
> should not be TREESAME to avoid confusion.

Maybe it's that the explanation of TREESAME in
rev-list-options.txt#L419-L436 [1] has a similar set of confusions about
how subtrees are considered and the path v filename confusions.

  And the other word to
> express "this path in tree A records a blob object that is identical
> to this other path in tree B" should not be BLOBSAME, as the word
> strongly hints it is somehow related to TREESAME.

Yep. Naming is hard.

> 
> Thanks.
> 
> 
Philip

[1]
https://github.com/git/git/blob/master/Documentation/rev-list-options.txt#L419-L436
