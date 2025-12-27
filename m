Received: from mail.rackland.de (mail.rackland.de [212.86.200.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D522F177
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.86.200.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766846654; cv=none; b=JbwiMNEc6HeCRSYXT5Cwc2nmtgVQF/YzxADW2p6fDB9ZK2l+zoEuMg7i1cK1yJByDteT/pTk2nzBYT6949Pj9IRqND8DVDp82i9ZJ17lGmGgxxXqRKRQbMDlJ/u7Kvw/8SKPNUlsQ2y6GyEBJGLaVCm0BuaBLFKmNBoovV13+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766846654; c=relaxed/simple;
	bh=nzTnVeZYB75ZRNFePBICtpIe4BT6r8WM7KwLcpmHcfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVfzX18kC2fbZj/ABSEQ5ucbsthdMYb7dIAXbnXs3gPTF6inVojLhnY6TwILXUEtG0U8OYwdR2UaKoslbd90wJeA9BNE851j+vIrPF2rX85YmcOryKFDBFAfIbYiH4u69R9Ukg5C4tD9/Dh0AKvFHxDfGMZSaLINUdkyqeIpurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danisch.de; spf=pass smtp.mailfrom=danisch.de; arc=none smtp.client-ip=212.86.200.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danisch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danisch.de
Received: from user (user.rackland.de [IPv6:2a00:1970:709::2212:187])
	by mail.rackland.de (Postfix) with SMTP id E6FCE60312;
	Sat, 27 Dec 2025 15:44:09 +0100 (CET)
Received: (nullmailer pid 482751 invoked by uid 1030);
	Sat, 27 Dec 2025 14:44:09 -0000
Date: Sat, 27 Dec 2025 15:44:09 +0100
From: Hadmut Danisch <hadmut@danisch.de>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: Git destroys u+s and g+s directory modes
Message-ID: <aU/wuT23Ybllu/1q@danisch.de>
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
 <aU_lqe2Z47STv68O@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aU_lqe2Z47STv68O@kitsune.suse.cz>

On Sat, Dec 27, 2025 at 02:56:57PM +0100, Michal Suchánek wrote:
> 
> When you want it to be readable you do not need any special permission
> bits.
> 
> You can set the directories and files to be readable by group, and
> ensure the container user is part of the group.


And that's the problem: 

"ensure the container user is part of the group" is what the S_ISGID flag on directories is good for: It ensures that newly created directories inherit their parent's group. Unix administration basics. 

And this is the bit git clears and breaks this mechanism. 


regards

Hadmut


