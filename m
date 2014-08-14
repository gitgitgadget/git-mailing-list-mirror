From: Matthew Flaschen <mflaschen@wikimedia.org>
Subject: "git fetch" does not pass quiet setting to "git c"
Date: Thu, 14 Aug 2014 00:11:48 -0400
Message-ID: <53EC3704.7060907@wikimedia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 06:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHmO7-0006JC-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 06:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbaHNELj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 00:11:39 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34195 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbaHNELj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 00:11:39 -0400
Received: by mail-qc0-f182.google.com with SMTP id i8so645774qcq.13
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wikimedia.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=yL1rtR4eDKDrbPfzFKxgnFO28wi+PdQfmbQocS8eIF8=;
        b=CNRpkYbk8vKEuC1V74MywyK4tFBSWN3iXvjKvMYh3vdC5YhLnCZ9fp9SQaxw1ZXNKr
         UL9wH/15c22lrJIMKJ+9E35AwnjnRDjPKKFZu/q9I7UdpWPH5YnoJP85jNVlFWEjBdB6
         OAVEiSaqJM/xHKnIfa235vWu0wE/G6kLobj2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=yL1rtR4eDKDrbPfzFKxgnFO28wi+PdQfmbQocS8eIF8=;
        b=Hqg6w+lt0yXepZIFZhcYEfQwhzo53FnPvbCHfIjFgXflmQeSsKqzbMq8K0L+Iiwe4k
         6FGuJMz/rXRfw5iMQvTrszQCJphN8KggNkyVSglHCozfJBJKnadG29oO3wfH8FTHi34W
         IDUVBp9c5/3nwC6omE5zEkH3YJ6x9ak+uEurJxzVJTWl3cH/3lrGMjBhs9IjAAAAe+Y2
         xovGQptiY/jl+QYR0vt1ssudvTsFcofJpFY7GEijijIqlQkbNDTI3cFuK8zxCEgkYVdR
         LOzqw2vYk63ufNWoc95OrDng0zJtOUkDK0Wtfr7+eM/jLV89vyuJTG9ZCfTeW2hLJ3L+
         /Ikg==
X-Gm-Message-State: ALoCoQlzb3vbuR3KviUMv/G2wRQS8TafmaHfAmzLcJPV46NwicL4Cs7rLR4UMHbAQZbyWUYA739I
X-Received: by 10.140.102.162 with SMTP id w31mr12324731qge.67.1407989498052;
        Wed, 13 Aug 2014 21:11:38 -0700 (PDT)
Received: from [192.168.1.32] (pool-71-175-120-120.phlapa.east.verizon.net. [71.175.120.120])
        by mx.google.com with ESMTPSA id n7sm6748985qax.5.2014.08.13.21.11.36
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 21:11:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255258>

"git fetch" does not pass the quiet flag (if applicable) to "git gc".

I've reproduced this in 2.0.1, but it appears to be present in master. 
It looks like this line 
(https://github.com/git/git/blob/master/builtin/fetch.c#L1201) is 
calling "git gc" (which does support --quiet) without passing it.

Tested with:

git fetch -q origin master

I would expect to see no output for that.  Instead, I see:

"Total 31 (delta 23), reused 31 (delta 23)"

(or whatever the values are).

This will cause cronjobs, for example, to send output when the command 
completes normally.

Thanks,

Matthew Flaschen
