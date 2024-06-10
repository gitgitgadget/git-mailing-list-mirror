Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526E156E4
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045897; cv=none; b=oEvRr/sXH7XjNzDR1pL8sPiSu/nWyImocsbc1nR9CyDUVOlMu4kjGVZUc+2vwLOES0/1UGl10geNdJISP0wFgwS2w0ri0ysZoZ04Ib1ss+MdaklmCUXChKtBuK4xAFOcJLeBa0qaf5WUDc6VW/JgK9bQ/22V5YR1Y6f+8O7EFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045897; c=relaxed/simple;
	bh=Ic32JdvcMCisLhM7aPMQdByTMDzNAZaCqfQLlac/ezA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=f7Vn/vMoOnOMapYOQIuLG2TO/ptvvhYAwRphJfFWUkMGgwwM7DztxgO9+VslsqhdWiy9LlCnjWpMvMShNFHGCGxDmlV5u2DMR0Dl68qbjT4/7Lhn4JQQDkzbxHhxzaNx2jGG6FiIYpd2/p/4vbmFs+XX7oK8+TBu7ygPzFF3QGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45AIaUoY066456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 11:36:30 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
Date: Mon, 10 Jun 2024 11:36:28 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: [BUG] "git clean -df ." silently doesn't delete folders with stale
 .nfs* files
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

NFS sometimes leaves files like .nfsXXXXXXXXXXX which usually means that 
some process that has this file open is alive.


"git clean -df ." was supposed to remove the folder where such file is 
located, but it encountered the failure, and silently ignored it and 
succeeded.


Desired behavior: "git clean -df ." should notify the user with warnings 
or errors for each such file that it failed to remove.


When "git clean -df ." succeeded I ran the next command and it failed 
because of the still-present folder with the .nfsXXXXXXXXX file in it.


I believe that this is a bug in git.


git-2.38.1



Thanks,

Yuri


