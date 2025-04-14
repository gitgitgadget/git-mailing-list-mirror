Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5479D2
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744590885; cv=none; b=ZbrKieOODLluO3Hy09TCZ8rDFuI4IT47O4VuRZptZ0eK4DSAoXwLJ8rKxS1KCI+KwqrmvhqrJsAKhYNeeDqT3WKQth+IBWJMMTfqaFnt0edeMtEu3DbgaOr+wvIybhLuEjIzXkjC0U6qBtQh7FYGGPue89KmHzQegobzsnqYZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744590885; c=relaxed/simple;
	bh=gw6eKDHUDLFcSMXf0KuZ8aaoGrAGine92e4jbTm/Cgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zcrfb39bZ0qeKwmW2IhrkhgI0EpclizP5p//DKrCeR1Q2uaVimN02qyefulz+yZ0Vm+hQwdes/M3tTGZjQWzqPd680HUs4wWkHz5/Ad53tptwXyEQ2dJKdyVSqe1QMgzmGOPFYBFog9vqXHbTXGVIxKa1QMmrX4li7XLG5bLGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=NQZMfjsD; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="NQZMfjsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1744590881; bh=gw6eKDHUDLFcSMXf0KuZ8aaoGrAGine92e4jbTm/Cgc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NQZMfjsDqFq/MF5HblbX7xj1XvX5CuFsrPKn1uP15Y2wupOx56qq0iC9C6Qv9iPIX
	 abqJ1s96eA7xY7jVRlI7nShO4trgZ6yr+snjbi3S0NcKVqRMLcuT7QIFFajjI1ULgn
	 6ukAJX8TxsVxvISScPGjZGD63UtBNYQcPckN0kDLmBpfh5D3LrLMdTf+uyxt8bw7lg
	 DPIFpttY8CYG/HaVsq17IT9GuNXfeeS+D8m+Rli5xX49eEDAqT2xDaeBTns3KOJ9vL
	 7ISeSDhPz+53KJZwOpyxFZ7oMJDIKlIkbUFAiWOjjnNbnEA7bpO33TDbwCV2u6nDu4
	 uv/jI1dQdNnpA==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id D079D1120180; Mon, 14 Apr 2025 02:34:41 +0200 (CEST)
Date: Mon, 14 Apr 2025 00:34:41 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org
Subject: Re: Way to "impersonate" remote or sync remotes without fetching
 everything?
Message-ID: <351a6036-3bac-43f4-88b0-cd52240312cd@frank.fyi>
Reply-To: git@vger.kernel.org
User-Agent: Mozilla Thunderbird
References: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
 <CALnO6CCUHE6-RcZkTBYT-CeXHnYPBPe1eGSogWd7=5tK5NyuxA@mail.gmail.com>
 <669a6a0f-bcfb-4596-a0c8-73c722a6ec10@frank.fyi>
 <CALnO6CALCFLWSs9HBWX13V_BUZkoeZuVjHVnF4_e0OMy3LfEjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: de-DE, en-US-large, en-US
Content-Disposition: inline
In-Reply-To: <CALnO6CALCFLWSs9HBWX13V_BUZkoeZuVjHVnF4_e0OMy3LfEjw@mail.gmail.com>

On 2025-04-13 23:52:14, D. Ben Knoble wrote:
> That all makes sense, except: why need the sync (cron) job? Treat a
> local copy as authoritative for you and push to all your remotes. This
> puts you in control at the cost of not happening automatically. (You
> could conceivably have a local cron job that did this.)

Cause I don't want to have it locally on e.g. a notebook that can break 
mainly :D
(I know myself I won't be making enough backups if that is their primary 
location)

But I have been thinking about something similar earlier today. Maybe I 
should just
trash my software forge (gitlab) and just use git from the cli via ssh.
Then writing a cron job to do the syncing would also be easier as I'd have
a local copy to work with and maybe add some Stagit sparkles to replace the
web-ui (aka some static page generator for git repos)
https://codemadness.org/stagit.html

(Still not quite satisfies with Stagit nor cgit, maybe I'll find 
something that needs,
less files generated on the server side and some "git in javascript" to 
display
the more exotic views instead of doing it server side like cgit does)

--
Klaus Frank

