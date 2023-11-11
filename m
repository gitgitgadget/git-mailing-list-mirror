Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7E18E31
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="mWEz+UO+"
X-Greylist: delayed 20754 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 08:54:10 PST
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB36258D
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2023082200; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=pbKtmcenINbQW/FKYCouVbb3N0Ul5uH1iwYu6WOfVGU=; b=mWEz+U
	O+p8XfAqrDx0xrBSbWyvcd6X31PV1ShPCIxb6+RFr/PUNs/AUje9btNcH1fpCu9VMeQk/Nb2YKeq8
	TwsyrXEK1bwrEAMZIbgYtR5D0JDrLIPo7YPDQfbNdgJuVfkaKtSVmzO1u0Wb1jkDK1vtZk099HES2
	rmV5vC42N20=;
Received: from [2.103.195.242] (helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1r1lqW-0001yy-7H;
	Sat, 11 Nov 2023 11:08:12 +0000
Message-ID: <9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email>
Date: Sat, 11 Nov 2023 11:08:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git Rename Detection Bug
To: Elijah Newren <newren@gmail.com>, Jeremy Pridmore <jpridmore@rdt.co.uk>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Paul Baumgartner <pbaumgartner@rdt.co.uk>
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
Content-Language: en-GB
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 11/11/2023 05:46, Elijah Newren wrote:
> The fact that you were trying to "undo" renames and "redo the correct
> ones" suggested there's something you still didn't understand about
> rename detection, though.


Could I suggest that we are missing a piece of terminology, to wit,
BLOBSAME. It's a compatriot to TREESAME, as used in `git log` for
history simplification (based on a tree's pathspec, most commonly a
commit's top level path).

File rename, at it's most basic, is when the blob associated with that
changed path is identical, i.e. BLOBSAME. There is no need to 'record'
the action of renaming, moving or whatever, the content sameness is
right there, in plain sight, as an identical blob name. After that
(files with slight variations) it is a load of heuristics, but starting
with BLOBSAME we see how easy the basic rename detection is, and why
renames (and de-dup) don't need recording.

The heuristics of 'rename with small change' is trickier, but for a
basic understanding, starting at BLOBSAME (and TREESAME for directory
renames) should make it easier to grasp the concepts.

--

Philip
