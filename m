Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8A101E3
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359152; cv=none; b=UTjm4C9QNIOFl500hJAU2iP95jBHJP3DINbK/IFA6XXGIqpCXWxhVwPdtrcnlUJWzpnfCBVQBMBMI5wZipVf4U1fquTiGEwZSC10H9crPRC6HDi8xHAlfqLHzwRrxtUaTxXA54RKv/fyfkKKgAF1eGl/i+G+uFR6iKaZx5w30so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359152; c=relaxed/simple;
	bh=NUD7V0idL4xB5WgdAzD4vNiMCNazKtowkDoMvH1zQ4c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmPdTWduyw48iE1ZNMmJ1g+XBz+6fEqcJxcEqYV6fYThI/Wp3/lN2BBw7vNMLWT+oMk/mi9KL2gaxbOmQnOQbZDyosBZrOXZLSZwE9TGdGAnxEa5FktvfPCTGvZEx+2lHxsAEvWgNNhcVXzcoHLDFpcylXgnTwbwu5zEBo71CD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 44AGctNl3545788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 16:38:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Mike Hommey'" <mh@glandium.org>
Cc: <git@vger.kernel.org>
References: <20240509021352.se4u7ajaolveyyjf@glandium.org> <xmqqmsozuf7y.fsf@gitster.g>
In-Reply-To: <xmqqmsozuf7y.fsf@gitster.g>
Subject: RE: bug: git config --global --unset doesn't unset configs in corner case
Date: Fri, 10 May 2024 12:38:49 -0400
Organization: Nexbridge Inc.
Message-ID: <001b01daa2f8$8cf49800$a6ddc800$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI30qTaqB5MsyNMqIBK0KfPkWSMFwIEWiczsMYogEA=
Content-Language: en-ca

On Thursday, May 9, 2024 12:23 PM, Junio C Hamano wrote:
>Mike Hommey <mh@glandium.org> writes:
>
>> When both ~/.gitconfig and ~/.config/git/config exist, git will read
>> both. But when using `git config --global --unset`, it will only touch
>> the first one. So unsetting config items from ~/.config/git/config is
>> not possible from the command line when ~/.gitconfig exists.
>
>Interesting observation of an understandable behaviour.
>
>I think the original intent of limiting the writing to just one was to
avoid having both
>files in the first place.  When both do exist already, I am not sure what
the right
>behaviour on the write side should be.  We could special case "--unset-all"
and
>remove from both, but "--unset" is to remove just one, so when the reading
side
>reads from both, it becomes "which one to remove"?
>
>Comments from those who are more familiar with the "git config" are
certainly
>appreciated.

If both ~/.gitconfig and ~/.config/git/config both exist, a scope of
--global becomes ambiguous. The --file <file> option should disambiguate the
operation if just --unset is used. Otherwise, perhaps we should fail the
operation.

--Randall

