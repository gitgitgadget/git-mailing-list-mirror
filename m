Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB92342513
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.59.185.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953941; cv=none; b=bZWP4Cll3sO4H0uOVQnigr0VIazyB35R8fY9sAt4Vtv+LBI5DTCXbixXPA8U2QLnf6kkq4PhXO9fo9+vrxm8ybB1VrDXDXB6h2W8r1ZEd/OyzavRDVsrJI5uTJygXLOg9AHFPE7J7u4nHL/YmB4pXdr6oHKSG1IzuBGe3TGNBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953941; c=relaxed/simple;
	bh=dFwFZrHg2z0WJ5R9BqQbmEDp3y2Vckq5nhIiVN3HEaI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VepoRfHFLUomN64L8zbIUKVm9twU7Q8qb3/GTinjkyR+CWsVaKLyJufISZB3GM67o947/MMmVGMec5au+15T9PQgTLvS1EMczWE26sUCuBC+p7IWuW+w/b1J9maJmrbhsGh8UUpybR3mryj2dziur5mjjJLfrJFzmQWju3ADAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openmail.cc; spf=pass smtp.mailfrom=openmail.cc; dkim=pass (1024-bit key) header.d=openmail.cc header.i=@openmail.cc header.b=FesROXgf; arc=none smtp.client-ip=146.59.185.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openmail.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openmail.cc header.i=@openmail.cc header.b="FesROXgf"
Received: (qmail 4876 invoked from network); 5 Dec 2025 16:52:09 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with SMTP; 5 Dec 2025 16:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=date:from
	:to:subject:message-id:mime-version:content-type; s=2018; bh=dFw
	FZrHg2z0WJ5R9BqQbmEDp3y2Vckq5nhIiVN3HEaI=; b=FesROXgfiEouhrsq1tR
	JU7lTeA6F5DQu4bVgnmjPLwRetkpsZuK8qmWPs8fuZDKZUvQy7xqP/ZzjuOVZ0zs
	+SfB2JAjrbrV1nIkEfQJJ12pifuucRkUAYUobG+nxBOH8dvxIxadkuii6QioQsE6
	RkXgsL92lhUINQcIohHTLomU=
Received: (qmail 75520 invoked from network); 5 Dec 2025 10:52:08 -0600
Received: by simscan 1.4.0 ppid: 75511, pid: 75518, t: 0.0413s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (bWFuZGF5QG9wZW5tYWlsLmNj@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 5 Dec 2025 16:52:08 -0000
Date: Fri, 5 Dec 2025 17:51:01 +0100
From: Cedric Sodhi <manday@openmail.cc>
To: git@vger.kernel.org
Subject: Git for structured data
Message-ID: <aTMNdQ_NHTVPtwG8@air>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello (from off list),

a filesystem of Git's working directory type can be seen as a type of database. Compared to other types of databases (relational or not), it might even be considered a fairly complex database with arbitrary nesting depth and relational semantics through symbolic links.

Git excels at version control of this specific type of database, the filesystem. Yet, Git can't be used as-is to version control any other type of database; even though they might be simpler, semantically.

We can have structured data (databases with schemas). We can have version controlled data (files with Git).

Why can't we have structured, version controlled data?

In recent years I've repeatedly struck cases where exactly that was needed. For amounts of data which are comparable to what you typically version with git; only structured. Without workarounds, either structure (table schemas) or versioning (Git) had to be sacrificed. Which is disappointing, in my opinion, seen how this only hinges on the type of source Git would have to read the data from.

I'd like to ask your opinion, on what you think is the most promising approach to unify structure and version control with Git. Currently, I can think of two, kind of complementary options:

A) Map structured data into a filesystem, possibly through FUSE, then version control that with Git.
Pros: Can mix non-structured data and structured data.
Cons: Expect terrible performance

B) Abstract Git's data backend to allow Git to read directly from databases
Pros: Perhaps reasonable performance
Cons: Additional changes to Git would be needed to allow mixing data.

What would you recommend?

Kind regards,
Cedric
